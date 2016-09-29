<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag
	import="project.jun.was.HoModel"
	import="project.jun.was.spring.HoController"
	import="project.jun.util.HoUtil"
	import="project.jun.was.parameter.HoParameter"
	import="project.jun.dao.HoDao"
	import="project.jun.dao.result.HoList"
	import="project.jun.config.HoConfig"
	import="org.springframework.web.context.support.WebApplicationContextUtils"
	import="org.springframework.web.context.WebApplicationContext"
	import="project.jun.dao.parameter.HoQueryParameterMap"
	import="java.util.Date"
	import="java.text.DateFormat"
	import="project.jun.util.HoValidator"
	import="project.jun.dao.parameter.HoQueryParameterHandler"
	import="project.jun.util.HoServletUtil"
%>
<%@ attribute name="title" type="java.lang.String"  %>
<%@ attribute name="type" type="java.lang.String" %>
<%@ attribute name="groupCode" type="java.lang.String" %>
<%@ attribute name="first" type="java.lang.String" %>
<%@ attribute name="name" type="java.lang.String" %>
<%@ attribute name="value" type="java.lang.String" %>

<%@ variable name-given="longDate" %>
<%!
	final int MAX_ROW_ITEM_SEARCH = 8;
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



<% 	if( isScript ) {

		String nowArea = HoServletUtil.getNowArea(request);


		if( !"fieldcontainer".equals(nowArea)) {
			HoServletUtil.setInArea(request, "fieldcontainer");
			HoServletUtil.initIndex(request, HoServletUtil.getArea(request));
			int itemsRow = HoServletUtil.getIndex(request, HoServletUtil.getArea(request)+"_row");
			HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request)+"_row");
			out.println("<br/> fieldcontainer - "+itemsRow+" [");
		}

		int itemNowIndex = HoServletUtil.getIndex(request, HoServletUtil.getArea(request));
		int increaseIndex = getIndexIncrement( type );

		// out.println("<br/>" + HoServletUtil.getArea(request) + ":" +  itemNowIndex + ":"+ increaseIndex );
		if( itemNowIndex + increaseIndex > MAX_ROW_ITEM_SEARCH ) {
			HoServletUtil.initIndex(request, HoServletUtil.getArea(request)+">item_row");
			out.println("]");
			HoServletUtil.initIndex(request, HoServletUtil.getArea(request));
			String area = HoServletUtil.getNowArea(request);

			HoServletUtil.setOutArea(request);
			HoServletUtil.setInArea(request, "fieldcontainer");
			int itemsRow = HoServletUtil.getIndex(request, HoServletUtil.getArea(request)+"_row");
			HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request)+"_row");
			out.println("<br/> fieldcontainer - "+itemsRow+" [");
		}

		HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request), increaseIndex );
		HoServletUtil.setInArea(request, "item");
		out.println(HoServletUtil.getIndex(request, HoServletUtil.getArea(request)+"_row") + "{item = "+title+"}");
		HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request)+"_row");
	%>
		<jsp:doBody></jsp:doBody>
	<%

%>

<%
		HoServletUtil.setOutArea(request);
	}
%>

<%
	if( isHtml ) {
%>
<jsp:doBody/>
<%	} %>

<%!
	public int getIndexIncrement( String type ) {
		if( "checkbox".equals(type) || "radio".equals(type) ){
			return MAX_ROW_ITEM_SEARCH;
		} else if( "selectCasecade".equals(type) || "selectMulti".equals(type) ){
			return MAX_ROW_ITEM_SEARCH;
		} else if( "period".equals(type) ){
			return 3;
		} else if( "popup".equals(type) ){
			return 3;
		} else if( "hidden".equals(type) ){
			return 0;
		} else if( "grid".equals(type) ){
			return MAX_ROW_ITEM_SEARCH;
		} else {
			return 2;
		}
	}

%>