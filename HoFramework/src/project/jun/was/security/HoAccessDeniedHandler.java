package project.jun.was.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.access.AccessDeniedHandler;

public class HoAccessDeniedHandler implements AccessDeniedHandler {

	private String errorPage;
	
	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response,AccessDeniedException exception) throws IOException, ServletException {
		String ajaxHeader = request.getHeader("X-Ajax-call");
		
		String result = "";
		
		response.setStatus(HttpServletResponse.SC_FORBIDDEN);
		response.setCharacterEncoding("utf-8");
		
		// Ajax가 아닌 경우
		if( ajaxHeader == null ) {
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			Object principal = auth.getPrincipal();
			if( principal instanceof UserDetails ) {
				String username = ((UserDetails)principal).getUsername();
				request.setAttribute("username", username);
			}
			request.setAttribute("errormsg",  exception);
			request.getRequestDispatcher(errorPage).forward(request, response);
		} 
		// Ajax 호출인 경우
		else {
			if( "true".equals(ajaxHeader)) {
				result = "{\"result:\" : \"fail\", \"message:\" : \""+exception.getMessage()+"\"}";
			} else {
				result = "{\"result:\" : \"fail\", \"message:\" : \"Access Denied(Header Value Mismatch.\"}";
			}
			
			response.getWriter().print(result);
			response.getWriter().flush();
			
		}

	}
	
	public void setErrorPage(String errorPage) {
		if((errorPage!= null) && !errorPage.startsWith("/")) {
			throw new IllegalArgumentException("errorPage must begin with '/'");
		}
		this.errorPage = errorPage;
	}
	

}
