<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.web.access.AccessDeniedHandlerImpl" %>
<%@ page import="org.springframework.security.core.Authentication" %>
<%@ page import="org.springframework.security.core.userdetails.UserDetails" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
Login Fail..<br/><br/>
<%
	Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	Object principal = auth.getPrincipal();

	if (principal instanceof UserDetails) {
		String username = ((UserDetails) principal).getUsername();
		String password = ((UserDetails) principal).getPassword();
		out.println("Account : " + username.toString() + " / " + password.toString() + "<br>");
	}
%>
<%= auth.getName() %><br/>
<%= auth.isAuthenticated() %><br/>
</body>
</html>
