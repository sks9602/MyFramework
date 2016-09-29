<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%>
<%@ include file="/jsp/common/include/include_include.jsp"
%><%@ taglib prefix="jun"  tagdir="/WEB-INF/tags" %>

<jun:function action="목록" args=" table_name" url="/s/example/example.do?p_action_flag=r_detail"  fields="Sample.selectTableInfo">
</jun:function>

<jun:function action="조회" args=" table_name" url="/s/example/example.do?p_action_flag=r_detail"  fields="Sample.selectTableInfo">
</jun:function>

<jun:function action="검색" args=" table_name" url="/s/example/example.do?p_action_flag=r_detail"  fields="Sample.selectTableInfo">
</jun:function>

<jun:function action="삭제" args=" table_name" url="/s/example/example.do?p_action_flag=r_detail"  fields="Sample.selectTableInfo">
</jun:function>
<jun:function action="저장" args=" table_name" url="/s/example/example.do?p_action_flag=r_detail"  fields="Sample.selectTableInfo">
</jun:function>
<jun:function action="추가" args=" table_name" url="/s/example/example.do?p_action_flag=r_detail"  fields="Sample.selectTableInfo">
</jun:function>

<jun:function action="조회" args=" table_name"  fields="Sample.selectTableInfo">
	var store1 = Ext.getStore('v_list_list_treelist_store_grid_id_1'); 
	store1.load({params: {'p_action_flag':'r_list_data' } });
	var store = Ext.getStore('v_list_list_treelist_store_grid_id_2'); 
	store.load({params: {'p_action_flag':'r_list_data' } });
</jun:function>

<jun:body pageIndex="<%= TAB_INDEX %>">

	<jun:data  ><!-- layout :  vbox, tab -->
		<jun:form section="search" action="/example/example.do" button="목록,조회,검색" gridId="id_1" delay="Y" >
			<jun:item_search  type="hidden"  name="p_action_flag" value="r_list_data" ></jun:item_search>
			<jun:item_search  type="combo"  name="" title="테이블"  groupCode="B20" first="none"></jun:item_search>
		</jun:form>
		<jun:data  >
			<jun:grid action="/example/example.do" id="id_1" title="목표 테이블 컬럼.." button="저장"  width="380" page="5" fields="Sample.selectTableList">
				<jun:columns>
					<jun:column title="테이블 명" column="table_name" width="150"></jun:column>
					<jun:column title="테이블 COMMENTS" column="table_comments"  width="200"></jun:column>
				</jun:columns>
				<jun:gridViewConfig>
			        viewConfig: {
			            stripeRows: true,
			            plugins: {
			                ptype: 'gridviewdragdrop',
			                dragGroup: 'firstGridDDGroup',
			                dropGroup: 'secondGridDDGroup'
			            },
			            listeners: {
			                drop: function(node, data, dropRec, dropPosition) {
			                    var dropOn = dropRec ? ' ' + dropPosition + ' ' + dropRec.get('name') : ' on empty view';
			                    hoAlert("Drag from right to left Dropped " + data.records[0].get('name') + dropOn);
			                }
			            }
			        },		
				</jun:gridViewConfig>
			</jun:grid>
		</jun:data>
		<jun:data position="east" collapse="N"><!-- layout :  vbox, tab -->
			<jun:grid action="/example/example.do" title="이관 대상 컬럼...." button="삭제" id="id_2"  width="380" fields="Sample.selectTableList">
				<jun:columns>
					<jun:column title="테이블 명" column="table_name" width="150"></jun:column>
					<jun:column title="테이블 COMMENTS" column="table_comments"  width="200"></jun:column>
				</jun:columns>
				<jun:gridViewConfig>
			        viewConfig: {
			            stripeRows: true,
			            plugins: {
			                ptype: 'gridviewdragdrop',
			                dragGroup: 'secondGridDDGroup',
			                dropGroup: 'firstGridDDGroup'
			            },
			            listeners: {
			                drop: function(node, data, dropRec, dropPosition) {
			                    var dropOn = dropRec ? ' ' + dropPosition + ' ' + dropRec.get('name') : ' on empty view';
			                    hoAlert("Drag from left to right Dropped " + data.records[0].get('name') + dropOn, 1000);
			                }
			            }
			        },		
				</jun:gridViewConfig>
			</jun:grid>
		</jun:data>
	</jun:data>
	<jun:data position="east" title="컬럼 조회...." width="700">
		<jun:data  position="west" >
			<jun:treegrid id="grid_1" action="/example/example.do" button="추가,저장" page="5" lead="checkbox" fields="Sample.selectTableList" >
				<jun:toolbars>
					<jun:toolbar_detail  type="combo"  name="" title="타이틀"  groupCode="B02" first="none"></jun:toolbar_detail>
					<jun:toolbar_detail  type="button"  name="" title="타이틀" ></jun:toolbar_detail>
				</jun:toolbars>
				<jun:columns>
					<jun:treecolumn title="이름" column="text" locked="Y" align="left" renderer="function" editor="textfield" > <!--  locked="Y" 때문에 editor안됨.. -->
						function (value, p, record){
							return Ext.String.format(
								"<span style=\"cursor:pointer;text-align:left;\" onclick=\"hoAlert('{0}', Ext.emptyFn, 2000);\"><b>{0}</b></span>",
							value,
							record.data.text,
							p );
						}
					</jun:treecolumn>
					<jun:column title="설명" column="id" flex="1" align="left" width="200" editor="textfield"></jun:column>
					<jun:column title="E-Mail" column="email" width="100" resize="N" sortable="N" editor="email" ></jun:column>
					<jun:column title="팩스" column="fax_number"  width="150" editor="numberfield, minValue:10, maxValue:100"  renderer="rowspanRenderer"></jun:column>
				</jun:columns>
				<jun:gridViewConfig></jun:gridViewConfig>
			</jun:treegrid>
		</jun:data>
			<jun:grid action="/example/example.do"  title="테이블 선택.." button="삭제" id="id_3"  width="300" fields="Sample.selectTableList">
				<jun:columns>
					<jun:column title="성명" column="NAME" ></jun:column>
					<jun:column title="사번" column="MEMBER_NO" ></jun:column>
				</jun:columns>
				<jun:gridViewConfig>
			        viewConfig: {
			            stripeRows: true,
			            plugins: {
			                ptype: 'gridviewdragdrop',
			                dragGroup: 'secondGridDDGroup',
			                dropGroup: 'firstGridDDGroup'
			            },
			            listeners: {
			                drop: function(node, data, dropRec, dropPosition) {
			                    var dropOn = dropRec ? ' ' + dropPosition + ' ' + dropRec.get('name') : ' on empty view';
			                    hoAlert("Drag from left to right Dropped " + data.records[0].get('name') + dropOn, 1000);
			                }
			            }
			        },		
				</jun:gridViewConfig>
			</jun:grid>
	</jun:data>
</jun:body>