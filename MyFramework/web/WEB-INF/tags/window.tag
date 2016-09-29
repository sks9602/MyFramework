<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag
	import="project.jun.was.HoModel"
	import="project.jun.util.HoUtil"
	import="project.jun.was.parameter.HoParameter"
	import="project.jun.was.spring.HoController"
	import="project.jun.util.HoServletUtil"
	import="project.jun.util.HoValidator"
	import="project.jun.dao.HoDao"
	import="project.jun.util.HoSpringUtil"
	import="project.jun.dao.result.HoMap"
	import="project.jun.dao.parameter.HoQueryParameterMap"
	import="org.apache.ibatis.metadata.result.MetaData"
%><%@ include file="include.tag" %>
<%@ attribute name="width" type="java.lang.String" 
%><%@ attribute name="height" type="java.lang.String" 
%><%@ attribute name="layout" type="java.lang.String" 
%><%@ attribute name="title" type="java.lang.String" 
%><%@ attribute name="id" type="java.lang.String" 
%><%@ attribute name="hide" type="java.lang.String" 
%><%-- Window숨기려고 하는 경우에는 "Y" 또는 "true" --%>
<%@ attribute name="maxItem" type="java.lang.String"
%>
<% 
HoServletUtil.setString(request, "MAX_ROW_ITEM", HoUtil.replaceNull(maxItem, "4"));

if( isScriptOut ) { 
	HoServletUtil.setInArea(request, "window");
	id = HoUtil.replaceNull(id, random());
%>
<% if(HoServletUtil.getNowArea(request).indexOf("function") < 0) { %>
Ext.onReady(function() {
<% } %>
	var <%= p_action_flag%>_win_<%= HoUtil.replaceNull(id)%> = Ext.getCmp('<%= p_action_flag%>_window_<%= HoUtil.replaceNull(id)%>') ;
	if( !<%= p_action_flag%>_win_<%= HoUtil.replaceNull(id)%> ) {
		<%= p_action_flag%>_win_<%= HoUtil.replaceNull(id, "")%> = Ext.create('Ext.window.Window', {
		    title: '<%= HoUtil.replaceNull(title, "Window 제목") %>',
		    id : '<%= p_action_flag%>_window_<%= HoUtil.replaceNull(id) %>' ,
		    height: <%= HoUtil.replaceNull(height, "500") %>,
		    width: <%= HoUtil.replaceNull(width, "700") %>,
		    layout: '<%= HoUtil.replaceNull(layout, "fit") %>',
		    items: [
				<jsp:doBody></jsp:doBody>
		    ]
		});
	}
	<% if(!HoValidator.isIn(hide, new String[]{"Y","true"} , true)) { // Window숨기는 경우%>
	<%= p_action_flag%>_win_<%= HoUtil.replaceNull(id)%>.show();
	<% } %>
<% if(HoServletUtil.getNowArea(request).indexOf("function") < 0) { %>
});
<% } %>
<% 
	HoServletUtil.setOutArea(request);
} // end of if( isScriptOut ) 
%>

