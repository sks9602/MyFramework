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
%>
<%
	HoModel        model     = new HoModel(request);
	HoParameter    param     = (HoParameter) model.get(HoController.HO_PARAMETER);

	String p_action_flag = param.get("p_action_flag");
	String division      = param.get("division");

	boolean isScript = "script".equals(division);
	boolean isScriptOut = "script_out".equals(division);
	boolean isHtml 	 = "html".equals(division);

	String section_name =  "_"+HoUtil.replaceNull(section);
	String area = HoServletUtil.getString(request, "search_script_item_area" +  p_action_flag);
%>

<% if( isScriptOut ) {
%>
function fs_Alert_<%//=param.get("p_action_flag") %> () {
<jsp:doBody></jsp:doBody>
}
<%
	}
%>

