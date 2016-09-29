/**
 * Combobox Column
 */

Ext.define('Ext.form.field.ux.ComboColumn', {
    extend: 'Ext.grid.column.Column',
    alias: 'widget.ux_combocolumn',

    initComponent: function() {
    	this.callParent(arguments);
    	
    	// this.renderer = (this.editor && this.editor.triggerAction) ? this.comboBoxRenderer : function(value) {return value};
    	
    	// this.renderer = (this.editor && this.editor.triggerAction) ? ComboBoxRenderer(this.editor, this.gridId) : function(value) {return value};
    	
    	this.renderer = function(value, metaData ) {
    		var combo = metaData.column.getEditor(), rValue = value||'';

    	    if(value && combo && combo.store && combo.displayField||'name'){
    	    	// 일반 Combo인경우...
        	    if(combo.store.findExact) {
	    	        var index = combo.store.findExact(combo.valueField||'value', value);
	    	        if(index >= 0){
	    	        	rValue = combo.store.getAt(index).get(combo.displayField||'name');
	    	        } 
        	    } 
        	    // Tree Combo인경우
        	    else {
        	    	/*
        	    	combo.setValue( value );
        	    	rValue = combo.getRawValue();
        	    	
        	    	// alert( combo.store.getNodeById(value) );
        	    	*/
        	    	if( value ) {
        	    		var valueFin = [], values = value.split(',');
        	    		Ext.each(combo.recursiveRecords, function(record) {
        	    			var data = record.get(combo.valueField);
    	                	Ext.each(values, function(val) {
    	                    	if(data == val) {
    	                        	valueFin.push(record.get(combo.displayField));
    	                        }
    	                     });
        	             });
        	    		
        	    		rValue = valueFin.join(', ');
        	    	}
        	    }
    	    }
    	    return rValue;
    	}
    },
    comboBoxRenderer : function(value, p, record) {
    	var combo = this.editor, gridId = this.gridId;

		var idx = combo.store.find(combo.valueField||'value', value); // TODO
		var rec = combo.store.getAt(idx);
		if (rec) {
			return rec.get(combo.displayField||'name'); // TODO
		}
		return value;

    	/*
    	var getValue = function(value) {
    		var idx = combo.store.find(combo.valueField||'value', value); // TODO
    		var rec = combo.store.getAt(idx);
    		if (rec) {
    			return rec.get(combo.displayField||'name'); // TODO
    		}
    		return value;
    	}
    	
    	return function(value) {
    		if (combo.store.getCount() === 0 && gridId) {
    			combo.store.on('load', function() {
					    					var grid = Ext.getCmp(gridId);
					    					if (grid) {
					    						grid.view.refresh();
					    					}
					    				}, {
					    					single: true
					    				}
					    			);
    			return value;
    		}

    		
    		return getValue(value);
    	};	
    	*/
    }
});

function ComboBoxRenderer(combo, gridId) {
	var getValue = function(value) {
		var idx = combo.store.find(combo.valueField||'value', value);
		var rec = combo.store.getAt(idx);
	
		if (rec) {
			return rec.get(combo.displayField||'name');
		}
		return value;
	}

	return function(value) {
		if (combo.store.getCount() === 0 && gridId) {
			combo.store.on('load', function() {
										var grid = Ext.getCmp(gridId);
											if (grid) {
												grid.view.refresh();
											}
									}, {
										single: true
									});
			return value;
		}

		return getValue(value);
	};
}