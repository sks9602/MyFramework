<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag
	import="project.jun.was.HoModel"
	import="project.jun.util.HoUtil"
	import="project.jun.was.parameter.HoParameter"
	import="project.jun.was.spring.HoController"
	import="project.jun.util.HoValidator"
	import="project.jun.util.HoServletUtil"
%><%@ attribute name="title"    type="java.lang.String"
%><%@ attribute name="pageIndex"    type="java.lang.String"
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

<% 	if( isScript) {

		if( !tab_index.equals("0") &&  "main".equals(param.get("type") )) {
			return;
		}
		if( tab_index.equals("0") &&  "sub".equals(param.get("type") )) {
			return;
		}

		HoServletUtil.setInArea(request, "body");
		if( "sub".equals(param.get("type")) ) {
			out.println("function fs_AddTab_" + p_action_flag + "() {" ) ;
			out.println(" if( !Ext.getCmp('"+ p_action_flag +"')) { ");
			out.println(" Ext.getCmp('id_main_tabpanel').add( " ) ;
		}
%>
{
title : '<%= title %>',
xtype : 'panel',
<% if( "sub".equals(param.get("type")) ) { %>
closable: true,
<% } %>
id : '<%= p_action_flag %>',
items : [
		<jsp:doBody></jsp:doBody>
	]
}
<%
		if( "sub".equals(param.get("type")) ) {
			out.println(" );   " ) ;
			out.println(" }");

			out.println("}" ) ;
		}
		HoServletUtil.setOutArea(request);
	}
%>



<% 	if( isHtml ) {
%>

<% 	}
%>