<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%>
<%@ include file="/jsp/common/include/include_include.jsp"
%><%@ taglib prefix="jun"  tagdir="/WEB-INF/tags" %>
<jun:function action="fs_click_list_anchor" args=" table_name" url="/s/example/example.do?p_action_flag=r_detail"  fields="Sample.selectTableInfo">
	

</jun:function>

<jun:function action="다운로드" args=" table_name">

</jun:function>

<jun:function action="추가" args=" table_name">

</jun:function>

<jun:body title="<%= TITLE %>" pageIndex="<%= TAB_INDEX %>">
	<jun:data>
		<jun:form section="search"  button="조회,다운로드" action="/example/example.do" gridId="grid_1" position="north">
			<jun:item_search  type="text"   name="mail" title="E-mail"       ></jun:item_search>
			<jun:item_search  type="combo"  name="title1" title="타이틀"  groupCode="B20" first="none"></jun:item_search>
			<jun:item_search  type="combo"  name="title2" title="타이틀"  groupCode="B20" first="none"></jun:item_search>
			<jun:item_search  type="radio"  name="color"  title="제목"    groupCode="B20" first="all"></jun:item_search>
			<jun:item_search  type="checkbox"  name="animal" title="제목"    groupCode="B20" first="all"></jun:item_search>
			<jun:item_search  type="text"   name="mail" title="E-mail"       ></jun:item_search>
			<jun:item_search  type="hidden"  name="p_action_flag" value="r_list_data" ></jun:item_search>
			<jun:item_search  type="text"   name="mail" title="E-mail"       ></jun:item_search>
		</jun:form>
		<jun:data layout="anchor">
			<jun:grid id="grid_1" action="/example/example.do" button="추가" page="15" fields="Sample.selectTableList" options="anchor: '300 0'," groupName="table_comments">
				<jun:columns>
					<jun:column title="이름" column="table_name" renderer="function" editor="link" >
						<jun:column_function functionFor="renderer">
							function (value, p, record){
								return Ext.String.format(
									"<div style=\"cursor:hand;\" onclick=\"fs_click_list_anchor('{1}');\"><b>{0}</b></div>",
								value,
								record.data.table_name,
								// "{"+ arg.join(",")+"}",
								p );
							},
							summaryType: 'count', // 'average', 'sum', 'max', function(records){ ~~  return ?? ; }
				            summaryRenderer: function(value, summaryData, dataIndex) {
				                return ((value === 0 || value > 1) ? '(' + value + ' Tasks)' : '(1 Task)');
				            }
						</jun:column_function>
					</jun:column>
					<jun:column title="설명" column="table_comments" flex="1" align="left" width="200" editor="textfield" ></jun:column>
					<jun:column title="E-Mail" column="email" width="100" resize="N" sortable="N" editor="email" editor="summary">
						<jun:column_function functionFor="summary">
							summaryType: 'count',
				            summaryRenderer: function(value, summaryData, dataIndex) {
				                return ((value === 0 || value > 1) ? '(' + value + ' Vals)' : '(1 Val)');
				            }
						</jun:column_function>
					
					</jun:column>
					<jun:column title="팩스" column="fax_number"  width="150" editor="numberfield, minValue:10, maxValue:100"  renderer="rowspanRenderer"></jun:column>
					<jun:columnGrp title="연락처">
						<jun:column title="전화번호" column="phone_number"  width="150"></jun:column>
						<jun:column title="휴대폰번호" column="TABLE_TYPE"  width="150" editor="checkbox" storeId="v_list_anchor_store_grid_grid_1"></jun:column>
					</jun:columnGrp>
					<jun:column title="팩스" column="fax_number"  width="50" renderer="actioncolumn">
					 items: [{
		                    icon   : '/s/static/js/ext-4.2/ux/image/fam/delete.gif',  // Use a URL in the icon config
		                    tooltip: 'Sell stock',
		                    handler: function(grid, rowIndex, colIndex) {
		                    	var store = Ext.getStore('store_grid_v_list_grid_1');
		                        var rec = store.getAt(rowIndex);
		                        alert("Sell " + rec.get('table_comments'));
		                    }
		                }, {
		                    getClass: function(v, meta, rec) {          // Or return a class from a function
		                        if ( rec.get('table_name') ==  'HR_CONSULTING') {
		                            return 'alert-col';
		                        } else {
		                            return 'buy-col';
		                        }
		                    },
		                    getTip: function(v, meta, rec) {
		                        if ( rec.get('table_name') ==  'HR_CONSULTING' ) {
		                            return 'Hold stock';
		                        } else {
		                            return 'Buy stock -' + rec.get('table_name') ;
		                        }
		                    },
		                    handler: function(grid, rowIndex, colIndex) {
		                    	var store = Ext.getStore('store_grid_v_list_grid_1');
		                        var rec = store.getAt(rowIndex);
		                        alert((rec.get('table_name') ==  'HR_CONSULTING' ? "Hold " : "Buy ") + rec.get('table_name'));
		                    }
		                }]
					</jun:column>
				</jun:columns>
				<jun:gridViewConfig></jun:gridViewConfig>
			</jun:grid>
		</jun:data>
	</jun:data>
</jun:body>