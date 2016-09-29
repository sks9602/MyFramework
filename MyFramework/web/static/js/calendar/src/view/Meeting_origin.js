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
                fieldStyle : 'ime-mode:active',
                name: 'item',
                emptyText: '내용을 입력하세요.',
                allowBlank : false,
                flex : 1,
                padding : '0 70 0 0'
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
    requires: [
    ],
    store: 'meetingDetailGridStore',

    columnLines: true,
    // enableLocking: true,


    dockedItems: [
        {
            xtype: 'meetingFormTopDock',
            dock: 'top',
            // the grid's column headers are a docked item with a weight of 100.
            // giving this a weight of 101 causes it to be docked under the column headers
            weight: 101,
            bodyStyle: {
                'background-color': '#E4E5E7'
            }
        }
    ],

    initComponent: function() {
        var me = this;

        me.columns = {
        		defaults: {
                    hideable: false
                },
            items: [
				{xtype: 'rownumberer', text : 'No', width: 24 },
				{text: "회의 내용", flex: 1, dataIndex: 'company', align:'center', resizable : false,
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
                   ['Walt Disney Company (The) (Holding Company)',29.89,0.24,0.81,'9/1 12:00am', 'Services']
               ]
        });
        
        
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
	            style: 'border-bottom: 1; ', // padding : 5px; 
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
						    columns: 3,
						    width: 110*3,
						    items: [{
						        boxLabel: 'Dog',
						        name: 'animals',
						        value: 'dog',
						        inputValue: 'dog'
						    }, {
						        boxLabel: 'Cat',
						        name: 'animals',
						        value: 'cat',
						        inputValue : 'cat'
						    }, {
						        boxLabel: 'Monkey',
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
    	         {xtype:'grid', 
    	          region :'center',
    	          width : 600,
    	          columns: [
    	                    {xtype: 'rownumberer', text : 'No', width: 40 },
    	                    {text: "회의 일시", dataIndex: 'lastChange', align:'center', renderer: Ext.util.Format.dateRenderer('Y/m/d a')},
    	                    {text: "회의 제목", flex: 1, dataIndex: 'company', align:'center', 
    	                    	renderer: function(v, p, r) {
    	                    		return Ext.String.format("<div class=\"in_grid_url_link\" style=\"text-align:left\"  onclick=\"alert(1); fs_click_meetingItem(1)\">{0}</div>", v, r.data.ID);
    	                    	}
    	                    },
    	                    {text: "Price", renderer: Ext.util.Format.usMoney, dataIndex: 'price'},
    	                    {text: "Change", dataIndex: 'change'},
    	                    {text: "Last Updated", renderer: Ext.util.Format.dateRenderer('Y/m/d A'), dataIndex: 'lastChange'}
    	                ],
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
    	                     ['3m Co',71.72,0.02,0.03,'9/1 12:00am', 'Manufacturing'],
    	                     ['Alcoa Inc',29.01,0.42,1.47,'9/1 12:00am', 'Manufacturing'],
    	                     ['Altria Group Inc',83.81,0.28,0.34,'9/1 12:00am', 'Manufacturing'],
    	                     ['American Express Company',52.55,0.01,0.02,'9/1 12:00am', 'Finance'],
    	                     ['American International Group, Inc.',64.13,0.31,0.49,'9/1 12:00am', 'Services'],
    	                     ['AT&T Inc.',31.61,-0.48,-1.54,'9/1 12:00am', 'Services'],
    	                     ['Boeing Co.',75.43,0.53,0.71,'9/1 12:00am', 'Manufacturing'],
    	                     ['Verizon Communications',35.57,0.39,1.11,'9/1 12:00am', 'Services'],
    	                     ['Wal-Mart Stores, Inc.',45.45,0.73,1.63,'9/1 12:00am', 'Retail'],
    	                     ['Walt Disney Company (The) (Holding Company)',29.89,0.24,0.81,'9/1 12:00am', 'Services']
    	                 ]
    	          }),  
    	          columnLines: true,
    	          enableLocking: true,
    	          dockedItems: [	{
    	        	  xtype: 'toolbar', flex:1, dock :'top', border : true,  
    	        	  items : [{ xtype : 'button' , text : '회의록 추가' }]
    	          		},
        	          Ext.create('Ext.ux.PagingToolbar', {
      		            displayInfo: true,
      		            dock :'bottom',
      		            border: 1,
      		            itemId : 'id_meeting_grid_bbar_gridPageTB',
      		            pageCnt : 10 
      		        })
      		     ]
            	},{
	            	xtype:'form',
	            	title : '상세내용',
	            	region : 'east',
	            	collapsible: true,
	            	split: true,
	            	width : 600,
	            	minWidth : 100,
	            	maxWidth : 1000,
	            	defaults: { autoScroll: false, anchor: '100%', labelWidth: 120, margin : '0 1 1 0' },
	            	items : [
							{
								xtype     : 'textfield',
								name      : 'title',
								fieldLabel: '회의제목',
							    labelSeparator : '',
								msgTarget: 'side'
							
							},
							{
								layout     : 'hbox',
								border : 0,
								defaults: { labelWidth: 120 },
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
									name      : 'time_st'
								},{
									border : 0,
									margin : '0 10 0 10',
									html : ' ~ '
								},{
									xtype     : 'timefield',
									width     : 80,
									name      : 'time_ed'
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
							},
							{
								xtype:'meetingDetailGrid',
								title : '상세목록'
							}
	    	        	]
	             }
             
    ],

    initComponent: function() {
    	
    	this.callParent(arguments);
    }
});
