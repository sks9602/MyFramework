<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%>
<%@ include file="/jsp/common/include/include_include.jsp"
%><%@ taglib prefix="jun"  tagdir="/WEB-INF/tags" %>
<jun:functions  targetId="search_1">
	<jun:function action="다운로드">
		fs_FileDownLoad('1');
		// fs_ExcelDownLoad('1');
	</jun:function>
</jun:functions>

<jun:functions  targetId="grid_2">
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
	
	<jun:function action="저장" args=" table_name" fields="Sample.selectTableInfo">
		var grid = Ext.getCmp('v_treelist_detail_grid_grid_2');
		
		grid.submit('changed', 'b_mergeList', { });
	</jun:function>
	
	<jun:function action="삭제" >
		var grid = Ext.getCmp('v_treelist_detail_grid_grid_2');
		
		grid.submit('checked', 'b_deleteList', { });
	</jun:function>
</jun:functions>

<jun:functions  targetId="grid_1">

	<jun:function action="상세조회" args="svc_cd, menu_id"  url="/system/menu.do?p_action_flag=r_detail" fields="Menu.selectMenuInfo">
		// 우측 [상세 정보]panel선택
		var east = Ext.getCmp("v_treelist_detail_data_east");
		east.expand();
		
		var myMask = new Ext.LoadMask(east, {msg:"조회중입니다. <br/>잠시만 기다려주세요...."});
		myMask.show();
		
		if( east.getCollapsed( ) ) {
			east.on("expand",function(panel, eOpts) {
				// 우측 화면 데이터 로딩 
				fs_load();
			});
		} else {
			// 우측 화면 데이터 로딩 
			fs_load();
		}
		

		 //우측 화면 데이터 로딩 function
		
		function fs_load() {
		
				store.on("load", function(_this, _records, _successful, _eOpts ) {
					// [메뉴 정보] From 내용 설정
					var form = Ext.getCmp('v_treelist_detail_detail_detail_1');
			        form.loadRecord(_records[0]);
			
					east.setTitle('[' + _records[0].data.MENU_NM +'] 메뉴의 상세 정보');
	
					// [세부기능 목록] 조회.
					var f_store = Ext.getStore('v_treelist_detail_store_grid_grid_2'); 
					args.p_action_flag = 'r_method_list';
					f_store.load({page : 1, params: args }); 
					
					f_store.on('load', function() {
						myMask.hide()
					} );
					
				});
		
		}
	</jun:function>

	<jun:function action="메뉴추가" args="svc_cd, menu_id"  url="/system/menu.do?p_action_flag=r_detail" fields="Menu.selectMenuInfo">
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
</jun:functions>
<jun:functions  targetId="detail_1">

	<jun:function action="상세정보저장" >
	
		var form = Ext.getCmp('v_treelist_detail_detail_detail_1');
		
		var p_action_flag = Ext.getCmp('v_treelist_detail_detail_1_P_ACTION_FLAG');
		var svc_cd = Ext.getCmp('v_treelist_detail_detail_1_SVC_CD');
		var menu_id = Ext.getCmp('v_treelist_detail_detail_1_MENU_ID');
		
		if( p_action_flag.getValue() == '' || svc_cd.getValue() == '' || menu_id.getValue() == '' ) {
			form.el.frame('red', 1, 0.2).frame('red', 1, 0.2); 
			hoAlert('추가 또는 수정 할 정보를 입력하세요.', Ext.exptyFn, 2000);
		} else {
			form.submit({
				'msgConfirm' : '저장하시겠습니까?', 
				success : function(form, action) {
					Ext.Msg.alert('Success', getResultMessageForm(form, action)); // action.result.message);
				},
				failure: function(form, action) {
					Ext.Msg.alert('Failure', getResultMessageForm(form, action)); // action.result.message);
				}
			});
		}
		
	</jun:function>
</jun:functions>

