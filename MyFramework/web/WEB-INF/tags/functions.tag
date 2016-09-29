<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag
	import="project.jun.was.HoModel"
	import="project.jun.util.HoUtil"
	import="project.jun.was.parameter.HoParameter"
	import="project.jun.was.spring.HoController"
	import="project.jun.util.HoServletUtil"
	import="project.jun.util.HoValidator"
	import="project.jun.dao.HoDao"
	import="project.jun.util.HoSpringUtil"
	import="project.jun.dao.result.HoMap"
	import="project.jun.dao.result.HoList"
	import="project.jun.dao.parameter.HoQueryParameterMap"
	import="org.apache.ibatis.metadata.result.MetaData"
%><%@ include file="include.tag" %>
<%@ attribute name="targetId" type="java.lang.String" required="true"
%>
<% if( isScriptOut ) {
	HoServletUtil.setString(request, "function-target-id", HoUtil.replaceNull(targetId) );
%>
	<jsp:doBody></jsp:doBody>
<%
	HoServletUtil.setString(request, "function-target-id", null );
}
%>

