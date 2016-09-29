<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%>
<%@ include file="/jsp/common/include/include_include.jsp"
%><%@ taglib prefix="jun"  tagdir="/WEB-INF/tags" %>
<jun:function action="다운로드" args=" table_name" url="/s/example/example.do?p_action_flag=r_detail"  fields="Sample.selectTableInfo">
</jun:function>

<jun:function action="추가" args=" table_name" url="/s/example/example.do?p_action_flag=r_detail"  fields="Sample.selectTableInfo">
alert( 'Example.v_tpl.jsp -> 추가');
</jun:function>

<jun:function action="저장" args=" table_name" fields="Sample.selectTableInfo">
alert( 'Example.v_tpl.jsp -> 저장');
</jun:function>

<jun:function action="삭제" args=" table_name" fields="Sample.selectTableInfo">
alert( 'Example.v_tpl.jsp -> 삭제');
</jun:function>

<jun:body pageIndex="<%= TAB_INDEX %>">
	<jun:form id="form_1" action="/example/example.do" title="상세정보" button="저장,삭제">
	</jun:form>
</jun:body>