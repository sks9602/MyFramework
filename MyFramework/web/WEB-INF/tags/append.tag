<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag
	import="project.jun.was.HoModel"
	import="project.jun.util.HoUtil"
	import="project.jun.was.parameter.HoParameter"
	import="project.jun.was.spring.HoController"
	import="project.jun.util.HoValidator"
	import="project.jun.util.HoServletUtil"
%><%@ include file="include.tag" %>
<% 	if( isScript || isScriptOut ) {%>
<jsp:doBody></jsp:doBody>
<% } %>


