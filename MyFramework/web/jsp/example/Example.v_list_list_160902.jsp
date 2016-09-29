<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%>
<%@ include file="/jsp/common/include/include_include.jsp"
%><%@ taglib prefix="jun"  tagdir="/WEB-INF/tags" %>


<jun:functions  targetId="search_1">
	<jun:function action="목록" args=" table_name" url="/s/example/example.do?p_action_flag=r_detail"  fields="Sample.selectTableInfo">
	</jun:function>
	
	<jun:function action="검색" args=" table_name" url="/s/example/example.do?p_action_flag=r_detail"  fields="Sample.selectTableInfo">
	</jun:function>
</jun:functions>

<jun:functions  targetId="grid_1">
	<jun:function action="클릭" args=" table_name" url="/s/example/example.do?p_action_flag=r_detail"  fields="Sample.selectTableInfo">
		// panel선택
		var east = Ext.getCmp("v_list_list_data_east");
		
		// collapsed상태에 따라 expand 또는 collpase
		east.getCollapsed() ? east.expand() :  east.collapse();
	</jun:function>

</jun:functions>

<jun:functions  targetId="grid_2">
	<jun:function action="삭제" args=" table_name" url="/s/example/example.do?p_action_flag=r_detail"  fields="Sample.selectTableInfo">
	</jun:function>
</jun:functions>



<jun:body title="목록+목록 조회" pageIndex="<%= TAB_INDEX %>">
	<jun:form section="search" action="/example/example.do" button="목록,검색" gridId="grid_1" id="search_1" >
		<jun:itemText  type="hidden"  name="p_action_flag" value="r_list_data" ></jun:itemText>
		<jun:itemText  type="text"   name="email" title="E-mail"       ></jun:itemText>
		<jun:itemCode  type="combo"  name="title1" title="타이틀"  groupCode="SYS001" first="none" colspan="2"></jun:itemCode>
		<jun:itemCode  type="radio"  name="title1" title="제목"    groupCode="SYS002" first="all" colspan="2"></jun:itemCode>
		<jun:itemCode  type="checkbox"  name="title3" title="제목"    groupCode="SYS003" first="all" colspan="3"></jun:itemCode>
	</jun:form>

	<jun:data ><!-- layout :  vbox, tab -->
		<jun:data ><!-- layout :  vbox, tab -->
			<jun:grid action="/example/example.do" id="grid_1" fields="Sample.selectTableList">
				<jun:columns>
					<jun:column title="성명" column="table_name" renderer="function" editor="link" width="200">
					</jun:column>
					<jun:column title="사번" column="MEMBER_NO" ></jun:column>
					<jun:column title="휴대폰번호" column="TABLE_TYPE"  width="150" editor="checkbox" storeId="v_list_store_grid_id_1">
					</jun:column>
				</jun:columns>
			</jun:grid>
		</jun:data>
		<jun:data position="east" id="east" title="두번째 목록 타이틀.." ><!-- layout :  vbox, tab -->
			<jun:grid action="/example/example.do" button="삭제" id="grid_2" page="3" fields="Sample.selectTableList" >
				<jun:columns>
					<jun:column title="성명2" column="NAME" ></jun:column>
					<jun:column title="사번2" column="MEMBER_NO" ></jun:column>
					<jun:column title="휴대폰번호2" column="TABLE_TYPE"  width="150" editor="checkbox" storeId="v_list_store_grid_id_2">
					</jun:column>
				</jun:columns>
			</jun:grid>
		</jun:data>
	</jun:data>
</jun:body>