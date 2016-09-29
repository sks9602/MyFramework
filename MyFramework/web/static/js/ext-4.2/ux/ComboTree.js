/*
 * Tree 형태의 Combobox생성..
Tree combo
Use with 'Ext.data.TreeStore'

If store root note has 'checked' property tree combo becomes multiselect combo (tree store must have records with 'checked' property)

Has event 'itemclick' that can be used to capture click

Options:
selectChildren - if set true and if store isn't multiselect, clicking on an non-leaf node selects all it's children
canSelectFolders - if set true and store isn't multiselect clicking on a folder selects that folder also as a value

Use:

single leaf node selector:
selectChildren: false
canSelectFolders: false
- this will select only leaf nodes and will not allow selecting non-leaf nodes

single node selector (can select leaf and non-leaf nodes)
selectChildren: false
canSelectFolders: true
- this will select single value either leaf or non-leaf

children selector:
selectChildren: true
canSelectFolders: true
- clicking on a node will select it's children and node, clicking on a leaf node will select only that node

This config:
selectChildren: true
canSelectFolders: false
- is invalid, you cannot select children without node

*/

/**
 * A plugin that provides the ability to visually indicate to the user that a node is disabled.
 * 
 * Notes:
 * 
 * - Compatible with Ext 4.x
 * - If the view already defines a getRowClass function, the original function will be called before this plugin.
 * - An Ext.data.Model must be defined for the store that includes the 'disabled' field.
        Ext.define('MyTreeModel', {
            extend: 'Ext.data.Model',
            fields: [
                {name: 'disabled', type:'bool', defaultValue:false}
                ...
            ]
        });
 * 
 * Example usage:
        @example
        var tree = Ext.create('Ext.tree.Panel',{
            plugins: [{
                ptype: 'dvp_nodedisabled'
            }]   
            ...
        });
        
 * 
 * @author $Author: pscrawford $
 * @revision $Rev: 13458 $
 * @date $Date: 2013-02-20 14:04:38 -0700 (Wed, 20 Feb 2013) $
 * @license Licensed under the terms of the Open Source [LGPL 3.0 license](http://www.gnu.org/licenses/lgpl.html).  Commercial use is permitted to the extent that the code/component(s) do NOT become part of another Open Source or Commercially licensed development library or toolkit without explicit permission.
 * @version 0.3 (February 2, 2012) Intercept 'onCheckChange' to cancel the event instead of overriding.
 * @constructor
 * @param {Object} config 
 */
Ext.define('Ext.ux.tree.plugin.NodeDisabled', {
    alias: 'plugin.dvp_nodedisabled',
    extend: 'Ext.AbstractPlugin',
    
    mixins: {
        observable: 'Ext.util.Observable'
    },
    
    //configurables
    /**
     * @cfg {String} disabledCls
     * The CSS class applied when the {@link Ext.data.Model} of the node has a 'disabled' field with a true value.
     */
    disabledCls: 'dvp-tree-node-disabled',
    /**
     * @cfg {Boolean} preventSelection 
     * True to prevent selection of a node that is disabled. Default true.
     */
    preventSelection: true,
    
    //properties
    
    //private
    constructor: function(){
        this.callParent(arguments);
        // Dont pass the config so that it is not applied to 'this' again
        this.mixins.observable.constructor.call(this);
    },//eof constructor
    
    /**
     * @private
     * @param {Ext.tree.Panel} tree
     */
    init: function(tree) {
        var me = this,
            view = ( tree.is("treeview") )? tree : tree.getView(),
            origFn,
            origScope;
        
        me.callParent(arguments);
        
        origFn = view.getRowClass;
        if (origFn){
            origScope = view.scope || me;
            Ext.apply(view,{
                //append our value to the original function's return value
                getRowClass: function(){
                    var v1,v2;
                    v1 = origFn.apply(origScope,arguments) || '';
                    v2 = me.getRowClass.apply(me,arguments) || '';
                    return (v1 && v2) ? v1+' '+v2 : v1+v2;
                }
            });
        } else {
            Ext.apply(view, {
                getRowClass: Ext.Function.bind(me.getRowClass,me)
            });
        }
        
        Ext.apply(view, {
            //if our function returns false, the original function is not called
            onCheckChange: Ext.Function.createInterceptor(view.onCheckChange,me.onCheckChangeInterceptor,me)
        });
        
        if (me.preventSelection){
            me.mon(tree.getSelectionModel(),'beforeselect',me.onBeforeNodeSelect,me);
        }
        
        tree.on('destroy', me.destroy, me, {single: true});
    }, // eof init
    
    /**
     * Destroy the plugin.  Called automatically when the component is destroyed.
     */
    destroy: function() {
        this.callParent(arguments);
        this.clearListeners();
    }, //eof destroy
    
    /**
     * Returns a properly typed result.
     * @return {Ext.tree.Panel}
     */
    getCmp: function() {
        return this.callParent(arguments);
    }, //eof getCmp 
    
    /**
     * @private
     * @param {Ext.data.Model} record
     * @param {Number} index
     * @param {Object} rowParams
     * @param {Ext.data.Store} ds
     * @return {String}
     */
    getRowClass: function(record,index,rowParams,ds){
        return record.get('disabled') ? this.disabledCls : '';
    },//eof getRowClass
    
    /**
     * @private
     * @param {Ext.selection.TreeModel} sm
     * @param {Ext.data.Model} node
     * @return {Boolean}
     */
    onBeforeNodeSelect: function(sm,node){
        if (node.get('disabled')){
            return false;
        }
    },//eof onBeforeNodeSelect
    
    /**
     * @private
     * @param {Ext.data.Model} record
     */
    onCheckChangeInterceptor: function(record) {
        if (record.get('disabled')){ 
            return false; 
        }
    }//eof onCheckChange

});//eo class

