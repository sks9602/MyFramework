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
	String tab_index      = param.get("tab_index");

	boolean isScript = "script".equals(division);
	boolean isHtml 	 = "html".equals(division);
	boolean isFirstTab = "0".equals(tab_index);

	int gridIndex = HoServletUtil.getIndex(request, "grid_index");

	int idx = HoServletUtil.getIndex(request, "column" + gridIndex);
%>


<% if( isScript ) { %>

<%
		HoServletUtil.setInArea(request, "item");
		out.println("{item = "+title+"}");
		HoServletUtil.setOutArea(request);

%>
<% } %>

<% if( isHtml ) {%>
<% } %>