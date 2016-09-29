<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%>
<%@ include file="/jsp/common/include/include_include.jsp"
%><%@ taglib prefix="jun"  tagdir="/WEB-INF/tags" %>
<jun:function action="다운로드" targetId="search_1">
	fs_FileDownLoad('1');
	// fs_ExcelDownLoad('1');
</jun:function>


<jun:function action="추가" targetId="grid_2">
	var grid = Ext.getCmp('v_treelist_detail_grid_grid_2');
	
	var svc_cd = Ext.getCmp('v_treelist_detail_detail_1_SVC_CD');
	var menu_id = Ext.getCmp('v_treelist_detail_detail_1_MENU_ID');
	
	if( svc_cd.getValue() == '' || menu_id.getValue() == '' ) {
		// Ext.get('v_treelist_detail_grid_1_col_MENU_NM').frame('blue', 1, 0.2).frame('blue', 1, 0.2); 
		// grid.el.frame('red', 1, 0.2).frame('red', 1, 0.2); 
		
		fs_Frame('v_treelist_detail_grid_1_col_MENU_NM', 'blue');
		fs_Frame(grid, 'red');
		hoAlert('세부기능을 추가하시려면 먼저 [메뉴 명]을 선택하세요.', Ext.exptyFn, 2000);
	} else {
		grid.getStore().add({'SVC_CD' : svc_cd.getValue(), 'MENU_ID' : menu_id.getValue(), 'ACTION_FLAG' : '* 추가하세요.'});
	}
</jun:function>

<jun:function action="저장" targetId="grid_2" args=" table_name" fields="Sample.selectTableInfo">
	var grid = Ext.getCmp('v_treelist_detail_grid_grid_2');
	
	grid.submit('changed', 'b_mergeList', { });
</jun:function>

<jun:function action="삭제" targetId="grid_2">
	var grid = Ext.getCmp('v_treelist_detail_grid_grid_2');
	
	grid.submit('checked', 'b_deleteList', { });
</jun:function>


<jun:function action="상세조회" targetId="grid_1" args="svc_cd, menu_id"  url="/system/menu.do?p_action_flag=r_detail" fields="Menu.selectMenuInfo">
	// 우측 [상세 정보]panel선택
	var east = Ext.getCmp("v_treelist_detail_data_east");
	east.expand();
	
	if( east.getCollapsed( ) ) {
		east.on("expand",function(panel, eOpts) {
			// 우측 화면 데이터 로딩 
			fs_load();
		});
	} else {
		// 우측 화면 데이터 로딩 
		fs_load();
	}
	
	/**
	 * 우측 화면 데이터 로딩 function
	 */
	function fs_load() {
	
			store.on("load", function(_this, _records, _successful, _eOpts ) {
				// [메뉴 정보] From 내용 설정
				var form = Ext.getCmp('v_treelist_detail_detail_detail_1');
		        form.loadRecord(_records[0]);
		
				east.setTitle('[' + _records[0].data.MENU_NM +'] 메뉴의 상세 정보');

				// [세부기능 목록] 조회.
				var store = Ext.getStore('v_treelist_detail_store_grid_grid_2'); 
				args.p_action_flag = 'r_method_list';
				store.load({page : 1, params: args }); 
			});
	
	}
</jun:function>

<jun:function action="메뉴추가" targetId="grid_1" args="svc_cd, menu_id"  url="/system/menu.do?p_action_flag=r_detail" fields="Menu.selectMenuInfo">
	// 우측 [상세 정보]panel선택
	var east = Ext.getCmp("v_treelist_detail_data_east");
	east.expand();
	
	/*
	var p_action_flag = Ext.getCmp('v_treelist_detail_detail_1_P_ACTION_FLAG');
	p_action_flag.setValue('b_insert');
	
	store.on("load", function(_this, _records, _successful, _eOpts ) {

		// [메뉴 정보] From 내용 설정
		var form = Ext.getCmp('v_treelist_detail_detail_detail_1');
        form.loadRecord(_records[0]);

		east.setTitle('메뉴 추가');
	});
	*/
	
	
	<jun:model var="record" name="Menu" fields="Menu.selectMenuInfo">MENU_ID : 'AAAA'</jun:model>


	var form = Ext.getCmp('v_treelist_detail_detail_detail_1');
    form.loadRecord(record);
	
</jun:function>

<jun:function action="상세정보저장" targetId="detail_1">

	var form = Ext.getCmp('v_treelist_detail_detail_detail_1');
	
	var p_action_flag = Ext.getCmp('v_treelist_detail_detail_1_P_ACTION_FLAG');
	var svc_cd = Ext.getCmp('v_treelist_detail_detail_1_SVC_CD');
	var menu_id = Ext.getCmp('v_treelist_detail_detail_1_MENU_ID');
	
	if( p_action_flag.getValue() == '' || svc_cd.getValue() == '' || menu_id.getValue() == '' ) {
		form.el.frame('red', 1, 0.2).frame('red', 1, 0.2); 
		hoAlert('추가 또는 수정 할 정보를 입력하세요.', Ext.exptyFn, 2000);
	} else {
		form.submit({
			'msgTxt' : '저장하시겠습니까?', 
			success : function(form, action) {
				Ext.Msg.alert('Success', getResultMessageForm(form, action)); // action.result.message);
			},
			failure: function(form, action) {
				Ext.Msg.alert('Failure', getResultMessageForm(form, action)); // action.result.message);
			}
		});
	}
	
</jun:function>


<jun:body pageIndex="<%= TAB_INDEX %>">
	<jun:data>
		<jun:form section="search" id="search_1"  button="조회,다운로드" gridId="grid_1" position="north" maxItem="4">
			<jun:itemText  type="hidden"  name="p_action_flag" value="r_treelist" ></jun:itemText>
			<jun:itemCode  type="combo"  name="SVC_CD" title="서비스 구분"  groupCode="SYS001" ></jun:itemCode>
		</jun:form>
		<jun:data>
			<jun:treegrid id="grid_1" action="/system/menu.do" fields="Menu.selectMenuList" >
				<jun:toolbars>
					<jun:toolbar_detail  type="combotipple_ux"  name="" title="타이틀"  groupCode="SYS001" first="none"></jun:toolbar_detail>
					<jun:toolbar_detail  type="button"  name="" title="타이틀" ></jun:toolbar_detail>
				</jun:toolbars>
				<jun:columns>
					<jun:treecolumn title="메뉴 명" column="MENU_NM" flex="1" align="left"></jun:treecolumn>
					<jun:column title="메뉴 URL" column="LINK_URL" align="left" width="200"></jun:column>
					<jun:column title="권한 적용 여부" column="AUTH_APPLY_YN" width="80" resize="N" sortable="N" ></jun:column>
				</jun:columns>
			</jun:treegrid>
		</jun:data>
	</jun:data>
</jun:body>