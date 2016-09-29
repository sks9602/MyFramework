<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%>
<%@ include file="/jsp/common/include/include_include.jsp"
%><%@ taglib prefix="jun"  tagdir="/WEB-INF/tags" %>

<jun:function action="검색"  targetId="treegrid_1">
		var grid = Ext.getCmp('v_auth_menu_treegrid_treegrid_1');
		
		if( grid && Ext.getCmp('v_auth_menu_detail_1_AUTH_ID').getValue() ) {
			
			var store = grid.getStore(); 

			var args = { 
						'auth_id' : Ext.getCmp('v_auth_menu_detail_1_AUTH_ID').getValue() 
						, 'type' : Ext.getCmp('v_auth_menu_treegrid_1_TYPE').getValue()
						, 'func_level_cd' : Ext.getCmp('v_auth_menu_treegrid_1_FUNC_LEVEL_CD').getValue()
						, 'menu_nm' : Ext.getCmp('v_auth_menu_treegrid_1_MENU_NM').getValue() };
			args.p_action_flag = 'r_auth_treelist';
			store.load({page : 1, params: args });
		} else {
			hoAlert('검색 할 메뉴를 선택하세요.', Ext.exptyFn, 2000, 'v_auth_menu_treegrid_treegrid_1');
		}
</jun:function>
<jun:function action="조회"  targetId="grid_1">
		var east = Ext.getCmp("v_auth_menu_data_east");
		 // east.expand();
		east.setTitle('*좌측의 목록에서 [권한 구분]을 클릭하세요.');
		
		fs_v_auth_menu_detail_1_초기화('search');
		
		// Ext.getCmp('v_auth_menu_grid_grid_1').getView().setLoading(false);

</jun:function>

<jun:function action="초기화" targetId="detail_1" args="gbn">
	<jun:model var="record" name="Auth" fields="Auth.selectAuthInfo"></jun:model>

	
	Ext.getCmp('v_auth_menu_treegrid_treegrid_1').expand(true);

	var form = Ext.getCmp('v_auth_menu_detail_detail_1');
    form.loadRecord(record);

	var auth_id = Ext.getCmp('v_auth_menu_detail_1_AUTH_ID');
	auth_id.setReadOnly(false);
	// [세부기능 목록] 조회.
	var store = Ext.getStore('v_auth_menu_store_grid_treegrid_1'); 
	var args1 = {METADATA : "Y"};
	args1.p_action_flag = 'r_auth_treelist';
	store.load({page : 1, params: args1 }); 


	// [권한 대상자 현황] 조회.
	var store2 = Ext.getStore('v_auth_menu_store_grid_grid_2'); 
	var args2 = {METADATA : "Y"};
	args2.p_action_flag = 'r_auth_memberlist';
	store2.load({page : 1, params: args2 }); 

	// 우측 상세 영역
	var east = Ext.getCmp("v_auth_menu_data_east");
	// [조회]버튼 클릭인경우
	if( args.GBN != 'search') {
		east.expand();
	}
	east.setTitle('*좌측의 목록에서 [권한 구분]을 클릭하세요.');
</jun:function>

<jun:function action="저장" targetId="treegrid_1">
	var grid = Ext.getCmp('v_auth_menu_treegrid_treegrid_1');
	
	grid.submit('changed', 'b_merge_auth_menu', { });
</jun:function>


<jun:function action="상세조회"  targetId="grid_1" args="auth_id"  url="/system/auth.do?p_action_flag=r_auth_detail" fields="Auth.selectAuthInfo">
	// 우측 [상세 정보]panel선택
	var east = Ext.getCmp("v_auth_menu_data_east");
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
		Ext.getCmp('v_auth_menu_treegrid_treegrid_1').expand(true);
		
		var auth_id = Ext.getCmp('v_auth_menu_detail_1_AUTH_ID');
		auth_id.addCls('x-form-text-readonly');
		auth_id.setReadOnly(true);
		store.on("load", function(_this, _records, _successful, _eOpts ) {
	
			// [메뉴 정보] From 내용 설정
			var form = Ext.getCmp('v_auth_menu_detail_detail_1');
	        form.loadRecord(_records[0]);
	
			east.setTitle('[' + _records[0].data.AUTH_NM +'] 권한의 메뉴 정보');
			
			// [세부기능 목록] 조회.
			var store = Ext.getStore('v_auth_menu_store_grid_treegrid_1'); 
			args.p_action_flag = 'r_auth_treelist';
			store.load({page : 1, params: args }); 
			
			// [권한 대상자 현황] 조회.
			var store2 = Ext.getStore('v_auth_menu_store_grid_grid_2'); 
			args.p_action_flag = 'r_auth_memberlist';
			store2.load({page : 1, params: args }); 
			
		});
	}
	
