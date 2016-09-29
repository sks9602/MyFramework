<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag
	import="project.jun.was.HoModel"
	import="project.jun.util.HoUtil"
	import="project.jun.was.parameter.HoParameter"
	import="project.jun.was.spring.HoController"
	import="project.jun.util.HoValidator"
	import="project.jun.util.HoServletUtil"
%><%@ include file="../include.tag" %>
<%@ attribute name="title"    type="java.lang.String" rtexprvalue="true"
%><%@ attribute name="pageIndex"    type="java.lang.String"
%>
<% 	if( isScript || isScriptOut ) {
		/*
		System.out.println(" isScriptOut : " + isScriptOut );
		System.out.println(" pageIndex : " + pageIndex );
		System.out.println(" type : " + param.get("type") );
		System.out.println(" cond1 : " + (!(pageIndex.equals("0") &&  "main".equals(param.get("type")))) );
		System.out.println(" cond2 : " + ( !pageIndex.equals("0")) );
		*/
		// if( !(pageIndex.equals("0") &&  "main".equals(param.get("type"))) || !pageIndex.equals("0") ) {
		if( pageIndex.equals("0") && "".equals(param.get("type"))) {
			// System.out.println(" retured ... " );
			return;
		}
		
		/*
		if( tab_index.equals("0") &&  "sub".equals(param.get("type") )) {
			return;
		}
		*/
		HoServletUtil.setInArea(request, "body");
		if( isScriptOut ) {
			out.println("function fs_AddTab_" + p_action_flag + "() {" ) ;
			out.println(" if( !Ext.getCmp('"+ p_action_flag +"')) { ");
			out.println(" Ext.getCmp('id_main_tabpanel').add( " ) ;
		}
%>
{
	title : '<%= HoUtil.replaceNull( title, param.get("title")) %>',
	xtype : 'panel',
	iconCls: 'tabs-icon',
	layout : 'border',
	border : false,
	tooltip : '<%= model.getString(HoController.HO_INCLUDE_JSP) %>',
	<% if( isScriptOut ) { %>
	closable: true,
	<% } %>
	id : '<%= p_action_flag %>',
	items : [
			<jsp:doBody></jsp:doBody>
	]
}
<%
		if( isScriptOut ) {
			out.println(" );   " ) ;
			out.println(" }");

			out.println("}" ) ;
		}
		HoServletUtil.setOutArea(request);
	}
%>
