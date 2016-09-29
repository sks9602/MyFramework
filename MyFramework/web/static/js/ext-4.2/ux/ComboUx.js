/**
 * combobox 재구성..
 */
Ext.define('Ext.form.field.ux.ComboUx', {
    extend: 'Ext.form.field.ComboBox',
	alias: 'widget.comboux',
    initComponent: function() {
        var me = this;
        
        me.callParent(arguments);
        
        
    },
    findRecord: function(field, value) {
	    var me=this, ds = this.store,params = me.params||{}, idx = ds.find(field, value);
	    
	    if(idx === -1 && !this.initialRecordFound && this.queryMode === 'remote' && value!= '' ) {
	      this.initialRecordFound = true;
	      this.store.on({
	        load: {
	          fn: Ext.Function.bind(function(value) {
	            if (this.forceSelection) {
	            	if(me.value == '') {
					    idx = ds.find(field, value);  // 처음 선택시 선택 안될대.. 처리.
					    return idx !== -1 ? ds.getAt(idx) : false;  // 처음 선택시 선택 안될대.. 처리.
	            	}
	              this.setValue(value);
	            }
	            this.store.removeAll();
	          }, this, [value]),
	          single: true
	        }
	      });
	      params[this.queryParam]=value;

	      ds.load({
	      	params: params
	      });
	    }
	    idx = ds.find(field, value);
	    return idx !== -1 ? ds.getAt(idx) : false;
	}, 
    onTrigger2Click: function(event) {
        var me = this;
        // alert(event.getTarget().className);
        me.collapse();
        me.clearValue();
    },
    onTrigger3Click : function(event) {
    	var me = this;
    	me.collapse();

    	var ux_combo_window_code_view = Ext.getCmp('ux_combo_window_code_view') ;
    	if( !ux_combo_window_code_view ) {
    		ux_combo_window_code_view = Ext.create('Ext.window.Window', {
			    title: '공통코드 팝업 - TODO',
			    id : 'ux_combo_window_code_view' ,
			    height: 600,
			    width: 500,
			    layout: 'fit',
			    items: [
	 		       	Ext.create('Ext.grid.Panel', {
					width : 600,
					minWidth : 500,
					viewConfig : {
						forceFit : true
					},
					columnLines : true,
					listeners : {
						render : function(_this) {
	
						}
					},
	
					id : 'ux_combo_grid_window_code_view',
					store : Ext.create('Ext.data.JsonStore', {
						storeId : 'ux_combo_store_grid_store_window_code_view', 
						autoDestroy : true,
						root : 'datas',
						totalProperty : 'totalCount',
						remoteSort : true,
						pageSize : 5,
						fields : [ 'owner', 'tname', 'table_name', 'table_alias', 'table_type', 'table_comments', 'cnt' ],
						id : 'ux_combo_grid_store_window_code_view',
						proxy : Ext.create('Ext.data.HttpProxy', {
							type : 'ajax', //'memory',
							url : '/s/example/example.do',
							reader : {
								type : 'json',
								root : 'datas'
							}
						})
					}),
					border : 1,
					selType : 'cellmodel',
					margin : '0 0 0 0',
	
					columns : [
	
					{
						xtype : 'rownumberer',
						width : 30
					},
	
					{
						dataIndex : 'name',
						header : '코드명',
						sortable : true,
						style : 'text-align:center',
						align : 'center',
						width : 100
					}
	
					, {
						dataIndex : 'member_no',
						header : '코드',
						sortable : true,
						style : 'text-align:center',
						align : 'center',
						width : 100
					}
	
					],
	
					bbar : Ext.create('Ext.ux.PagingToolbar', {
						displayInfo : true,
						pageCnt : 3,
						displayMsg : 'Displaying topics {0} - {1} of {2}',
						emptyMsg : "No topics to display",
						id : 'ux_combo_window_bbar_code_view',
						store : Ext.getStore('ux_combo_store_grid_store_window_code_view'),
						items : [ ]
					})
	
				})
	
				]
			})
    	}
    	ux_combo_window_code_view.show();
    }
});
