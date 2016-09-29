<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/include/include_outline.jsp"%>
<%
	String url = "/example/example.do";
	String [] action_flags =  {"v_list_view", "v_detail"};
	String [] titles =  {"목록조회", "상세화면"};
%>

<% if( isScript ) { %>
Ext.widget('tabpanel', {
	renderTo: 'div_<%= p_action_flag%>',
	id : 'id_main_tabpanel',
	region: 'center',
	margins: '0 5 5 0',
	title : '메뉴명 또는 선택된 item',
	defaults: {
            autoScroll: true
        },
	items : [
<% }  %>
<%
		for( int j=0; j<action_flags.length; j++ ) {
			if( isScript && j>0 ) {
				out.println(", // " + division);
			}
%>
<% if( isScript ) { %>
{
title : '<%= titles[j]%>',
xtype : 'panel',
items : [
<% }  %>

		<jsp:include page="<%=url%>" flush="true">
			<jsp:param name="p_action_flag" value="<%= action_flags[j] %>"/>
			<jsp:param name="outline" value="COMPONENT"/>
			<jsp:param name="division" value="<%= division %>"/>
		</jsp:include>
<% if( isScript ) { %>
]}
<% } %>
<%
		}
%>
<% if( isScript ) { %>
		]
	})
<% } %>

<% if( isHtml ) { %>
	<div id="div_<%= p_action_flag%>"></div>
<% } %>