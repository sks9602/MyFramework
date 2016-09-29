/**
 * @class Ext.calendar.view.Month
 * @extends Ext.calendar.CalendarView
 * <p>Displays a calendar view by month. This class does not usually need ot be used directly as you can
 * use a {@link Ext.calendar.CalendarPanel CalendarPanel} to manage multiple calendar views at once including
 * the month view.</p>
 * @constructor
 * @param {Object} config The config object
 */
Ext.define('Ext.calendar.view.Wbs', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.ux_wbs',

    requires: [
        'Ext.data.ArrayStore'
    ],
    isCalendar : false,
    layout : 'border',
    border :false,
    items : [
            {
            	xtype:'panel',
            	border : 0,
            	region : 'center',
            	layout : 'border',
            	items : [
            	         {xtype:'panel', 
            	          title : '검색조건', 
            	          region :'north',
            	          split: true,
            	          collapsible  : true,
            	          items : [
            	               {xtype : 'form',
            	               items : [
            	                   { xtype: 'fieldcontainer', layout: { type: 'hbox', defaultMargins: {top: 0, right: 5, bottom: 0, left: 0} }, 
            	                	 items: [{
	            	         		        	width         : 300, 
			            	     		        xtype         : 'combo',
			            	     		        queryMode     : 'local',
			            	     		        value         : 'mrs',
			            	     		        triggerAction : 'all',
			            	     		        forceSelection: true,
			            	     		        editable      : false,
			            	     		        fieldLabel    :  'Project',
			            	     				labelSeparator : ' : ',
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
												    border : 0,
												    columns: 3,
												    width: 110*3,
													labelSeparator : ' : ',
												    items: [{
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
													labelSeparator : ' : ', 
													msgTarget: 'side'
											
												}]
            	                   }    
            	               ]}
            	          ],
            	          dockedItems: [{
            	                xtype: 'toolbar', dock: 'bottom', flex:1, border : true, 
            	            	items : [ 
            	            		'->', 
            	            	    { xtype : 'button' , text : '조회' }
            	            	]
            	          }]
            	         },
            	         {xtype:'treegrid', 
            	        	rootVisible: false,
            	        	useArrows: true,
            	        	viewConfig: {
            	            	forceFit: true
            	            },
            	            columnLines : true,
            	            rowLines : true,
	            	        // enableLocking: true,
            	            region :'center',
            	            columns: {
            	            	items : [
            	            	    { dataIndex: 'level', text : 'No', width: 60, style: 'text-align:center' },
									{ dataIndex: 'prc' , header: '<div class="grid-header-textfield"></div>&nbsp;단계'  , sortable: true , style: 'text-align:center', align: 'left'  ,  width: 80 },
									{ xtype: 'treecolumn', dataIndex: 'text' , header: '<div class="grid-header-link"></div>&nbsp;업무내용'  , sortable: true , style: 'text-align:center', align: 'left'  , width: 200, renderer : 
										
										function (value, p, record){
											return Ext.String.format(
												"<span style=\"cursor:pointer;text-align:left;\" onclick=\"alert('{0}');\"><b>{0}</b></span>",
											value,
											record.data.text,
											p );
										}
									
									},
									{ dataIndex: 'id' , header: '<div class="grid-header-textfield"></div>&nbsp;진행상태'  , sortable: true , style: 'text-align:center', align: 'left'  ,  flex : 1, width: 200 },
									{ dataIndex: 'email' , header: '<div class="grid-header-email"></div>&nbsp;진행율'  , sortable: false , style: 'text-align:center', align: 'center'  ,  width: 100, fixed: true },
									{ dataIndex: 'email' , header: '<div class="grid-header-email"></div>&nbsp;특이사항'  , sortable: false , style: 'text-align:center', align: 'center'  ,  width: 100, fixed: true },
									{ dataIndex: 'email' , header: '<div class="grid-header-email"></div>&nbsp;시작일'  , sortable: false , style: 'text-align:center', align: 'center'  ,  width: 100, fixed: true },
									{ dataIndex: 'email' , header: '<div class="grid-header-email"></div>&nbsp;종료일'  , sortable: false , style: 'text-align:center', align: 'center'  ,  width: 100, fixed: true },
									{ dataIndex: 'fax_number' , header: '<div class="grid-header-numberfield"></div>&nbsp;산출물'  , sortable: true , style: 'text-align:center', align: 'center'  ,  width: 150 }
            	                ]
            	            },
            	            store: Ext.create('Ext.data.TreeStore', {
            	    			storeId:'v_treelist_store_wbs',
            	    			// autoDestroy: true,
            	    			autoLoad: true,
            	    			// autoSync: true,
            	    			remoteSort:	false,
            	    			fields:['level', 'id', 'text', 'owner','tname','table_name','table_alias','table_type','table_comments','cnt', 'mode'], //['TABLE_NAME', 'TABLE_ALIAS', 'TABLE_TYPE'],
            	    			proxy: Ext.create('Ext.data.HttpProxy', {
            	    				type: 'ajax', //'memory',
            	    				url: '/s/example/example.do?p_action_flag=r_json_tree',
            	    				reader: {
            	    		            type: 'json',
            	    		            params : { 'p_action_flag' : 'r_json_tree' }
            	    		            //, expanded: true
            	    		        }, 
            	    		        writer: {
            	    		        	type: 'ux_json',
            	    		        	writeAllFields: true,
            	    		        	encode : true,
            	    		        	expandData : false,
            	    		            params : { 'p_action_flag' : 'wbs.js.writer' }, // @TODO  이런 형태로 파라미터 추가 가능..
            	    		            allowSingle : false 
            	    		        }, 
            	    				api: {
            	    	                create: '/s/example/example.do',
            	    	                update: '/s/example/example.do'
            	    		        }		        
            	    			}),listeners : {
            	    				beforeload: function(store, operation, eOpts){
            	    	                if(store.sorters && store.sorters.getCount()) {
            	    	                	var sorter = store.sorters.getAt(0);
            	    						
            	    	                	var sortProp = sorter.property;
            	    	                	
            	    	                	Ext.apply(store.getProxy().extraParams, store.params);                	
            	    	                    Ext.apply(store.getProxy().extraParams, {
            	    	                        'sort'  : sortProp,
            	    	                        'dir'   : sorter.direction
            	    	                    }); 
            	    	                    
            	    	                }
            	    	            }
            	    	        }
            	    		}),
	              	          dockedItems: [{
		          	                xtype: 'toolbar', dock: 'top', flex:1, border : true, 
		          	            	items : [ 
		          	            	    { xtype : 'button' , text : '추가',
		          	            	    	handler : function() {
		          	            	    		var tree = this.up('treepanel');
		          	            	    		
		          	            	    		var store = tree.getStore();
		          	            	    		var node = tree.getSelectionModel().getSelection();
		          	            	    		
		          	            	    		if( node ) {
		          	            	    			var ran = Math.round(Math.random()*10000000);
		          	            	    			if( node[0].get('leaf') ) {
		          	            	    				node[0].set('leaf', false); 
		          	            	    			}
		          	            	    			
		          	            	    			try {
		          	            	    				node[0].appendChild({
				          	            	  		        id: 'gc_'+ran,
				          	            	  		        text: '* No Title',
				          	            	  		        mode : 'insert',
				          	            	  		        // name: '* No Title',
				          	            	  		        leaf: true
				          	            	  			});
		          	            	    				
		          	            	    				node[0].expand();
		          	            	    			} catch(e) {
		          	            	    				alert('2 :'  + e);
		          	            	    			}
		          	            	    		}
		          	            	    	}
		          	            	    }
		          	            	]
		              	          },{
		            	                xtype: 'toolbar', dock: 'top', flex:1, border : true, 
		            	            	items : [ 
		            	            		'->', 
		            	            	    { xtype : 'button' , text : '조회' }
		            	            	]
		            	          }]
            	         }
            	]
            	 
            }
             
    ],

    initComponent: function() {
    	
    	this.callParent(arguments);
    }
});
