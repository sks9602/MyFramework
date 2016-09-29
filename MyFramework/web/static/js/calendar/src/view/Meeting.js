Ext.define('Ext.ux.grid.dock.MeetingForm', {
    extend: 'Ext.form.Panel',
    xtype: 'meetingFormTopDock',
    requires: [
       'Ext.layout.container.HBox',
       'Ext.form.field.Date'
    ],
    layout: 'hbox',
    cls: 'tasks-new-form',
    itemId : 'id_project_meeting_form',
    initComponent: function() {
        this.items = [
            {
            	xtype: 'component',
                cls: 'tasks-new',
                width: 25,
                height: 24
            },
            {
                xtype: 'textfield',
                name: 'item',
                emptyText: '내용을 입력하세요.',
                allowBlank : false,
                flex : 1,
                fieldCls : 'x-form-type-korean',
                // width : 665,
                viewConfig : { style:{ padding : '0 90 0 0' } } 
            }
        ];

        this.callParent(arguments);
    },
    listeners : {
    	render : function(_this, eOpts) {
    		var fields = _this.query('textfield')
    		for( var i=0; i<fields.length ; i++) {
    			fields[i].on('specialkey', function(me, ef, efOpts) {
            		if(ef.getKey() === ef.ENTER) {
            			if (_this.isValid()) {

            				var values = _this.getValues()
            				
        					// Store에 추가
	                		Ext.getStore('id_main_top_function_store').add( values );
	                		// Form초기화
	                		_this.getForm().reset();
            			}
            		}
    			});	
    		}
    	}
    } 

});



