/*
 * Form에 등록되었던 이력을 조회하는 Grid + Grid 팝업
 */
Ext.define('Ext.window.ux.DevelopeFormGrid', {
	extend: 'Ext.window.Window',
    title: 'Form저장이력 ',
    id : 'id_win_develop_form_grid',
    itemId : 'win_develop_form_grid',
    menuId : undefined,
    formId : undefined,
    height: 600,
    // baseCls : 'x-window-red',
    width: 950,
    // x : 100,
    // y : 100,
    layout: 'border',
    constrain: true,
    border : false,
    closable: true,
    autoHeight: true,
    closeAction: 'hide',
    items: [{
    	region : 'west',
        xtype: 'grid',
        width : 450,
        itemId : 'develop_form_grid_list',
    	border: true,
    	margin: '0 5 0 0',
    	title : 'Form이력',
        columns: [
	          {xtype: 'rownumberer', text : 'No', width: 30, style: 'text-align:center' },
	          {header: '제목 &amp; 적용', flex : 1, dataIndex: 'HISTORY_NM', 
	        	  renderer : function (value, p, record){
	        		  return Ext.String.format( "<span class=\"in_grid_url_link\">{0}</span>",
	        				  	value ?  value : '[적용]',
	        				  	p );
	        	  }
	          }, 
	          {header: '등록일자', dataIndex: 'HISTORY_DT_YMD', align : 'center', width:160, 
	        	  renderer : function (value, p, record){
	        		  return Ext.String.format( "<span class=\"in_grid_url_link\">{0}</span>",
	        				  value,
	        				  record.data.HISTORY_SEQ,
	        				  p );
	        	  }
	          }, 
	          {header: '항목수', dataIndex: 'ITEM_CNT', align : 'right', width:50}, 
	          {header: '삭제', dataIndex: 'DELETE', width:50 , align : 'center',  renderer : function (value, p, record){
	        	  return Ext.String.format("<span class=\"in_grid_url_link\">[삭제]</span>");
	          	}
	          }
        ],                 
        store: Ext.create('Ext.data.JsonStore', {
        	storeId:'develop_store_form_grid_list',
			autoDestroy: true,
			remoteSort:	true,
			fields:['F_MENU_ID',  'F_FORM_ID', 'HISTORY_SEQ','HISTORY_DT','HISTORY_DT_YMD','HISTORY_NM','ITEM_CNT'], //['TABLE_NAME', 'TABLE_ALIAS', 'TABLE_TYPE'],
			id : 'id_win_develop_store_form_grid_store',
			proxy: Ext.create('Ext.data.HttpProxy', {
				type: 'ajax', //'memory',
				url: '/s/system/develope.do',
				reader: {
		            type: 'json',
					totalProperty: 'totalCount',
					root: 'datas'
		        },
		        writer: {
		            type: 'singlepost', // 'json',
		            writeAllFields: true,
		            encode : true,
		            root: 'datas',
		           	params : { }, // @TODO  이런 형태로 파라미터 추가 가능..
		            allowSingle : false 
		        },
				api: {
	                create: '/s/system/develope.do',
	                update: '/s/system/develope.do'
		        }
			})
	    }),
    	dockedItems: [{
    		xtype: 'toolbar', 
    		dock: 'bottom', 
    		flex:1, border : true, 
    		items : ['->', {
    			xtype : 'button', border: 1, iconCls:'btn-icon-find',style: { borderColor: '#99bce8', borderStyle: 'solid'},  
    			text: '저장', handler : function (btn, e) {
    				alert('저장..');	
    			}
    		}]
    	}],
    	listeners : {
    		cellclick : function( table, td, cellIndex, record, tr, rowIndex, e, eOpts ) {
				var clickedDataIndex = table.panel.headerCt.getHeaderAtIndex(cellIndex).dataIndex;

				// 시간을 클릭시 상세 목록에 List표시
				if( clickedDataIndex == 'HISTORY_DT_YMD' ) {
		    		// [세부기능 목록] 조회.
					var store = Ext.getStore('develop_store_form_grid_list_detail_list'); 
					var args = { p_action_flag : 'r_list_form_detail', COMPANY_ID : '0000', SYSTEM_ID : 'S',  'F_MENU_ID' : record.get('F_MENU_ID') , 'F_FORM_ID' : record.get('F_FORM_ID'), 'HISTORY_SEQ' : record.get("HISTORY_SEQ") };
					store.load({page : 1, params: args }); 
				} 
				//  "제목"을 클릭시 form에 설정 처리
				else if( clickedDataIndex == 'HISTORY_NM') {
					var grid = Ext.getCmp('id_win_develop_form_grid');
					var form = Ext.getCmp( grid.formId ); 
					
		    		var args = {'p_action_flag' : 'r_detail_form' , COMPANY_ID : '0000', SYSTEM_ID : 'S', 'F_MENU_ID' : record.get('F_MENU_ID') ,  'F_FORM_ID' : record.get('F_FORM_ID'), 'HISTORY_SEQ' : record.get("HISTORY_SEQ") }; 
		    		
		    		var store = Ext.create('Ext.data.JsonStore', {
		    				root: 'datas', 
		    				fields : [
								'COMPANY_ID',
								'SYSTEM_ID' ,
								'F_FORM_ID' ,
								'HISTORY_SEQ' ,
								'ITEM_NM' ,
								'ITEM_VAL'   
		    				], 	
		    				proxy: new Ext.data.HttpProxy({ 
		    					type: 'ajax',  
		    					url: '/s/system/develope.do' ,  // /s/system/develope.do
		    					reader: { 
		    						type: 'json', 
		    						root: 'datas' 
		    					} 
		    				}) 
		    		});				
		    		store.load({params: args});
		   			
	    			// var form = Ext.getCmp("id_main_top_win_develop_status_form_info");
	    			// var form = Ext.ComponentQuery.query('#status_form_info')[0]; 

					store.on("load", function(_this, _records, _successful, _eOpts ) {
						var fields = new Array;
						for( var x in _this.proxy.reader.rawData.datas[0] ) {
							// P_ACTION_FLAG 제외..
							
							console.log(typeof(x));
							
							if( x != 'P_ACTION_FLAG' ) {
								if( x.endsWith("_DT")) {
									fields.push({ name : x , type : 'date', format : 'Y-m-d H:i:s'} );
								} else {
									fields.push(x);
								}
							}
						}
						Ext.define('Ext.ux.FormModel', {
							extend : 'Ext.data.Model',
							fields : fields
						})
						
						var record = Ext.create('Ext.ux.FormModel', _this.proxy.reader.rawData.datas[0]  );
						
						form.loadRecord(  record );

						// form.loadRecord( _this.proxy.reader.rawData.datas[0] ); 
				       //  form.loadRecord(_records[0]);			
					});
				}
				// [삭제]버튼 클릭시 db에서 삭제 처리.
				else if( clickedDataIndex == 'DELETE') {
					
		    		var args = {'p_action_flag' : 'b_delete_form' , COMPANY_ID : '0000', SYSTEM_ID : 'S', 'F_MENU_ID' : record.get('F_MENU_ID') ,  'F_FORM_ID' : record.get('F_FORM_ID'), 'HISTORY_SEQ' : record.get("HISTORY_SEQ") }; 
					
		    		var operation = Ext.create('Ext.data.Operation', {
		    		    action : 'read',
		    		    params : args
		    		});
		    		
		    		var proxy = Ext.create('Ext.data.proxy.Ajax', {
		    		    url: '/s/system/develope.do',
		    		    api: {
		    		        create  : undefined,
		    		        read    : undefined,
		    		        update  : '/s/system/develope.do',
		    		        destroy : '/s/system/develope.do'
		    		    }
		    		});
		    		// submit처리
		    		proxy.read(operation);
		    		
		    		// grid에서 해당 row삭제...
					var store = Ext.getStore('develop_store_form_grid_list'); 
					store.removeAt( rowIndex )

					// 상세 목록 grid삭제..
					var store2 = Ext.getStore('develop_store_form_grid_list_detail_list'); 
					store2.removeAll(); 
				}
    			
    		}
    	}
    }
    ,{  // 
    	region : 'center',
        border : true,
        xtype: 'grid',
        title: 'Form 내용',
    	collapsible: true,
    	id : 'id_win_develop_form_grid_list_detail',
    	itemId : 'develop_form_grid_list_detail',
        columns: [
    	      {xtype: 'rownumberer', text : 'No', width: 30, style: 'text-align:center' },
              {header: '컬럼영', dataIndex: 'ITEM_NM', width:120}, 
              {header: '내용', flex : 1, dataIndex: 'ITEM_VAL', width:180 , 
	        	  editor : {
	        		  xtype      : 'textfield_ux'
	              }
              }, 
              {header: '구분', dataIndex: 'GBN', width:100}  // 배열 OR 단일
        ],                 
        store: Ext.create('Ext.data.JsonStore', {
        	storeId:'develop_store_form_grid_list_detail_list',
			autoDestroy: true,
			remoteSort:	true,
			pageSize : 30,
			
			fields:['ITEM_NM','ITEM_TT','ITEM_TP','ITEM_VAL'], //['TABLE_NAME', 'TABLE_ALIAS', 'TABLE_TYPE'],
			id : 'id_win_develop_store_form_grid_detail_list_store',
			proxy: Ext.create('Ext.data.HttpProxy', {
				type: 'ajax', //'memory',
				url: '/s/system/develope.do',
				reader: {
		            type: 'json',
					totalProperty: 'totalCount',
					root: 'datas'
		        },
		        writer: {
		            type: 'singlepost', // 'json',
		            writeAllFields: true,
		            encode : true,
		            root: 'datas',
		           	params : { }, // @TODO  이런 형태로 파라미터 추가 가능..
		            allowSingle : false 
		        },
				api: {
	                create: '/s/system/develope.do',
	                update: '/s/system/develope.do'
		        }
			})
	    }),
    	dockedItems: [{
    		xtype: 'toolbar', 
    		dock: 'bottom', 
    		flex:1, border : true, 
    		items : ['->', {
    			xtype : 'button', border: 1, iconCls:'btn-icon-find',style: { borderColor: '#99bce8', borderStyle: 'solid'},  
    			text: '저장', handler : function (btn, e) {
    				// var grid = Ext.getCmp('id_win_develop_form_grid_list_detail');
    				var grid = Ext.ComponentQuery.query('#win_develop_form_grid > #develop_form_grid_list_detail')[0];
    				
    				grid.submit('changed', 'b_mergeList', { noQuestion : true }); // 
    			}
    		}]
    	}],
    	plugins : [ Ext.create('Ext.grid.plugin.CellEditing', { clicksToEdit: 1} ) ]
    }],
    listeners : {
    	move : function(_this, x, y, eOpts) {
    		
    	},
    	minimize: function(_this, eOpts) {
    		
    	},
    	show: function(_this, eOpts) {
    		if( _this.formId ) {
	    		// [세부기능 목록] 조회.
				var store = Ext.getStore('develop_store_form_grid_list'); 
				var args = { p_action_flag : 'r_list_form_history', COMPANY_ID : '0000', SYSTEM_ID : 'S',  F_MENU_ID : _this.menuId, F_FORM_ID : _this.formId };
				// args.p_action_flag = 'r_list_form_history';
				store.load({page : 1, params: args }); 
				
				// 상세 목록 grid삭제..				
				var store2 = Ext.getStore('develop_store_form_grid_list_detail_list'); 
				store2.removeAll(); 
    		} else {
    			hoAlert('파라미터가 정확하지 않습니다.', Ext.exptyFn, 2000);
    		}
    	}
    },
	initComponent: function() {
		this.callParent(arguments);
	},
	setMenuId : function (menuId) {
		var me = this;
		
		this.menuId = menuId;
	},
	setMemberId : function (memberId) {
		var me = this;
		
		this.memberId = memberId;
	},
	setFormId : function (formId) {
		var me = this;
		
		this.formId = formId;
	}
});