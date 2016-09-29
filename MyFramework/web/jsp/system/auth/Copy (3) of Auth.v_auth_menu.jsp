<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%>
<%@ include file="/jsp/common/include/include_include.jsp"
%><%@ taglib prefix="jun"  tagdir="/WEB-INF/tags" %>

<jun:function action="초기화">
	<jun:model var="record" name="Auth" fields="Auth.selectAuthInfo"></jun:model>

	var form = Ext.getCmp('v_auth_menu_detail_detail_1');
    form.loadRecord(record);

	var auth_id = Ext.getCmp('v_auth_menu_detail_1_text_AUTH_ID');
	auth_id.setReadOnly(false);
	// [세부기능 목록] 조회.
	var store = Ext.getStore('v_auth_menu_store_grid_treegrid_1'); 
	var args = {};
	args.p_action_flag = 'r_menu_treelist';
	store.load({page : 1, params: {METADATA : "Y"} }); 

</jun:function>

<jun:function action="저장" args=" table_name" fields="Sample.selectTableInfo">
	var grid = Ext.getCmp('v_auth_menu_treegrid_treegrid_1');
	
	grid.submit('changed', 'b_merge_auth_menu', { });
</jun:function>

<jun:function action="삭제">
	var grid = Ext.getCmp('v_treelist_detail_grid_grid_2');
	
	grid.submit('checked', 'b_deleteList', {});
</jun:function>


<jun:function action="상세조회" args="auth_id"  url="/system/auth.do?p_action_flag=r_auth_detail" fields="Auth.selectAuthInfo">
	// 우측 [상세 정보]panel선택
	var east = Ext.getCmp("v_auth_menu_data_east");
	east.expand();

	var auth_id = Ext.getCmp('v_auth_menu_detail_1_text_AUTH_ID');
	auth_id.addCls('x-form-text-readonly');
	auth_id.setReadOnly(true);
	store.on("load", function(_this, _records, _successful, _eOpts ) {

		// [메뉴 정보] From 내용 설정
		var form = Ext.getCmp('v_auth_menu_detail_detail_1');
        form.loadRecord(_records[0]);

		east.setTitle('[' + _records[0].data.AUTH_NM +'] 권한의 메뉴 정보');
	});

	// [세부기능 목록] 조회.
	var store = Ext.getStore('v_auth_menu_store_grid_treegrid_1'); 
	args.p_action_flag = 'r_menu_treelist';
	store.load({page : 1, params: args }); 
</jun:function>

