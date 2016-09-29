package project.jun.was.listener;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.apache.log4j.Logger;

import project.jun.was.parameter.HoParameter;

public class SessionCounterListener implements HttpSessionListener {
	private int count = 0;
	private ServletContext context = null;
	protected  Logger          logger     = Logger.getLogger(HoParameter.class);

	public SessionCounterListener(){
	}

	public SessionCounterListener(ServletContext context){
		this.context = context;
	}

	public synchronized void sessionCreated(HttpSessionEvent se) {
		count++;
		if( this.context == null) {
			this.context = se.getSession().getServletContext();
		}
		log("sessionCreated(" + se.getSession().getId() + ") count=" + count);
		this.context.setAttribute("count", new Integer(count));
	}

	public synchronized void sessionDestroyed(HttpSessionEvent se) {
		count--;
		log("sessionDestroyed(" + se.getSession().getId() + ") count=" + count);
		if( this.context != null ) {
			this.context.setAttribute("count", new Integer(count));
		}
	}

	private void log(String message) {
		if (context != null) {
			context.log("SessionListener: " + message);
		}

		logger.debug("SessionListener: " + message);
	}

}
