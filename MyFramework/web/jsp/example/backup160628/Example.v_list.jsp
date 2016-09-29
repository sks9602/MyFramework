<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%>
<%@ include file="/jsp/common/include/include_include.jsp"
%><%@ taglib prefix="jun"  tagdir="/WEB-INF/tags" %>

	<jun:window>
		<jun:data>
			<jun:grid action="/example/example.do" title="두번째 목록 타이틀.." id="id_load" page="3" width="500" fields="Sample.selectTableList">
				<jun:columns>
					<jun:column title="성명" column="NAME" ></jun:column>
					<jun:column title="사번" column="MEMBER_NO" ></jun:column>
				</jun:columns>
			</jun:grid>
		</jun:data>
	</jun:window>


<jun:function action="탭생성" args=" table_name" url="/s/example/example.do?p_action_flag=r_detail"  fields="Sample.selectTableInfo">
	Ext.create('widget.uxNotification', {
		title: 'Notification',
		position: 'br',
		manager: 'demo1',
		iconCls: 'ux-notification-icon-information', // 'ux-notification-icon-error',
		autoCloseDelay: 3000,
		spacing: 20,
		html: 'Entering from the component\'s br corner. 3000 milliseconds autoCloseDelay.<br />Increasd spacing.'
	}).show();


	fs_AddTab_v_tree_detail(args);
	
	if( Ext.getCmp('v_list_list')) {
		fs_AddTab_v_detail_list();
	}

	try {
		fs_AddTab_v_list_anchor();
	} catch(e) {
		alert(e);
	}	

	if( !Ext.getCmp('v_list_detail_list')) {
		fs_AddTab_v_list_detail_list();
	}

	if( Ext.getCmp('v_list_detail')) {
		fs_AddTab_v_list_list();
	}

	if( Ext.getCmp('v_detail')) {
		fs_AddTab_v_list_detail();
	}
	if( !Ext.getCmp('v_detail')) {
		fs_AddTab_v_detail();
	}

	if( !Ext.getCmp('v_treelist')) {
		fs_AddTab_v_treelist();
	}
	fs_AddTab_v_list_list_hori();
	fs_AddTab_v_list_list_treelist();

	
	
	// Tab (Example.v_tpl.jsp) 생성
	fs_AddTab_v_tpl();
	// Example.v_tpl.jsp에 item추가
	var cmpTpl = Ext.getCmp('v_tpl_detail_form_1');
	// item추 가
	cmpTpl.add(	<jun:item>
					<jun:item_detail  type="radio"  name="" title="제목"    groupCode="W02" first="all"></jun:item_detail>
					<jun:item_detail  type="text"    title="Title"  name="title"          value=""  require="Y" ></jun:item_detail>
					<jun:item_detail  type="passsword"   name="passsword" title="Password"  value=''      ></jun:item_detail>
					<jun:section title="섹션 E-mail">
						<jun:item_detail  type="text"   name="mail1" title="E-mail"       ></jun:item_detail>
						<jun:item_detail  type="text"   name="mail2" title="E-mail"       ></jun:item_detail>
					</jun:section>
					<jun:section title="섹션 COMBO">
						<jun:item_detail  type="combo"  name="title" title="타이틀"  groupCode="B02" first="none" id="comboL20"></jun:item_detail>
						<jun:item_detail  type="label"  name="table_name" title="테이블 명"  value="* 선택되지 않았습니다." ></jun:item_detail>
					</jun:section>
					<jun:item_detail  type="radio"  name="color" title="Favorite Color"    groupCode="W02" first="all"></jun:item_detail>
					<jun:item_detail  type="checkbox"  name="animal" title="제목"    groupCode="W02" first="all" id="cbW20"></jun:item_detail>
					<jun:item_detail  type="file"  name="file" title="파일" folder="sks" ></jun:item_detail>
					<jun:item_detail  type="file"  name="file" title="파일" folder="sks" ></jun:item_detail>
				</jun:item>);
	cmpTpl.add({ xtype: 'fieldcontainer', layout: { type: 'hbox', defaultMargins: {top: 0, right: 5, bottom: 0, left: 0} }
				, items: [{
							xtype     : 'textfield',
							width:          300,
							name      : '',
							fieldLabel: 'E-mail',labelSeparator : '',
							msgTarget: 'side'
						},{
							xtype     : 'textfield',
							width:          300,
							name      : '',
							fieldLabel: '다른 Title',labelSeparator : '',
							msgTarget: 'side'
						}]
				});
	cmpTpl.add([{
							xtype     : 'textfield',
							width:          300,
							name      : '',
							fieldLabel: 'E-mail',labelSeparator : '',
							msgTarget: 'side'
						},{
							xtype     : 'textfield',
							width:          300,
							id : 'zzzzzzzzzz',
							name      : '',
							fieldLabel: '다른 Title',labelSeparator : '',
							msgTarget: 'side'
						}]);	
	// item삭제 테스트...
	cmpTpl.remove('zzzzzzzzzz');

					
	fs_AddTab_v_list_tab_list();
	
	Ext.getCmp('id_main_tabpanel').setActiveTab('v_tree_detail');
	/*
	for( var i in args) {
 		var tgt = Ext.DomQuery.select('div[id=v_tree_detail] *[name='+i+']');
 		for(var j=0; j< tgt.length ; j++ ) {
 			tgt[j].value = args[i];
 		}

	 	var tgt2 = Ext.DomQuery.select('div[id=v_tree_detail] *[id='+i+'_label]');

	 	for(var j=0; j< tgt2.length ; j++ ) {
			Ext.get(tgt2[j].id).update(args[i]);
	 	}
	}
	*/

	store.on("load", function(_this, _records, _successful, _eOpts ) {

		var form = Ext.getCmp('id_detail_v_tree_detail_dtl_1');
		//for( var i in  _records[0].data ) {
			// alert( i );
		//}
		// TODO
        //form.loadRecord(_records[0]);
	});
	<jun:window id="id_window_1">
		<jun:data>
			<jun:form section="search" id="wsearch" action="/example/example.do" gridId="grid_1" position="north" delay="Y">
				<jun:item_searchText  type="hidden"  name="p_action_flag" value="r_list_data" ></jun:item_searchText>
				<jun:item_searchText  type="text"   name="mail" title="E-mail"  vtype="email"    ></jun:item_searchText><!-- unit="건"  -->
				<jun:item_searchText  type="text"   name="table_nm" title="알파뱃만"  vtype="alphanew"      ></jun:item_searchText>
				<jun:item_searchText  type="text"   name="text_nm" title="숫자만"    vtype="numericpos"   ></jun:item_searchText>
				<jun:item_searchTree  type="tree"  name="title2" title="타이틀"  groupCode="B20"></jun:item_searchTree>
				<jun:item_searchText  type="text"   name="text_nm" title="텍스트"       ></jun:item_searchText>
			</jun:form>
			<jun:data>
				<jun:grid action="/example/example.do" id="id_2" page="3" width="500" fields="Sample.selectTableList">
					<jun:columns>
						<jun:column title="성명" column="NAME" ></jun:column>
						<jun:column title="사번" column="MEMBER_NO" ></jun:column>
					</jun:columns>
				</jun:grid>
			</jun:data>
		</jun:data>
	</jun:window>
