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


<jun:body pageIndex="<%= TAB_INDEX %>">

	<jun:data><!-- layout :  vbox, tab -->
		<jun:form section="search" action="/example/example.do" button="목록,조회,검색" gridId="id_1" delay="Y" >
			<jun:item_search  type="text"   name="" title="E-mail"       ></jun:item_search>
			<jun:item_search  type="combo"  name="" title="타이틀"  groupCode="B20" first="none"></jun:item_search>
			<jun:item_search  type="radio"  name="" title="제목"    groupCode="B20" first="all"></jun:item_search>
			<jun:item_search  type="checkbox"  name="" title="제목"    groupCode="B20" first="all"></jun:item_search>
			<jun:item_search  type="hidden"  name="p_action_flag" value="r_list_data" ></jun:item_search>
		</jun:form>
		<jun:grid action="/example/example.do" id="id_1" width="500" page="5" fields="Sample.selectTableList" lead="checkbox" >
			<jun:columns>
				<jun:column title="성명" column="NAME" ></jun:column>
				<jun:column title="사번" column="MEMBER_NO" ></jun:column>
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
	<jun:data position="east" title="두번째 목록 타이틀.."><!-- layout :  vbox, tab -->
		<jun:form section="search" action="/example/example.do" button="목록,조회,검색" gridId="id_2" id="search_2">
			<jun:item_search  type="text"   name="" title="E-mail"       ></jun:item_search>
			<jun:item_search  type="combo"  name="" title="타이틀"  groupCode="B20" first="none"></jun:item_search>
			<jun:item_search  type="radio"  name="" title="제목"    groupCode="B20" first="all"></jun:item_search>
			<jun:item_search  type="checkbox"  name="" title="제목"    groupCode="B20" first="all"></jun:item_search>
			<jun:item_search  type="hidden"  name="p_action_flag" value="r_list_data" ></jun:item_search>
		</jun:form>
		<jun:grid action="/example/example.do" button="삭제" id="id_2"  width="500" fields="Sample.selectTableList">
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