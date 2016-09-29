package project.jun.aop.advice;

import java.lang.reflect.Method;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import org.apache.log4j.Logger;
import org.springframework.aop.AfterReturningAdvice;

import project.jun.config.HoConfig;
import project.jun.dao.result.HoList;
import project.jun.dao.result.HoMap;
import project.jun.dao.result.HoResult;
import project.jun.delegate.HoDelegate;
import project.jun.util.HoValidator;
import project.jun.was.parameter.HoParameterMap;


/**
 * 메서드가 시작되기전에 log를 작성한다.
 * @author 신갑식
 *
 */
public class HoDaoFormatInjectionAdvice implements AfterReturningAdvice {
	protected static Logger          logger     = Logger.getLogger(HoDaoFormatInjectionAdvice.class); //Logger.getRootLogger();

	/**
	 * 메서드가 시작 되면 class명 arguments등의 log를 작성한다.
	 */
	public void afterReturning(Object returnValue, Method method, Object[] args, Object target) throws Throwable {
		String className = target.getClass().getName();

		logger.info("After : "+className+"."+method.getName()+"()" );

		try {
			if( target instanceof HoDelegate ) {
				if( returnValue instanceof HoList || returnValue instanceof HoMap) {
					HoParameterMap hoParameterMap = (HoParameterMap) args[2];
					HoConfig       hoConfig       = (HoConfig) args[3];
					for( int i=0; i<args.length; i++) {

					}

					Map<String, String> displayFormat = (Map<String, String>)hoConfig.getDisplayFormat() ;

					Set<String> set = displayFormat.keySet();
					Iterator<String> it  = set.iterator();
					String key = null;
					String valule = "";
					while( it.hasNext() ) {
						key    = it.next();
						valule = (String) hoParameterMap.get(hoConfig.getSessionNamePrefix() + key);
						if( !HoValidator.isEmpty(valule) ) {
							displayFormat.put(key, valule);
						}
					}
					((HoResult)returnValue).setDisplayFormat(displayFormat);

				}
			}
		} catch(Exception e) {
			e.printStackTrace();

			throw e;
		}
	}

}
