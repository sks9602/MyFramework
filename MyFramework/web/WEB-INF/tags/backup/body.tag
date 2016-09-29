<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag
	import="project.jun.was.HoModel"
	import="project.jun.util.HoUtil"
	import="project.jun.was.parameter.HoParameter"
	import="project.jun.was.spring.HoController"
	import="project.jun.util.HoValidator"
%><%@ attribute name="title"    type="java.lang.String"
%><%@ attribute name="pageIndex"    type="java.lang.String"
%>
<%
	HoModel        model     = new HoModel(request);
	HoParameter    param     = (HoParameter) model.get(HoController.HO_PARAMETER);

	String p_action_flag = param.get("p_action_flag");
	String division      = param.get("division");

	boolean isScript = "script".equals(division);
	boolean isHtml 	 = "html".equals(division);

%>

<% if( isScript ) {
	if( !"0".equals(pageIndex)) {
		out.println(", // " + pageIndex + ", "+ division);
	}
%>

{
title : '<%= title %>',
xtype : 'panel',
items : [
<% }  %>
<jsp:doBody></jsp:doBody>
<% if( isScript ) { %>
]}
<% } %>



<% if( isHtml ) { %>
<% } %>
