<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag
	import="project.jun.was.HoModel"
	import="project.jun.util.HoUtil"
	import="project.jun.was.parameter.HoParameter"
	import="project.jun.was.spring.HoController"
	import="project.jun.util.HoServletUtil"
%><%@ attribute name="title" type="java.lang.String"
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
	String nowArea = HoServletUtil.getNowArea(request);
	if( "fieldcontainer".equals(nowArea)) {
		HoServletUtil.initIndex(request, HoServletUtil.getArea(request)+">item_row");
		out.println("] }");
		HoServletUtil.setOutArea(request);
	}


	int sectionRow = HoServletUtil.getIndex(request, HoServletUtil.getArea(request)+">fieldcontainer_row");
	HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request)+">fieldcontainer_row");
	HoServletUtil.setInArea(request, "section");

	out.println((sectionRow > 0 ? "," : "" ) + "{xtype:'fieldset',title: '"+title+"', layout: 'anchor', margin : '5 5 0 5', items : [ ");

	HoServletUtil.setInArea(request, "fieldcontainer");
	int itemsRow = HoServletUtil.getIndex(request, HoServletUtil.getArea(request)+"_row");
	HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request)+"_row");
	out.println((itemsRow > 0 ? "," : "" ) +  "{ xtype: 'fieldcontainer', layout: { type: 'hbox', defaultMargins: {top: 0, right: 10, bottom: 0, left: 0} }, items: [");


%>
<jsp:doBody></jsp:doBody>


<%
	String nowEndArea = HoServletUtil.getNowArea(request);
	if( "fieldcontainer".equals(nowEndArea)) {
		HoServletUtil.initIndex(request, HoServletUtil.getArea(request)+">item_row");
		HoServletUtil.setOutArea(request);
	}

	out.println("] }");
	HoServletUtil.initIndex(request, HoServletUtil.getArea(request)+">fieldcontainer");
	HoServletUtil.initIndex(request, HoServletUtil.getArea(request)+">fieldcontainer_row");

	out.println("] }");
	HoServletUtil.setOutArea(request);
%>
<% } %>



<% if( isHtml ) {

%>

<% } %>