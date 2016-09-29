<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="/jsp/common/include/include_js.jsp"%>
<style>
.bottom-border {
padding: 0 15 0 0;
background:#ffffff;
margin : 0;
}
</style>

<script type="text/javascript">
Ext.onReady(function() {

Ext.QuickTips.init();

<%
	String url = "/example/example.do";
	String [] action_flags =  {"v_list_view"};
%>
Ext.widget('tabpanel', {
	renderTo: 'div_main',
	items : [

<%
	String [] views1 =  {"script"};

	for( int i=0; i<views1.length ; i++) {
		for( int j=0; j<action_flags.length; j++ ) {
			if( j>0 ) {
				out.println(",");
			}
%>
Ext.create('Ext.panel.Panel', { items : [
{
    title: 'Normal Tab',
    renderTo:Ext.getBody(),
    html: "My content was added during construction."
}
] }),
Ext.create('Ext.panel.Panel', { items : [
{
    title: 'Normal Tab',
    renderTo:Ext.getBody(),
    html: "My content was added during construction."
}
] })
<%
		}
	}
%>
		]
	});
});
</script>

</head>

<body>
	<div id="div_main"></div>
<%
	String [] views2 =  {"html"};

	for( int i=0; i<views2.length ; i++) {
		for( int j=0; j<action_flags.length; j++ ) {
%>
	 <jsp:include page="<%=url%>"  flush="true">
		<jsp:param name="p_action_flag" value="<%= action_flags[j] %>"/>
		<jsp:param name="outline" value="COMPONENT"/>
		<jsp:param name="division" value="<%= views2[i] %>"/>
	</jsp:include>
<%
		}
	}
%>
</body>
</html>