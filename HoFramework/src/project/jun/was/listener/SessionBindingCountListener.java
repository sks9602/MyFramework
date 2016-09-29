package project.jun.was.listener;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;

import org.apache.log4j.Logger;

import project.jun.was.parameter.HoParameter;

public class SessionBindingCountListener implements HttpSessionAttributeListener  { // HttpSessionBindingListener,
	private int count = 0;
	private ServletContext context = null;
	protected  Logger          logger     = Logger.getLogger(HoParameter.class);

	public SessionBindingCountListener(){
	}

	public SessionBindingCountListener(ServletContext context){
		this.context = context;
	}

	public void valueBound(HttpSessionBindingEvent se) {
		//System.out.println(" event.getName() : " + se.getName());
		//System.out.println(" event.getSource() : " + se.getSource());
		//System.out.println(" event.getValue() : " + se.getValue());

		if( this.context == null) {
			this.context = se.getSession().getServletContext();
		}

		if( se.getName().equals("SSN_USER_ID")) {
			count++;
			log(" valueBound(" + se.getSession().getId() + ") count=" + count);
			this.context.setAttribute("count", new Integer(count));
		}

	}

	public synchronized void valueUnbound(HttpSessionBindingEvent se) {
		//System.out.println(" event.valueUnbound.getName() : " + se.getName());
		//System.out.println(" event.valueUnbound.getSource() : " + se.getSource());
		//System.out.println(" event.valueUnbound.getValue() : " + se.getValue());

		if( se.getName().equals("SSN_USER_ID")) {
			count--;
			log(" valueUnbound(" + se.getSession().getId() + ") count=" + count);
			this.context.setAttribute("count", new Integer(count));
		}
	}

	public synchronized void attributeAdded(HttpSessionBindingEvent se) {
		if( this.context == null) {
			this.context = se.getSession().getServletContext();
		}

		if( se.getName().equals("SSN_USER_ID")) {
			count++;
			log(" attributeAdded(" + se.getSession().getId() + ") count=" + count);
			this.context.setAttribute("count", new Integer(count));
		}

	}

	public synchronized void attributeRemoved(HttpSessionBindingEvent se) {
		if( se.getName().equals("SSN_USER_ID")) {
			if( count > 0 ) {
				count--;
			}
			log(" attributeRemoved(" + se.getSession().getId() + ") count=" + count);
			this.context.setAttribute("count", new Integer(count));
		}

	}

	public void attributeReplaced(HttpSessionBindingEvent se) {

	}

	private void log(String message) {
		if (context != null) {
			context.log("SessionBindingCountListener: " + message);
		}
		logger.debug("SessionBindingCountListener: " + message);
	}


}
