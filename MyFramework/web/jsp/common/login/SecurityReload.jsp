<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.jun.util.HoSpringUtil"
	import="project.jun.was.security.HoReloadableFilterInvocationSecurityMetadataSource"
	import="project.jun.was.security.HoReloadableMapBasedMethodSecurityMetadataSource"
%>
<%
	HoSpringUtil   hsUtil = new HoSpringUtil();

	// URI 기반 접근제어 reload
	HoReloadableFilterInvocationSecurityMetadataSource uriSource = (HoReloadableFilterInvocationSecurityMetadataSource) hsUtil.getBean(application, "databaseSecurityMetadataSource");
	uriSource.reload();
	
	// Method 기반 접근제어 reload
	HoReloadableMapBasedMethodSecurityMetadataSource   methodSource = (HoReloadableMapBasedMethodSecurityMetadataSource) hsUtil.getBean(application, "methodSecurityMetadataSources");
	methodSource.reload();

%>
Authority base on Spring-Security has reloaded.