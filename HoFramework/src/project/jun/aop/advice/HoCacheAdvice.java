package project.jun.aop.advice;

import java.util.Map;

import org.aopalliance.intercept.MethodInterceptor;
import org.aopalliance.intercept.MethodInvocation;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.InitializingBean;

import project.jun.dao.HoDao;
import project.jun.dao.parameter.HoQueryParameterMap;
import project.jun.dao.result.HoList;
import project.jun.dao.result.transfigure.HoSetHasMap;
import project.jun.util.cache.HoCache;
import project.jun.util.cache.HoEhCache;

/**
 * 메서드가 return할경우 log를 작성한다.
 *
 * @author 신갑식
 */

public class HoCacheAdvice implements MethodInterceptor, InitializingBean {
	protected static Logger logger = Logger.getLogger(HoCacheAdvice.class); // Logger.getRootLogger();

	public final static  String CACHED_CODE_SET = "HoCacheAdvice.CACHED_CODE_SET";
	public final static  String CACHED_COLUMN_SET = "HoCacheAdvice.CACHED_COLUMN_SET";
	public final static  String CACHED_COLUMN_CODE_SET = "HoCacheAdvice.CACHED_COLUMN_CODE_SET";
	public final static  String CACHED_BUTTON_SET = "HoCacheAdvice.CACHED_BUTTON_SET";
	/*
	 * @see
	 * org.springframework.aop.AfterReturningAdvice#afterReturning(java.lang.Object, java.lang.reflect.Method, java.lang.Object[], java.lang.Object)
	 * 공통 코드일
	 */
	public void afterPropertiesSet() throws Exception {
		// TODO Auto-generated method stub

	}

	public Object invoke(MethodInvocation invocation) throws Throwable {
		HoDao dao = (HoDao)invocation.getThis();
		//String methodName = invocation.getMethod().getName();
		Object[] arguments = invocation.getArguments();
		Map cacheMap  = dao.getCacheMap();


		// 공통코드 목록 조회 일 경우..
		if( cacheMap!=null && arguments.length > 0 && cacheMap.containsKey((String)arguments[0])) {
			Object result;
			String cacheInfo = (String)cacheMap.get((String)arguments[0]);
			String cacheName = "";
			String cacheCode = "";
			String codeSet   = "";

			if( cacheInfo.indexOf(',') > 0  ) {
				String [] infos = cacheInfo.split(",");
				cacheName = infos[0].replaceAll(" ", "");
				cacheCode = infos[1].replaceAll(" ", "");
				if(infos.length > 2 ) {
					codeSet = infos[2].replaceAll(" ", ""); // 코드 단위별로도 저장하기 위한 컬럼
				}
			} else {
				cacheName = dao.getCache().getName().replaceAll(" ", "");
				cacheCode = cacheInfo.replaceAll(" ", "");
			}

			HoCache cache = new HoEhCache(dao.getCache());

			HoQueryParameterMap value = (HoQueryParameterMap) arguments[1];

			result  = cache.get(value.get(cacheCode));
			if (result == null) {
				result = invocation.proceed();
				cache.put(value.get(cacheCode), result);

				if( !codeSet.equals("") && result instanceof HoList ) {
					HoSetHasMap  setMap = (HoSetHasMap) cache.get(HoCacheAdvice.CACHED_CODE_SET);
					if( setMap == null ) {
						setMap = new HoSetHasMap((HoList) result, cacheCode, codeSet );
					} else {
						setMap.put((HoList) result, cacheCode, codeSet);
					}
					cache.put(HoCacheAdvice.CACHED_CODE_SET , setMap);
					logger.debug("Caching - SQL : "+ arguments[0] + " , NAME["+ cacheName +"], CODE["+  cacheCode +" : " + value.get(cacheCode)+"], SET[ " + codeSet + "]");
				} else {
					logger.debug("Caching - SQL : "+ arguments[0] + " , NAME["+ cacheName +"], CODE["+  cacheCode +" : " + value.get(cacheCode)+"]");
				}

			} else {
				logger.debug("Restoring Cache - SQL :  "+ arguments[0] + " , NAME["+ cacheName +"], CODE["+  cacheCode +" : " + value.get(cacheCode)+"]");
			}
			return result;
		} else {
			return invocation.proceed();
		}
	}


}
