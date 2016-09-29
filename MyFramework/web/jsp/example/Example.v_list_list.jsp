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
	<jun:function action="접기테스트">
		Ext.getCmp('v_list_list_grid_grid_1').getView().getFeature('v_list_list_group_grid_1').collapseAll();
	</jun:function>

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
			<jun:grid action="/example/example.do" id="grid_1" button="접기테스트" fields="Sample.selectTableList" pageYn="N" groupName="GROUP_VAL" groupTpl="Grouping ID is {name}.">
				<jun:columns>
					<jun:column title="테이블명" column="TNAME" width="200">
						summaryType: 'count',
			            summaryRenderer: function(value, summaryData, dataIndex) {
			            	return  Ext.util.Format.plural(value, ' Table', ' Tables');
			                // return ((value === 0 || value > 1) ? '(' + value + ' Tables)' : '(' + value + ' Table)');
			            },
					</jun:column>
					<jun:column title="컬럼수(최대)" column="CNT" >
						summaryType: 'average', // average  max
			            summaryRenderer: function(value, summaryData, dataIndex) {
			            	return GridColumnRenderer.signDecFormat(value,3);
			            },
					</jun:column>
					<jun:column title="컬럼 여부" column="COLUMN_YN" width="100" editor="checkbox:TNAME" storeId="v_list_list_store_grid_grid_1">
						summaryType: 'max', // average  max
			            summaryRenderer: function(value, summaryData, dataIndex) {
			            	return 'X';
			            },
					</jun:column>
				</jun:columns>
			</jun:grid>
			<jun:grid action="/example/example.do" position="east" title="두번째 목록 타이틀.." width="500"   button="삭제" id="grid_2" page="3" fields="Sample.selectTableList" >
				<jun:columns>
					<jun:column title="성명2" column="NAME" ></jun:column>
					<jun:column title="사번2" column="MEMBER_NO" ></jun:column>
					<jun:column title="휴대폰번호2" column="TABLE_TYPE"  width="150" editor="checkbox" storeId="v_list_store_grid_id_2">
					</jun:column>
				</jun:columns>
			</jun:grid>
	</jun:data>
</jun:body>