</jun:function>

<jun:function action="조회Deprecated" args=" table_name, comments">
	// Ext.Msg.show({title : '버튼 호출..', msg : 'here', buttons: Ext.Msg.YESNO, icon: Ext.Msg.QUESTION});
	fs_AddTab_v_list_anchor();
	fs_AddTab_v_tree_detail();


	if( !Ext.getCmp('v_detail_list')) {
		fs_AddTab_v_detail_list();
	}

	if( !Ext.getCmp('v_list_detail_list')) {
		fs_AddTab_v_list_detail_list();
	}

	if( Ext.getCmp('v_list_detail')) {
		fs_AddTab_v_list_list();
	}

	if( Ext.getCmp('v_detail')) {
		fs_AddTab_v_list_detail();
	}
	if( !Ext.getCmp('v_detail')) {
		fs_AddTab_v_detail();
	}
	fs_AddTab_v_tpl();

	hoConfirm('Are you sure you want to do that?', function(btn) {
		if( btn == 'yes' ) {
			if( this.up('form').getForm().isValid() ) {
				var param = getParam(this, 'b_insert');

				Ext.Ajax.request({
	                                url: '/s/example/example.do',
	                                method: 'POST',
	                                params: param,
	                                success : function(response,options){
										hoMessage('성공..');
	                                },
	                                failure: function(){
	                                	/*
										for( var x in arguments[0] ) {
											alert( arguments[0][x])
										}
										for( var x in arguments[1] ) {
											alert( arguments[1][x])
										}
										for( var x in arguments[2] ) {
											alert( arguments[2][x])
										}
										*/
	                                    hoError('오류');
	                                },
	                                scope: this
	                            });
			}
			// Ext.Msg.show({title : '버튼 호출..', msg : 'btn [' + btn +']' , buttons: Ext.Msg.YESNO, icon: Ext.Msg.QUESTION});
		} else {
			// hoError('다운로드');
		}
	}, this );

