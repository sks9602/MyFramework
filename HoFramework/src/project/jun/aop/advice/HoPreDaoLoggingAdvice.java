package project.jun.aop.advice;

import java.lang.reflect.Method;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.aop.MethodBeforeAdvice;

/**
 * 메서드가 시작되기전에 log를 작성한다.
 * @author 신갑식
 *
 */
public class HoPreDaoLoggingAdvice implements MethodBeforeAdvice {
	protected static Logger          logger     = Logger.getLogger(HoPreDaoLoggingAdvice.class); //Logger.getRootLogger();

	/**
	 * 메서드가 시작 되면 class명 arguments등의 log를 작성한다.
	 */
	public void before(Method method, Object[] args, Object target) throws Throwable {
		String className = target.getClass().getName();

		logger.info("Starting : "+className+"."+method.getName()+"()" );

		try {

			if(args!=null && args.length>0) {
				for(int i=0 ; i<args.length ; i++) {
					if( args[i] instanceof Object []) {
						Object [] argsObj = (Object []) args[i];

						if( argsObj.length == 0 ) {
							logger.info("args["+i+"] (!!Object []!!) : length : " + argsObj.length );
						} else {
							if( i==0 ) {
								logger.info("args["+i+"] ("+ argsObj[0].getClass().getName() + ") : length : " + argsObj.length );
								
								logger.info("args["+i+"][0] : " +((Object[])args[i])[0]);
								logger.info("~ args["+i+"]["+(argsObj.length-1)+"] : " +((Object[])args[i])[argsObj.length-1]);
							
							} else {
								logger.debug("args["+i+"] ("+ argsObj[0].getClass().getName() + ") : length : " + argsObj.length );
	
								logger.debug("args["+i+"][0] : " +((Object[])args[i])[0]);
								logger.debug("~ args["+i+"]["+(argsObj.length-1)+"] : " +((Object[])args[i])[argsObj.length-1]);
							}
						}
						/*
						for( int j=0 ; j<((Object[])args[i]).length ; j++) {
							logger.info("args["+i+"]["+j+"] : " +((Object[])args[i])[j]);
						}
						*/
					} else {
						if( args[i] instanceof Map ) {
							Map list = (Map)args[i];
							if( i==0 ) {
								logger.info("args["+i+"] (" +args[i].getClass().getName() + ") size is " + list.size() );
							} else {
								logger.debug("args["+i+"] (" +args[i].getClass().getName() + ") size is " + list.size() );
							}
							if( list.size() > 0 ) {
								logger.debug("->  [0] : " + list.get(0) +" ~ ["+ ( list.size() -1 ) + "] :" + list.get(list.size() -1 )  );
							}
						} else {
							if( i==0 ) {
								logger.info("args["+i+"] (" +args[i].getClass().getName() + ") : " + args[i]);
							} else {
								logger.debug("args["+i+"] (" +args[i].getClass().getName() + ") : " + args[i]);
							}
						}
					}
				}
			}
		} catch(Exception e) {
			e.printStackTrace();

			throw e;
		}
	}

}
