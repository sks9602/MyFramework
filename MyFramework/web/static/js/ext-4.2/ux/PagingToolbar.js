
Ext.define('Ext.ux.Button', {
    alias: 'widget.pagingBtn',
    extend: 'Ext.button.Button',

    setText: function(text) {
        text = text || '';
        var me = this,
            oldText = me.text || '';

        if (text != oldText) {
            me.text = text;
            if (me.rendered) {
                me.btnInnerEl.update(text || '&#160;');
                me.setComponentCls();
                if (Ext.isStrict && Ext.isIE8) {
                    
                    me.el.repaint();
                }
               // me.updateLayout();
            }
           me.fireEvent('textchange', me, oldText, text);
        }
        return me;
    }
    
});

/**
 * Grid Paging용 toolbar
 */
Ext.define('Ext.ux.PagingToolbar', {
    alias: 'ux.paging',
    extend: 'Ext.PagingToolbar',
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
        	page.push({xtype:'pagingBtn', text : i , itemId : 'page_'+i, disabled : true, scope : this, width : 30, tooltip : { text : 'Page '+i , mouseOffset : [0, -60]}, handler : me.movePage });
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
        /*
        page.push({
            itemId: 'refresh',
            tooltip: me.refreshText,
            overflowText: me.refreshText,
            iconCls: Ext.baseCSSPrefix + 'tbar-loading',
            handler: me.doRefresh,
            scope: me
        });
        */

        me.progressBar = Ext.create('Ext.ProgressBar', {
        	text    : 'Initiating...',
            // width: 200,
        	flex : 1,
            hidden : true,
            animate: true,
            /*
            animate : {
        		duration: 500,
        		easing: 'bounceOut'	
        	},	
        	*/
            itemId : 'progressBar',
            listeners : {
            	update : function (_this, value, text, eOpts) {
            		if( value == 1 ) {
    			        Ext.Function.defer(function() {
    			        	_this.reset(true);
    					}, 2000);
    	        	}
            	}
            }
        });
        
        page.push(me.progressBar);
        // page.push('-');

        return page;
    },
    constructor: function(config) {
    	
    	this.callParent(arguments);
    	
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
        
        me.setPageingButton((currPage == 0 || currPage == 1) ? 'first' : 'now');
 
        me.updateInfo();
        Ext.resumeLayouts(true);

        if (me.rendered) {
            me.fireEvent('change', me, pageData);
        }
    },
    setPageingButton : function(type){
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
        
        lastPage = ((Math.round(pageCount / me.pageCnt)-1)*me.pageCnt); 
        var firstVal = parseInt(firstItem.getText()), btnText;
        
        switch( type||'first' ) {
	    	case 'first' : btnText = 1 ; break;
	    	case 'previous' : btnText = firstVal - me.pageCnt ; break;
	    	case 'next' : btnText = firstVal + me.pageCnt; break;
	    	case 'last' : btnText = lastPage+1; break;
	    	case 'now' : btnText = firstVal; break;
	    	case 'page' : btnText = ((Math.floor((Math.min(me.readPageFromInput(pageData), pageCount)-1) / me.pageCnt))*me.pageCnt)+1; break;
	    	default : btnText = 1; break;
        }

        for( var i=btnText,j=1 ; i<=btnText+me.pageCnt; i++,j++ ) {
        	
        	item = me.child('#page_'+j);
        	
        	if (item) {
                item.setText(i);
                
        		page = parseInt(item.text);
        		
                item.setDisabled( page > pageCount );
        		item.toggle( currPage == item.text );
        		if( (page-1)*me.store.pageSize < count) {
	        		tootipTxt = 'Page '+ item.text + ' ('+ ((page-1)*me.store.pageSize+1) +'~'+ Math.min(page*me.store.pageSize, count) +') ';
	        		item.setTooltip({mouseOffset : [0, -60], text : tootipTxt });
        		} else {
        			item.setTooltip({mouseOffset : [0, -60], text : 'Page '+ item.text });
        		}
            }
            
        } 

        me.setChildDisabled('#first', firstItem.text == '1');
        me.setChildDisabled('#prev', firstItem.text == '1');
        me.setChildDisabled('#next', ((parseInt(firstItem.getText())+me.pageCnt) >= pageCount));
        me.setChildDisabled('#last', ((parseInt(firstItem.getText())+me.pageCnt) >= pageCount));
        me.setChildDisabled('#refresh', false);
        
    },
    onPagingKeyDown : function (field, e) {
        var me = this,
        k = e.getKey(),
        pageData = me.getPageData(),
        increment = e.shiftKey ? this.pageCnt : 1,
        pageNum;

	    if (k == e.RETURN) {
	        e.stopEvent();
	        pageNum = me.readPageFromInput(pageData);
	        if (pageNum !== false) {
	            pageNum = Math.min(Math.max(1, pageNum), pageData.pageCount);
	            if(me.fireEvent('beforechange', me, pageNum) !== false){
	                me.store.loadPage(pageNum, { params : me.store.params });
	            }
	        }
	        me.setPageingButton('page');   
	    } else if (k == e.HOME || k == e.END) {
	        e.stopEvent();
	        pageNum = k == e.HOME ? 1 : pageData.pageCount;
	        field.setValue(pageNum);
	    } else if (k == e.UP || k == e.PAGE_UP || k == e.DOWN || k == e.PAGE_DOWN) {
	        e.stopEvent();
	        pageNum = me.readPageFromInput(pageData);
	        if (pageNum) {
	        	if( k == e.PAGE_DOWN ) {
	        		increment *= -1*this.pageCnt;
	        	} else if (k == e.DOWN ) {
	                increment *= -1;
	            } else if( k == e.PAGE_UP ) {
	        		increment *= this.pageCnt;
	        	} 
	        	/*
	        	if (k == e.DOWN || k == e.PAGE_DOWN) {
                    increment *= -1;
                }
                */
	            pageNum += increment;
	            if (pageNum >= 1 && pageNum <= pageData.pageCount) {
	                field.setValue(pageNum);
	            }
	        }
	    }
    }, 
    moveFirst : function(){
        this.setPageingButton('first');    	
    },
    movePrevious : function(){
    	this.setPageingButton('previous');    	
    },
    moveNext : function(){
    	this.setPageingButton('next');
    }, 
    moveLast : function(){
    	this.setPageingButton('last');    	
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