</jun:function>

<jun:function action="권한Reload">
	Ext.Ajax.request({
	    url: '/s/system/login.do',
	    params: {
	        'p_action_flag' : 'r_security_reload'
	    },
	    success: function(response){
	        var text = response.responseText;
	        hoAlert(text, Ext.emptyFn, 1000);
	    },
	    failure: function(response){
	        var text = response.responseText;
	        hoAlert(text, Ext.emptyFn, 1000);
	    }	
	});
</jun:function>

<jun:function action="저장" args=" table_name" fields="Sample.selectTableInfo">
	var store = Ext.getStore('v_list_store_grid_grid_1');
	
	// 파라미터 추가 SinglePost.js에서 처리
	store.getProxy().getWriter().setParams({'bb':'bb', 'cc':'cc'});
	// form추가.. SinglePost.js에서 처리
	store.getProxy().getWriter().setParams('v_list_detail_form1');
	// Outline.all_in_one.jsp에 선언됨..
	store.submit( { // '저장',
		msgTxt : '저장', 
		callback : function() {
			store.reload()
		}, 
		success : function(batch, option) {
			alert('성공');
		}, 
		failure : function() {
		 	alert('실패');
		}
	});
	
	// store.sync({});
</jun:function>

<jun:function action="파일다운로드" args="table_name" >
	// /web/jsp/common/outline/Outline.all_in_one.jsp에 선언된 함수 호출...
	fs_FileDownLoad('1');

</jun:function>

<jun:function action="다운로드" args="table_name" >
	// /web/jsp/common/outline/Outline.all_in_one.jsp에 선언된 함수 호출...
	fs_ExcelDownLoad('1');

</jun:function>

<jun:function action="클릭" args=" table_name" url="/s/example/example.do?p_action_flag=r_detail"  fields="Sample.selectTableInfo">
	fs_AddTab_v_tree_detail(args);
	Ext.getCmp('id_main_tabpanel').setActiveTab('v_tree_detail');

	store.on("load", function(_this, _records, _successful, _eOpts ) {

		var form = Ext.getCmp('v_tree_detail_detail_dtl_1');
		//for( var i in  _records[0].data ) {
			// alert( i );
		//}

        form.loadRecord(_records[0]);
        
        makeProcess(_records[0].data);
	});
	
	Ext.getCmp('id_main_tabpanel').setTitle(args.table_name +'Selected... (Example.v_list.jsp의 클릭에서 Title변경..)');
</jun:function>

<jun:function action="cellclick">
	gridview = arguments[0]; // _this  alert( grid.getXType()); -> gridview
	td = arguments[1];
	cellIndex = arguments[2];
	record = arguments[3];
	tr = arguments[4];
	rowIndex = arguments[5];
	e = arguments[6];
</jun:function>

