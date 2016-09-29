/**
 * Grid상단에 checkbox가 포함된 Column
 */
/*
Ext.override(Ext.selection.CheckboxModel, {
    maybeFireSelectionChange: function(fireEvent) {
    	for( var x in arguments ) {
    		console.log("Ext.selection.CheckboxModel.maybeFireSelectionChange() - " + x + ":" + arguments[x])
    	}
        if (fireEvent && !this.suspendChange) {
            this.updateHeaderState();
        }
        this.callParent(arguments);
    },
    onCheckChange: function(record, isSelected, suppressEvent, commitFn) {
        var me = this,
            eventName = isSelected ? 'select' : 'deselect';

        console.log("Ext.selection.CheckboxModel.onCheckChange() - " + eventName )
        
        if ((suppressEvent || me.fireEvent('before' + eventName, me, record)) !== false &&
           commitFn() !== false) {

            if (!suppressEvent) {
                me.fireEvent(eventName, me, record);
            }
        }   
    },
    onSelectChange: function() {
    	for( var x in arguments ) {
    		console.log("Ext.selection.CheckboxModel.onSelectChange() - " + x + ":" + arguments[x])
    		if( typeof(arguments[x]) == 'object') {
    			for( var y in arguments[x] ) {
    				if( typeof(arguments[x][y]) != 'function') {
    					console.log("Ext.selection.CheckboxModel.onSelectChange() for- " + y + ":" + arguments[x][y]);
    					
 						for( var z in arguments[x][y] ) {
 							if( typeof(arguments[x][y][z]) != 'function') {
 								console.log("Ext.selection.CheckboxModel.onSelectChange() for- for- ["+ typeof(arguments[x][y][z])+ "]" + z + ":" + arguments[x][y][z]);
 							}
						}
    				}
    			}
    		}
    	}
        this.callParent(arguments);
        if (!this.suspendChange) {
            this.updateHeaderState();
        }
    }
});

Ext.util.Observable.prototype.fireEvent = 
    Ext.Function.createInterceptor(Ext.util.Observable.prototype.fireEvent, function() {
        console.log(this.$className, arguments, this);
        return true;
});
*/

