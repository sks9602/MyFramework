<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag
	import="project.jun.was.HoModel"
	import="project.jun.util.HoUtil"
	import="project.jun.util.HoServletUtil"
	import="project.jun.was.parameter.HoParameter"
	import="project.jun.was.spring.HoController"
	import="project.jun.util.HoValidator"
%><%@ include file="include.tag" %>
<%@ attribute name="title" type="java.lang.String"
%><%
	int gridIndex = HoServletUtil.getIndex(request, "grid_index");
%>
<% if( isScript || isScriptOut ) { %>
<%
		HoServletUtil.setInArea(request, "column");
		int columnIndex = HoServletUtil.getIndex(request, HoServletUtil.getArea(request)+"_row");
		HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request)+"_row");
		out.print((columnIndex>0 ? "," : "") + "{ header: '"+ title+"'");
		out.print(", columns: [");
		%>
		<jsp:doBody></jsp:doBody>
		<%
		out.print("]}");
		HoServletUtil.setOutArea(request);
%>
<% } %>
<% if( isHtml ) {%>
<% } %>