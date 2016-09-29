/*
 * 프로그램 개발 관리를 위한 팝업 윈도우생성
 */
Ext.define('Ext.window.ux.DevelopeManger', {
	extend: 'Ext.window.Window',
    title: '개발 진행 상태 ',
    role : 'DEVELOPER', // PM, TESTER, DEVELOPER,,
    memberId : undefined,
    menuId : undefined,
    id : 'id_main_top_win_develop_status',
    height: 800,
    // baseCls : 'x-window-red',
    width: 1400,
    x : 100,
    y : 100,
    layout: 'border',
    constrain: true,
    border : false,
    closable: true,
    autoHeight: true,
    closeAction: 'hide',
    minimizable : true,
    maximizable: true,
    items: [{
    	region : 'north',
    	// height : 270,
        width: 1400,
        xtype : 'form',
        id : 'id_main_top_win_develop_status_form_info',
        itemId : 'status_form_info',
    	border: true,
    	margin: '0 0 5 0',
    	collapsible: true,
    	title : '메뉴 및 개발정보',
		layout: { 
			type: 'table', 
			columns: 5, 
			columnWidth : 320,
	        tableAttrs: {
	            style: {
	            	// width: '100%' 
	            }
	        },
			defaultMargins: {top: 1, right: 3, bottom: 0, left: 0} 
		},
        defaults: { width: '320',  autoScroll: true,  anchor: '100%',  style : 'margin-right:5px;'  },  //  
    	items : [
    	    {
				xtype : 'hidden',
				name : 'MENU_ID'
			},{
				fieldLabel: '개발자',	
				xtype : 'combotree',
				// xtype : 'combo',
				name : 'DEV_MEMBER_ID',
				multiselect : false,
				allowBlank : false
			},{
				fieldLabel: '메뉴명',	
				xtype : 'textfield_ux',
				name : 'MENU_NM',
				value : '테스트 메뉴 (Sample)'
			},{
				fieldLabel: '메뉴 URL',	
				xtype : 'textfield_ux',
				name : 'MENU_URL',
				value : '/s/example/example.do?p_action_flag=all_in_one',
				width : 420,
				colspan : 2
			},{
				fieldLabel: '기능(구현/대상)수',
				xtype : 'displayfield_ux',
				name : 'FUNCTION_CNT',
				value : ' 2 / 8',
				qtip : '개발 완료기능 수 / 개발 대상기능 수',
				width : 180
			},{
				fieldLabel: 'package(기능상위)',	
				xtype : 'textfield_ux',
				name : 'PKG_NM',
				value : 'com.base.example',
				width : 555,
				colspan : 2
			},{
				fieldLabel: 'Java 명',	
				xtype : 'textfield_ux',
				name : 'JAVA_NM',
				value : 'Example',
				qtip : 'Action.java, Delegate.java, XX.xml자동생성'
			},{
				fieldLabel: 'jsp 경로',	
				xtype : 'textfield_ux',
				name : 'JSP_PATH',
				value : '/jsp/example/',
				width : 370,
				colspan : 2
			},{
				/* fieldLabel: '개발상태',	
				xtype : 'displayfield',
				value : '개발중  → ',
				width : 170
			},{
				hideLabel: true, */
				fieldLabel: '개발상태',	
				xtype : 'combobox_ux',
				name : 'DEV_STT_CD',
		        queryMode:      'local',
		        value:          'test-req',
		        triggerAction:  'all',
		        forceSelection: true,
		        editable:       false,
		        displayField:   'name',
		        valueField:     'value',
		        store:          Ext.create('Ext.data.Store', {
		             fields : ['name', 'value'],
		             data   : [
		                 {name : '미계획',   value: 'no-plan'},
		                 {name : '계획중',   value: 'dev-plan'},
		                 {name : '개발중',   value: 'dev-ing'},
		                 {name : '테스트 요청',  value: 'test-req'},
		                 {name : '테스트 완료', value: 'test-cmpl'},
		                 {name : '수정 요청', value: 'mod-req'},
		                 {name : '수정 중', value: 'mod-ing'},
		                 {name : '개선 요청', value: 'upg-req'},
		                 {name : '개선 중', value: 'upg-ing'}
		             ]
		         })

			},{
				fieldLabel: '개발난이도',
				xtype : 'combobox_ux',
		        name:           'DEV_HARD_CD',
				// width : 220,
		        queryMode:      'local',
		        value:          'mh',
		        triggerAction:  'all',
		        forceSelection: true,
		        editable:       false,
		        displayField:   'name',
		        valueField:     'value',
		        store:          Ext.create('Ext.data.Store', {
		             fields : ['name', 'value'],
		             data   : [
		                 {name : '상-상', value: 'hh'},
		                 {name : '상-중', value: 'hm'},
		                 {name : '상-하', value: 'hl'},
		                 {name : '중-상', value: 'mh'},
		                 {name : '중-중', value: 'mm'},
		                 {name : '중-하', value: 'ml'},
		                 {name : '하-상', value: 'lh'},
		                 {name : '하-중', value: 'lm'},
		                 {name : '하-하', value: 'll'}
		             ]
		         })

			},{
				fieldLabel: '개발율',
				xtype : 'numberfield_ux',
				name : 'DEV_PRGS_RT',
				value : '65',
				minValue : 0, maxValue : 100, step : 5, allowDecimals : false,
				unit : '%',
				width : 210,
				colspan : 3
			} /* ,Ext.create('Ext.ProgressBar', {
				width: 150,
				margin : 1,
				value : 0.65,
				text : '65%'
			 }) */
			,{
				fieldLabel: '개발시작계획일',	
				xtype : 'displayfield_ux',
				name : 'DEV_STT_PLAN_DT',
				value : '2016/01/10',
				qtip : '일정표상 개발을 시작하기로 한 날자',
				width : 240
			},{
				fieldLabel: '개발시작예정일',	
				xtype : 'datefield_ux',
				name : 'DEV_STT_SCHD_DT',
				qtip : '개발자가 실제 개발을 시작 할 수 있는 날자'
			},{
				fieldLabel: '개발시작일',	
				xtype : 'datefield_ux',
				name : 'DEV_STT_DT',
				qtip : '개발자가 실제 개발을 시작 한 날자'
			},{
				fieldLabel: '처리/수정요청 건',	
				xtype : 'displayfield_ux',
				name : 'REQ_CNT',
				value : '0 / 10',
				width : 220,
				colspan : 2
			},{
				fieldLabel: '개발완료계획일',	
				xtype : 'displayfield_ux',
				name : 'DEV_END_PLAN_DT',
				value : '2016/01/15',
				qtip : '일정표상 개발을 완료하기로 한 날자'
			},{
				fieldLabel: '개발완료예정일',	
				xtype : 'datefield_ux',
				name : 'DEV_END_SCHD_DT',
				qtip : '개발자가 실제 개발을 완료 할 수 있는 날자'
			},{
				fieldLabel: '개발완료일',	
				xtype : 'datefield_ux',
				name : 'DEV_END_DT',
				qtip : '개발자가 실제 개발을 완료 한 날자(단위테스트 포함)'
			},{
				fieldLabel: '수정완료일',	
				xtype : 'datefield_ux',
				name : 'MOD_END_DT',
				qtip : '개발자가 실제 개발을 완료 한 날자(수정요청 사항 포함)'
			},{
				fieldLabel: 'TODO건',	
				xtype : 'displayfield_ux',
				name : 'TODO_CNT',
				value : '10',
				width : 220
		}],
    	dockedItems: [{
    		xtype: 'toolbar', 
    		dock: 'bottom', 
    		flex:1, border : true, 
    		items : ['->', {
    			xtype : 'button', border: 1, iconCls:'btn-icon-find',style: { borderColor: '#99bce8', borderStyle: 'solid'},  
    			text: '저장', handler : function () {
    				alert('저장..');	
    			}
    		}]
    	}]
    }
    ,{  // 
    	region : 'center',
        xtype: 'tabpanel',
        border : true,
        items : [{
            title: '구현 기능 목록',
            layout: 'border',
            border : false,
            items : [{ 
    	    	region : 'center',
    	        xtype: 'grid',
    	        dockedItems: [
    	                      {
    	                          xtype: 'functionFormTopDock',
    	                          dock: 'top',
    	                          // the grid's column headers are a docked item with a weight of 100.
    	                          // giving this a weight of 101 causes it to be docked under the column headers
    	                          weight: 101,
    	                          bodyStyle: {
    	                              'background-color': '#E4E5E7'
    	                          }
    	                      }
    	                  ],
    	        columns: [{header: 'No',width:25}, 
    	                  {header: 'p_action_flag', dataIndex: 'p_action_flag', width:120}, 
    	                  {header: 'method', dataIndex: 'method', width:110}, 
    	                  {header: 'jsp', dataIndex: 'jsp', width:150}, 
    	                  {header: '기능 설명', dataIndex: 'desc',flex:1}, 
    	                  {header: '기능 형태(R,CUD,DOWN)',dataIndex: 'due_nm',width:150}, // COMBOBOX : 화면, CUD, 다운로드, 업로드, 인터페이스 ~~ 등등  
    	                  {header: '난이도', dataIndex: 'due1_nm',width:100}, 
    	                  // {header: '개발율(%)',width:100}, 
    	                  {header: '개발상태', dataIndex: 'due2_nm',width:100}],   // COMBOBOX : 개발전, 개발중, 단위 테스트완료              
    	        store: Ext.create('Ext.data.ArrayStore', {
    	        	fields : ['p_action_flag', 'method', 'jsp', 'desc', 'due', 'due1', 'due2', 'due_nm', 'due1_nm', 'due2_nm'],
    	        	storeId : 'id_main_top_function_store'
    	        }),
    	        listeners : {
    	        	columnresize : function( headerContainer, column, width ) {
    	        		Ext.ComponentQuery.query('#id_main_top_function_form > #id_main_top_function_form_desc')[0].setWidth(width-5);
    	        		// Ext.getCmp('id_main_top_function_store_desc').setWidth(width-5);
    	        	}
    	        }
    	    }]
        }, {
            title: '수정요청 목록',
            layout: 'border',
            border : false,
	        dockedItems: [
	        	{
	            	xtype: 'toolbar', 
	                dock: 'top', 
	                items : [{
	                	xtype : 'button', border: 1, iconCls:'btn-icon-new',
	                	style: { borderColor: '#99bce8', borderStyle: 'solid'},  
	                	text: '신규 등록', 
	                	handler : function () {
	                		alert('수정요청 사항 신규 등록..');	
	                	}
	                }]
	        }],
            items : [{ 
    	    	region : 'center',
    	        xtype: 'grid',
    	        columns: [{header: 'No',width:25}, 
    	                  {header: '범위',width:80}, 
    	                  {header: '중요도',width:80}, 
    	                  {header: '제목',flex:1}, 
    	                  {header: '요청자',width:80}, 
    	                  {header: '요청일',width:80}, 
    	                  {header: '완료희망일',width:80}, 
    	                  {header: '수정자',width:80},
    	                  {header: '수정착수일',width:80}, 
    	                  {header: '수정완료일',width:80}, 
    	                  {header: 'Status',width:80}],                 
    	        store: Ext.create('Ext.data.ArrayStore', {}) // A dummy empty data store
    	    },{
    	    	region : 'east',
    	    	width : 600,
    	    	maxWidth : 800,
    	        collapsible: true,
    	        collapsed : true,
    	        collapseFirst : true,
    	        split: true,
    	    	xtype : 'form',
    	    	autoScroll:true,
    	    	// layout: 'border',
    	    	title : '요청 상세내용',
    	        dockedItems: [
    	      	        	{
    	      	            	xtype: 'toolbar', 
    	      	                dock: 'bottom', 
    	      	                items : ['->', {
    	      	                	xtype : 'button', border: 1, iconCls:'btn-icon-save',
    	      	                	style: { borderColor: '#99bce8', borderStyle: 'solid'},  
    	      	                	text: '저장', 
    	      	                	handler : function () {
    	      	                		alert('수정요청 사항 저장..');	
    	      	                	}
    	      	                }]
    	      	}],
    	    	items : [
    	    	{
    	    		xtype: 'fieldcontainer',
    	    		layout: { type: 'hbox', defaultMargins: {top: 0, right: 3, bottom: 0, left: 0} },
					items: [{
	        	    		fieldLabel: '제목',
	        	    		xtype: 'displayfield', // 'htmleditor',
	        	    		value : '이것 저것 수정해 주세요!.'
        	   				}]
    	    	},
        	   	{ 
        	   		xtype: 'fieldcontainer', 
        	   		layout : { type: 'hbox', defaultMargins: {top: 0, right: 3, bottom: 0, left: 0} },
					items : [
        	   			{
							fieldLabel: '요청일',	
							xtype : 'datefield',
							width : 220
						},{
							fieldLabel: '완료희망일',	
							xtype : 'datefield',
							width : 220
						}
        	   		]
        	   	},
        	   	{ 
        	   		xtype: 'fieldcontainer', 
        	   		layout: { type: 'hbox' , defaultMargins: {top: 0, right: 3, bottom: 0, left: 0} },
        	   		items : [
        	   			{
							fieldLabel: '수정착수일',	
							xtype : 'datefield',
							width : 220
						},{
							fieldLabel: '수정완료일',	
							xtype : 'datefield',
							width : 220
						}
        	   		]
        	   	},
        	   	{
					fieldLabel: '처리상태',
					xtype : 'combobox',
					width : 520,
			        queryMode:      'local',
			        value:          'req',
			        triggerAction:  'all',
			        forceSelection: true,
			        editable:       false,
			        name:           'status',
			        displayField:   'name',
			        valueField:     'value',
			        store:          Ext.create('Ext.data.Store', {
			             fields : ['name', 'value'],
			             data   : [
			                 {name : '요청중', value: 'req'},
			                 {name : '처리중', value: 'mod'},
			                 {name : '수정불가', value: 'cannot'},
			                 {name : '수정대상 아님', value: 'not-for-this'},
			                 {name : '확인요청중', value: 'req-conf'},
			                 {name : '확인완료', value: 'conf'}
			             ]
			         })

				},Ext.create('Ext.Img', {
					region : 'center',
					width : 550,
					height : 300,
    	    		id : 'id_main_top_win_develop_status_req_img',
    	    	    src: 'http://www.sencha.com/img/20110215-feat-html5.png',
    	    	}) ,{
    	    		xtype: 'fieldcontainer',
    	    		layout: { type: 'fit', defaultMargins: {top: 0, right: 3, bottom: 0, left: 0} },
					items: [{
							fieldLabel: '요청 내용',
	        	    		xtype: 'textarea', // 'htmleditor',
	        	    		height : 80
        	   		}]
    	    	},{
    	    		xtype: 'fieldcontainer',
    	    		layout: { type: 'fit', defaultMargins: {top: 0, right: 3, bottom: 0, left: 0} },
					items: [{
							fieldLabel: '처리자 의견',
	        	    		xtype: 'textarea', // 'htmleditor',
	        	    		height : 80
        	   		}]
    	    	}]
    	    }]
        }, {
            title: 'TODO 목록',
            layout: 'border',
            border : false,
            items : [{  
    	    	region : 'center',
    	        xtype: 'grid',
    	        // border: true,
    	        columns: [
    	                  	{header: 'No',width:25}, 
    	                  	{header: 'Title',flex:1}, 
    	                  	{header: '착수예정일',width:80}, 
    	                  	{header: '착수일',width:80}, 
    	                  	{header: '완료예정일',width:80}, 
    	                  	{header: '완료일',width:80}, 
    	                  	{ header: 'Status',width:80}],                 // One header just for show. There's no data,
    	        store: Ext.create('Ext.data.ArrayStore', {}) // A dummy empty data store
    	    }]
        }, {
            title: '프로젝트 조직',
            layout: 'border',
            border : false,
            items : [{  
    	    	region : 'center',
    	        xtype: 'tree',
    	        // border: true,
        	    rootVisible: false,
        	    autoScroll:true,
                bodyStyle:{"background-color":"white"},
                store: Ext.create('Ext.data.TreeStore', {
	     	    	root: {
	     	        	expanded: true,
	     	            children: [
	     	                { text: "Project 팀", leaf: false, expanded: true, children: [
		     	                { text: "개발 팀", leaf: false, expanded: true, children: [
		     	                    { text: "개발자 1", leaf: true },
		     	                   	{ text: "개발자 2", leaf: true}
		     	                ] },
		     	                { text: "디자인 팀", expanded: true },
		     	                { text: "유지보수 팀", leaf: false, expanded: true, children: [
	    	     	                { text: "개발자 2", leaf: true },
	   	     	                    { text: "개발자 3", leaf: true}
	   	     	                ] }
		     	            ]},
	     	                { text: "현업", leaf: false, expanded: true, children: [
		     	                { text: "인사 팀", leaf: false, expanded: true, children: [
		     	                    { text: "개발자 1", leaf: true },
		     	                   	{ text: "개발자 2", leaf: true}
		     	                ] },
		     	                { text: "인프라 팀", expanded: true },
		     	                { text: "보안 팀", leaf: false, expanded: true, children: [
	    	     	                { text: "개발자 2", leaf: true },
	   	     	                    { text: "개발자 3", leaf: true}
	   	     	                ] }
		     	            ]}
	     	            ]
	     	        }
	     	    })
    	    }]
        },
        {
            title: '요구 사항 관리',
            layout: 'border',
            border : false,
            items : [{ 
    	    	region : 'center',
    	        xtype: 'grid',
    	        columns: [{header: 'No',width:25}, 
    	                  {header: '요구구분', flex:1}, 
    	                  {header: '요구사항', dataIndex: 'desc',flex:1}, 
    	                  {header: '요청자', dataIndex: 'p_action_flag', width:120}, 
    	                  {header: '요청일자', dataIndex: 'method', width:110}, 
    	                  {header: '적용내용',width:200}, 
    	                  {header: '적용자',width:100},
    	                  {header: '적용확인',width:100}],         
    	        store: Ext.create('Ext.data.ArrayStore', {
    	        	fields : ['p_action_flag', 'method', 'desc'],
    	        	storeId : 'id_main_top_demand_store'
    	        }),
    	        listeners : {
    	        	columnresize : function( headerContainer, column, width ) {
    	        		// Ext.getCmp('id_main_top_demand_store').setWidth(width-5);
    	        	}
    	        }
    	    },{
    	    	region : 'east',
    	    	width : 600,
    	    	maxWidth : 800,
    	        collapsible: true,
    	        collapsed : true,
    	        collapseFirst : true,
    	        split: true,
    	    	xtype : 'form',
    	    	title : '요구 상세내용',
    	    	items : [
        	   	{
					fieldLabel: '요구 구분',
					xtype : 'combobox',
					width : 520,
			        queryMode:      'local',
			        value:          'req',
			        triggerAction:  'all',
			        forceSelection: true,
			        editable:       false,
			        name:           'status',
			        displayField:   'name',
			        valueField:     'value',
			        store:          Ext.create('Ext.data.Store', {
			             fields : ['name', 'value'],
			             data   : [
			                 {name : '현업 -> Project팀', value: 'req'},
			                 {name : '현업 -> 현업', value: 'mod'},
			                 {name : 'Project팀 -> Project팀', value: 'cannot'},
			                 {name : 'Project팀 -> 현업', value: 'not-for-this'}
			             ]
			         })

				},{
    	    		xtype: 'fieldcontainer',
    	    		layout: { type: 'fit', defaultMargins: {top: 0, right: 3, bottom: 0, left: 0} },
					items: [{
							fieldLabel: '요구 사항',
	        	    		xtype: 'textarea', // 'htmleditor',
	        	    		height : 80
        	   		}]
    	    	},
        	   	{ 
        	   		xtype: 'fieldcontainer', 
        	   		layout : { type: 'hbox', defaultMargins: {top: 0, right: 3, bottom: 0, left: 0} },
					items : [
        	   			{
							fieldLabel: '요청일',	
							xtype : 'datefield',
							width : 220
						},{
							fieldLabel: '요청자',	
							xtype : 'datefield',
							width : 220
						}
        	   		]
        	   	},
        	   	{ 
        	   		xtype: 'fieldcontainer', 
        	   		layout: { type: 'hbox' , defaultMargins: {top: 0, right: 3, bottom: 0, left: 0} },
        	   		items : [
        	   			{
							fieldLabel: '응답일',	
							xtype : 'datefield',
							width : 220
						},{
							fieldLabel: '응답자',	
							xtype : 'datefield',
							width : 220
						}
        	   		]
        	   	},
        	   	{ 
        	   		xtype: 'fieldcontainer', 
        	   		layout: { type: 'hbox' , defaultMargins: {top: 0, right: 3, bottom: 0, left: 0} },
        	   		items : [
        	   			{
							fieldLabel: '적용일',	
							xtype : 'datefield',
							width : 220
						},{
							fieldLabel: '적용자',	
							xtype : 'datefield',
							width : 220
						}
        	   		]
        	   	},
        	   	{
    	    		xtype: 'fieldcontainer',
    	    		layout: { type: 'fit', defaultMargins: {top: 0, right: 3, bottom: 0, left: 0} },
					items: [{
							fieldLabel: '적용내용',
	        	    		xtype: 'textarea', // 'htmleditor',
	        	    		height : 80
        	   		}]
    	    	}]
    	    }]
        }]
    }], 
    listeners : {
    	move : function(_this, x, y, eOpts) {
    		
    	},
    	minimize: function(_this, eOpts) {
    		_this.hide('id_main_tabpanel_gear');
    	},
    	show : function(_this, eOpts) {
    		var me = _this;
    		if( me.memberId && me.menuId ) {
	    		var args = {'MEMBER_ID' : me.memberId,'MENU_ID' : me.menuId ,'p_action_flag' : 'r_detail_pms'};
	    		var store = Ext.create('Ext.data.JsonStore', {
	    				root: 'datas', 
	    				fields : [
							'COMPANY_ID',
							'SYSTEM_ID',
							'MENU_ID',
							'DEV_MEMBER_ID',
							'PKG_NM',
							'JAVA_NM',
							'JSP_PATH',
							'DEV_STT_CD',
							'DEV_HARD_CD',
							'DEV_PRGS_RT',
							'DEV_STT_PLAN_DT',
							'DEV_STT_SCHD_DT',
							'DEV_STT_DT',
							'DEV_END_PLAN_DT',
							'DEV_END_SCHD_DT',
							'DEV_END_DT',
							'MOD_END_DT'    
	    				], 
	    				proxy: new Ext.data.HttpProxy({ 
	    					type: 'ajax',  
	    					url: '/s/system/menu.do' ,  // /s/system/develope.do
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
					// [메뉴 정보] From 내용 설정
					var form = Ext.ComponentQuery.query('#status_form_info')[0];
					if( _records && _records[0]) {
						form.loadRecord(_records[0]);		
					}
				});
    		}
    	}
    },
	initComponent: function() {
		this.callParent(arguments);
	},
	setMemberId : function (memberId) {
		var me = this;
		
		this.memberId = memberId;
	},
	setMenuId : function (menuId) {
		var me = this;
		
		this.menuId = menuId;
	}
});