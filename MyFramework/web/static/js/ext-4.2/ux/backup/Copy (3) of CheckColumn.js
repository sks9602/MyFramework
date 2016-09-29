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
        me.idx = 0;
        if( !grid.getStore() || me.storeCnt <= 0 ) {
        	return;
        }
        /*
        Ext.MessageBox.show({
            title: 'Please wait',
            msg: 'Loading items...',
            progressText: 'Initializing...',
            width:300,
            progress:true,
            closable:false,
            animateTarget: el
        });
        */
        var progressBar = Ext.getCmp(Ext.getCmp(grid.ownerCt.getId()).getDockedComponent('gridPageTB').getId()).getComponent('progressBar');

        if (!me.checked) {
        	for( var i=1; i<=Math.ceil(grid.getStore().getCount()/20); i++ ) {
        		me.fireEvent('selectall', grid.getStore(), header, true, grid, i);
        	}
            header.getEl().down('img').addCls(Ext.baseCSSPrefix + 'grid-checkcolumn-checked');
            me.checked = true;
        } else {
        	for( var i=1; i<=Math.ceil(grid.getStore().getCount()/20); i++ ) {
        		me.fireEvent('selectall', grid.getStore(), header, false, grid, i);
        	}
            header.getEl().down('img').removeCls(Ext.baseCSSPrefix + 'grid-checkcolumn-checked');
            me.checked = false;
        }
        // Progressbar 숨기기..
        Ext.Function.defer(function() {
        	progressBar.reset(true);
		}, 35000);
    },
    
    onSelectAll: function(store, column, checked, grid, idx) {
    	var me = this;
        var dataIndex = column.dataIndex, storeCnt = store.getCount(), record, minVal = Math.min(idx*20,storeCnt) ;

        var progressBar = Ext.getCmp(Ext.getCmp(grid.ownerCt.getId()).getDockedComponent('gridPageTB').getId()).getComponent('progressBar');
        if( idx == 1 ) {
	        progressBar.show();
	        progressBar.updateProgress(0, 'Initiating..');
        }
        
        Ext.Function.defer(function() {
			
            // 실제 data변경
            for(var i = (idx-1)*20; i < minVal  ; i++) {
            	record = store.getAt(i);
            	record.set(dataIndex, checked);
            }

            progressBar.updateProgress(minVal/storeCnt, Math.round(100*minVal/storeCnt)+ '% changed');
            
            //Ext.MessageBox.updateProgress(minVal/storeCnt, Math.round(100*minVal/storeCnt)+ '% changed');
		}, 1000*idx);

	}
	
});