</jun:function>

<jun:function action="메뉴추가"  targetId="detail_1" args="svc_cd, menu_id"  url="/system/menu.do?p_action_flag=r_detail" fields="Menu.selectMenuInfo">
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

	var form = Ext.getCmp('v_auth_menu_detail_detail_1');
	
	form.submit({
		'msgTxt' : '저장하시겠습니까?',
		success : function(form, action) {
			Ext.Msg.alert('Success', getResultMessageForm(form, action)); 
			var store = Ext.getStore('v_auth_menu_store_grid_grid_1'); 
			store.reload(); 
		},
		failure : function(form, action) {
			Ext.Msg.alert('Success', getResultMessageForm(form, action)); 
			var store = Ext.getStore('v_auth_menu_store_grid_grid_1');
			store.reload(); 
		}
	});

</jun:function>

<jun:function action="추가"  targetId="grid_2">
	var grid = Ext.getCmp('v_auth_menu_grid_grid_2');
	
	var auth_id = Ext.getCmp('v_auth_menu_detail_1_AUTH_ID');
	
	if( auth_id.getValue() == '' ) {
		//Ext.get('v_auth_menu_grid_1_col_AUTH_NM').frame('blue', 1, 0.2).frame('blue', 1, 0.2); 
		//grid.el.frame('red', 1, 0.2).frame('red', 1, 0.2); 
		
		fs_Frame('v_auth_menu_grid_1_col_AUTH_NM', 'blue');
		fs_Frame(grid, 'red');
		hoAlert('권한 대상자를 추가하시려면 먼저  [권한구분]을 선택하세요.', Ext.exptyFn, 2000);
	} else {
		grid.getStore().add({'AUTH_ID' : auth_id.getValue(), 'MEMBER_NM' : '* 추가하세요.'});
	}
</jun:function>

<jun:function action="저장"  targetId="grid_2">
</jun:function>

<jun:function action="삭제"  targetId="grid_2">
</jun:function>

