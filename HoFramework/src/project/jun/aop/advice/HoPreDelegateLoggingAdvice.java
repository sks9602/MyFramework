package project.jun.aop.advice;

import java.lang.reflect.Method;

import org.apache.log4j.Logger;
import org.springframework.aop.MethodBeforeAdvice;

import project.jun.was.parameter.HoParameterMap;

/**
 * 메서드가 시작되기전에 log를 작성한다.
 * @author 신갑식
 *
 */
public class HoPreDelegateLoggingAdvice implements MethodBeforeAdvice {
	protected static Logger          logger     = Logger.getLogger(HoPreDelegateLoggingAdvice.class); //Logger.getRootLogger();

	/**
	 * 메서드가 시작 되면 class명 arguments등의 log를 작성한다.
	 */
	public void before(Method method, Object[] args, Object target) throws Throwable {
		String className = target.getClass().getName();

		logger.info("Starting : "+className+"."+method.getName()+"()" );

		try {

			if(args!=null) {

				if( args.length>0) {
					logger.info("p_action_flag : " + args[0] );
				}
				if( args.length>2) {
					if( args[2] instanceof HoParameterMap ) {
						((HoParameterMap)args[2]).toString();
					}

				}
			}
		} catch(Exception e) {
			e.printStackTrace();

			throw e;
		}
	}

}
