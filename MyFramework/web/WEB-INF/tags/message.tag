<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag
	import="project.jun.dao.result.HoMap"
	import="project.jun.was.HoModel"
	import="project.jun.util.HoUtil"
	import="project.jun.was.parameter.HoParameter"
	import="project.jun.was.spring.HoController"
	import="project.jun.util.HoServletUtil"
	import="project.jun.util.HoValidator"
%><%@ include file="include.tag" %>
<%
	String attr = org.springframework.web.servlet.FrameworkServlet.SERVLET_CONTEXT_PREFIX + "action";
	org.springframework.context.ApplicationContext factory = org.springframework.web.context.support.WebApplicationContextUtils.getWebApplicationContext(application, attr);

	
	String message = factory.getMessage("CUD-MSG-CO0001", new String [0], java.util.Locale.getDefault());
	
	System.out.println("---->" + message);

%>