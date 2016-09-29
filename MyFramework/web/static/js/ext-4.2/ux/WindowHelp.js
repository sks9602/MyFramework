/**
 * 
 * 도움물 Comments Window (하나만 생성되게 coding필요..)
 * 
 */

Ext.define('Ext.window.ux.WindowHelp', {
    extend: 'Ext.window.Window',
    alias: 'widget.window_help',
	height: 200,
	width: 530,
	resizable : false,
	layout: 'border',
	border: false,
	// draggable : false,
	closeAction : 'hide' ,
	id : 'comments-window',
	target : undefined,
	listeners : {
		show : function(_this) {
			// [삭제]버튼 disable속성 처리..
			_this.child('#helpToolBottom').child('#helpBtnDelete').setDisabled(_this.target.id.indexOf('help') == -1);
		}
	},
    initComponent: function () {

        var me = this;
        
    	me.items = [{
    		xtype : 'form',
    		border: false,
    		layout: 'border',
    		region : 'center',
    		items : [{
    			region : 'center', 
    			border: false,
    			id : me.id+'-comments',
    			xtype: 'htmleditor',
    			value : Ext.get(me.target.id).getAttribute('data-qtip')
    		}]
    	}];
   	
    	// TODO 저장 / 삭제 Ajax로 db저장 구현 필요..
    	me.dockedItems = [{
    	    xtype: 'toolbar',
    	    dock: 'bottom',
    	    itemId : 'helpToolBottom',
    	    // ui: 'footer',
    	    items: [
    	    	'->',
    	        { 
    	        	xtype: 'button', 
    	        	text: '저장',
    	        	handler : function() {
    	        		var lableHelp = Ext.get(me.target.id);
    	        		//@ TODO DB저장
    	        		var formId = me.targetField.up('form').getId();
    	        		var targetId = me.targetField.getId();

    	        		// help 이미지 일경우.. qtip 수정..
    	        		if( me.target.id.indexOf('-hefp')>0) {
    	        			lableHelp.set({ 'data-qtip' : Ext.getCmp(me.id+'-comments').getValue() + "<br/> Form Id :" + formId + "<br/> Target Id :" + targetId });
    	        		}
    	        		
    	        		// 도움말 이미지가  없을 경우 도움말 이미지 생성.
    	        		if( !Ext.get(me.targetField.getId()+'-help')) {
    		        		var helpTpl = Ext.create('Ext.XTemplate', G_HELP_TIP_TPL );
    		        		
    		        		Ext.DomHelper.append(me.targetField.getId()+'-labelEl', helpTpl.apply([me.targetField.getId()+'-help', '@TODO Title', Ext.getCmp(me.id+'-comments').getValue()]) );
    		        		// help버튼에 이벤트 추가
    		        		var imgEl = Ext.get(me.targetField.getId()+'-help'); 
    				        if(imgEl){
    				            imgEl.on("click", function(e, t, eOpts) {
    				            	e.stopEvent( );
    				            	onItemHelpClick(e, t, eOpts, me.targetField);
    				            });
    				        }
    	        		}
    	        		me.close();
    	        	}
    	        },
    	        { 
    	        	xtype: 'button', 
    	        	text: '삭제',
    	        	itemId : 'helpBtnDelete',
    	        	handler : function() {
    	        		if( me.target.id.indexOf('help') > 0) {
    	        			Ext.removeNode(me.target);
    	        		}
    	        		me.close();
    	        	}
    	        }
    	    ]
    	}];
        
        me.callParent(arguments);
    }, 
    setTarget: function (target) {
    	this.target = target;
    }, 
    setTargetField : function (targetField) {
    	this.targetField = targetField;
    }

});
