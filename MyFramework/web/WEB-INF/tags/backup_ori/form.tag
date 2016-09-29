<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag
	import="project.jun.was.HoModel"
	import="project.jun.util.HoUtil"
	import="project.jun.was.parameter.HoParameter"
	import="project.jun.was.spring.HoController"
	import="project.jun.util.HoServletUtil"
	import="project.jun.util.HoValidator"
%><%@ attribute name="section" type="java.lang.String"
%><%@ attribute name="action" type="java.lang.String"
%><%@ attribute name="title" type="java.lang.String"
%><%@ attribute name="button" type="java.lang.String"
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

<% if( isScript ) {
	HoServletUtil.setInArea(request, "form");
	out.println("<br/>-------------------");
	out.println("<br/>" + HoServletUtil.getArea(request));

	String [] buttons = HoValidator.isNotEmpty(button) ? button.split("\\,") : new String [0];

%>
	<jsp:doBody></jsp:doBody>
<%
	String nowArea = HoServletUtil.getNowArea(request);
	if( "fieldcontainer".equals(nowArea)) {
		HoServletUtil.initIndex(request, HoServletUtil.getArea(request)+">item_row");
		HoServletUtil.setOutArea(request);
	}

	out.println("]");

	if( buttons.length> 0 ) {
		out.println("<br/> button - [");
		for( int i=0 ; i< buttons.length ; i++ ) {
			out.println("{"+ buttons[i] + "}");
		}
		out.println("]");
	}

	out.println("<br/> " + HoServletUtil.getArea(request));
	HoServletUtil.initIndex(request, HoServletUtil.getArea(request)+">fieldcontainer");
	HoServletUtil.initIndex(request, HoServletUtil.getArea(request)+">fieldcontainer_row");
	HoServletUtil.setOutArea(request);

	}
%>



<% if( isHtml ) {

} %>