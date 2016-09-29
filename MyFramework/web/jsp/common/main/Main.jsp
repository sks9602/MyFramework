<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.web.access.AccessDeniedHandlerImpl" %>
<%@ page import="org.springframework.security.core.Authentication" %>
<%@ page import="org.springframework.security.core.userdetails.UserDetails" %>
<%@ page import="project.jun.user.UserInfo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
Login Success..<br/><br/>
<%

	Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	Object principal = auth.getPrincipal();

	if (principal instanceof UserInfo) {
		String username = ((UserInfo) principal).getUsername();
		String password = ((UserInfo) principal).getPassword();
		String userId = ((UserInfo) principal).getUserId();
		out.println("Account : " + username.toString() + " / " + password.toString() + "<br>");
		out.println("User ID : " + userId + "<br>");
	}
%>
Name : <%= SecurityContextHolder.getContext().getAuthentication().getName() %><br/>
</body>
</html>
