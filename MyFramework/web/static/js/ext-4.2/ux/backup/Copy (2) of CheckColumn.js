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

        var progressBar = Ext.getCmp(Ext.getCmp(grid.ownerCt.getId()).getDockedComponent('gridPageTB').getId()).getComponent('progressBar');

       
        me.storeCnt = grid.getStore().getCount();
        me.idx = 0;
        if( !grid.getStore() || me.storeCnt <= 0 ) {
        	return;
        }

        progressBar.on('show', function(_this, e) {
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

        progressBar.show();
        
        var inval = setInterval(function() {
        	var v = me.idx;
            console.log(" me.idx :" + me.idx);
            console.log(" me.storeCnt :" +  me.storeCnt);
            if(v >= me.storeCnt-1){
            	clearInterval( inval );
            	// progressBar.hide();
            }else{
                var i = v/me.storeCnt;
                progressBar.updateProgress(i, Math.round(100*i)+'% changed');
            }
        }, 500);
        

    },
    
    onSelectAll: function(store, column, checked) {
    	var me = this;
        var dataIndex = column.dataIndex;

        // 실제 data변경
        for(var i = 0; i < store.getCount() ; i++) {
            store.getAt(i).set(dataIndex, checked);
            me.idx = i;
            console.log(" me.idx >> :" + me.idx);
        }
	}
	
});