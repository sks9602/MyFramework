<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag
	import="project.jun.was.HoModel"
	import="project.jun.util.HoUtil"
	import="project.jun.was.parameter.HoParameter"
	import="project.jun.was.spring.HoController"
	import="project.jun.util.HoValidator"
	import="project.jun.util.HoServletUtil"
%><%@ attribute name="title"    type="java.lang.String"
%><%@ attribute name="pageIndex"    type="java.lang.String"
%>
<%
	HoModel        model     = new HoModel(request);
	HoParameter    param     = (HoParameter) model.get(HoController.HO_PARAMETER);

	String p_action_flag = param.get("p_action_flag");
	String division      = param.get("division");
	String tab_index      = param.get("tab_index");

	boolean isScriptOut = "script_out".equals(division);
	boolean isScript = "script".equals(division);
	boolean isHtml 	 = "html".equals(division);
	boolean isFirstTab = "0".equals(tab_index);

%>

<% 	if( isScript) {
		HoServletUtil.setInArea(request, "body");
		out.println(HoServletUtil.getArea(request));
%>
		<jsp:doBody></jsp:doBody>
<%
		out.println("<br/>" + HoServletUtil.getArea(request));
		HoServletUtil.setOutArea(request);
		out.println("<br/> end.." + HoServletUtil.getArea(request));
	}
%>



<% 	if( isHtml ) {
%>

<% 	}
%>