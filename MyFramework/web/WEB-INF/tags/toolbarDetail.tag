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
<%@ include file="include.tag" %>
<%@ attribute name="title" type="java.lang.String"  %>
<%@ attribute name="type" type="java.lang.String" %>
<%@ attribute name="value" type="java.lang.String" %>
<%@ attribute name="require" type="java.lang.String" %><%-- 필수여부 : 'Y'필수 / '기타' 선택  --%>
<%@ attribute name="newLine" type="java.lang.String" %><%-- Y/true일 경우 Toolbar를 다음 라인에 출력   --%>
<% 	if( isScript || isScriptOut ) {

		String nowArea = HoServletUtil.getNowArea(request);


		HoServletUtil.setInArea(request, "toolbaritem");
		
		// 이전에 버튼이 있을 경우
		if("Y".equals(HoServletUtil.getString(request, "dockedItems-buttons"))) {
			out.println(",");
			HoServletUtil.setString(request, "dockedItems-buttons", null);
		}
		if("right".equals(HoServletUtil.getString(request, "dockedItems-align"))) {
			out.println("'->',");
			HoServletUtil.setString(request, "dockedItems-align", null);
		} 
		
		int idx = HoServletUtil.getIndex(request, HoServletUtil.getArea(request)+"_row");
		out.println(idx > 0 ? "," : "");
		
		
		// out.println(HoServletUtil.getIndex(request, HoServletUtil.getArea(request)+"_row") == 0 ? "'->'," : ",");
		// out.println(HoServletUtil.getIndex(request, HoServletUtil.getArea(request)+"_row") > 0 ? "," : "");
		HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request)+"_row");

		if( HoValidator.isIn(newLine, new String[]{"Y", "true"}, true)) {
%>
			]}
			,{xtype: 'toolbar', dock :'top', flex : 1, border : true, 
			  id : 'tbar_<%=p_action_flag%>_<%=HoServletUtil.getString(request, "grid-id")%>_<%= idx %>',
			  items : [
<%			
		}
		if( "combo".equals(type) || "select".equals(type) || "combotipple_ux".equals(type) ){
%>
	'<%= title %>', <jsp:doBody></jsp:doBody>
<%
		} else if( "text".equals(type) ){
%>
	'<%= title %>', <jsp:doBody></jsp:doBody>
<%
} else if( "html".equals(type) ){
%>
	'<%= title %>'
<%
		} else if( "button".equals(type)) {
%>
			{
				xtype     : 'button',
				text      : '<%= title %>',  
				<jsp:doBody></jsp:doBody>
				iconCls:'top-search-btn-icon',  border: 1, style: { borderColor: '#99bce8', borderStyle: 'solid'}
			}
<%
		}
		HoServletUtil.setOutArea(request);
	}
%>

<%
	if( isHtml ) {
%>
<jsp:doBody/>
<%	} %>
