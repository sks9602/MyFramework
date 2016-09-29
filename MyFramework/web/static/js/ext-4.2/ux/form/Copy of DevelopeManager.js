Ext.create('Ext.window.Window', {
				        	    title: '개발 진행 상태 ',
				        	    id : 'id_main_top_win_develop_status',
				        	    height: 800,
				        	    // baseCls : 'x-window-red',
				        	    width: 1200,
				        	    x : 100,
				        	    y : 100,
				        	    layout: 'border',
				        	    constrain: true,
				        	    closable: true,
				        	    closeAction: 'hide',
				        	    minimizable : true,
				        	    maximizable: true,
				        	    items: [{
				        	    	region : 'north',
				        	    	height : 150,
				        	    	xtype : 'form',
				        	    	border: true,
				        	    	margin: '0 0 5 0',
				        	    	collapsible: true,
				        	    	title : '메뉴 및 개발정보',
				        	    	items : [{
				        	    		xtype: 'fieldcontainer', 
				        	    		layout: { type: 'hbox', defaultMargins: {top: 1, right: 3, bottom: 0, left: 0} },
										items: [{
											fieldLabel: '개발자',	
											xtype : 'displayfield',
											value : '이개발',
											width : 220
										},{
											fieldLabel: '메뉴명',	
											xtype : 'textfield',
											value : '테스트 메뉴 (Sample)',
											width : 325
										},{
											fieldLabel: '메뉴 URL',	
											xtype : 'textfield',
											value : '/s/example/example.do?p_action_flag=all_in_one',
											width : 420
										},{
											fieldLabel: '기능(구현/대상)수',
											xtype : 'displayfield',
											value : ' 2 / 8',
											qtip : '개발 완료기능 수 / 개발 대상기능 수',
											width : 180
										} /* ,Ext.create('Ext.ProgressBar', {
											width: 150,
											margin : 1,
											value : 0.65,
											text : '65%'
										 }) */
										]
									},{
				        	    		xtype: 'fieldcontainer', 
				        	    		layout: { type: 'hbox', defaultMargins: {top: 0, right: 3, bottom: 0, left: 0} },
										items: [{
											/* fieldLabel: '개발상태',	
											xtype : 'displayfield',
											value : '개발중  → ',
											width : 170
										},{
											hideLabel: true, */
											fieldLabel: '개발상태',	
											xtype : 'combobox',
											width : 220, // 100,
									        queryMode:      'local',
									        value:          'test-req',
									        triggerAction:  'all',
									        forceSelection: true,
									        editable:       false,
									        name:           'dev_status',
									        displayField:   'name',
									        valueField:     'value',
									        store:          Ext.create('Ext.data.Store', {
									             fields : ['name', 'value'],
									             data   : [
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
											xtype : 'combobox',
											width : 220,
									        queryMode:      'local',
									        value:          'mh',
									        triggerAction:  'all',
									        forceSelection: true,
									        editable:       false,
									        name:           'dif',
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
											value : '65',
											minValue : 0, maxValue : 100, step : 5, allowDecimals : false,
											unit : '%',
											width : 180
										} /* ,Ext.create('Ext.ProgressBar', {
											width: 150,
											margin : 1,
											value : 0.65,
											text : '65%'
										 }) */
										]
									},{
				        	    		xtype: 'fieldcontainer', 
				        	    		layout: { type: 'hbox', defaultMargins: {top: 0, right: 3, bottom: 0, left: 0} },
										items: [{
											fieldLabel: '개발시작계획일',	
											xtype : 'datefield',
											qtip : '일정표상 개발을 시작하기로 한 날자',
											width : 220
										},{
											fieldLabel: '개발시작예정일',	
											xtype : 'datefield',
											qtip : '개발자가 실제 개발을 시작 할 수 있는 날자',
											width : 220
										},{
											fieldLabel: '개발시작일',	
											xtype : 'datefield',
											qtip : '개발자가 실제 개발을 시작 한 날자',
											width : 220
										},{
											fieldLabel: '처리/수정요청 건',	
											xtype : 'displayfield',
											value : '0 / 10',
											width : 220
										}]
									},{
				        	    		xtype: 'fieldcontainer', 
				        	    		layout: { type: 'hbox', defaultMargins: {top: 0, right: 3, bottom: 0, left: 0} },
										items: [{
											fieldLabel: '개발완료계획일',	
											xtype : 'datefield',
											qtip : '일정표상 개발을 완료하기로 한 날자',
											width : 220
										},{
											fieldLabel: '개발완료예정일',	
											xtype : 'datefield',
											qtip : '개발자가 실제 개발을 완료 할 수 있는 날자',
											width : 220
										},{
											fieldLabel: '개발완료일',	
											xtype : 'datefield',
											qtip : '개발자가 실제 개발을 완료 한 날자(단위테스트 포함)',
											width : 220
										},{
											fieldLabel: '수정완료일',	
											xtype : 'datefield',
											qtip : '개발자가 실제 개발을 완료 한 날자(수정요청 사항 포함)',
											width : 220
										},{
											fieldLabel: 'TODO건',	
											xtype : 'displayfield',
											value : '10',
											width : 220
										}]
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
						        	                          xtype: 'functionForm',
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
						        	                  {header: 'p_action_flag',width:120}, 
						        	                  {header: '기능 설명',flex:1}, 
						        	                  {header: '기능 형태(R,CUD,DOWN)',width:150}, // COMBOBOX : 화면, CUD, 다운로드, 업로드, 인터페이스 ~~ 등등  
						        	                  {header: '난이도',width:100}, 
						        	                  // {header: '개발율(%)',width:100}, 
						        	                  {header: '개발상태',width:100}],   // COMBOBOX : 개발전, 개발중, 단위 테스트완료              
						        	        store: Ext.create('Ext.data.ArrayStore', {}),
						        	        listeners : {
						        	        	columnresize : function( headerContainer, column, width ) {
						        	        		Ext.getCmp('list_id_desc').setWidth(width-5);
						        	        	}
						        	        }
						        	    }]
				        	        }, {
				        	            title: '수정요청 목록',
				        	            layout: 'border',
				        	            border : false,
				    	                items : [{ 
						        	    	region : 'center',
						        	        xtype: 'grid',
						        	        columns: [{header: 'No',width:25}, 
						        	                  {header: '범위',width:80}, 
						        	                  {header: '중요도',width:80}, 
						        	                  {header: '제목',flex:1}, 
						        	                  {header: '요청자',width:80}, 
						        	                  {header: '요청일자',width:80}, 
						        	                  {header: '완료요청일자',width:80}, 
						        	                  {header: '수정자',width:80},
						        	                  {header: '수정착수일자',width:80}, 
						        	                  {header: '수정완료일자',width:80}, 
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
						        	    	// layout: 'border',
						        	    	title : '요청 상세내용',
						        	    	items : [
						        	    	{
						        	    		xtype: 'fieldcontainer',
						        	    		layout: { type: 'hbox', defaultMargins: {top: 0, right: 3, bottom: 0, left: 0} },
												items: [{
								        	    		fieldLabel: '제목',
								        	    		xtype: 'displayfield', // 'htmleditor',
								        	    		region : 'north',
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
														fieldLabel: '완료요청일',	
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
												region : 'north',
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

											},/* {
						        	    		xtype: 'fieldcontainer',
						        	    		layout: { type: 'fit', defaultMargins: {top: 0, right: 3, bottom: 0, left: 0} },
												items: [
													Ext.create('Ext.Img', {
														region : 'center',
								        	    		id : 'id_main_top_win_develop_status_req_img',
								        	    	    src: 'http://www.sencha.com/img/20110215-feat-html5.png',
								        	    	})
							        	   		]
						        	    	} */ Ext.create('Ext.Img', {
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
								        	    		region : 'south',
								        	    		height : 80
							        	   		}]
						        	    	},{
						        	    		xtype: 'fieldcontainer',
						        	    		layout: { type: 'fit', defaultMargins: {top: 0, right: 3, bottom: 0, left: 0} },
												items: [{
														fieldLabel: '처리자 의견',
								        	    		xtype: 'textarea', // 'htmleditor',
								        	    		region : 'south',
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
				        	        }]
				        	    }], /*
				                tools: [{
				                    type: 'restore',
				                    handler: function (evt, toolEl, owner, tool) {
				                    	
				                        var window = owner.up('window');
				                        window.setWidth(1200);
				                        window.setXY([100, 100], {});
				                        window.expand(true);
				                        window.tools['restore'].hide();
				                        window.tools['minimize'].show();
				                        
				                    }
				                }], */
				        	    listeners : {
				        	    	move : function(_this, x, y, eOpts) {
				        	    		
				        	    	}/*,
				        	    	render : function(_this, x, y, eOpts) {
				        	    		_this.tools['restore'].hide();
				        	    	}*/,
				        	    	minimize: function(_this, eOpts) {
				        	    		_this.hide('id_main_tabpanel_gear');
				        	    		/*
				        	    		_this.collapse();
				        	    		_this.setWidth(150);
				        	    		_this.alignTo(Ext.get('id_main_top_win_develop_status'), 'bl-bl');
				        	    		_this.tools['minimize'].hide();
				        	    		*/
				        	    		/*
			        	    			for( var x in _this.tools ) {
			        	    				try {
			        	    					_this.tools[x].show();
			        	    				} catch(e) {
					        	    			alert(e);
					        	    		}
			        	    			}
				        	    		*/
				        	    		// _this.tools['maximize'].show();
				        	    		
				        	    	}
				        	    }
				        	});