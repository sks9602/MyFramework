package project.jun.util;import javax.servlet.ServletContext;import org.springframework.web.context.WebApplicationContext;import org.springframework.web.context.support.WebApplicationContextUtils;import org.springframework.web.servlet.FrameworkServlet;public class HoSpringUtil {	public Object getBean(ServletContext context, String beanName) {		Object bean = null;		try {			String attr = FrameworkServlet.SERVLET_CONTEXT_PREFIX + "action";			WebApplicationContext factory = WebApplicationContextUtils.getWebApplicationContext(context, attr);			bean = factory.getBean(beanName);		}	    catch(Exception e ) {	    	e.printStackTrace();		} finally {		}		return bean;	}}