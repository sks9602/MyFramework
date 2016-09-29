<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag
	import="project.jun.was.HoModel"
	import="project.jun.util.HoUtil"
	import="project.jun.was.parameter.HoParameter"
	import="project.jun.was.spring.HoController"
	import="project.jun.util.HoServletUtil"
%><%@ attribute name="layout" type="java.lang.String"
%>
<%
	HoModel        model     = new HoModel(request);
	HoParameter    param     = (HoParameter) model.get(HoController.HO_PARAMETER);

	String p_action_flag = param.get("p_action_flag");
	String division      = param.get("division");
	String tab_index      = param.get("tab_index");

	boolean isScript = "script".equals(division);
	boolean isHtml 	 = "html".equals(division);
	boolean isFirstTab = "0".equals(tab_index);

%>



<% if( isScript ) { %>

<%

	HoServletUtil.setInArea(request, "data");
	out.println("<br/>-------------------");
	out.println("<br/>" + HoServletUtil.getArea(request));

	if( !"".equals(layout))  {
		out.println("<br/> layout -("+layout+") [");
	}
	out.println("<br/>&nbsp; data -  [");
%>

	<jsp:doBody></jsp:doBody>
<%
	out.println("<br/>&nbsp;]");

	if( !"".equals(layout))  {
		out.println("<br/> ]");
	}

	out.println("<br/>" + HoServletUtil.getArea(request));
	HoServletUtil.setOutArea(request);

} %>



<% if( isHtml ) {
%>

<%
} %>