<jun:function action="메뉴추가" args="svc_cd, menu_id"  url="/system/menu.do?p_action_flag=r_detail" fields="Menu.selectMenuInfo">
	// 우측 [상세 정보]panel선택
	var east = Ext.getCmp("v_treelist_detail_data_east");
	east.expand();
	
	/*
	var p_action_flag = Ext.getCmp('v_treelist_detail_detail_1_text_P_ACTION_FLAG');
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

<jun:function action="상세정보저장">

	var form = Ext.getCmp('v_treelist_detail_detail_detail_1');
	
	var p_action_flag = Ext.getCmp('v_treelist_detail_detail_1_text_P_ACTION_FLAG');
	var svc_cd = Ext.getCmp('v_treelist_detail_detail_1_text_SVC_CD');
	var menu_id = Ext.getCmp('v_treelist_detail_detail_1_text_MENU_ID');
	
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
		<jun:form section="search"  button="조회" gridId="grid_1" position="north" maxItem="4">
			<jun:itemText  type="hidden"  name="p_action_flag" value="r_auth_list" ></jun:itemText>
			<jun:itemText  type="text"   name="AUTH_NM"  title="권한 구분"        ></jun:itemText>
		</jun:form>
		<jun:data>
			<jun:grid id="grid_1" action="/system/auth.do" actionFlag="b_mergeList" page="1" fields="Auth.selectAuthList">
				<jun:columns>
					<jun:column title="권한 구분" column="AUTH_NM"  width="150"  editor="link" align="left">
						renderer : function (value, p, record){
							return Ext.String.format(
								"<span class=\"in_grid_url_link\"  onclick=\"fs_v_auth_menu_상세조회('{1}');\">{0}</span>",
							value,
							record.data.AUTH_ID,
							p );
						},
					</jun:column>
					<jun:column title="권한 설명" column="AUTH_DESC" align="left" flex="1">
					</jun:column>
					<jun:column title="권한 대상자 수" column="AUTH_CNT" align="right" width="80">
					</jun:column>
				</jun:columns>
				<jun:objects name="viewConfig">
			            enableTextSelection: true
				</jun:objects>
			</jun:grid>
			<jun:form title="권한 정보" action="/system/menu.do" button="초기화,상세정보저장" id="detail_1" position="south" maxItem="4">
				<jun:itemText  type="hidden"  name="p_action_flag" value="b_mergeInfo" ></jun:itemText>
				<jun:itemText  type="text"   name="AUTH_ID"  title="권한 ID"       ></jun:itemText>
				<jun:itemText  type="text"   name="AUTH_NM"  title="권한 구분"       ></jun:itemText>
				<jun:itemText  type="textarea"   name="AUTH_DESC" title="권한 설명"     ></jun:itemText>
			</jun:form>
		</jun:data>
	</jun:data>
	<jun:data position="east" id="east" title="*좌측의 목록에서 [권한 구분]을 클릭하세요." width="860">
		<jun:treegrid id="treegrid_1" action="/system/auth.do" fields="Auth.selectMenuList" button="저장" lead="checkbox" >
			<jun:toolbars>
				<jun:toolbarDetail  type="combotipple_ux"  name="" title="조회권한"  groupCode="SYS001" first="none">
					<jun:columnCode  type="combo"  groupCode="SYS004" width="100" codeColumn="CD_NM" nameColumn="FREE_3"> 
						listConfig : { 
							itemTpl : Ext.create('Ext.XTemplate', '<tpl for=".">{FREE_3}</tpl>' )
						},
						listeners : {
							change : function ( field, newValue, oldValue, eOpts ) {
								var grid = Ext.getCmp('v_auth_menu_treegrid_treegrid_1');
								
								if( grid ) {
								
									var records = grid.getSelectedRecords();
									
									if( records.length == 0 ) {
										hoAlert('수정 할 메뉴를 선택하세요.', Ext.exptyFn, 2000, 'v_auth_menu_treegrid_treegrid_1');
									} else {
										for( var x in records ) {
											if( records[x].get('LINK_URL') != '#' && newValue!=null ) {
												records[x].set('R_LEVEL', newValue);
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
				<jun:toolbarDetail  type="combotipple_ux"  name="" title="출력권한"  groupCode="SYS001" first="none">
					<jun:columnCode  type="combo"  groupCode="SYS004" width="100" codeColumn="CD_NM" nameColumn="FREE_3"> 
						listConfig : { 
							itemTpl : Ext.create('Ext.XTemplate', '<tpl for=".">{FREE_3}</tpl>' )
						},
						listeners : {
							change : function ( field, newValue, oldValue, eOpts ) {
								var grid = Ext.getCmp('v_auth_menu_treegrid_treegrid_1');
								if( grid ) {
									var records = grid.getSelectedRecords();
									
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
						},
					</jun:columnCode>				
				</jun:toolbarDetail>
				<jun:toolbarDetail  type="combotipple_ux"  name="" title="저장권한"  groupCode="SYS001" first="none">
					<jun:columnCode  type="combo"  groupCode="SYS004" width="100" codeColumn="CD_NM" nameColumn="FREE_3"> 
						listConfig : { 
							itemTpl : Ext.create('Ext.XTemplate', '<tpl for=".">{FREE_3}</tpl>' )
						},
						listeners : {
							change : function ( field, newValue, oldValue, eOpts ) {
								var grid = Ext.getCmp('v_auth_menu_treegrid_treegrid_1');
								if( grid ) {
									var records = grid.getSelectedRecords();
									
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
						},
					</jun:columnCode>				
				</jun:toolbarDetail>
				<jun:toolbarDetail  type="combotipple_ux"  name="" title="삭제권한"  groupCode="SYS001" first="none">
					<jun:columnCode  type="combo"  groupCode="SYS004" width="100" codeColumn="CD_NM" nameColumn="FREE_3"> 
						listConfig : { 
							itemTpl : Ext.create('Ext.XTemplate', '<tpl for=".">{FREE_3}</tpl>' )
						},
						listeners : {
							change : function ( field, newValue, oldValue, eOpts ) {
								var grid = Ext.getCmp('v_auth_menu_treegrid_treegrid_1');
								if( grid ) {
									var records = grid.getSelectedRecords();
									
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
						},
					</jun:columnCode>				
				</jun:toolbarDetail>
				<jun:toolbarDetail  type="button"  name="" title="필터" >
				handler: function(btn, e) {
					var grid = Ext.getCmp('v_auth_menu_treegrid_treegrid_1');
					
					if( grid ) {
						var store = grid.getStore(); 
						this.searchType = (this.searchType||'METHOD') == 'METHOD' ? 'MENU' : 'METHOD';
						var args = { 'auth_id' : Ext.getCmp('v_auth_menu_detail_1_text_AUTH_ID').getValue() , 'TYPE' : this.searchType };
						args.p_action_flag = 'r_menu_treelist';
						store.load({page : 1, params: args });
					}
				
				},
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
					<jun:column title="조회" column="R_LEVEL"  width="40" renderer="actioncolumn">
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
			                        	return '';
			                        }
		                    	}
		                    }
						],
					</jun:column>					
					<jun:column title="출력" column="P_LEVEL"  width="40" renderer="actioncolumn">
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
			                        	return '';
			                        }
		                    	}
		                    }
						],
					</jun:column>					
					<jun:column title="저장" column="I_LEVEL"  width="40" renderer="actioncolumn">
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
			                        	return '';
			                        }
		                    	}
		                    }
						],
					</jun:column>					
					<jun:column title="삭제" column="D_LEVEL"  width="40" renderer="actioncolumn">
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
			                        	return '';
			                        }
		                    	}
		                    }
						],
					</jun:column>					
				</jun:columnGrp>
				<jun:column title="기능 권한" column="M_LEVEL"  width="70" renderer="actioncolumn"> 
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
			                        	return '';
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
	</jun:data>	
</jun:body>