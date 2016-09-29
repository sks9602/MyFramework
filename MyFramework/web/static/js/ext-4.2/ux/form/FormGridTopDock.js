/*
 * Grid상단에  dock로 나오는 입력 영역form
 */
Ext.define('Ext.ux.grid.dock.Form', {
    extend: 'Ext.form.Panel',
    xtype: 'functionFormTopDock',
    requires: [
       'Ext.layout.container.HBox',
       'Ext.form.field.Date'
    ],
    layout: 'hbox',
    cls: 'tasks-new-form',
    itemId : 'id_main_top_function_form',
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
                name: 'p_action_flag',
                emptyText: 'Add a new function',
                allowBlank : false,
                width: 120 /* ,
                listeners : {
                	'specialkey' : function( me, e, eOpts ) {
                	}
                } */
            },
            {
                xtype: 'textfield',
                name: 'method',
                emptyText: 'Method Name',
                allowBlank : false,
                width: 100 
            },
            {
                xtype: 'textfield',
                name: 'jsp',
                emptyText: 'jsp 명',
                allowBlank : false,
                width: 145 
            },
            {
                xtype: 'textfield',
                name: 'desc',
                itemId : 'id_main_top_function_form_desc',
                emptyText: 'Description',
                allowBlank : false,
                width: 195
            },
            {
				xtype : 'combobox',
				width : 145,
		        queryMode:      'local',
		        value:          'hh',
		        triggerAction:  'all',
		        forceSelection: true,
		        editable:       false,
                allowBlank : false,
		        name:           'due',
		        itemId : 'due',
		        displayField:   'name',
		        valueField:     'value',
		        store:          Ext.create('Ext.data.Store', {
		             fields : ['name', 'value'],
		             storeId : 'id_main_top_store_due',
		             data   : [
		                 {name : '화면', value: 'hh'},
		                 {name : '입력/수정/삭제', value: 'hm'},
		                 {name : '엑셀다운로드', value: 'hl'}
		             ]
		         })

			},
            {
				xtype : 'combobox',
				width : 95,
		        queryMode:      'local',
		        value:          'm',
		        triggerAction:  'all',
		        forceSelection: true,
		        editable:       false,
                allowBlank : false,
		        name:           'due1',
		        itemId : 'due1',
		        displayField:   'name',
		        valueField:     'value',
		        store:          Ext.create('Ext.data.Store', {
		             fields : ['name', 'value'],
		             storeId : 'id_main_top_store_due1',
		             data   : [
		                 {name : '상', value: 'h'},
		                 {name : '중', value: 'm'},
		                 {name : '하', value: 'l'}
		             ]
		         })

			},
            {
				xtype : 'combobox',
				width : 97,
		        queryMode:      'local',
		        value:          'a',
		        triggerAction:  'all',
		        forceSelection: true,
		        editable:       false,
                allowBlank : false,
		        name:           'due2',
		        itemId : 'due2',
		        displayField:   'name',
		        valueField:     'value',
		        store:          Ext.create('Ext.data.Store', {
		             fields : ['name', 'value'],
		             storeId : 'id_main_top_store_due2',
		             data   : [
		                 {name : '개발전', value: 'a'},
		                 {name : '개발중', value: 'b'},
		                 {name : '단위테스트중', value: 'c'},
		                 {name : '테스트요청', value: 'd'},
		                 {name : '수정요청', value: 'e'},
		                 {name : '수정중', value: 'f'},
		                 {name : '테스트완료', value: 'g'}
		             ]
		         })

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
            				
            				var combos = ['due','due1','due2']
            				for( var c in  combos ) {
            					values[combos[c]+'_nm'] = fs_ComboValue(combos[c]);
            				}
            				
            				function fs_ComboValue( name ) {
	        					var store = Ext.getStore('id_main_top_store_'+name);
	        					var index = store.findExact('value', _this.queryById(name).getValue());
	        					 
	        					if (index != -1){
	        	                    var rs = store.getAt(index).data; 
	        	                    return rs.name; 
	        	                } else {
	        	                	return value;
	        	                }
            				}
            				
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