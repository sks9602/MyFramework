<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/include/include_outline.jsp"%>
<%
	String url = "/example/example.do";
	String [] action_flags =  {"v_list", "v_detail","v_list_detail","v_list_list"};
	String [] titles =  {"목록조회", "상세화면", "목록+상세", "목록+목록"};
%>
<%
		for( int j= 0; j<action_flags.length; j++ ) {
%>
		<jsp:include page="<%=url%>" flush="true">
			<jsp:param name="p_action_flag" value="<%= action_flags[j] %>"/>
			<jsp:param name="outline" value="COMPONENT"/>
			<jsp:param name="division" value="<%= division %>"/>
			<jsp:param name="tab_index" value="<%= j %>"/>
		</jsp:include>
<%
		}
%>


<% if( isHtml ) { %>
	<div id="div_v_main"></div>
<% } %>