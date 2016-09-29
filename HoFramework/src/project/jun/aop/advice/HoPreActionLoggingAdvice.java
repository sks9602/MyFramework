package project.jun.aop.advice;

import java.lang.reflect.Method;

import org.apache.log4j.Logger;
import org.springframework.aop.MethodBeforeAdvice;


/**
 * 메서드가 시작되기전에 log를 작성한다.
 * @author 신갑식
 *
 */
public class HoPreActionLoggingAdvice implements MethodBeforeAdvice {
	protected static Logger          logger     = Logger.getLogger(HoPreActionLoggingAdvice.class); //Logger.getRootLogger();

	/**
	 * 메서드가 시작 되면 class명 arguments등의 log를 작성한다.
	 */
	public void before(Method method, Object[] args, Object target) throws Throwable {
		String className = target.getClass().getName();

		logger.info("Action Starting : "+className+"."+method.getName()+"()" );

		//logger.info("method : "+method.toString());
		//logger.info("target : "+target);
		/*
		if( target instanceof HoDelegate && method.getName().indexOf("getHoParameter") == -1 ) {

			HoDelegate delegate = (HoDelegate)target;
			if(delegate.getHoConfig().isDebugParameter()) {
				delegate.getHoParameter().infoParameter(delegate.getHoConfig().isDebugParameterOrdered());
			}
			if(delegate.getHoConfig().isDebugParameterValue()) {
				delegate.getHoParameter().infoParameterValue(delegate.getHoConfig().isDebugParameterOrdered());
			}
		}
		*/

	}

}
