<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/include/include_outline.jsp"%>
<%

	ArrayList<String []> list = new ArrayList<String []>();
	// String[3] {"url", "p_action_flag", "타이틀"}
	list.add(new String[]{"/system/auth.do", "v_auth_menu", "권한 관리"});
	list.add(new String[]{"/system/auth.do", "v_treelist_auth", "권한별 메뉴"});
	String type= param.get("type");
	
	String [] pages = null;
%>

<%
		for( int j= ( "".equals(type) ? 0 : "main".equals(type) ? 0 : 1) ; j<( "main".equals(type) ? 1 : list.size() ); j++ ) {
			pages = list.get(j);
%>
		<jsp:include page="<%=pages[0]%>" flush="false">
			<jsp:param name="p_action_flag" value="<%= pages[1] %>"/>
			<jsp:param name="title" value="<%= pages[2] %>"/>
			<jsp:param name="outline" value="COMPONENT"/>
			<jsp:param name="tab_index" value="<%= j %>"/>
			<jsp:param name="type" value="<%= type %>"/>
		</jsp:include>
			<!-- jsp:param name="division" value="<%= division %>"/ -->
			<!-- jsp:param name="type" value="<%= type %>"/ -->
<%

		}
%>

<% if( isHtml ) { %>
	<div id="div_v_main"></div>
<% } %>