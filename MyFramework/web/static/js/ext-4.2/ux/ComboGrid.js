/**
 * Grid 형태의 Combobox생성..
 */
Ext.define('Ext.form.field.ux.ComboGrid', {
    extend: 'Ext.form.field.Picker',
    alias: 'widget.combogrid',

    requires: ['Ext.grid.View', 'Ext.grid.column.Column'],

    width: 300,
    valueField : 'TNAME',  // <-- TODO 설정..
    // fieldLabel: 'Grid Picker',

    initComponent: function() {
        var me = this;

        me.callParent(arguments);
    },

    createPicker: function() {
    	var me = this;
    	
        picker = new Ext.create('Ext.grid.Panel', {
            floating: true,
            hidden: true,
            height: 150,
            minHeight: 150,
            minWidth: 400,
            width: 400,
            header: false,
            store: Ext.create('Ext.data.JsonStore', {
            	remoteSort:	true,
            	fields:	['TABLE_NAME','TNAME', 'NAME', 'VALUE' , 'GROUP', 'COMPANY_CD', 'CODE', 'CODE_NM', 'UP_CD', 'USEDEF1', 'USEDEF2', 'USEDEF3', 'USEDEF4', 'USEDEF5'],
            	proxy: {
            		type: 'ajax',
					url : G_CONTEXT_PATH+'/example/example.do', /// @ TODO url변경..
					extraParams : {  p_action_flag : 'r_list_data' } , // , 
					reader: {
								type: 'json',
								totalProperty: 'totalCount',
								root: 'datas'
							}
					}
            }),
            listeners : {
            	cellclick : function( _this, td, cellIndex, record, tr, rowIndex, e, eOpts ) {
            		me.setValue( record.get( me.valueField ));
            	},
            	celldblclick : function( _this, td, cellIndex, record, tr, rowIndex, e, eOpts ) {
            		me.setValue( record.get( me.valueField ));
            		me.picker.hide();
            	}, 
            	render : function( _this,  eOpts ) {
            		try {
            			_this.store.load();
            		} catch(e) {
            		}
            	}
            },
            columns: [{
                xtype: 'gridcolumn',
                minWidth: 120,
                width: 120,
                flex : 1,
                text: 'TNAME',
                dataIndex : 'TNAME'
            }, {
                xtype: 'gridcolumn',
                minWidth: 95,
                width: 95,
                flex : 1,
                text: 'NAME',
                dataIndex : 'NAME'
            }, {
                xtype: 'gridcolumn',
                minWidth: 200,
                width: 200,
                text: 'VALUE',
                dataIndex : 'VALUE'
            }]
        });
    	
        return picker;
    }

});