Ext.define('Ext.form.field.ux.CheckColumn', {
    extend: 'Ext.grid.column.CheckColumn',
    alias: 'widget.ux_checkcolumn',
    renderTpl: [
        '<div id="{id}-titleEl" data-ref="titleEl" {tipMarkup}class="', Ext.baseCSSPrefix, 'column-header-inner<tpl if="!$comp.isContainer"> ', Ext.baseCSSPrefix, 'leaf-column-header</tpl>',
        '<tpl if="empty"> ', Ext.baseCSSPrefix, 'column-header-inner-empty</tpl>">',

        '<span class="', Ext.baseCSSPrefix, 'column-header-text-container" >',
        '<span class="', Ext.baseCSSPrefix, 'column-header-text-wrapper">',
        '<span id="{id}-textEl" data-ref="textEl" class="', Ext.baseCSSPrefix, 'column-header-text',
        '{childElCls}">',
        '<img class="', Ext.baseCSSPrefix, 'grid-checkcolumn" style="float:left;" src="' + Ext.BLANK_IMAGE_URL + '"/>',
        '{text}',
        '</span>',
        '</span>',
        '</span>',
        '<tpl if="!menuDisabled">',
        '<div id="{id}-triggerEl" data-ref="triggerEl" role="presentation" class="', Ext.baseCSSPrefix, 'column-header-trigger',
        '{childElCls}" style="{triggerStyle}"></div>',
        '</tpl>',
        '</div>',
        '{%this.renderContainer(out,values)%}'
    ],
    disableValue : ['HO_T_SYS_AUTH', 'HO_T_SYS_CODE'], // Array or String // TODO 컬럼명 변경...  
    hiddenValue : ['HO_T_SYS_AUTH_MENU', 'HO_T_SYS_AUTH_MENU_LEVEL'], // Array or String // TODO 컬럼명 변경... 
    checkReferColumn : null,
    editor: {
        xtype: 'checkbox',
        cls: 'x-grid-checkheader-editor'
    },
    constructor : function(config) {
        var me = this;

        Ext.apply(config, {
            stopSelection: true,
            sortable: false,
            draggable: false,
            resizable: false,
            menuDisabled: true,
            hideable: false,
            tdCls: 'no-tip',
            defaultRenderer: me.defaultRenderer,
            checked: false
        });

        me.callParent([ config ]);
        
        me.on('headerclick', me.onHeaderClick);
        me.on('selectall', me.onSelectAll);
        
    },
    onHeaderClick: function(headerCt, header, e, el) {
        var me = this,
            grid = headerCt.grid;

        if( !grid.getStore() || grid.getStore().getCount() <= 0 ) {
        	return;
        }

        if (!me.checked) {
        	me.fireEvent('selectall', grid.getStore(), header, true, grid);
            header.getEl().down('img').addCls(Ext.baseCSSPrefix + 'grid-checkcolumn-checked');
            me.checked = true;
        } else {
        	me.fireEvent('selectall', grid.getStore(), header, false, grid);
            header.getEl().down('img').removeCls(Ext.baseCSSPrefix + 'grid-checkcolumn-checked');
            me.checked = false;
        }
    },
    processEvent: function(type, view, cell, recordIndex, cellIndex, e, record, row) {
        var me = this,
            key = type === 'keydown' && e.getKey(),
            mousedown = type == 'mousedown';

        var checkVal = this.checkReferColumn ? record.get(this.checkReferColumn) :  record.get(this.dataIndex) ;

        if( this.disableValue ) {
    		
    		if( Ext.isArray(this.disableValue) ) {
    			if( Ext.Array.contains(this.disableValue, checkVal) ) {
    				e.stopEvent();
    				return false;
    	     	}
    		} else {
    			if( checkVal == this.disableValue ) {
    				e.stopEvent();
    	     		return false;
    	     	} 
    		}
    	}
        
        if( this.hiddenValue) {
        	if( Ext.isArray(this.hiddenValue) ) {
    			if( Ext.Array.contains(this.hiddenValue, checkVal) ) {
    				e.stopEvent();
    	     		return false;
    	     	}
    		} else {
    			if( checkVal == this.hiddenValue ) {
    				e.stopEvent();
    	     		return false;
    	     	}
    		}
        }
        
        
        if (!me.disabled && (mousedown || (key == e.ENTER || key == e.SPACE))) {
            var dataIndex = me.dataIndex,
                checked = dataIndex.endsWith("_YN") ? ((record.get(dataIndex) == 'Y' || record.get(dataIndex) == true)? 'N' : 'Y') : !record.get(dataIndex);

            if (me.fireEvent('beforecheckchange', me, recordIndex, checked) !== false) {
  
                record.set(dataIndex, checked );
                
                me.fireEvent('checkchange', me, recordIndex, checked);

                if (mousedown) {
                    e.stopEvent();
                }
                
                if (!me.stopSelection) {
                    view.selModel.selectByPosition({
                        row: recordIndex,
                        column: cellIndex
                    });
                }
                return false;
            } else { 
                return !me.stopSelection;
            }
        } else {
            return false; // me.callParent(arguments);
        }
    },
    /*
    processEvent: function(type, view, cell, recordIndex, cellIndex, e) {
        var record = view.panel.store.getAt(recordIndex);
        
        fs_HoScriptLog('processEvent : ' + type);

        var checkVal = this.checkReferColumn ? record.get(this.checkReferColumn) :  record.get(this.dataIndex) ;
        fs_HoScriptLog('checkVal : ' + checkVal);

        if (type != 'mouseover' ) { // type == 'mousedown' || type == 'click'
        	if( this.disableValue ) {
        		
        		if( Ext.isArray(this.disableValue) ) {
        			fs_HoScriptLog('Ext.Array.contains(this.disableValue, checkVal)  : ' + Ext.Array.contains(this.disableValue, checkVal) );
        			if( Ext.Array.contains(this.disableValue, checkVal) ) {
        				e.stopEvent();
        				return false;
        	     	} else {		    	
        	     		return this.callParent(arguments);
        	     	}
        		} else {
        			if( checkVal == this.disableValue ) {
        				e.stopEvent();
        	     		return false;
        	     	} else {		    	
        	     		return this.callParent(arguments);
        	     	}
        		}
        	} else {
        		return this.callParent(arguments);
        	}
	      	
        } else {
         	return this.callParent(arguments);
        }
    },
    */
    onSelectAll: function(store, column, checked, grid) {
    	var me = this;
        var dataIndex = column.dataIndex, storeCnt = store.getCount(), record, v, disableValue = column.disableValue, checkReferColumn = column.checkReferColumn ;

        /*
        store.suspendEvents();
        for(var i = 0; i < storeCnt  ; i++) {
        	if( store.getAt(i).get(dataIndex) != disableValue ) {
	        	store.getAt(i).set(dataIndex, checked );  // ? 'Y' :'N'
        	}
        }
        store.resumeEvents();
        grid.getView().refresh();
        */       
        try {
        	var progressBar, girdPageTBId = this.pActionFlag +"_grid_bbar_"+this.gridId+"_gridPageTB";
        	try {
	        	// summary에서 checkbox있을 경우
	        	if( Ext.getCmp(grid.ownerCt.getId()).getXType() == 'panel') {
	        		progressBar = Ext.getCmp(Ext.getCmp(grid.getId()).getDockedComponent(girdPageTBId).getId()).child('#progressBar'); // .getComponent('progressBar');
	        	} 
	        	// 일반 grid
	        	else {
		        	progressBar = Ext.getCmp(Ext.getCmp(grid.ownerCt.getId()).getDockedComponent('gridPageTB').getId()).child('#progressBar'); // .getComponent('progressBar');
	        	}
        	} catch(e) {
        		
        	}
	        
        	if( progressBar ) {
	 	        progressBar.show( null, function() {progressBar.updateProgress(0, 'Initiated.', true, this); }, this );
		        
		        progressBar.updateProgress(0, 'Changing.', true, this);
        	}
        	
	        store.suspendEvents();
 	        Ext.Function.defer(function() {
		        // 실제 data변경
		        for(var i = 0; i < storeCnt  ; i++) {
		        	// disabled Value가 아닌 경우에만 변경..
		        	var record = store.getAt(i);
		        	var checkVal = checkReferColumn ? record.get(checkReferColumn) :  record.get(dataIndex) ;
		        	
		        	// fs_HoScriptLog('checkVal : ' + checkVal);
		        	
		        	if( disableValue && !me.isHiddenValue(checkVal) ){
		            	if( Ext.isArray(disableValue) ) {
 		        			if( !Ext.Array.contains(disableValue, checkVal) ) {
		        				if(dataIndex.endsWith("_YN")) {
		        					store.getAt(i).set(dataIndex, checked ? "Y" : "N" );
		        				} else {
		        					store.getAt(i).set(dataIndex, checked );
		        				}
		        	     	}
		        		} else {
		        			if( checkVal != disableValue ) {
		        				if(dataIndex.endsWith("_YN")) {
		        					store.getAt(i).set(dataIndex, checked ? "Y" : "N" );
		        				} else {
		        					store.getAt(i).set(dataIndex, checked );
		        				}
		        	     	}
		        		}
		            }
		        	
		        	/*
		        	if( store.getAt(i).get(dataIndex) != disableValue ) {
			        	store.getAt(i).set(dataIndex, checked );  // ? 'Y' :'N'
		        	}
		        	*/
		        	if( progressBar ) {
			        	if( i%20 == 19 ) {
			                v = i/storeCnt;
			                progressBar.updateProgress(v, Math.round(100*v) + '% changed', true, this);
			        	}
		        	}
		        }
		        store.resumeEvents();
		        grid.getView().refresh();
		        if( progressBar ) {
		        	progressBar.updateProgress(1, 'Done.', true, this);
		        }
		        
	        }, 100);
        } catch(e) {
        	console.log( e );
        	
            store.suspendEvents();
	        // 실제 data변경
	        for(var i = 0; i < storeCnt  ; i++) {
	        	store.getAt(i).set(dataIndex, checked );  // ? 'Y' :'N'
	        	if( progressBar ) {
		        	if( i%20 == 19 ) {
		                v = i/storeCnt;
		                progressBar.updateProgress(v, Math.round(100*v) + '% changed', true, this);
		        	}
	        	}
	        }
	        store.resumeEvents();
	        grid.getView().refresh();
        }

	} , 
	isHiddenValue : function(checkVal) {
        if( this.hiddenValue) {
        	if( Ext.isArray(this.hiddenValue) ) {
    			if( Ext.Array.contains(this.hiddenValue, checkVal) ) {
    	     		return true;
    	     	} else {
    	     		return false;
    	     	}
    		} else {
    			if( checkVal == this.hiddenValue ) {
    	     		return true;
    	     	}else {
    	     		return false;
    	     	}
    		}
        } else {
        	return false;
        }		
	},
    renderer : function(value, meta, record){
        var cssPrefix = Ext.baseCSSPrefix,
        cls = [cssPrefix + 'grid-checkcolumn'], isDisabled = false;

        var checkVal = this.checkReferColumn ? record.get(this.checkReferColumn) : value;
        
        if( this.disableValue ){
        	if( Ext.isArray(this.disableValue) ) {
    			if( Ext.Array.contains(this.disableValue, checkVal) ) {
    				meta.tdCls += ' ' + this.disabledCls;
    	        	isDisabled = true;
    	     	}
    		} else {
    			if( checkVal == this.disableValue ) {
    				meta.tdCls += ' ' + this.disabledCls;
    	        	isDisabled = true;
    	     	}
    		}
        	
        } else {
            if ( this.disabled ||  value == this.disableValue ) {
                meta.tdCls += ' ' + this.disabledCls;
            	isDisabled = true;
            }
        }
        
        if ( (typeof(value) == 'boolean' && value) || (typeof(value) == 'string' && value.toUpperCase() == 'Y') ) {
            cls.push(cssPrefix + 'grid-checkcolumn-checked');
        }

        if( this.hiddenValue) {
        	if( Ext.isArray(this.hiddenValue) ) {
    			if( Ext.Array.contains(this.hiddenValue, checkVal) ) {
    				cls = [];
    	     	}
    		} else {
    			if( checkVal == this.hiddenValue ) {
    				cls = [];
    	     	}
    		}
        }

    	return '<img class="' + cls.join(' ') + '" src="' + Ext.BLANK_IMAGE_URL + '"/>';

        /*
        if( isDisabled ) {
        	fs_HoScriptLog('cls : ' + '<img class="' + cls.join(' ') + '" src="' + Ext.BLANK_IMAGE_URL + '"/>' );

        	return '<img class="' + cls.join(' ') + '" src="' + Ext.BLANK_IMAGE_URL + '"/>';
        } else {
        	return this.callParent(arguments);
        }
        */
	}

});