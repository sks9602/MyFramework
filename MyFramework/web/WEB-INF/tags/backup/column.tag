<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag
	import="project.jun.was.HoModel"
	import="project.jun.util.HoUtil"
	import="project.jun.util.HoServletUtil"
	import="project.jun.was.parameter.HoParameter"
	import="project.jun.was.spring.HoController"
%><%@ attribute name="title" type="java.lang.String"
%><%@ attribute name="column" type="java.lang.String"
%><%
	HoModel        model     = new HoModel(request);
	HoParameter    param     = (HoParameter) model.get(HoController.HO_PARAMETER);

	String p_action_flag = param.get("p_action_flag");
	String division      = param.get("division");

	boolean isScript = "script".equals(division);
	boolean isHtml 	 = "html".equals(division);

	int gridIndex = HoServletUtil.getIndex(request, "grid_index");

	int idx = HoServletUtil.getIndex(request, "column" + gridIndex);
%><%
	if( isScript ) {
%><%
	if (idx !=0 ) {
		out.print("," );
	}
%>		{ header: '<%= title %>', dataIndex: '<%= column %>', width: 100, sortable:false, align:'center'}
<%
	HoServletUtil.increaseIndex(request, "column" + gridIndex);
	}
%><%
if( isHtml ) {
%><% } %>
