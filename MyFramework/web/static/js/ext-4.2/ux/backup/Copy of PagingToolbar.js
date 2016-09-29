Ext.define('Ext.ux.PagingToolbar', {
    alias: 'ux.paging',
    extend: 'Ext.PagingToolbar',
    pageCnt : 10,
    getPagingItems: function() {
        var me = this;

        var page = [];
        page.push({
            itemId: 'first',
            tooltip: { text : me.firstText, mouseOffset : [0, -60]} , 
            overflowText: me.firstText,
            iconCls: Ext.baseCSSPrefix + 'tbar-page-first',
            disabled: true,
            handler: me.moveFirst,
            scope: me
        });
        page.push({
            itemId: 'prev',
            tooltip:  { text : me.prevText, mouseOffset : [0, -60]} , 
            overflowText: me.prevText,
            iconCls: Ext.baseCSSPrefix + 'tbar-page-prev',
            disabled: true,
            handler: me.movePrevious,
            scope: me
        });
        page.push('-');

        for( var i=1; i<=this.pageCnt ;i++) {
        	page.push({xtype:'button', text : ""+i , itemId : 'page_'+i, disabled : true, scope : this, tooltip : { text : 'Page '+i , mouseOffset : [0, -60]}, handler : me.movePage });
        }

        page.push('-');
        page.push({
            itemId: 'next',
            tooltip: { text : me.nextText, mouseOffset : [0, -60]} ,
            overflowText: me.nextText,
            iconCls: Ext.baseCSSPrefix + 'tbar-page-next',
            disabled: true,
            handler: me.moveNext,
            scope: me
        });

        page.push({
            itemId: 'last',
            tooltip: { text : me.lastText, mouseOffset : [0, -60]} ,  
            overflowText: me.lastText,
            iconCls: Ext.baseCSSPrefix + 'tbar-page-last',
            disabled: true,
            handler: me.moveLast,
            scope: me
        });
        page.push( '-');
        page.push( me.beforePageText);
        page.push({
            xtype: 'numberfield',
            itemId: 'inputItem',
            name: 'inputItem',
            cls: Ext.baseCSSPrefix + 'tbar-page-number',
            allowDecimals: false,
            minValue: 1,
            hideTrigger: true,
            enableKeyEvents: true,
            keyNavEnabled: false,
            selectOnFocus: true,
            submitValue: false,

            isFormField: false,
            width: me.inputItemWidth,
            margins: '-1 2 3 2',
            listeners: {
                scope: me,
                keydown: me.onPagingKeyDown,
                blur: me.onPagingBlur
            }
        });
        page.push({
            xtype: 'tbtext',
            itemId: 'afterTextItem',
            text: Ext.String.format(me.afterPageText, 1)
        });
        page.push('-');
        page.push({
            itemId: 'refresh',
            tooltip: me.refreshText,
            overflowText: me.refreshText,
            iconCls: Ext.baseCSSPrefix + 'tbar-loading',
            handler: me.doRefresh,
            scope: me
        });
        page.push('-');

        return page;
    },
    initComponent:  function() {
    	var me = this;
    	me.callParent();
	},
	
    onLoad : function(){
        var me = this,
            pageData,
            currPage,
            pageCount,
            afterText,
            count,
            isEmpty,
            item;

        count = me.store.getCount();
        isEmpty = count === 0;
        if (!isEmpty) {
            pageData = me.getPageData();
            currPage = pageData.currentPage;
            pageCount = pageData.pageCount;
            afterText = Ext.String.format(me.afterPageText, isNaN(pageCount) ? 1 : pageCount);
        } else {
            currPage = 0;
            pageCount = 0;
            afterText = Ext.String.format(me.afterPageText, 0);
        }

        Ext.suspendLayouts();
        item = me.child('#afterTextItem');
        if (item) {    
            item.setText(afterText);
        }
        item = me.getInputItem();
        if (item) {
            item.setDisabled(isEmpty).setValue(currPage);
        }
        
        me.setPageingButton();
 
        me.updateInfo();
        Ext.resumeLayouts(true);

        if (me.rendered) {
            me.fireEvent('change', me, pageData);
        }
    },

    setPageingButton : function(){
        var me = this,item, count, isEmpty, firstItem, page, tootipTxt,
                 pageData, currPage, pageCount = me.getPageData().pageCount;

        count = me.store.getCount();
        isEmpty = count === 0;

        firstItem = me.child('#page_1');

        if (!isEmpty) {
            pageData = me.getPageData();
            currPage = pageData.currentPage;
            pageCount = pageData.pageCount;
        } else {
            currPage = 0;
            pageCount = 0;
        }

        me.setChildDisabled('#first', firstItem.text == '1');
        me.setChildDisabled('#prev', firstItem.text == '1');
        
        for( var i=1; i<=me.pageCnt; i++ ) {
        	item = me.child('#page_'+i);
        	if (item) {
        		page = parseInt(item.text);
                item.setDisabled( page > pageCount );
        		item.toggle( currPage == item.text );
        		if( (page-1)*me.store.pageSize <= count) {
	        		tootipTxt = 'Page '+ item.text + ' ('+ ((page-1)*me.store.pageSize+1) +'~'+ Math.min(page*me.store.pageSize, count) +')';
	        		item.setTooltip({mouseOffset : [0, -60], text : tootipTxt });
        		} else {
        			item.setTooltip({mouseOffset : [0, -60], text : 'Page '+ item.text });
        		}
            }
        } 
        me.setChildDisabled('#next', ((parseInt(firstItem.getText())+me.pageCnt) >= pageCount));
        me.setChildDisabled('#last', ((parseInt(firstItem.getText())+me.pageCnt) >= pageCount));
        me.setChildDisabled('#refresh', false);
        
    },
    onPagingKeyDown : function (field, e) {
        var me = this,item, viewPage,pageData = me.getPageData(),
        pageCount = me.getPageData().pageCount;
        
    	me.callParent(arguments);

    	viewPage = ((Math.floor((me.readPageFromInput(pageData)-1) / me.pageCnt))*me.pageCnt);

        for( var i=1; i<=me.pageCnt; i++ ) {
        	item = me.child('#page_'+i);
        	if (item) {
        		item.setText( viewPage + i);
            }
        }  
        me.setPageingButton();    	

    }, 
    moveFirst : function(){
        var me = this,item, 
        pageCount = me.getPageData().pageCount;

        for( var i=1; i<=me.pageCnt; i++ ) {
        	item = me.child('#page_'+i);
        	if (item) {
        		item.setText( i );
            }
        }  
        me.setPageingButton();    	
    },
    movePrevious : function(){
        var me = this,item, 
        pageCount = me.getPageData().pageCount;

        for( var i=1; i<=me.pageCnt; i++ ) {
        	item = me.child('#page_'+i);
        	if (item) {
        		item.setText( parseInt(item.getText()) - me.pageCnt );
            }
        }  
        me.setPageingButton();    	
    },
    moveNext : function(){
        var me = this,item, 
        pageCount = me.getPageData().pageCount;

    	item = me.child('#page_1');

        if( (parseInt(item.getText())+me.pageCnt) <= pageCount ) {
	        for( var i=1; i<=me.pageCnt; i++ ) {
	        	item = me.child('#page_'+i);
	        	if (item) {
	        		item.setText( parseInt(item.getText()) + me.pageCnt );
	            }
	        }  
        }
        me.setPageingButton();
    }, 
    moveLast : function(){
        var me = this,item, lastPage,
        pageCount = me.getPageData().pageCount;

        lastPage = ((Math.round(pageCount / me.pageCnt)-1)*me.pageCnt);
        for( var i=1; i<=me.pageCnt; i++ ) {
        	item = me.child('#page_'+i);
        	if (item) {
        		item.setText( lastPage + i);
            }
        }  
        me.setPageingButton();    	
    },
    movePage : function(_btn, _e) {

		var me = this, pageData = me.getPageData(), pageNum = _btn.text;

		if (pageNum !== false) {
            pageNum = Math.min(Math.max(1, pageNum), pageData.pageCount);
            if(me.fireEvent('beforechange', me, pageNum) !== false){
                me.store.loadPage(pageNum, { params : me.store.params } );
            }
        }
	}
});