<jun:body pageIndex="<%= TAB_INDEX %>">
	<jun:data>
		<jun:form section="search"  button="조회" gridId="grid_1" position="north" maxItem="4" id="search">
			<jun:itemText  type="hidden"  name="p_action_flag" value="r_auth_list" ></jun:itemText>
			<jun:itemText  type="text"   name="AUTH_NM"  title="권한 구분"        ></jun:itemText>
		</jun:form>
		<jun:data>
			<jun:grid id="grid_1" action="/system/auth.do" page="1" fields="Auth.selectAuthList">
				<jun:columns>
					<jun:column title="권한 구분" column="AUTH_NM"  width="150"  editor="link" align="left">
						renderer : function (value, p, record){
							return Ext.String.format(
								"<span class=\"in_grid_url_link\"  onclick=\"fs_v_auth_menu_grid_1_상세조회('{1}');\">{0}</span>",
							value,
							record.data.AUTH_ID,
							p );
						},
					</jun:column>
					<jun:column title="권한 설명" column="AUTH_DESC" align="left" flex="1">
					</jun:column>
					<jun:column title="메뉴 수" column="MENU_CNT" align="right" width="80">
					</jun:column>
					<jun:column title="권한 대상자 수" column="AUTH_CNT" align="right" width="80">
					</jun:column>
				</jun:columns>
				<jun:objects name="viewConfig">
			            enableTextSelection: true
				</jun:objects>
			</jun:grid>
			<jun:form title="권한 정보" action="/system/auth.do" button="초기화,상세정보저장" id="detail_1" position="south" maxItem="4">
				<jun:itemText  type="hidden"  name="p_action_flag" value="b_merge_auth_info" ></jun:itemText>
				<jun:itemText  type="text"   name="AUTH_ID"  title="권한 ID"    require="Y"></jun:itemText>
				<jun:itemText  type="text"   name="AUTH_NM"  title="권한 구분"   require="Y"></jun:itemText>
				<jun:itemText  type="textarea"   name="AUTH_DESC" title="권한 설명"     ></jun:itemText>
			</jun:form>
		</jun:data>
	</jun:data>
	<jun:data layout="accordion" id="east"  position="east" title="*좌측의 목록에서 [권한 구분]을 클릭하세요."  width="860"  ><%--  collapse="Y" 우측 영역 collapsable --%>
		<jun:treegrid id="treegrid_1"  title="권한별 메뉴 현황" action="/system/auth.do" fields="Auth.selectMenuList" button="저장" lead="checkbox" >
			<jun:toolbars>
				<jun:toolbarDetail  type="combotipple_ux" title="메뉴 구성" >
					<jun:columnCode  type="combo" name="TYPE" groupCode="SYS006" width="150"> 
					</jun:columnCode>				
				</jun:toolbarDetail>
				<jun:toolbarDetail  type="combotipple_ux" title="기능구분" >
					<jun:columnCode  type="combo"  name="FUNC_LEVEL_CD" groupCode="SYS005" width="100"> 
						multiSelect : true,
					</jun:columnCode>				
				</jun:toolbarDetail>
				<jun:toolbarDetail  type="text"  title="메뉴명">
					<jun:columnCode  type="text"  name="MENU_NM" width="150" >
					</jun:columnCode>		
				</jun:toolbarDetail>
				<jun:toolbarDetail  type="button"  title="검색" >
				handler: function(btn, e) {
					fs_v_auth_menu_treegrid_1_검색();
				},
				</jun:toolbarDetail>
				<jun:toolbarDetail  type="html"  title="<b>권한 변경 :</b>"  newLine="Y">
				</jun:toolbarDetail>
				<jun:toolbarDetail  type="combotipple_ux" title="조회권한" >
					<jun:columnCode  type="combo"  groupCode="SYS004" width="100" codeColumn="CD_NM" nameColumn="FREE_3"> 
						listConfig : { 
							itemTpl : Ext.create('Ext.XTemplate', '<tpl for="."><img src="data:image/gif;base64,R0lGODlhAQABAID/AMDAwAAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==" class="x-action-col-icon  {ICON_CLS}"> {FREE_3}</tpl>' )
						},
						listeners : {
							change : function ( field, newValue, oldValue, eOpts ) {
								var grid = Ext.getCmp('v_auth_menu_treegrid_treegrid_1');
								
								if( grid ) {
								
									var records = grid.getSelectedRecords(); 
									if( newValue ) {
										if( records.length == 0 ) {
											hoAlert('수정 할 메뉴를 선택하세요.', Ext.exptyFn, 2000, 'v_auth_menu_treegrid_treegrid_1');
										} else {
											for( var x in records ) {
												if( records[x].get('LINK_URL') != '#' && newValue!=null ) {
													records[x].set('R_LEVEL', newValue);
												}
											}
										}
									}
									/* Underscore.js example
									var obj = { 'a' : 'a', 'b' : 'b' };
									alert( _.keys(obj) );
									*/
								}
							}
						},
					</jun:columnCode>				
				</jun:toolbarDetail>
				<jun:toolbarDetail  type="combotipple_ux"  title="출력권한" >
					<jun:columnCode  type="combo"  groupCode="SYS004" width="100" codeColumn="CD_NM" nameColumn="FREE_3"> 
						listConfig : { 
							itemTpl : Ext.create('Ext.XTemplate', '<tpl for="."><img src="data:image/gif;base64,R0lGODlhAQABAID/AMDAwAAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==" class="x-action-col-icon  {ICON_CLS}"> {FREE_3}</tpl>' )
						},
						listeners : {
							change : function ( field, newValue, oldValue, eOpts ) {
								var grid = Ext.getCmp('v_auth_menu_treegrid_treegrid_1');
								if( grid ) {
									var records = grid.getSelectedRecords();
									if( newValue ) {
										if( records.length == 0 ) {
											hoAlert('수정 할 메뉴를 선택하세요.', Ext.exptyFn, 2000, 'v_auth_menu_treegrid_treegrid_1');
										} else {
											for( var x in records ) {
												if( records[x].get('LINK_URL') != '#' && newValue!=null ) {
													records[x].set('P_LEVEL', newValue);
												}
											}
										}
									}
								}
							}
						},
					</jun:columnCode>				
				</jun:toolbarDetail>
				<jun:toolbarDetail  type="combotipple_ux" title="저장권한">
					<jun:columnCode  type="combo"  groupCode="SYS004" width="100" codeColumn="CD_NM" nameColumn="FREE_3"> 
						listConfig : { 
							itemTpl : Ext.create('Ext.XTemplate', '<div><img src="data:image/gif;base64,R0lGODlhAQABAID/AMDAwAAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==" class="x-action-col-icon  {ICON_CLS}"> {FREE_3}</div>' )
						},
						listeners : {
							change : function ( field, newValue, oldValue, eOpts ) {
								var grid = Ext.getCmp('v_auth_menu_treegrid_treegrid_1');
								if( grid ) {
									var records = grid.getSelectedRecords();
									
									if( newValue ) {
										if( records.length == 0 ) {
											hoAlert('수정 할 메뉴를 선택하세요.', Ext.exptyFn, 2000, 'v_auth_menu_treegrid_treegrid_1');
										} else {
											for( var x in records ) {
												if( records[x].get('LINK_URL') != '#' && newValue!=null ) {
													records[x].set('I_LEVEL', newValue);
												}
											}
										}
									}
								}
							}
						},
					</jun:columnCode>				
				</jun:toolbarDetail>
				<jun:toolbarDetail  type="combotipple_ux"  title="삭제권한">
					<jun:columnCode  type="combo"  groupCode="SYS004" width="100" codeColumn="CD_NM" nameColumn="FREE_3"> 
						listConfig : { 
							itemTpl : Ext.create('Ext.XTemplate', '<tpl for="."><img src="data:image/gif;base64,R0lGODlhAQABAID/AMDAwAAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==" class="x-action-col-icon  {ICON_CLS}"> {FREE_3}</tpl>' )
						},
						listeners : {
							change : function ( field, newValue, oldValue, eOpts ) {
								var grid = Ext.getCmp('v_auth_menu_treegrid_treegrid_1');
								if( grid ) {
									var records = grid.getSelectedRecords();
									
									if( newValue ) {
										if( records.length == 0 ) {
											hoAlert('수정 할 메뉴를 선택하세요.', Ext.exptyFn, 2000, 'v_auth_menu_treegrid_treegrid_1');
										} else {
											for( var x in records ) {
												if( records[x].get('LINK_URL') != '#' && newValue!=null ) {
													records[x].set('D_LEVEL', newValue);
												}
											}
										}
									}
								}
							}
						},
					</jun:columnCode>				
				</jun:toolbarDetail>
				<jun:toolbarDetail  type="combotipple_ux" title="기능권한">
					<jun:columnCode  type="combo"  groupCode="SYS004" width="100" codeColumn="CD_NM" nameColumn="FREE_3"> 
						listConfig : { 
							itemTpl : Ext.create('Ext.XTemplate', '<tpl for="."><img src="data:image/gif;base64,R0lGODlhAQABAID/AMDAwAAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==" class="x-action-col-icon  {ICON_CLS}"> {FREE_3}</tpl>' )
						},
						listeners : {
							change : function ( field, newValue, oldValue, eOpts ) {
								var grid = Ext.getCmp('v_auth_menu_treegrid_treegrid_1');
								if( grid ) {
									var records = grid.getSelectedRecords();
									
									if( newValue ) {
										if( records.length == 0 ) {
											hoAlert('수정 할 메뉴를 선택하세요.', Ext.exptyFn, 2000, 'v_auth_menu_treegrid_treegrid_1');
										} else {
											for( var x in records ) {
												if( records[x].get('TYPE') == 'METHOD' && newValue!=null ) {
													records[x].set('M_LEVEL', newValue);
												}
											}
										}
									}
								}
							}
						},
					</jun:columnCode>				
				</jun:toolbarDetail>
			</jun:toolbars>
			<jun:columns>
				<jun:treecolumn title="메뉴 명" column="MENU_NM" flex="1" align="left" editor="link">
					renderer : function (value, p, record){
						if( record.get('TYPE') == 'MENU' ) {
							return Ext.String.format(
								"<span class=\"in_grid_url_link\"  onclick=\"fs_v_treelist_detail_상세조회('{1}', '{2}');\">{0}</span>",
								value, record.data.SVC_CD, record.data.MENU_ID, p );
						} else {
							return Ext.String.format(
								"<span class=\"in_grid_url_link\"  onclick=\"fs_v_treelist_detail_상세조회('{1}', '{2}');\">[{4}] - {0}</span>",
								value, record.data.SVC_CD, record.data.MENU_ID, p, record.data.FUNC_LEVEL_CD_NM );						
						} 
					},
				</jun:treecolumn>
				<jun:column title="권한 적용 여부" column="AUTH_APPLY_YN" width="80" resize="N" sortable="N" >
					tooltip: 'Y일 경우 - 해당 메뉴가 권한이 있을 경우 사용 할 수 있음. <br/>N일 경우 - 해당 메뉴가 권한 없이 사용 할 수 있음',
					renderer : function (value, p, record){
						if( record.get('LINK_URL') != '#' ) {
							return Ext.String.format( "<span class=\"in_grid_display\">{0}</span>", value, p );
						} else {
							return "-";
						}
					},
				</jun:column>
				<jun:column title="적용 여부" column="AUTH_YN" width="70" resize="N" sortable="N" > 
					tooltip: 'Y일 경우 - 선택된 권한에서 이 메뉴를 사용 할 수 있음. <br/>N일 경우 - 선택된 권한에서 이 메뉴를 사용 할 수 없음.',
					renderer : function (value, p, record){
						if( record.get('LINK_URL') != '#' ) {
							return Ext.String.format( "<span class=\"in_grid_display\">{0}</span>", value, p );
						} else {
							return "-";
						}
					},
				</jun:column>
				<jun:columnGrp title="메뉴 권한">
					<jun:column title="조회" column="R_LEVEL"  width="50" renderer="actioncolumn" editor="action">
						items: [
							{	handler: function(grid, rowIndex, colIndex, item, e, record, row) {
									if( record.get('LINK_URL') != '#' )  {
										record.set('R_LEVEL', record.get('R_LEVEL') == 'Y' ? 'N' : 'Y');

										if( record.get('R_LEVEL') == 'Y' || record.get('P_LEVEL') == 'Y' || record.get('I_LEVEL') == 'Y' || record.get('D_LEVEL') == 'Y') {
											record.set('AUTH_YN', 'Y'); 
										} else {
											record.set('AUTH_YN', 'N'); 
										}
									} else {
										e.stopEvent();
									}
								},
								getClass: function(v, meta, record, rowIndex, colIndex, store) {   
									if( record.get('LINK_URL') != '#' )  {
										if( record.get('R_LEVEL') == 'Y' ) {
			                        		return 'alert-col';
			                        	} else {
			                        		return 'buy-col';
			                        	}
			                        } else {
			                        	return 'x-hide-display';
			                        }
		                    	}
		                    }
						],
					</jun:column>					
					<jun:column title="출력" column="P_LEVEL"  width="50" renderer="actioncolumn" editor="action">
						items: [
							{	handler: function(grid, rowIndex, colIndex, item, e, record, row) {
									if( record.get('LINK_URL') != '#' )  {
										record.set('P_LEVEL', record.get('P_LEVEL') == 'Y' ? 'N' : 'Y');

										if( record.get('R_LEVEL') == 'Y' || record.get('P_LEVEL') == 'Y' || record.get('I_LEVEL') == 'Y' || record.get('D_LEVEL') == 'Y') {
											record.set('AUTH_YN', 'Y'); 
										} else {
											record.set('AUTH_YN', 'N'); 
										}
									} else {
										e.stopEvent();
									}
								},
								getClass: function(v, meta, record, rowIndex, colIndex, store) {   
									if( record.get('LINK_URL') != '#' )  {
										if( record.get('P_LEVEL') == 'Y' ) {
			                        		return 'alert-col';
			                        	} else {
			                        		return 'buy-col';
			                        	}
			                        } else {
			                        	return 'x-hide-display';
			                        }
		                    	}
		                    }
						],
					</jun:column>					
					<jun:column title="저장" column="I_LEVEL"  width="50" renderer="actioncolumn" editor="action">
						items: [
							{	handler: function(grid, rowIndex, colIndex, item, e, record, row) {
									if( record.get('LINK_URL') != '#' )  {
										record.set('I_LEVEL', record.get('I_LEVEL') == 'Y' ? 'N' : 'Y');

										if( record.get('R_LEVEL') == 'Y' || record.get('P_LEVEL') == 'Y' || record.get('I_LEVEL') == 'Y' || record.get('D_LEVEL') == 'Y') {
											record.set('AUTH_YN', 'Y'); 
										} else {
											record.set('AUTH_YN', 'N'); 
										}
									} else {
										e.stopEvent();
									}
								},
								getClass: function(v, meta, record, rowIndex, colIndex, store) {   
									if( record.get('LINK_URL') != '#' )  {
										if( record.get('I_LEVEL') == 'Y' ) {
			                        		return 'alert-col';
			                        	} else {
			                        		return 'buy-col';
			                        	}
			                        } else {
			                        	return 'x-hide-display';
			                        }
		                    	}
		                    }
						],
					</jun:column>					
					<jun:column title="삭제" column="D_LEVEL"  width="50" renderer="actioncolumn" editor="action">
						items: [
							{	handler: function(grid, rowIndex, colIndex, item, e, record, row) {
									if( record.get('LINK_URL') != '#' )  {
										record.set('D_LEVEL', record.get('D_LEVEL') == 'Y' ? 'N' : 'Y');

										if( record.get('R_LEVEL') == 'Y' || record.get('P_LEVEL') == 'Y' || record.get('I_LEVEL') == 'Y' || record.get('D_LEVEL') == 'Y') {
											record.set('AUTH_YN', 'Y'); 
										} else {
											record.set('AUTH_YN', 'N'); 
										}
									} else {
										e.stopEvent();
									}
								},
								getClass: function(v, meta, record, rowIndex, colIndex, store) {   
									if( record.get('LINK_URL') != '#' )  {
										if( record.get('D_LEVEL') == 'Y' ) {
			                        		return 'alert-col';
			                        	} else {
			                        		return 'buy-col';
			                        	}
			                        } else {
			                        	return 'x-hide-display';
			                        }
		                    	}
		                    }
						],
					</jun:column>					
				</jun:columnGrp>
				<jun:column title="기능 권한" column="M_LEVEL"  width="70" renderer="actioncolumn" editor="action"> 
						items: [
							{	handler: function(grid, rowIndex, colIndex, item, e, record, row) {
									if( record.get('TYPE') == 'METHOD' )  {
										record.set('M_LEVEL', record.get('M_LEVEL') == 'Y' ? 'N' : 'Y');
									} else {
										e.stopEvent();
									}
								},
								getClass: function(v, meta, record, rowIndex, colIndex, store) {   
									if( record.get('TYPE') == 'METHOD' )  {
										if( record.get('M_LEVEL') == 'Y' ) {
			                        		return 'alert-col';
			                        	} else {
			                        		return 'buy-col';
			                        	}
			                        } else {
			                        	return 'x-hide-display';
			                        }
		                    	}
		                    }
						],
				</jun:column>
			</jun:columns>
			<jun:objects name="listeners"></jun:objects>
			<jun:objects name="viewConfig">
				listeners: {
			                itemcontextmenu : function(view, rec, item, index, e) {
			                    e.stopEvent();

								var tree = Ext.getCmp('v_auth_menu_treegrid_treegrid_1');
								var store = tree.getStore();
								var t_node = store.getNodeById(rec.get('id'));
			                    
			                	var contextMenu = Ext.create('Ext.menu.Menu', {
												  	items: [
												  			Ext.create('Ext.Action', {
														        iconCls : 'btn-icon-expand',
														        text: 'Expand this tree',
														        disabled : t_node.isLeaf()||!t_node.hasChildNodes()||t_node.isExpanded(),
														        handler: function(widget, event) {
														            if (rec) {
														                t_node.expand(true);
														            }
														        }
														    }),
														    Ext.create('Ext.Action', {
														        iconCls : 'btn-icon-collapse',
														        text: 'Collapse this tree',
														        disabled : t_node.isLeaf()||!t_node.hasChildNodes()||!t_node.isExpanded(),
														        handler: function(widget, event) {
														            if (rec) {
														                t_node.collapse(true);
														            }
														        }
														    })
													]
												});
								contextMenu.showAt(e.getXY());
								return false;
			                }
			            }			
			</jun:objects>
		</jun:treegrid>
		<jun:grid id="grid_2" title="권한 대상자 현황" action="/system/auth.do" page="1" button="추가,저장,삭제" lead="checkbox"  fields="Auth.selectAuthMemberList" position="sub">
			<jun:objects name="window">
					popupMember : Ext.create('Ext.window.ux.WindowPopupMember',{})
		
			</jun:objects>
			<jun:columns>
				<jun:column title="고객사 명" column="COMPANY_ID_NM"  width="100" align="left">
				</jun:column>
				<jun:column title="운영자 ID" column="MEMBER_ID"  width="100" align="left">
				</jun:column>
				<jun:column title="운영자 명" column="MEMBER_NM"   flex="1" editor="popup" align="left">
					renderer : function (value, metaData, record){
						// metaData.tdAttr = 'data-qtip="' + value + '"';
						return Ext.String.format(
							"<span class=\"in_grid_url_link\" onclick=\"fs_v_auth_menu_상세조회('{1}');\">{0}</span>",
						value,
						record.data.AUTH_ID,
						metaData );
					},
					editor : {
						xtype         : 'trigger' 
					},
				</jun:column>
				<jun:column title="부여 권한 수" column="AUTH_CNT" align="right" width="80">
				</jun:column>
				<jun:column title="삭제" column="IS_EXISTS" align="center" width="60" renderer="actioncolumn">
					items: [
							{  
								getTip: function(v, meta, record, rowIndex, colIndex, store) {
									if( record.get('MEMBER_ID') ) {
										if( record.get('IS_EXISTS') == 'Y' ) {
				                			return '이미 등록된 ' + record.get('MEMBER_NM') +'[운영자  ID : '+ record.get('MEMBER_ID') +']를 즉시 삭제';
										} else {
											return '아직 등록되지 않은 ' + record.get('MEMBER_NM') +'[운영자  ID : '+ record.get('MEMBER_ID') +']를 즉시 삭제';
				                		}
				                	} else {
				                		return '등록되지 않은 데이터를 즉시 삭제';
				                	} 
				                 },
				                 handler: function(grid, rowIndex, colIndex, item, e, record, row) {
				                 	if( record.get('IS_EXISTS') == 'Y' ) {
				                 		hoConfirm(record.get('MEMBER_NM')+'[ID : '+ record.get('MEMBER_ID') +'] 운영자를 삭제하시겠습니까?', function(btn, text, opt) {
				                 			if( btn == 'yes' ) {
				                 				// TODO 삭제용 Ajax Call 
				                 				grid.getStore().removeAt( rowIndex );
				                 			}
				                 		}, this);
				                 	} else {
				                 		grid.getStore().removeAt( rowIndex );
				                 	}
				                 },
				                 getClass: function(v, meta, record, rowIndex, colIndex, store) {   
				                    	
									return 'delete-col';
								}
							}
					],
				</jun:column>
			</jun:columns>
			<jun:objects name="listeners">
				cellclick : function ( table, td, cellIndex, record, tr, rowIndex, e, eOpts ) {
					var clickedDataIndex = table.panel.headerCt.getHeaderAtIndex(cellIndex).dataIndex;
					// if( cellIndex == 3 ) {
					if( clickedDataIndex == 'MEMBER_ID' || clickedDataIndex == 'MEMBER_NM'  ) {
						/*
						var clickedColumnName = table.panel.headerCt.getHeaderAtIndex(cellIndex).text;
						var clickedCellValue = record.get(clickedDataIndex);
						*/
						var popMemberWin = table.ownerCt.window.popupMember;
						popMemberWin.setRecord(record);
						popMemberWin.show(td); 
					}
				},
			</jun:objects>
			<jun:objects name="viewConfig">
				enableTextSelection: true
			</jun:objects>
		</jun:grid>
	</jun:data>
</jun:body>