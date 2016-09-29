<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.jun.util.HoSpringUtil"
	import="project.jun.was.security.HoReloadableFilterInvocationSecurityMetadataSource"
	import="project.jun.was.security.HoReloadableMapBasedMethodSecurityMetadataSource"
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	HoSpringUtil   hsUtil = new HoSpringUtil();

	// URI 기반 접근제어 reload
	HoReloadableFilterInvocationSecurityMetadataSource uriSource = (HoReloadableFilterInvocationSecurityMetadataSource) hsUtil.getBean(application, "databaseSecurityMetadataSource");
	uriSource.reload();
	
	// Method 기반 접근제어 reload
	HoReloadableMapBasedMethodSecurityMetadataSource   methodSource = (HoReloadableMapBasedMethodSecurityMetadataSource) hsUtil.getBean(application, "methodSecurityMetadataSources");
	methodSource.reload();
%>


	Ajax... No Authority... (Reloaded by Hard Coding...... TODO  delete this... )
</body>
</html>
