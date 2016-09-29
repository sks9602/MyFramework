<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%>
<%@ include file="/jsp/common/include/include_include.jsp"
%><%@ taglib prefix="jun"  tagdir="/WEB-INF/tags" %>

<jun:function action="목록" args=" table_name" url="/s/example/example.do?p_action_flag=r_detail"  fields="Sample.selectTableInfo">
</jun:function>

<jun:function action="조회_미사용" args=" table_name" url="/s/example/example.do?p_action_flag=r_detail"  fields="Sample.selectTableInfo">
</jun:function>

<jun:function action="검색" args=" table_name" url="/s/example/example.do?p_action_flag=r_detail"  fields="Sample.selectTableInfo">
</jun:function>

<jun:function action="삭제" args=" table_name" url="/s/example/example.do?p_action_flag=r_detail"  fields="Sample.selectTableInfo">
</jun:function>

<jun:function action="클릭" args=" table_name" url="/s/example/example.do?p_action_flag=r_detail"  fields="Sample.selectTableInfo">
	// panel선택
	var east = Ext.getCmp("v_list_list_data_east");
	
	// collapsed상태에 따라 expand 또는 collpase
	east.getCollapsed() ? east.expand() :  east.collapse();
</jun:function>

<jun:body title="목록+목록 조회" pageIndex="<%= TAB_INDEX %>">
	<jun:form section="search" action="/example/example.do" button="목록,조회,검색" gridId="id_1">
		<jun:item_searchText  type="hidden"  name="p_action_flag" value="r_list_data" ></jun:item_searchText>
		<jun:item_search  type="text"   name="" title="E-mail"       ></jun:item_search>
		<jun:item_search  type="combo"  name="" title="타이틀"  groupCode="B20" first="none"></jun:item_search>
		<jun:item_search  type="radio"  name="" title="제목"    groupCode="B20" first="all"></jun:item_search>
		<jun:item_search  type="checkbox"  name="" title="제목"    groupCode="B20" first="all"></jun:item_search>
	</jun:form>

	<jun:data ><!-- layout :  vbox, tab -->
		<jun:data ><!-- layout :  vbox, tab -->
			<jun:grid action="/example/example.do" id="id_1" width="500" fields="Sample.selectTableList">
				<jun:columns>
					<jun:column title="성명" column="table_name" renderer="function" editor="link" width="200">
						<jun:column_function functionFor="renderer">
							function (value, p, record){
								return Ext.String.format(
									"<div class=\"in_grid_url_link\" onclick=\"fs_v_list_list_클릭('{1}');\">{0}</div>",
								value,
								record.data.table_name,
								p );
							}
						</jun:column_function>
					</jun:column>
					<jun:column title="사번" column="MEMBER_NO" ></jun:column>
					<jun:column title="휴대폰번호" column="TABLE_TYPE"  width="150" editor="checkbox" storeId="v_list_store_grid_id_1">
						<jun:column_function functionFor="checkbox">
							function( _column, _rowIndex, _checked, _eOpts) {  
								
								var store = Ext.getStore('v_list_store_grid_grid_1');
								
								var record = store.getAt(_rowIndex);
								var columnIndex = _column.getIndex();
								
								record.set('hp_number', _checked );
							}
						</jun:column_function>
					</jun:column>
				</jun:columns>
			</jun:grid>
		</jun:data>
		<jun:data position="east" id="east" title="두번째 목록 타이틀.."  width="500"><!-- layout :  vbox, tab -->
			<jun:grid action="/example/example.do" button="삭제" id="id_2" page="3" fields="Sample.selectTableList" >
				<jun:columns>
					<jun:column title="성명" column="NAME" ></jun:column>
					<jun:column title="사번" column="MEMBER_NO" ></jun:column>
					<jun:column title="휴대폰번호" column="TABLE_TYPE"  width="150" editor="checkbox" storeId="v_list_store_grid_id_2">
						<jun:column_function functionFor="checkbox">
							function( _column, _rowIndex, _checked, _eOpts) {  
								
								var store = Ext.getStore('v_list_store_grid_grid_1');
								
								var record = store.getAt(_rowIndex);
								var columnIndex = _column.getIndex();
								
								record.set('hp_number', _checked );
							}
						</jun:column_function>
					</jun:column>
				</jun:columns>
			</jun:grid>
		</jun:data>
	</jun:data>
</jun:body>