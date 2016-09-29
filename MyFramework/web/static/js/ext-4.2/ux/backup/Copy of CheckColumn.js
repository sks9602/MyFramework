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
       
        me.storeCnt = grid.getStore().getCount();
        if( !grid.getStore() || me.storeCnt <= 0 ) {
        	return;
        }
		Ext.MessageBox.show({
	        title: 'Please wait',
	        msg: 'Changing items...',
	        progressText: 'Initializing...',
	        width:300,
	        progress:true,
	        closable:true ,
	        modal : false,
	        animateTarget: me.id +'-titleEl'
	    });
		
		Ext.MessageBox.toFront();   
		
		Ext.MessageBox.updateProgress(0, '0% chagned');

        var inval = setInterval(function() {
        	var v = me.idx;
        	console.log(v);
            if(v >= me.storeCnt-1){
            	clearInterval( inval );
            	Ext.MessageBox.hide();
            }else{
                var i = v/me.storeCnt;
                Ext.MessageBox.updateProgress(i, Math.round(100*i)+'% chagned');
            }
        }, 500);
        Ext.MessageBox.on("show", function(_this, opts) {
            if (!me.checked) {
                me.fireEvent('selectall', grid.getStore(), header, true);
                header.getEl().down('img').addCls(Ext.baseCSSPrefix + 'grid-checkcolumn-checked');
                me.checked = true;
            } else {
                me.fireEvent('selectall', grid.getStore(), header, false);
                header.getEl().down('img').removeCls(Ext.baseCSSPrefix + 'grid-checkcolumn-checked');
                me.checked = false;
            }
    	});
    },
    
    onSelectAll: function(store, column, checked) {
    	var me = this;
        var dataIndex = column.dataIndex;

        // 실제 data변경
        for(var i = 0; i < store.getCount() ; i++) {
            // store.getAt(i).set(dataIndex, checked);
            me.idx = i;
        }
	}
	
});