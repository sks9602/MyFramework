<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag
	import="project.jun.was.HoModel"
	import="project.jun.util.HoUtil"
	import="project.jun.util.HoValidator"
	import="project.jun.was.parameter.HoParameter"
	import="project.jun.was.spring.HoController"
	import="project.jun.util.HoServletUtil"
%><%@ attribute name="id" type="java.lang.String"
%><%@ attribute name="action" type="java.lang.String"
%><%@ attribute name="title" type="java.lang.String"
%><%@ attribute name="width" type="java.lang.String"
%><%@ attribute name="height" type="java.lang.String"
%><%@ attribute name="page" type="java.lang.String"
%><%@ attribute name="button" type="java.lang.String"
%><%
	HoModel        model     = new HoModel(request);
	HoParameter    param     = (HoParameter) model.get(HoController.HO_PARAMETER);

	String p_action_flag = param.get("p_action_flag");
	String division      = param.get("division");
	String tab_index      = param.get("tab_index");

	boolean isScript = "script".equals(division);
	boolean isHtml 	 = "html".equals(division);
	boolean isFirstTab = "0".equals(tab_index);

	String section_name =  "_grid";
	String area = HoServletUtil.getString(request, "search_script_item_area" +  p_action_flag);
%>



<% if( isScript ) { %>

<%

	String [] buttons = HoValidator.isNotEmpty(button) ? button.split("\\,") : new String [0];

	HoServletUtil.setInArea(request, "grid");
	out.println("<br/>&nbsp;&nbsp;&nbsp;grid- "+HoUtil.replaceNull(id)+" [");

	if( buttons.length> 0 ) {
		out.println("<br/> button - [");
		for( int i=0 ; i< buttons.length ; i++ ) {
			out.println("{"+ buttons[i] + "}");
		}
		out.println("] <br/>");
	}

%>
	<jsp:doBody></jsp:doBody>
<%
	out.println("<br/>&nbsp;&nbsp;&nbsp;]");
	HoServletUtil.setOutArea(request);

%>

<% } %>


<% if( isHtml  ) {
%>

<%
 } %>