Ext.define('Ext.ux.grid.dock.MeetingDetailGrid', {
    extend: 'Ext.grid.Panel',
    xtype: 'meetingDetailGrid',
    store: 'meetingDetailGridStore',
    columnLines: true,
    border : 0,
    dockedItems: [
        {
            xtype: 'meetingFormTopDock',
            dock: 'top',
            weight: 101,
            bodyStyle: {
                'background-color': '#E4E5E7'
            }
        }
    ],
    initComponent: function() {
        var me = this;

        me.columns = {
        		/*
        		defaults: {
        			resizable : false,
                    hideable: false
                },
                */
            items: [
				{xtype: 'rownumberer', text : 'No', width: 24 },
				{text: "회의 내용", flex : 1, dataIndex: 'company', align:'center', resizable : true,
					renderer: function(v, p, r) {
						return Ext.String.format("<div class=\"in_grid_url_link\" style=\"text-align:left\"  onclick=\"alert(1); fs_click_meetingItem(1)\">{0}</div>", v, r.data.ID);
					},
                    editor: {
                        xtype: 'textfield',
                        selectOnFocus: true
                    }
				},
				{
				    xtype: 'actioncolumn',
				    dataIndex: 'reminder',
				    cls: 'tasks-icon-column-header tasks-reminder-column-header',
				    width: 24,
				    tooltip: 'Set Reminder',
				    menuPosition: 'tr-br',
				    menuDisabled: true,
				    sortable: false,
				    emptyCellText: '',
				    resizable : false,
				    listeners: {
				        // select: Ext.bind(me.handleReminderSelect, me)
				    }
				},
				{
				    xtype: 'actioncolumn',
				    cls: 'tasks-icon-column-header tasks-edit-column-header',
				    width: 24,
				    icon: 'resources/images/edit_task.png',
				    iconCls: 'x-hidden',
				    tooltip: 'Edit',
				    menuDisabled: true,
				    resizable : false,
				    sortable: false
				   // , handler: Ext.bind(me.handleEditClick, me)
				},
				{
				    xtype: 'actioncolumn',
				    cls: 'tasks-icon-column-header tasks-delete-column-header',
				    width: 24,
				    icon: 'resources/images/delete.png',
				    iconCls: 'x-hidden',
				    tooltip: 'Delete',
				    menuDisabled: true,
				    resizable : false,
				    sortable: false
				    // , handler: Ext.bind(me.handleDeleteClick, me)
				}
            ]
        };

        this.store = Ext.create('Ext.data.ArrayStore', {
            model: Ext.define('Company', {
                extend: 'Ext.data.Model',
                fields: [
                    {name: 'company'},
                    {name: 'price', type: 'float'},
                    {name: 'change', type: 'float'},
                    {name: 'pctChange', type: 'float'},
                    {name: 'lastChange', type: 'date', dateFormat: 'n/j h:ia'},
                    {name: 'industry'},
                    {name: 'desc'}
                 ]
            }) ,
            data: [
                   ['Merck & Co., Inc.',40.96,0.41,1.01,'9/1 12:00am', 'Medical'],
                   ['Microsoft Corporation',25.84,0.14,0.54,'9/1 12:00am', 'Computer'],
                   ['Pfizer Inc',27.96,0.4,1.45,'9/1 12:00am', 'Medical'],
                   ['The Coca-Cola Company',45.07,0.26,0.58,'9/1 12:00am', 'Food'],
                   ['The Home Depot, Inc.',34.64,0.35,1.02,'9/1 12:00am', 'Retail'],
                   ['The Procter & Gamble Company',61.91,0.01,0.02,'9/1 12:00am', 'Manufacturing'],
                   ['United Technologies Corporation',63.26,0.55,0.88,'9/1 12:00am', 'Computer'],
                   ['Verizon Communications',35.57,0.39,1.11,'9/1 12:00am', 'Services'],
                   ['Wal-Mart Stores, Inc.',45.45,0.73,1.63,'9/1 12:00am', 'Retail'],
                   ['Walt Disney Company (The) (Holding Company)',29.89,0.24,0.81,'9/1 12:00am', 'Services'],
                   ['Merck & Co., Inc.',40.96,0.41,1.01,'9/1 12:00am', 'Medical'],
                   ['Microsoft Corporation',25.84,0.14,0.54,'9/1 12:00am', 'Computer'],
                   ['Pfizer Inc',27.96,0.4,1.45,'9/1 12:00am', 'Medical'],
                   ['The Coca-Cola Company',45.07,0.26,0.58,'9/1 12:00am', 'Food'],
                   ['The Home Depot, Inc.',34.64,0.35,1.02,'9/1 12:00am', 'Retail'],
                   ['The Procter & Gamble Company',61.91,0.01,0.02,'9/1 12:00am', 'Manufacturing'],
                   ['United Technologies Corporation',63.26,0.55,0.88,'9/1 12:00am', 'Computer'],
                   ['Verizon Communications',35.57,0.39,1.11,'9/1 12:00am', 'Services'],
                   ['Wal-Mart Stores, Inc.',45.45,0.73,1.63,'9/1 12:00am', 'Retail'],
                   ['Walt Disney Company (The) (Holding Company)',29.89,0.24,0.81,'9/1 12:00am', 'Services'],
                   ['Merck & Co., Inc.',40.96,0.41,1.01,'9/1 12:00am', 'Medical'],
                   ['Microsoft Corporation',25.84,0.14,0.54,'9/1 12:00am', 'Computer'],
                   ['Pfizer Inc',27.96,0.4,1.45,'9/1 12:00am', 'Medical'],
                   ['The Coca-Cola Company',45.07,0.26,0.58,'9/1 12:00am', 'Food'],
                   ['The Home Depot, Inc.',34.64,0.35,1.02,'9/1 12:00am', 'Retail'],
                   ['The Procter & Gamble Company',61.91,0.01,0.02,'9/1 12:00am', 'Manufacturing'],
                   ['United Technologies Corporation',63.26,0.55,0.88,'9/1 12:00am', 'Computer'],
                   ['Verizon Communications',35.57,0.39,1.11,'9/1 12:00am', 'Services'],
                   ['Wal-Mart Stores, Inc.',45.45,0.73,1.63,'9/1 12:00am', 'Retail'],
                   ['Walt Disney Company (The) (Holding Company)',29.89,0.24,0.81,'9/1 12:00am', 'Services'],
                   ['Merck & Co., Inc.',40.96,0.41,1.01,'9/1 12:00am', 'Medical'],
                   ['Microsoft Corporation',25.84,0.14,0.54,'9/1 12:00am', 'Computer'],
                   ['Pfizer Inc',27.96,0.4,1.45,'9/1 12:00am', 'Medical'],
                   ['The Coca-Cola Company',45.07,0.26,0.58,'9/1 12:00am', 'Food'],
                   ['The Home Depot, Inc.',34.64,0.35,1.02,'9/1 12:00am', 'Retail'],
                   ['The Procter & Gamble Company',61.91,0.01,0.02,'9/1 12:00am', 'Manufacturing'],
                   ['United Technologies Corporation',63.26,0.55,0.88,'9/1 12:00am', 'Computer'],
                   ['Verizon Communications',35.57,0.39,1.11,'9/1 12:00am', 'Services'],
                   ['Wal-Mart Stores, Inc.',45.45,0.73,1.63,'9/1 12:00am', 'Retail'],
                   ['Walt Disney Company (The) (Holding Company)',29.89,0.24,0.81,'9/1 12:00am', 'Services'],
                   ['Merck & Co., Inc.',40.96,0.41,1.01,'9/1 12:00am', 'Medical'],
                   ['Microsoft Corporation',25.84,0.14,0.54,'9/1 12:00am', 'Computer'],
                   ['Pfizer Inc',27.96,0.4,1.45,'9/1 12:00am', 'Medical'],
                   ['The Coca-Cola Company',45.07,0.26,0.58,'9/1 12:00am', 'Food'],
                   ['The Home Depot, Inc.',34.64,0.35,1.02,'9/1 12:00am', 'Retail'],
                   ['The Procter & Gamble Company',61.91,0.01,0.02,'9/1 12:00am', 'Manufacturing'],
                   ['United Technologies Corporation',63.26,0.55,0.88,'9/1 12:00am', 'Computer'],
                   ['Verizon Communications',35.57,0.39,1.11,'9/1 12:00am', 'Services'],
                   ['Wal-Mart Stores, Inc.',45.45,0.73,1.63,'9/1 12:00am', 'Retail'],
                   ['Walt Disney Company (The) (Holding Company)',29.89,0.24,0.81,'9/1 12:00am', 'Services']
               ]
        });
        
        
        me.callParent(arguments);
        
    }
});


