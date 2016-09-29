<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag
	import="project.jun.was.HoModel"
	import="project.jun.util.HoUtil"
	import="project.jun.util.HoServletUtil"
	import="project.jun.was.parameter.HoParameter"
	import="project.jun.was.spring.HoController"
	import="project.jun.util.HoValidator"
%><%@ attribute name="title" type="java.lang.String"
%><%
	HoModel        model     = new HoModel(request);
	HoParameter    param     = (HoParameter) model.get(HoController.HO_PARAMETER);

	String p_action_flag = param.get("p_action_flag");
	String division      = param.get("division");
	String tab_index      = param.get("tab_index");

	boolean isScript = "script".equals(division);
	boolean isHtml 	 = "html".equals(division);
	boolean isFirstTab = "0".equals(tab_index);

	int gridIndex = HoServletUtil.getIndex(request, "grid_index");

%>


<% if( isScript ) { %>

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