package project.jun.was.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.MDC;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;

public class HoLog4jMDCUserFilter implements Filter {

	@Override
	public void destroy() {
		// TODO Auto-generated method stub

	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest httprequest = (HttpServletRequest) request;
    	SecurityContext context =	(SecurityContext) httprequest.getSession().getAttribute(HttpSessionSecurityContextRepository.SPRING_SECURITY_CONTEXT_KEY);
 
    	if(context != null) {
    			Authentication authentication = context.getAuthentication();
    			MDC.put("principal", authentication.getName());
    			MDC.put("sessionId",httprequest.getSession().getId());
    		}else{
    			MDC.put("principal", "");
    			MDC.put("sessionId",httprequest.getSession().getId());
    		}
        	chain.doFilter(request, response);
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub

	}

}