<jun:body pageIndex="<%= TAB_INDEX %>">
	<jun:data>
		<jun:form section="search" id="search_1"  button="조회,다운로드" gridId="grid_1" position="north" maxItem="2">
			<jun:itemText  type="hidden"  name="p_action_flag" value="r_treelist" ></jun:itemText>
			<jun:itemCode  type="combo"  name="SVC_CD" title="서비스 구분"  groupCode="SYS001" ></jun:itemCode>
			<jun:itemText  type="text"   name="MENU_NM"  title="메뉴 명"        ></jun:itemText>
			<jun:itemCode  type="combo"  name="USE_YN" title="사용 여부" groupCode="SYS004" multiSelect="Y"  codeColumn="NAME" nameColumn="FREE_1">listConfig : { itemTpl : Ext.create('Ext.XTemplate', '<tpl for=".">{FREE_1}</tpl>') }, </jun:itemCode>
		</jun:form>
		<jun:treegrid id="grid_1" action="/system/menu.do" fields="Menu.selectMenuList" >
			<jun:toolbars>
				<jun:toolbar_detail  type="combotipple_ux"  name="" title="타이틀"  groupCode="SYS001" first="none"></jun:toolbar_detail>
				<jun:toolbar_detail  type="button"  name="" title="타이틀" ></jun:toolbar_detail>
			</jun:toolbars>
			<jun:columns>
				<jun:treecolumn title="메뉴 명" column="MENU_NM" flex="1" align="left" editor="link">
					renderer : function (value, p, record){
						return Ext.String.format(
							"<span class=\"in_grid_url_link\"  onclick=\"fs_v_treelist_detail_grid_1_상세조회('{1}', '{2}');\">{0}</span>",
						value,
						record.data.SVC_CD,
						record.data.MENU_ID,
						p );
					},
				</jun:treecolumn>
				<jun:column title="메뉴 URL" column="LINK_URL" align="left" width="200"></jun:column>
				<jun:column title="사용 여부" column="USE_YN" width="70" resize="N" sortable="N" ></jun:column>
				<jun:column title="메뉴 구성 여부" column="DISPLAY_YN"  width="80"></jun:column>
				<jun:column title="권한 적용 여부" column="AUTH_APPLY_YN" width="80" resize="N" sortable="N" ></jun:column>
				<jun:column title="메뉴 추가" column="MENU_ID"  width="80" renderer="actioncolumn">
					items: [
					 		{
			                    getTip: function(v, meta, record, rowIndex, colIndex, store) {
			                    	var treeStore = Ext.getStore('v_treelist_detail_store_grid_grid_1');
			                        if( treeStore.getNodeById(record.get('ID')).getDepth() == 1 ) {
			                    		return '동일 레벨 메뉴 추가 불가';
			                    	} else {
			                    		return '동일 레벨 메뉴 추가';
			                    	}
			                    },
			                    handler: function(grid, rowIndex, colIndex, item, e, record, row) {
			                        var treeStore = Ext.getStore('v_treelist_detail_store_grid_grid_1');
			                        
			                        var menuDepth = treeStore.getNodeById(record.get('ID')).getDepth();
			                        /*
			                        var contextMenu = Ext.create('Ext.menu.Menu', {
										        items: [
										            Ext.create('Ext.Action', {
												        iconCls : menuDepth == 1 ? 'buy-col' : 'alert-col',
												        text: '['+record.get('MENU_NM')+']메뉴와 같은 레벨의 메뉴 추가',
												        disabled : menuDepth == 1, 
												        handler: function(widget, event) {
												        	fs_v_treelist_detail_grid_1_메뉴추가 ( record.get('SVC_CD'), record.get('MENU_ID') );
												        }
												    }),
												    Ext.create('Ext.Action', {
												        iconCls : menuDepth > 2 ? 'buy-col' : 'alert-col',
												        text: '['+record.get('MENU_NM')+']메뉴의 하위에 메뉴 추가',
												        disabled : menuDepth > 2, 
												        handler: function(widget, event) {
												           fs_v_treelist_detail_grid_1_메뉴추가 ( record.get('SVC_CD'), record.get('P_MENU_ID') );
												        }
												    })
										        ]
										    });
									contextMenu.showAt(e.getXY());
										    
		                    		*/
		                    		if( !grid.menu ) {
		                    			grid.menu = {};
		                    		}
		                    		if( !grid.menu[record.get('ID')] ) {
			                        	grid.menu[record.get('ID')] = Ext.create('Ext.menu.Menu', {
										        items: [
										            Ext.create('Ext.Action', {
												        iconCls : menuDepth == 1 ? 'buy-col' : 'alert-col',
												        text: '['+record.get('MENU_NM')+']메뉴와 같은 레벨의 메뉴 추가',
												        disabled : menuDepth == 1, 
												        handler: function(widget, event) {
												        	fs_v_treelist_detail_grid_1_메뉴추가 ( record.get('SVC_CD'), record.get('MENU_ID') );
												        }
												    }),
												    Ext.create('Ext.Action', {
												        iconCls : menuDepth > 2 ? 'buy-col' : 'alert-col',
												        text: '['+record.get('MENU_NM')+']메뉴의 하위에 메뉴 추가',
												        disabled : menuDepth > 2, 
												        handler: function(widget, event) {
												           fs_v_treelist_detail_grid_1_메뉴추가 ( record.get('SVC_CD'), record.get('P_MENU_ID') );
												        }
												    })
										        ]
										    });
			                        }
			                        grid.menu[record.get('ID')].showAt(e.getXY());
			                    },
			                    getClass: function(v, meta, record, rowIndex, colIndex, store) {   
			                    	
			                        var treeStore = Ext.getStore('v_treelist_detail_store_grid_grid_1');

									if( treeStore.getNodeById(record.get('ID')).getDepth() == 1 ) {
			                    		return ''; // 'buy-col';
			                    	} else {
			                    		return 'alert-col';
			                    	}
			                    }
			                }, {
								getTip: function(v, meta, record, rowIndex, colIndex, store) {
			                    	var treeStore = Ext.getStore('v_treelist_detail_store_grid_grid_1');
			                        if( treeStore.getNodeById(record.get('ID')).getDepth() > 2 ) {
			                    		return '하위 레벨 메뉴 추가 불가';
			                    	} else {
			                    		return '하위 레벨 메뉴 추가';
			                    	}
			                    },
			                    handler: function(grid, rowIndex, colIndex, item, e, record, row) {
			                        var treeStore = Ext.getStore('v_treelist_detail_store_grid_grid_1');
			                        var menuDepth = treeStore.getNodeById(record.get('ID')).getDepth();
			                        /*
			                        var contextMenu = Ext.create('Ext.menu.Menu', {
										        items: [
										        	Ext.create('Ext.Action', {
												        iconCls : menuDepth == 1 ? 'buy-col' : 'alert-col',
												        text: '['+record.get('MENU_NM')+']메뉴와 같은 레벨의 메뉴 추가',
												        disabled : menuDepth == 1, 
												        handler: function(widget, event) {
												            if (record) {
												                alert('Sell ' + record.get('table_name'));
												            }
												        }
												    }),
										            Ext.create('Ext.Action', {
												        iconCls : menuDepth > 2 ? 'buy-col' : 'alert-col',
												        text: '['+record.get('MENU_NM')+']메뉴의 하위에 메뉴 추가',
												        disabled : menuDepth > 2, 
												        handler: function(widget, event) {
												            if (record) {
												                alert('Sell ' + record.get('table_name'));
												            }
												        }
												    })
										        ]
										    });
										    
		                    			contextMenu.showAt(e.getXY());
		                    		*/
		                    		if( !grid.menu ) {
		                    			grid.menu = {};
		                    		}
		                    		if( !grid.menu[record.get('ID')] ) {
			                        	grid.menu[record.get('ID')] = Ext.create('Ext.menu.Menu', {
										        items: [
										            Ext.create('Ext.Action', {
												        iconCls : menuDepth == 1 ? 'buy-col' : 'alert-col',
												        text: '['+record.get('MENU_NM')+']메뉴와 같은 레벨의 메뉴 추가',
												        disabled : menuDepth == 1, 
												        handler: function(widget, event) {
												        	fs_v_treelist_detail_grid_1_메뉴추가 ( record.get('SVC_CD'), record.get('MENU_ID') );
												        }
												    }),
												    Ext.create('Ext.Action', {
												        iconCls : menuDepth > 2 ? 'buy-col' : 'alert-col',
												        text: '['+record.get('MENU_NM')+']메뉴의 하위에 메뉴 추가',
												        disabled : menuDepth > 2, 
												        handler: function(widget, event) {
												           fs_v_treelist_detail_grid_1_메뉴추가 ( record.get('SVC_CD'), record.get('P_MENU_ID') );
												        }
												    })
										        ]
										    });
			                        }
			                        
			                        grid.menu[record.get('ID')].showAt(e.getXY());

			                    },
			                    getClass: function(v, meta, record, rowIndex, colIndex, store) {   
			                    	
			                        var treeStore = Ext.getStore('v_treelist_detail_store_grid_grid_1');

									if( treeStore.getNodeById(record.get('ID')).getDepth() > 2 ) {
			                    		return ''; // 'buy-col';
			                    	} else {
			                    		return 'alert-col';
			                    	}
			                    }
		                	}
						],
				</jun:column>					
				
			</jun:columns>
		</jun:treegrid>
	</jun:data>
	<jun:data position="east" id="east" title="*좌측의 목록에서 [메뉴 명]을 클릭하세요." width="660" collapse="right"><%--  collapse="Y" --%>
		<jun:form title="Button" action="/system/menu.do" id="form_btn" position="north"   hidden="Y" >
			<jun:itemText  type="text"  name="P_ACTION_FLAG" title="ACTION FLAG"  value="r_btn_status" ></jun:itemText>
			<jun:itemText  type="text"  name="SQL_ID"  title="SQL ID"       ></jun:itemText>
			<jun:itemText  type="text"  name="INFO1"  title="INFO1"  value="1"     ></jun:itemText>
			<jun:itemText  type="text"  name="INFO2"  title="INFO2"  value="2"     ></jun:itemText>
			<jun:itemText  type="text"  name="INFO3"  title="INFO3"  value="3"     ></jun:itemText>
		</jun:form>
		<jun:form title="메뉴 정보" action="/system/menu.do" button="상세정보저장:Menu.buttonEnable" id="detail_1" position="north" maxItem="2">
			<jun:itemText  type="hidden"  name="p_action_flag" value="b_mergeInfo" ></jun:itemText>
			<jun:itemText  type="hidden"   name="SVC_CD"  title="서비스 구분"       ></jun:itemText>
			<jun:itemText  type="label"   name="SVC_CD_NM"  title="서비스 구분"       ></jun:itemText>
			<jun:itemText  type="label"   name="P_MENU_ID"  title="상위 메뉴 ID"       ></jun:itemText>
			<jun:itemText  type="text"   name="MENU_ID"  title="메뉴 ID"       >maxLength : 20,</jun:itemText>
			<jun:itemText  type="text"   name="ICON_CLS" title="ICON CLASS"     ></jun:itemText>
			<jun:itemText  type="text"   name="MENU_NM"  title="메뉴 명"        ></jun:itemText>
			<jun:itemCode  type="combo"  name="LINK_TYPE_CD" title="연계 형태"  groupCode="SYS002" >
				listeners : {
					change : function ( _this, newValue, oldValue, eOpts ) {
						var section = Ext.getCmp('v_treelist_detail_detail_1_section_1');
						if( section ) {
							if( newValue == 'SYS002002' || newValue == 'SYS002003') {
								section.expand();
							} else {
								section.collapse();
							}
						}
					}
				},
			</jun:itemCode>
			<jun:itemText  type="text"   name="LINK_URL" title="메뉴 URL"     ></jun:itemText>
			<jun:itemToggle  type="toggle"  name="USE_YN" title="사용 여부"   ></jun:itemToggle>
			<jun:itemToggle  type="toggle"  name="DISPLAY_YN" title="메뉴 구성 여부"   ></jun:itemToggle>
			<jun:itemToggle  type="toggle"  name="AUTH_APPLY_YN" title="권한 적용 여부"   ></jun:itemToggle>
			<jun:section title="팝업 메뉴 정보" id="section_1" colspan="2" expand="N" expandable="N">
				<jun:itemNumber  type="scope"  name="popup" title="팝업 (가로*세로)" unit="px" colspan="2"></jun:itemNumber>
			</jun:section>
			<jun:section title="개발 관련 정보" id="section_2" colspan="2">
				<jun:itemText  type="text"   name="PKG_NM" title="package 명" ></jun:itemText>
				<jun:itemText  type="text"   name="JAVA_NM" title="Java 명" ></jun:itemText>
				<jun:itemText  type="text"   name="JSP_PATH" title="jsp 경로" ></jun:itemText>
			</jun:section>
		</jun:form>

		<jun:grid title="세부기능 목록" id="grid_2" action="/system/menu.do" button="추가,저장,삭제:Menu.enable" lead="checkbox" page="1" fields="Menu.selectMethodList">
			<jun:columns>
				<jun:column title="p_action_flag" column="ACTION_FLAG"  width="100"  editor="textfield" align="left">
					<jun:columnText type="text" require="Y"></jun:columnText>
				</jun:column>
				<jun:column title="METHOD" column="METHOD" align="left" flex="1" editor="textfield">
					<jun:columnText type="text" ></jun:columnText>
				</jun:column>
				<jun:column title="기능 구분" column="FUNC_LEVEL_CD" align="left" width="80" editor="combotipple">
					<jun:columnCode  type="combo"  groupCode="SYS005" ></jun:columnCode>
				</jun:column>
				<jun:column title="기능 설명" column="METHOD_NM" flex="1" align="left" width="200" editor="textfield">
					<jun:columnText  type="text" ></jun:columnText>
				</jun:column>
				<jun:column title="사용 여부" column="USE_YN" width="70" resize="N" sortable="N" editor="combotipple">
					renderer : function (value, meta, record, rowIndex, colIndex, gridStore, view, _return){
						var store = Ext.getStore('v_treelist_detail_store_editor_grid_2_USE_YN');
						
						// view를 통한 store 가져오기 ok(아래)
						// var store = view.ownerCt.columns[colIndex].editor.store;
						
						var index = store.findExact('CD_NM',value);
						
						if (index != -1){
		                    rs = store.getAt(index).data; 
		                    return rs.FREE_1; 
		                } else {
		                	return value;
		                }
					},
					<jun:columnCode  type="combo"  groupCode="SYS004" codeColumn="CD_NM" nameColumn="FREE_1"> 
						listConfig : { 
							itemTpl : Ext.create('Ext.XTemplate', '<tpl for=".">{FREE_1}</tpl>' )
						},
					</jun:columnCode>
				</jun:column>
				<jun:column title="권한 적용 여부" column="AUTH_APPLY_YN" width="100" resize="N" sortable="N"  editor="combotipple">
					renderer : function (value, meta, record, rowIndex, colINdex, gridStore, view, _return){
						var store = Ext.getStore('v_treelist_detail_store_editor_grid_2_AUTH_APPLY_YN');
						
						var index = store.findExact('CD_NM',value);
						
						if (index != -1){
		                    rs = store.getAt(index).data; 
		                    return rs.FREE_3; 
		                } else {
		                	return value;
		                }
					},
					<jun:columnCode  type="combo"  groupCode="SYS004" codeColumn="CD_NM" nameColumn="FREE_3"> 
						listConfig : { 
							itemTpl : Ext.create('Ext.XTemplate', '<tpl for=".">{FREE_3}</tpl>' )
						},
					</jun:columnCode>
				
				</jun:column>
			</jun:columns>
		</jun:grid>
	</jun:data>	
</jun:body>