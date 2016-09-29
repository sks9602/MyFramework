<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/include/include_outline.jsp"%>
<%

	String url = "/example/example.do";
	String [] action_flags =  {"v_list","v_list_anchor","v_tree_detail", "v_detail" ,"v_list_detail","v_list_list","v_detail_list","v_list_detail_list","v_list_tab_list","v_tpl","v_treelist","v_list_list_hori","v_list_list_treelist"}; //
	String [] titles =  {"목록조회","목록조회 (확장)","트리+상세", "상세화면", "목록+상세", "목록+목록","상세+목록", "목록+상세+목록", "목록+Tab+목록", "XTemplate", "TreeGrid", "목록+목록 Horizon", "Grid+Grid+Tree"};

	String type= param.get("type");
%>

<%
		for( int j= ( "".equals(type) ? 0 : "main".equals(type) ? 0 : 1) ; j<( "main".equals(type) ? 1 : action_flags.length ); j++ ) {

%>
		<jsp:include page="<%=url%>" flush="false">
			<jsp:param name="p_action_flag" value="<%= action_flags[j] %>"/>
			<jsp:param name="title" value="<%= titles[j] %>"/>
			<jsp:param name="outline" value="COMPONENT"/>
			<jsp:param name="tab_index" value="<%= j %>"/>
		</jsp:include>
			<!-- jsp:param name="division" value="<%= division %>"/ -->
			<!-- jsp:param name="type" value="<%= type %>"/ -->
<%

		}
%>

<% if( isHtml ) { %>
	<div id="div_v_main"></div>
<% } %>