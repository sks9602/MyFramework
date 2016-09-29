<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.jun.util.HoSpringUtil"
	import="project.jun.was.security.HoReloadableFilterInvocationSecurityMetadataSource"
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<%
	HoSpringUtil   hsUtil = new HoSpringUtil();

	HoReloadableFilterInvocationSecurityMetadataSource source = (HoReloadableFilterInvocationSecurityMetadataSource) hsUtil.getBean(application, "databaseSecurityMetadataSource");
	
	source.reload();
%>
<body>
	<form name='formLogin' action='/s/j_spring_security_check' method='POST'>
		<table>
			<tr><td>Company:</td><td><input type='text' name='company_cd' value='1000'></td></tr>
			<tr><td>User:</td><td><input type='text' name='j_username' value='sesedu'/></td></tr>
			<tr><td>Password:</td><td><input type='password' name='j_password' value='sesedu'/></td></tr>
			<tr><td colspan='2'><input name="submit" type="submit" value="Login"/></td></tr>
		</table>
	</form>
</body>
</html>