Ext.define('Ext.window.ux.WindowMeeting', {
    extend: 'Ext.window.Window',
    xtype: 'windowMeeting',
    alias: 'widget.windowMeeting',
	height: 800,
	width: 800,
	resizable : false,
	// layout: 'border',
	// forceFit: true,
	border: false,
	// draggable : false,
	closeAction : 'hide' ,
    initComponent: function () {
    	var me = this;
    		
    	me.callParent(arguments);
    }
});


/**
 * @class Ext.calendar.view.Month
 * @extends Ext.calendar.CalendarView
 * <p>Displays a calendar view by month. This class does not usually need ot be used directly as you can
 * use a {@link Ext.calendar.CalendarPanel CalendarPanel} to manage multiple calendar views at once including
 * the month view.</p>
 * @constructor
 * @param {Object} config The config object
 */
Ext.define('Ext.calendar.view.Meeting', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.ux_meeting',

    requires: [
        'Ext.data.ArrayStore'
    ],
    isCalendar : false,
    layout : 'border',
    border :false,
    items : [{
		xtype:'panel', 
		title : '검색조건', 
	      region :'north',
	      items : [{
	    	  	xtype : 'form',
	            // style: 'border-bottom: 1; ', // padding : 5px; 
	    	  	border : 0,
	            bodyStyle: {  'padding-top': '1px' },
	        	layout: { type: 'table' , columns: 4, defaultMargins: {top: 0, right: 0, bottom: 1, left: 0} },
	        	defaults: { autoScroll: false, anchor: '100%', labelWidth: 120, margin : '0 1 1 1' },
	        	items : [
	               {
     		        	width         : 300, 
	     		        xtype         : 'combo',
	     		        queryMode     : 'local',
	     		        value         : 'mrs',
	     		        triggerAction : 'all',
	     		        forceSelection: true,
	     		        editable      : false,
	     		        fieldLabel    :  'Project',
	     		        labelSeparator : '',
	     		        labelCls   : 'x-form-item-label',
	     		        name          : 'project',
	     		        displayField  : 'name',
	     		        valueField    : 'value',
	     		        code          : 'X10', 
	     		        store         : Ext.create('Ext.data.Store', {
	     		            fields    : ['name', 'value'],
	     		            data      : [
	     		                {name : 'A Project',   value : 'mr'},
	     		                {name : 'B 프로젝트',  value : 'mrs'},
	     		                {name : 'C ~~', value : 'miss'}
	     		            ]
	     		        })
	     		     },
	     		     {
						    xtype: 'checkboxgroup', 
						    fieldLabel: '프토젝트',
		     		        labelSeparator : '',
						    border : 0,
						    columns: 4,
						    width: 110*4,
						    items: [{
						    	xtype : 'checkbox',
						        boxLabel: '요구반영',
						        name: 'animals',
						        value: 'dog',
						        inputValue: 'dog'
						    }, {
						    	xtype : 'checkbox',
						        boxLabel: '미반영',
						        name: 'animals',
						        inputValue: 'monkey'
						    }, {
						    	xtype : 'checkbox',
						        boxLabel: '참고사항',
						        name: 'animals',
						        value: 'cat',
						        inputValue : 'cat'
						    }, {
						    	xtype : 'checkbox',
						        boxLabel: '결정보류',
						        name: 'animals',
						        inputValue: 'monkey'
						    }]
						}  ,
						{
							xtype     : 'textfield',
							width :  300,
							name      : 'text',
							fieldLabel: '조직명',
		     		        labelSeparator : '',
							msgTarget: 'side'
					
						}]
    	                   } 
    	          ],
    	          dockedItems: [{
    	        	  xtype: 'toolbar', flex:1, dock :'bottom', border : true,  
    	        	  items : [ '->', { xtype : 'button' , text : '조회' }]
    	          }]
    	         },
    	         {
						xtype : 'grid',
						title : '회의록 목록',
						region : 'east',
						width : 600,
						minWidth : 100,
						maxWidth : 1000,
						collapsible : true,
						split : true,
						columns : [
							{
								xtype : 'rownumberer',
								text : 'No',
								width : 40
							},
							{
								text : "회의 일시",
								dataIndex : 'lastChange',
								align : 'center',
								renderer : Ext.util.Format.dateRenderer('Y/m/d a')
							},
							{
								text : "회의 제목",
								flex : 1,
								dataIndex : 'company',
								align : 'center',
								renderer : function(v, p, r) {
									return Ext.String.format(
											"<div class=\"in_grid_url_link\" style=\"text-align:left\"  onclick=\"alert(1); fs_click_meetingItem(1)\">{0}</div>",
											v, r.data.ID);
								}
							},
							{
								text : "Price",
								renderer : Ext.util.Format.usMoney,
								dataIndex : 'price'
							},
							{
								text : "Change",
								dataIndex : 'change'
							},
							{
								text : "Last Updated",
								renderer : Ext.util.Format .dateRenderer('Y/m/d A'),
								dataIndex : 'lastChange'
							} ],
							store : Ext.create('Ext.data.ArrayStore', {
								model : Ext.define('Company', {
											extend : 'Ext.data.Model',
											fields : [
													{name : 'company'},
													{name : 'price',type : 'float'},
													{name : 'change',type : 'float'},
													{name : 'pctChange',type : 'float'},
													{name : 'lastChange',type : 'date',dateFormat : 'n/j h:ia'},
													{name : 'industry'},
													{name : 'desc'} 
											]
										}),
										data : [
						                           ['3m Co',71.72,0.02,0.03,'9/1 12:00am', 'Manufacturing'],
						                           ['Alcoa Inc',29.01,0.42,1.47,'9/1 12:00am', 'Manufacturing'],
						                           ['Altria Group Inc',83.81,0.28,0.34,'9/1 12:00am', 'Manufacturing'],
						                           ['American Express Company',52.55,0.01,0.02,'9/1 12:00am', 'Finance'],
						                           ['American International Group, Inc.',64.13,0.31,0.49,'9/1 12:00am', 'Services'],
						                           ['AT&T Inc.',31.61,-0.48,-1.54,'9/1 12:00am', 'Services'],
						                           ['Boeing Co.',75.43,0.53,0.71,'9/1 12:00am', 'Manufacturing'],
						                           ['Caterpillar Inc.',67.27,0.92,1.39,'9/1 12:00am', 'Services'],
						                           ['Citigroup, Inc.',49.37,0.02,0.04,'9/1 12:00am', 'Finance'],
						                           ['E.I. du Pont de Nemours and Company',40.48,0.51,1.28,'9/1 12:00am', 'Manufacturing'],
						                           ['Exxon Mobil Corp',68.1,-0.43,-0.64,'9/1 12:00am', 'Manufacturing'],
						                           ['General Electric Company',34.14,-0.08,-0.23,'9/1 12:00am', 'Manufacturing'],
						                           ['General Motors Corporation',30.27,1.09,3.74,'9/1 12:00am', 'Automotive'],
						                           ['Hewlett-Packard Co.',36.53,-0.03,-0.08,'9/1 12:00am', 'Computer'],
						                           ['Honeywell Intl Inc',38.77,0.05,0.13,'9/1 12:00am', 'Manufacturing'],
						                           ['Intel Corporation',19.88,0.31,1.58,'9/1 12:00am', 'Computer'],
						                           ['International Business Machines',81.41,0.44,0.54,'9/1 12:00am', 'Computer'],
						                           ['Johnson & Johnson',64.72,0.06,0.09,'9/1 12:00am', 'Medical'],
						                           ['JP Morgan & Chase & Co',45.73,0.07,0.15,'9/1 12:00am', 'Finance'],
						                           ['McDonald\'s Corporation',36.76,0.86,2.40,'9/1 12:00am', 'Food'],
						                           ['Merck & Co., Inc.',40.96,0.41,1.01,'9/1 12:00am', 'Medical'],
						                           ['Microsoft Corporation',25.84,0.14,0.54,'9/1 12:00am', 'Computer'],
						                           ['Pfizer Inc',27.96,0.4,1.45,'9/1 12:00am', 'Medical'],
						                           ['The Coca-Cola Company',45.07,0.26,0.58,'9/1 12:00am', 'Food'],
						                           ['The Home Depot, Inc.',34.64,0.35,1.02,'9/1 12:00am', 'Retail'],
						                           ['The Procter & Gamble Company',61.91,0.01,0.02,'9/1 12:00am', 'Manufacturing'],
						                           ['United Technologies Corporation',63.26,0.55,0.88,'9/1 12:00am', 'Computer'],
						                           ['Verizon Communications',35.57,0.39,1.11,'9/1 12:00am', 'Services'],
						                           ['Wal-Mart Stores, Inc.',45.45,0.73,1.63,'9/1 12:00am', 'Retail'],
						                           ['Walt Disney Company (The) (Holding Company)',29.89,0.24,0.81,'9/1 12:00am', 'Services']
						                 ]
									}),
								columnLines : true,
								enableLocking : true,
								dockedItems : [
										Ext.create('Ext.ux.PagingToolbar', {
											displayInfo : true,
											dock : 'bottom',
											border : 1,
											itemId : 'id_meeting_grid_bbar_gridPageTB',
											pageCnt : 10
										}) 
									]
							},
							Ext.create('Ext.panel.Panel',{
								layout : 'card',
								activeItem : 1,
								region : 'center',
								itemId : 'id-meeting-card-panel',
				            	width : 600,
				            	minWidth : 100,
				            	// maxWidth : 1000,
								items : [ {
										layout : 'border',
										border : 0,
										title : '회의록 등록',
										items : [{
							            	xtype:'formPanel',
							            	autoSubmit : true,
							            	// title : '상세내용',
							    	          dockedItems: [	
										        	          {
																		xtype : 'toolbar',
																		flex : 1,
																		dock : 'bottom',
																		border : true,
																		items : [{ xtype : 'label', text : '', itemId : 'id_auto_save_msg' }, '->', {
																			xtype : 'button',
																			text : '회의록 저장',
																			handler : function(btn) {
																						btn.up("#id-meeting-card-panel").getLayout().setActiveItem(1) ; 

																					}
																				},
																				{
																					xtype : 'button',
																					text : '취소',
																					handler : function(btn) {
																						// console.log(btn.up("panel").up("panel").up("panel").getLayout().setActiveItem(1) );
																						btn.up("#id-meeting-card-panel").getLayout().setActiveItem(1) ; 
																					}
																				}]
																			}
										      		     ],
							            	region : 'north',
							            	collapsible: false,
							            	split: false,
							            	border : 0,
							            	width : 600,
							            	minWidth : 100,
							            	// maxWidth : 1000,
							            	defaults: { autoScroll: false, anchor: '100%', labelWidth: 120, margin : '0 1 1 0' ,
												listeners: {
													change  : {
														fn: function( _this, newValue, oldValue, eOpts ) {
															var formPanel = _this.up('panel');
															formPanel.setFieldChangeStatus( _this );
															/*
															var saveMsg = formPanel.down('toolbar').down('#id_auto_save_msg');
															
															// formPanel.submit();
															saveMsg.setText('# Saving draft...');
															
															Ext.defer(function(){
													        }, 2000);
															*/
														},
														buffer: 1000
													}
												}},
							            	items : [
													{
														xtype     : 'hidden',
														name      : 'P_ACTION_FLAG',
														id        : 'P_ACTION_FLAG'
													},{
														xtype     : 'textfield',
														name      : 'title',
														fieldLabel: '회의제목',
													    labelSeparator : '',
													    margin : '1 1 1 0',
														msgTarget: 'side',
														inputCls : 'x-field-ux-korean'													
													},
													{
														layout     : 'hbox',
														border : 0,
														defaults: { labelWidth: 120 ,
															listeners: {
																change  : {
																	fn: function( _this, newValue, oldValue, eOpts ) {
																		var formPanel = _this.up('panel').up('panel');
																		formPanel.setFieldChangeStatus( _this );
																		// formPanel.submit();
																	},
																	buffer: 1000
																}
															}},
														items : [{
															xtype     : 'datefield',
															name      : 'meet_dt',
															fieldLabel: '회의 일시',
														    labelSeparator : '',
															msgTarget: 'side'
														},{
															border : 0,
															margin : '0 10 0 0',
															html : ' '
														},{
															xtype     : 'timefield',
															width     : 80,
															name      : 'time_st',
															id      : 'time_st',
															itemId      : 'time_st',
															listeners : {
																change : function( _this, newValue, oldValue, eOpts ) {
																	var timeEd = _this.up('panel').down('#time_ed');
																	if( timeEd.getValue() ) {
																		
																		if( timeEd.getValue() < newValue ) {
																			timeEd.markInvalid( ' This field has to less than ' + timeEd.getRawValue() );
																		}
																	}
																	timeEd.setMinValue( newValue );
																}
															}
														},{
															border : 0,
															margin : '0 10 0 10',
															html : ' ~ '
														},{
															xtype     : 'timefield',
															width     : 80,
															name      : 'time_ed',
															id      : 'time_ed',
															itemId      : 'time_ed',
															listeners : {
																change : function( _this, newValue, oldValue, eOpts ) {
																	// _this.up('panel').down('#time_st').setMaxValue( newValue );
																	var timeSt = _this.up('panel').down('#time_st');
																	if( timeSt.getValue() ) {
																		
																		if( timeSt.getValue() > newValue ) {
																			timeSt.markInvalid( ' This field has to less than ' + timeSt.getRawValue() );
																		}
																	}
																	timeSt.setMaxValue( newValue );
																}
															}
														}]
													},
													{
														xtype     : 'textfield',
														name      : 'place',
														fieldLabel: '회의 장소',
													    labelSeparator : '',
														msgTarget: 'side'
													},
													{
														xtype     : 'textfield',
														name      : 'member_no',
														fieldLabel: '참석자',
													    labelSeparator : '',
														msgTarget: 'side'
													},
													{
														xtype     : 'textfield',
														name      : 'regi_nm',
														fieldLabel: '작성자',
													    labelSeparator : '',
														msgTarget: 'side'
													}
							    	        	]
							             }, {
											titleAlign : 'left',
											xtype:'meetingDetailGrid',
											region : 'center',
											title : '회의상세 내용'
									}]},{
									xtype : 'grid',
									title : '회의 상세내용',
									columnLines : true,
									border : 0,
									columns : {
										defaults : {
											hideable : false
										},
										items : [
												{
													xtype : 'rownumberer',
													text : 'No',
													width : 35
												},
												{
													text : "구분",
													width : 120,
													dataIndex : 'company',
													align : 'center'
												},
												{
													text : "회의 일시",
													dataIndex : 'lastChange',
													align : 'center',
													renderer : Ext.util.Format
															.dateRenderer('Y/m/d a')
												},
												{
													text : "회의 내용",
													flex : 1,
													dataIndex : 'company',
													align : 'center',
													renderer : function(
															v,
															p,
															r) {
														return Ext.String
																.format(
																		"<div class=\"in_grid_url_link\" style=\"text-align:left\"  onclick=\"alert(1); fs_click_meetingItem(1)\">{0}</div>",
																		v,
																		r.data.ID);
													},
													editor : {
														xtype : 'textfield',
														selectOnFocus : true
													}
												},
												{
													xtype : 'actioncolumn',
													cls : 'tasks-icon-column-header tasks-edit-column-header',
													width : 24,
													icon : 'resources/images/edit_task.png',
													iconCls : 'x-hidden',
													tooltip : '참고사항',
													menuDisabled : true,
													resizable : false,
													sortable : false
												// , handler:
												// Ext.bind(me.handleEditClick,
												// me)
												},
												{
													xtype : 'actioncolumn',
													dataIndex : 'reminder',
													cls : 'tasks-icon-column-header tasks-reminder-column-header',
													width : 24,
													tooltip : '요구 반영',
													iconCls : 'x-hidden',
													menuPosition : 'tr-br',
													menuDisabled : true,
													sortable : false,
													emptyCellText : '',
													resizable : false,
													listeners : {
													// select:
													// Ext.bind(me.handleReminderSelect,
													// me)
													}
												},
												{
													xtype : 'actioncolumn',
													cls : 'tasks-icon-column-header tasks-delete-column-header',
													width : 24,
													icon : 'resources/images/delete.png',
													iconCls : 'x-hidden',
													iconCls : 'x-hidden',
													tooltip : '요구 미반영',
													menuDisabled : true,
													resizable : false,
													sortable : false
												// , handler: Ext.bind(me.handleDeleteClick, me)
												} ]
									},
	                store : Ext.create('Ext.data.ArrayStore', {
	                    model: Ext.define('Company', {
	                        extend: 'Ext.data.Model',
	                        fields: [
	                            {name: 'company'},
	                            {name: 'price', type: 'float'},
	                            {name: 'change', type: 'float'},
	                            {name: 'pctChange', type: 'float'},
	                            {name: 'lastChange', type: 'date', dateFormat: 'n/j h:ia'},
	                            {name: 'industry'},
	                            {name: 'desc'}
	                         ]
	                    }) ,
	                    data: [
	                           ['Merck & Co., Inc.',40.96,0.41,1.01,'9/1 12:00am', 'Medical'],
	                           ['Microsoft Corporation',25.84,0.14,0.54,'9/1 12:00am', 'Computer'],
	                           ['Pfizer Inc',27.96,0.4,1.45,'9/1 12:00am', 'Medical'],
	                           ['The Coca-Cola Company',45.07,0.26,0.58,'9/1 12:00am', 'Food'],
	                           ['The Home Depot, Inc.',34.64,0.35,1.02,'9/1 12:00am', 'Retail'],
	                           ['The Procter & Gamble Company',61.91,0.01,0.02,'9/1 12:00am', 'Manufacturing'],
	                           ['United Technologies Corporation',63.26,0.55,0.88,'9/1 12:00am', 'Computer'],
	                           ['Verizon Communications',35.57,0.39,1.11,'9/1 12:00am', 'Services'],
	                           ['Wal-Mart Stores, Inc.',45.45,0.73,1.63,'9/1 12:00am', 'Retail'],
	                           ['Walt Disney Company (The) (Holding Company)',29.89,0.24,0.81,'9/1 12:00am', 'Services']
	                       ]
	                }),
	    	          dockedItems: [	
	        	          {
							xtype : 'toolbar',
							flex : 1,
							dock : 'top',
							border : true,
							items : [ {
								xtype : 'button',
								text : '회의록 추가',
								handler : function(btn) {
											// btn.up("panel").up("panel").getLayout().setActiveItem(0);
											btn.up("#id-meeting-card-panel").getLayout().setActiveItem(0) ; 
										}
									} ]
								},
						Ext.create('Ext.ux.PagingToolbar', {
	      		            displayInfo: true,
	      		            dock :'bottom',
	      		            border: 1,
	      		            itemId : 'id_meeting_item_grid_bbar_gridPageTB',
	      		            pageCnt : 10 
	      		        })
	      		     ]
	             }]
 	         	})
             
    ],

    initComponent: function() {
    	
    	this.callParent(arguments);
    }
});