<jun:body pageIndex="<%= TAB_INDEX %>">
	<jun:data>
		<jun:form section="search"  button="조회,탭생성,파일다운로드,다운로드,권한Reload" action="/example/example.do" gridId="grid_1" position="north" delay="Y">
			<jun:item_searchText  type="hidden"  name="p_action_flag" value="r_list_data" ></jun:item_searchText>
			<jun:item_searchText  type="text"   name="mail" title="E-mail"  vtype="email"    ></jun:item_searchText><!-- unit="건"  -->
			<jun:item_searchCode  type="combo"  name="HR_ABL.ABILITY_GBN" title="타이틀"  groupCode="B20" first="all" multiSelect="Y"  value="B2010,B2020">
				displayTpl: '<tpl for=".">{[xindex > 1 ? "," : ""]}{NAME} - {VALUE}</tpl>',
			</jun:item_searchCode>
			<jun:item_searchAjax  type="combo"  name="combo" title="Ajax타이틀"  groupCode="" multiSelect="Y" page="20"  value="HR_ABL" dependsNames="ABILITY_GBN"></jun:item_searchAjax>
			<jun:item_searchCode  type="radio"  name="color"  title="Radio"    groupCode="B60" first="all" require="true" value="B6010"></jun:item_searchCode>
			<jun:item_searchDate  type="period"  name="edu_dt" title="학습시작일" value="week"></jun:item_searchDate>
			<jun:item_searchCode  type="checkbox"  name="animal" title="Checkbox"    groupCode="B20" first="all" value="B2010,B2020"></jun:item_searchCode>
			<jun:item_searchText  type="text"   name="table_nm" title="알파뱃만"  vtype="alphanew"      ></jun:item_searchText>
			<jun:item_searchText  type="text"   name="text_nm" title="숫자만"    vtype="numericpos"   ></jun:item_searchText>
			<jun:item_searchNumber  type="scope"   name="HR_ABL.ORDER_NO" title="scope"  value="3,80"   min="0" max="100" ></jun:item_searchNumber> <!-- unit="%"   -->
			<jun:item_searchNumber  type="slider"   name="slider" title="slider"  value="3,80"   min="0" max="100" ></jun:item_searchNumber> <!-- unit="%"   -->
			<jun:item_searchTree  type="tree"  name="title2" title="타이틀"  groupCode="B20"></jun:item_searchTree>
			<jun:item_searchText  type="text"   name="text_nm" title="텍스트"       ></jun:item_searchText>
		</jun:form>
		<jun:form section="detail" action="/example/example.do" gridId="grid_1" hidden="Y" id="form1">
			<jun:item_search  type="text"   name="table_nm" title="테이블명"       ></jun:item_search>
			<jun:item_search  type="hidden"  name="p_action_flag" value="r_list_data" ></jun:item_search>
			<jun:item_search  type="text"   name="mail" title="E-mail"       ></jun:item_search>
		</jun:form>
		<jun:data>
			<jun:grid id="grid_1" action="/example/example.do" button="저장" page="5" lead="checkbox" fields="Sample.selectTableList" groupTpl="" groupName="" listeners="cellclick:fs_v_list_cellclick">
				<jun:toolbars>
					<jun:toolbar_detail  type="combo"  name="" title="타이틀"  groupCode="B20" first="none"></jun:toolbar_detail>
					<jun:toolbar_detail  type="button"  name="" title="타이틀" ></jun:toolbar_detail>
				</jun:toolbars>
				<jun:columns>
					<jun:column title="이름" column="table_name" locked="Y" renderer="function" editor="link" >
						<jun:column_function functionFor="renderer">
							function (value, p, record){
								return Ext.String.format(
									"<div class=\"in_grid_url_link\" id=\"v_list_{1}\" onclick=\"fs_v_list_클릭('{1}');\">{0}</div>",
								value,
								record.data.table_name,
								p );
							}
						</jun:column_function>
					</jun:column>
					<jun:column title="이름2" column="table_name" width="200" editor="copy"></jun:column>
					<jun:column title="설명" column="table_comments" flex="1" align="left" width="200" editor="textfield"></jun:column>
					<jun:column title="Grid Editor" column="email" width="100" resize="N" sortable="N" editor="combogrid"></jun:column>
					<jun:column title="Combo Editor" column="email2" width="100" resize="N" sortable="N" editor="combotipple" ></jun:column>
					<jun:column title="Tree Editor" column="owner" width="100" resize="N" sortable="N" editor="combotree" ></jun:column>
					<jun:column title="E-Mail" column="email" width="100" resize="N" sortable="N" editor="email" ></jun:column>
					<jun:column title="팩스" column="fax_number"  width="150" editor="numberfield, minValue:10, maxValue:100"  renderer="rowspanRenderer"></jun:column>
					<jun:columnGrp title="연락처">
						<jun:column title="전화번호" column="phone_number"  width="150" editor="editors" >
							getEditor : function( record, defaultField) { 
		                        if ( record.get('table_name') == 'HR_ABL' ) {
		                            return Ext.create('Ext.grid.CellEditor', {
		                                field: Ext.create('Ext.form.field.Text')
		                            });
		                        } else if ( record.get('table_name') == 'CERT_INFO' ) {
		                            return Ext.create('Ext.grid.CellEditor', {
		                                field: Ext.create('Ext.form.field.Date')
		                            });
		                        } else if ( record.get('table_name') == 'S_ZIP_CODE' ) {
		                            return Ext.create('Ext.grid.CellEditor', {
		                                field: { xtype : 'checkboxfield'} 
		                                	/* {
									            xtype      : 'radiogroup',
									            layout: 'hbox',
									            items: [
									                {
									                    boxLabel  : 'Blue',
									                    name      : 'color',
									                    inputValue: 'blue',
									                    id        : 'radio4'
									                }, {
									                    boxLabel  : 'Grey',
									                    name      : 'color',
									                    inputValue: 'grey',
									                    id        : 'radio5'
									                }, {
									                    boxLabel  : 'Black',
									                    name      : 'color',
									                    inputValue: 'black',
									                    id        : 'radio6'
									                }
									            ]
									        } */
		                            });
		                        } else if ( record.get('table_name') == 'HR_RESUME_TRAIN' ) {
		                            return Ext.create('Ext.grid.CellEditor', {
		                                field: {
								            xtype      : 'checkboxgroup',
								            layout: 'hbox',
								            items: [
								                {
								                    boxLabel  : 'Blue',
								                    name      : 'animal',
								                    inputValue: 'blue',
								                    id        : 'radio4'
								                }, {
								                    boxLabel  : 'Grey',
								                    name      : 'animal',
								                    inputValue: 'grey',
								                    id        : 'radio5'
								                }, {
								                    boxLabel  : 'Black',
								                    name      : 'animal',
								                    inputValue: 'black',
								                    id        : 'radio6'
								                }
								            ]
								        }
		                            });
		                        } else {
		                            return Ext.create('Ext.grid.CellEditor', {
		                                field: Ext.create('Ext.form.field.Number')
		                            });
		                        }
							}
						</jun:column>
						<jun:column title="휴대폰번호" column="TABLE_TYPE"  width="150" editor="checkbox" storeId="v_list_store_grid_grid_1">
							<jun:column_function functionFor="checkbox">
								function( _column, _rowIndex, _checked, _eOpts) {  
									
									var store = Ext.getStore('v_list_store_grid_grid_1');
									
									var record = store.getAt(_rowIndex);
									var columnIndex = _column.getIndex();
									
									record.set('hp_number', _checked );
								}
							</jun:column_function>
						</jun:column>
					</jun:columnGrp>
					<jun:column title="팩스" column="fax_number"  width="150" renderer="actioncolumn">
					<jun:column_function functionFor="actioncolumn">
						 items: [{
			                    // icon   : '/s/static/js/ext-4.2/ux/image/fam/delete.gif',  // Use a URL in the icon config
			                    tooltip: 'Sell stock',
			                    handler: function(grid, rowIndex, colIndex) {
			                    	var store = grid.getStore();
			                        var rec = store.getAt(rowIndex);
			                        alert("Sell " + rec.get('table_comments'));
			                    },
			                    getClass: function(v, meta, rec) {   // 두번째에 있는 icon이 클릭되었을 경우 icon이 변경 되게 처리..
			                        if ( rec.get('tname').indexOf('AAAA')>=0 ) {
			                            return 'alert-col';
			                        } else {
			                            return 'buy-col';
			                        }
			                    }
			                }, {
			                    getClass: function(v, meta, rec) {          // Or return a class from a function
			                        if ( rec.get('table_name').indexOf('HR_ABL')>=0 ) {
			                            return 'alert-col';
			                        } else {
			                            return 'buy-col';
			                        }
			                    },
			                    getTip: function(v, meta, rec) {
			                        if ( rec.get('table_name').indexOf('HR_ABL')>=0 ) {
			                            return 'Hold stock';
			                        } else {
			                            return 'Buy stock -' + rec.get('table_name') ;
			                        }
			                    },
			                    handler: function(grid, rowIndex, colIndex, item, e, record, row) {
			                    	var store = grid.getStore();
			                        var rec = store.getAt(rowIndex);
			                        try {
			                        	rec.set('tname', 'AAAA');  // 이렇게 값을 바꿔 주면..getClass() 때문에 첫번째 icon바뀜..
			                        
			                        	// var row = grid.getNode(rowIndex);
			                        	/*
			                        	var tds = Ext.fly(row).query('.x-grid-cell');
			                        	
			                        	for( var i=0; i < tds.length; i++ ) {
			                        		Ext.get(tds[i]).addCls('x-grid-dirty-cell');
			                        	}
			                        	*/
			                        	
			                        	// td자체 조회.
			                        	//var td = Ext.fly(row).query('.x-grid-cell')[colIndex];
			                        	// grid의 cell td에 "변경(dirty)" 표시 처리 --> 2번 클릭 해야 됨..	
			                        	//Ext.get(td).addCls('x-grid-dirty-cell');
			                        	
			                        	// td자체 조회.
			                        	//var el = Ext.fly(Ext.fly(row).query('.x-grid-cell')[colIndex]); 
										// grid의 cell td에 "변경(dirty)" 표시 처리 --> 2번 클릭 해야 됨..			                        	
			                        	//el.addCls('x-grid-dirty-cell');
										
			                        } catch(e) {
			                        	alert(e);
			                        }
			                        // rec.set('table_name', 'HR_ABL_AAAA');
			                        
			                        
			                        // alert((rec.get('table_name').indexOf('HR_ABL')>=0 ? "Hold " : "Buy ") + rec.get('table_name'));
			                    }
			                }, {
			                    getClass: function(v, meta, rec) {          // Or return a class from a function
			                        if ( rec.get('table_name').indexOf('HR_ABL')>=0 ) {
			                            return 'buy-col';
			                        } else {
			                            return 'alert-col';
			                        }
			                    },
			                    getTip: function(v, meta, rec) {
			                        if ( rec.get('table_name').indexOf('HR_ABL')>=0 ) {
			                            return 'Hold stock';
			                        } else {
			                            return 'Buy stock -' + rec.get('table_name') ;
			                        }
			                    },
			                    handler: function(grid, rowIndex, colIndex) {
			                    	var store = grid.getStore();
			                        var rec = store.getAt(rowIndex);
			                        
			                        rec.set('table_name', 'HR_ABL_AAAA');
			                    }
			                }]
		                </jun:column_function>
					</jun:column>
				</jun:columns>
				<jun:gridViewConfig>
			        viewConfig: {
			            stripeRows: true,
			            enableTextSelection: true, // grid에서.. select가능하게...
			            plugins: {
			                ptype: 'gridviewdragdrop',
			                dragGroup: 'firstGridDDGroup',
			                dropGroup: 'firstGridDDGroup',
			                ddGroup: 'firstGridDDGroup',
			                dragText: 'For more information...'
			            },
			            listeners: {
			                itemcontextmenu: function(view, rec, node, index, e) {
			                    e.stopEvent();
			                    
			                    var contextMenu = Ext.create('Ext.menu.Menu', {
											        items: [
											            Ext.create('Ext.Action', {
													        iconCls : 'buy-button',
													        text: 'gridViewConfig.tag -> Buy stock - ' + rec.get('table_name'),
													        // disabled: true,
													        handler: function(widget, event) {
													            //var rec = grid.getSelectionModel().getSelection()[0];
													            if (rec) {
													                alert('Sell ' + rec.get('table_name'));
													            }
													        }
													    }),
											            Ext.create('Ext.Action', {
													        // icon   : '../shared/icons/fam/delete.gif',  // Use a URL in the icon config
													        iconCls : 'alert-col',
													        text: 'gridViewConfig.tag -> Sell stock',
													        // disabled: true,
													        handler: function(widget, event) {
													            //var rec = grid.getSelectionModel().getSelection()[0];
													            if (rec) {
													                alert('Sell ' + rec.get('table_name'));
													            }
													        }
													    })
											        ]
											    });
											    
			                    contextMenu.showAt(e.getXY());
			                    return false;
			                }
			            }
			        },				
				</jun:gridViewConfig>
			</jun:grid>
		</jun:data>
	</jun:data>
</jun:body>