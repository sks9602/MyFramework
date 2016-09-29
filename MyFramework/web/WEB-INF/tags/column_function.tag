<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag
	import="project.jun.was.HoModel"
	import="project.jun.util.HoUtil"
	import="project.jun.util.HoServletUtil"
	import="project.jun.was.parameter.HoParameter"
	import="project.jun.was.spring.HoController"
	import="project.jun.util.HoValidator"
%>
<%@ include file="include.tag" %>
<%@ attribute name="functionFor" type="java.lang.String" required="true" %> <%-- "do" 이건 상관없이 그냥 실행 해야 할 경우.. / renderer/ editors / summary / editor / checkbox  --%>
<% if( isScript || isScriptOut  ) { 
	String functionCol = HoUtil.replaceNull(HoServletUtil.getString(request, "column-function"),"do");
	
		if( HoUtil.replaceNull(functionFor).equals(HoUtil.replaceNull(functionCol))) {
%>
	<jsp:doBody></jsp:doBody>
<% 		} else {
			out.println("Ext.emptyFn");
		}
	}
%>

<% if( isHtml ) {%>
<% } %>