//end of file
Ext.define('Ext.form.field.ux.ComboTree',
{
        extend: 'Ext.form.field.Picker',
        alias: 'widget.combotree',
        tree: false,
        autoScroll : false,
        trigger1Cls: 'x-form-clear-trigger',
        trigger2Cls : 'x-form-combo-trigger',
        submitValue : false,
        editable : false, 
    	labelWidth : 120,
    	width : 320,
        code : undefined,
    	labelSeparator: '',
        constructor: function(config)
        {
        	
        	this.store = Ext.create('Ext.data.TreeStore', {
				root : {
					NAME : config.fieldLabel||'Root',
					TEXT : config.fieldLabel||'Root', 
					expanded: true
				},
				autoLoad: true,
				autoSync: true,
				fields :  ['ID', 'TEXT', 'MENU_NM','LINK_URL'] ,  // ['id', 'text', 'name', 'value'], // ['ID', 'TEXT', 'MENU_NM','LINK_URL'] , 
				proxy   : {
				    type : 'ajax',
				    extraParams : { 
						'p_action_flag' : 'r_treelist' , // 'r_treelist',
						'code' : config.code
					},
				    url  : '/s/system/menu.do', // '/s/example/example.do', // '/system/auth.do', 
				    reader: {
				        type: 'json'
				    }
				},
				folderSort: false
			});
			
			this.addEvents(
                {
                        "itemclick" : true
                });

                this.listeners = Ext.apply(config.listeners||{}, {
                	focus:function(_this, the, eOpts){ 
                		_this.setCloseTriggerDisplay(_this.getValue().length > 0);
                	}
                }); // config.listeners; <-- original
                
                
                
                this.callParent(arguments);
        },
        records: [],
        recursiveRecords: [],
        selectChildren: true,
        canSelectFolders: false,
        multiselect: false, // true,
        displayField: 'TEXT', // 'TEXT', 'text',
        valueField: 'ID', // 'ID', 'id',
        /*
		store: Ext.create('Ext.data.TreeStore', {
				root : {
					name : "ComboTree",
					text : "Root",
					expanded: true
				},
				autoLoad: true,
				autoSync: true,
				fields : ['id', 'text', 'name', 'value'],
				proxy   : {
				    type : 'ajax',
				    extraParams : { 
						'p_action_flag' : 'r_tree' 
					},
				    url  : '/s/example/example.do',
				    reader: {
				        type: 'json'
				    }
				},
				folderSort: false
			}),
		*/
        recursivePush: function(node)
        {
                var     me = this; 
                me.recursiveRecords.push(node);
                
                node.eachChild(function(nodesingle)
                {
                        if(nodesingle.hasChildNodes() == true)
                        {
                                me.recursivePush(nodesingle);
                        }
                        else me.recursiveRecords.push(nodesingle);
                });
        },
        recursiveUnPush: function(node)
        {
                var     me = this;
                Ext.Array.remove(me.records, node);
                
                node.eachChild(function(nodesingle)
                {
                        if(nodesingle.hasChildNodes() == true)
                        {
                                me.recursiveUnPush(nodesingle);
                        }
                        else Ext.Array.remove(me.records, nodesingle);
                });
        },
        afterLoadSetValue: false,
        setValue: function(valueInit)
        {
                if(typeof valueInit == 'undefined') return;
                
                var     me = this,
                        tree = this.tree,
                        value = valueInit.split(',');
                     
                inputEl = me.inputEl;

                if(tree.store.isLoading())
                {
                        me.afterLoadSetValue = valueInit;
                }

                if(inputEl && me.emptyText && !Ext.isEmpty(value))
                {
                        inputEl.removeCls(me.emptyCls);
                }

                if(tree == false) return false;

                var node = tree.getRootNode();
                if(node == null) return false;
                
                me.recursiveRecords = [];
                me.recursivePush(node);
                
                var valueFin = [];
                var idsFin = [];
                
               // if(me.multiselect == true) {
                        Ext.each(me.recursiveRecords, function(record)
                        {
            				if((me.canSelectFolders == false && record.get('leaf') == false ) || record.get('disabled') || !me.multiselect) {
            					// do not thing
            				} else {
            					record.set('checked', false);
            				}
                        });
               // } 
                
                me.records = [];
                Ext.each(me.recursiveRecords, function(record)
                {
                        var data = record.get(me.valueField);
                        Ext.each(value, function(val)
                        {
                                if(data && data == val) 
                                {
                                        valueFin.push(record.get(me.displayField));
                                        idsFin.push(data);
                                        if(me.multiselect == true) {
                                        	record.set('checked', true);
                                        }
                                        me.records.push(record);
                                }
                        });
                });

                me.value = valueInit;
                me.setRawValue(valueFin.join(', '));
                
                me.setHiddenValue(value);
                me.checkChange();
                me.applyEmptyText();
                
                return me;
        },
        setHiddenValue: function(values){
            var me = this,
                name = me.hiddenName, 
                i,
                dom, childNodes, input, valueCount, childrenCount;
                
            if (!me.hiddenDataEl || !name) {
                return;
            }
            values = Ext.Array.from(values);
            dom = me.hiddenDataEl.dom;
            childNodes = dom.childNodes;
            input = childNodes[0];
            valueCount = values.length;
            childrenCount = childNodes.length;
            
            if (!input && valueCount > 0) {
                me.hiddenDataEl.update(Ext.DomHelper.markup({
                    tag: 'input', 
                    type: 'hidden', 
                    name: name
                }));
                childrenCount = 1;
                input = dom.firstChild;
            }
            while (childrenCount > valueCount) {
                dom.removeChild(childNodes[0]);
                -- childrenCount;
            }
            while (childrenCount < valueCount) {
                dom.appendChild(input.cloneNode(true));
                ++ childrenCount;
            }
            for (i = 0; i < valueCount; i++) {
                childNodes[i].value = values[i];
            }
        },
        getValue: function() 
        {
                return this.value;
        },
        getSubmitValue: function()
        {
                return this.value;
        },
        getModelData: function() {
            var me = this,
                data = null;
            if (!me.disabled) {
                data = {};
                data[me.getName()] = me.getValue().split(",");
            }
            return data;
        },
        checkParentNodes: function(node)
        {
                if(node == null) return;
                
                var     me = this,
                        checkedAll = true,
                        ids = [];
                        
                Ext.each(me.records, function(value)
                {
                        ids.push(value.get(me.valueField));
                });

                node.eachChild(function(nodesingle)
                {
                        if(!Ext.Array.contains(ids, nodesingle.get(me.valueField))) checkedAll = false;
                });
                
                if(checkedAll == true)
                {
                        me.records.push(node);
                        me.checkParentNodes(node.parentNode);
                }
                else
                {
                        Ext.Array.remove(me.records, node);
                        me.checkParentNodes(node.parentNode);
                }
                
        },
        hiddenDataCls: Ext.baseCSSPrefix + 'hide-display ' + Ext.baseCSSPrefix + 'form-data-hidden',

        
        fieldSubTpl: [
            '<div class="{hiddenDataCls}" role="presentation"></div>',
            '<input id="{id}" type="{type}" {inputAttrTpl} class="{fieldCls} {typeCls} {editableCls}" autocomplete="off"',
                '<tpl if="value"> value="{[Ext.util.Format.htmlEncode(values.value)]}"</tpl>',
                '<tpl if="name"> name="{name}"</tpl>',
                '<tpl if="placeholder"> placeholder="{placeholder}"</tpl>',
                '<tpl if="size"> size="{size}"</tpl>',
                '<tpl if="maxLength !== undefined"> maxlength="{maxLength}"</tpl>',
                '<tpl if="readOnly"> readonly="readonly"</tpl>',
                '<tpl if="disabled"> disabled="disabled"</tpl>',
                '<tpl if="tabIdx"> tabIndex="{tabIdx}"</tpl>',
                '<tpl if="fieldStyle"> style="{fieldStyle}"</tpl>',
                '/>',
            {
                compiled: true,
                disableFormats: true
            }
        ],
        getSubTplData: function(){
            var me = this;
            Ext.applyIf(me.subTplData, {
                hiddenDataCls: me.hiddenDataCls
            });
            return me.callParent(arguments);
        },
        initComponent: function() 
        {
                var     me = this;
                Ext.applyIf(me.renderSelectors, {
                    hiddenDataEl: '.' + me.hiddenDataCls.split(' ').join('.')
                });
 
                me.tree = Ext.create('Ext.tree.Panel',
                {
                        alias: 'widget.assetstree',
                        hidden: true,
                        rootVisible: (typeof me.rootVisible != 'undefined') ? me.rootVisible : true,
                        useArrows: true,
                        frame: false,
                        minWidth: me.width,
                        width: me.width,
                        height: 300,
                        minHeight: 100,
                        width : 320,
                        floating: true,
                        store: me.store,
            			displayField : me.displayField,
                        plugins: [{
                            ptype: 'dvp_nodedisabled'
                        }],
                        listeners:
                        {
                        		
                                load: function(store, records)
                                {
                                        if(me.afterLoadSetValue != false)
                                        {
                                                me.setValue(me.afterLoadSetValue);
                                        }
                                },
                                itemclick: function(view, record, item, index, e, eOpts)
                                {
                                        var values = [];
                                        
                                        if( record.get('disabled') ) {
                                        	return false;
                                        }

                                        var node = me.tree.getRootNode().findChild('id', record.get(me.valueField), true);
                                        if(node == null) 
                                        {
                                                if(me.tree.getRootNode().get(me.valueField) == record.get(me.valueField)) node = me.tree.getRootNode();
                                                else return false;
                                        }

                                       
                                        if(me.multiselect == false) me.records = [];
                                                
                                        if((me.canSelectFolders == false && record.get('leaf') == false) || record.get('disabled')) return false;
                                        

                                        if(record.get('leaf') == true || me.selectChildren == false) 
                                        {
                                                if(me.multiselect == false) {
                                                	me.records.push(record);
                                                } 
                                                else
                                                {
                                                        if(record.get('checked') == false) me.records.push(record);
                                                        else Ext.Array.remove(me.records, record);
                                                }

                                        }
                                        else
                                        {                   
                                                me.recursiveRecords = [];

                                                if(me.multiselect == false || record.get('checked') == false)
                                                {
                                                        me.recursivePush(node);
                                                        Ext.each(me.recursiveRecords, function(value)
                                                        {
                                                                if(!Ext.Array.contains(me.records, value)) me.records.push(value);
                                                        });
                                                }
                                                else if(record.get('checked') == true)
                                                {
                                                        me.recursiveUnPush(node);
                                                }
                                        }
                                        
                                        if(me.canSelectFolders == true) me.checkParentNodes(node.parentNode);
                
                                        Ext.each(me.records, function(record)
                                        {
                                                values.push(record.get(me.valueField));
                                        });

                                        me.setValue(values.join(','));
                
                                        me.fireEvent('itemclick', me, record, item, index, e, eOpts, me.records, values);

                                        if(me.multiselect == false) {
                                        	me.onTriggerClick();
                                        }
                                        // me.triggerCell.item(0).setDisplayed(values.length > 0);
                                        me.setCloseTriggerDisplay(values.length > 0);
                                                                                
                                }
                        }
                });
                
                if(me.tree.getRootNode().get('checked') != null) me.multiselect = true;
                
                this.createPicker = function()
                {
                        var     me = this;
                        return me.tree;
                };
                
                this.callParent(arguments);
        },
        onTrigger1Click : function(){
            var me = this;
            var values = [];
            me.setValue(values.join(','));
            //me.triggerCell.item(0).setDisplayed(false);
            me.setCloseTriggerDisplay(false);
            
        },
        afterRender: function(){
            this.callParent();
            //this.triggerCell.item(0).setDisplayed(false);
            this.setCloseTriggerDisplay(false);
       },
       setCloseTriggerDisplay : function (display) {
        	if( !this.allowBlank) {
        		this.triggerCell.item(0).setDisplayed(false);
        	} else {
        		this.triggerCell.item(0).setDisplayed(display);
        	}
        }

});