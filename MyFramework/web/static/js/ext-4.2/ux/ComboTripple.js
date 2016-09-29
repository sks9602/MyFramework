/**
 * combobox 재구성.. (Combo + X + 팝업)
 */
Ext.define('Ext.form.field.ux.ComboTripple', {
    extend: 'Ext.form.field.ComboBox',
	alias: 'widget.combotipple_ux',
    trigger2Cls : 'x-form-clear-trigger',
    trigger3Cls : 'x-form-search-trigger',
    queryMode     : 'local',
    triggerAction : 'all',
    forceSelection: true,
    valueField    : 'VALUE',
	displayField  : 'NAME',
	labelSeparator: '',
    // editable      : false,
    width         : 320,  
    labelWidth : 120,
    columns    : 'auto', 
    msgTarget  : 'side', 
	constructor: function(config)
    {
		
		if( !config.afterLabelTextTpl && config.comments ) {
			config.afterLabelTextTpl =  Ext.create('Ext.XTemplate', Ext.String.format(G_HELP_TIP_TPL , '{id}-help', config.commentsTitle||'', config.comments ))
		}
        this.listeners = Ext.applyIf(config.listeners||{}, {
        	beforerender : function( _this ) {
        		_this.listConfig = _this.listConfig||{};
        		if( !_this.listConfig.itemTpl ) {
        			_this.listConfig.itemTpl = Ext.create('Ext.XTemplate', '<tpl for=".">{NAME}<tpl if="COMMENTS_TITLE">'+ Ext.String.format(G_HELP_TIP_TPL_ITEM , _this.getId()+'-{VALUE}-help') +'</tpl></tpl>')
        		}
        	},
        	// 도움말 Comments에 기능 추가..
        	afterrender: function(_this){
        		try {
        			_this.setPopupTriggerDisplay(_this.code||''!='' || _this.code.indexOf('.')<0);
        		} catch(e) {
        			alert('ComboTripple.js -> ' + e);
        		}
        		var imgEl = Ext.get(_this.getId()+'-help'); 
		        if(imgEl){
		            imgEl.on("click", function(e, t, eOpts) {
		            	e.stopEvent( );
		            	var win = Ext.getCmp('comments-window');
		            	if( !win ) {
		            		win = Ext.create('Ext.window.ux.WindowHelp', {
		            			title: _this.getFieldLabel()+'의 Comments 수정 ',
			        	    	x : e.getX(),
			        	    	y : e.getY(),
			        	    	target : t
			        	    });
			        	} else {
			        		win.setTitle(_this.getFieldLabel()+'의 Comments 수정 ');
			        		win.setX(e.getX());
			        		win.setY(e.getY());
			        		win.setTarget(t);

			        		Ext.getCmp('comments-window-comments').setValue( t.getAttribute('data-qtip') );
			        	}
						win.show();
		            });
		        }
		        if( _this.value == null || _this.value == '' ) {
		        	_this.setCloseTriggerDisplay(false);
		        }
		        
		        // ok, 하지만 화면의 ui때문에 주석처리
		        _this.on('change', function(__this, newValue, oldValue, eOpts ) {
		        	__this.setCloseTriggerDisplay( newValue != '' );
		        } );
		        
        		/* Combobox의 item에 나오는 comments 추가하려다 실패..
        		var helpArr = new Array;

        		if( _this.comments ) {
        			helpArr.push(Ext.get(_this.getId()+'-help')); 
        		}

        		for( var i=0; i<_this.store.getCount( ) ; i++ ) {
        			if( _this.store.getAt(i).get('value') ) {
        				helpArr.push(Ext.get(_this.getId()+'-'+ _this.store.getAt(i).get('value') +'-help')); 
        			}
        		}
        		
        		for( var img = 0 ; img < helpArr.length ; img++ ) {
        			if(helpArr[img]){
        				helpArr[img].on("click", function(e, t, eOpts) {
    		            	e.stopEvent( );
    		            	var win = Ext.getCmp('comments-window');
    		            	if( !win ) {
    		            		win = Ext.create('Ext.window.ux.WindowHelp', {
    		            			title: _this.getFieldLabel()+'의 Comments 수정 ',
    			        	    	x : e.getX(),
    			        	    	y : e.getY(),
    			        	    	targetId : t.id
    			        	    });
    			        	} else {
    			        		win.setTitle(_this.getFieldLabel()+'의 Comments 수정 ');
    			        		Ext.getCmp('comments-window-comments').setValue( imgEl.getAttribute('data-qtip') );
    			        		win.setX(e.getX());
    			        		win.setY(e.getY());
    			        	}
    						win.show();
    		            });
    		        }
        			
        		}
		        */
		    } ,
		    change : function (_this, newValue, oldValue, eOpts) {
		    	
				if( config.event && config.event.change ) {
					Ext.Function.defer(config.event.change,0, this,  [_this, newValue, oldValue, eOpts] );
				}
		    }
        }); // config.listeners; <-- original
        this.callParent(arguments);
    },
    initComponent: function() {
        var me = this;
        me.queryMode     = 'local';
        me.forceSelection= true;
        // me.editable      = false;
        
        me.callParent(arguments);
        
    },
    afterRender: function(){
        this.callParent();
        // 'X' 콤보 안보이게..
        if( !this.allowBlank  ) { // || this.getValue() == '' ok, 하지만 화면의 ui때문에 주석처리
        	this.setCloseTriggerDisplay(false);
        }
        
    },
    onTrigger2Click: function(event) {
        var me = this;
        // alert(event.getTarget().className);
        me.collapse();
        // 첫번째 값이 "-전체-" 인 경우
       	/* if(  me.first == 'all') {
            me.setValue('');       	
       	} else */
        
        if( me.first||'none' == 'none' || me.first == 'all'){
            me.clearValue();       	
        }
		me.inputEl.focus();
		/*  ok, 하지만 화면의 ui때문에 주석처리 */
		me.setCloseTriggerDisplay(false);
		
    }, 
    onTrigger3Click : function(event) {
    	var me = this;
    	me.collapse();

    	if(me.code && me.code.indexOf('.')>=0) {
    		hoAlert('공통코드가 아닙니다.', Ext.exptyFn, 1000);
    	}  else {
	    	var ux_combo_window_code_view = Ext.getCmp('ux_combo_window_code_view') ;
	    	if( !ux_combo_window_code_view ) {
	    		ux_combo_window_code_view = Ext.create('Ext.window.Window', {
				    title: '공통코드 팝업 - TODO',
				    id : 'ux_combo_window_code_view' ,
				    height: 600,
				    width: 1200,
				    minWidth : 900,
				    border : 0,
				    layout: 'fit',
				    items: [
		 		       	Ext.create('Ext.tree.Panel', {
						viewConfig : {
							forceFit : true
						},
						rootVisible: false,
						columnLines : true,
						rowLines : true,
						id : 'ux_combo_grid_window_code_view',
						store : Ext.create('Ext.data.TreeStore', {
							idProperty: 'ID',
							textProperty: 'TEXT',
							storeId : 'ux_combo_store_grid_store_window_code_view', 
							autoDestroy : true,
							// autoLoad : true,
							remoteSort : true,
							fields : [ 'depth', 'leaf', 'expanded', 'COMPANY_ID', 'CD', 'CD_NM', 'P_CD', 'FREE_1', 'FREE_2', 'FREE_3', 'FREE_4', 'FREE_5', 'FREE_6', 'FREE_7', 'FREE_8', 'FREE_9', 'USE_YN', 'COMMENTS_TITLE', 'COMMENTS', 'SORT_NUM', 'ICON_CLS' ],
							id : 'ux_combo_grid_store_window_code_view',
							proxy : Ext.create('Ext.data.HttpProxy', {
								type: 'ajax', //'memory',
								url : '/s/system/code.do?p_action_flag=v_list_group',
								reader : {
									type : 'json'
								}
							})
						}),
						selType : 'cellmodel',
						margin : '0 0 0 0',
						columns : [
									{
										xtype : 'rownumberer',
										width : 30
									}, 
									{	xtype: 'treecolumn',
										dataIndex : 'CD_NM',
										header : '코드명',
										sortable : true,
										minWidth : 150,
										flex : 1,
										locked : true
									},
									{
										dataIndex : 'CD',
										header : '코드',
										sortable : true,
										style : 'text-align:center',
										width : 100,
										locked : true
									}, 
									{
										dataIndex : 'ICON_CLS',
										header : 'ICON CLS',
										sortable : true,
										style : 'text-align:center',
										align : 'center',
										width : 90,
										locked : true
									},
									{
										dataIndex : 'USE_YN',
										header : '사용여부',
										sortable : true,
										style : 'text-align:center',
										align : 'center',
										width : 60,
										locked : true
									}, 
									{
										dataIndex : 'FREE_1',
										header : '정의 코드1',
										sortable : true,
										style : 'text-align:center',
										align : 'center',
										width : 90
									}, 
									{
										dataIndex : 'FREE_2',
										header : '정의 코드2',
										sortable : true,
										style : 'text-align:center',
										align : 'center',
										width : 90
									}, 
									{
										dataIndex : 'FREE_3',
										header : '정의 코드3',
										sortable : true,
										style : 'text-align:center',
										align : 'center',
										width : 90
									}, 
									{
										dataIndex : 'FREE_4',
										header : '정의 코드4',
										sortable : true,
										style : 'text-align:center',
										align : 'center',
										width : 90
									}, 
									{
										dataIndex : 'FREE_5',
										header : '정의 코드5',
										sortable : true,
										style : 'text-align:center',
										align : 'center',
										width : 90
									}, 
									{
										dataIndex : 'FREE_6',
										header : '정의 코드6',
										sortable : true,
										style : 'text-align:center',
										align : 'center',
										width : 90
									}, 
									{
										dataIndex : 'FREE_7',
										header : '정의 코드7',
										sortable : true,
										style : 'text-align:center',
										align : 'center',
										width : 90
									}, 
									{
										dataIndex : 'FREE_8',
										header : '정의 코드8',
										sortable : true,
										style : 'text-align:center',
										align : 'center',
										width : 90
									}, 
									{
										dataIndex : 'FREE_9',
										header : '정의 코드9',
										sortable : true,
										style : 'text-align:center',
										align : 'center',
										width : 90
									}, 
									{
										dataIndex : 'COMMENTS_TITLE',
										header : 'COMMENT제목',
										sortable : true,
										style : 'text-align:center',
										align : 'center',
										width : 90
									}, 
									{
										dataIndex : 'COMMENTS',
										header : 'COMMENT',
										sortable : true,
										style : 'text-align:center',
										align : 'center',
										width : 90
									}, 
									{
										dataIndex : 'SORT_NUM',
										header : '정렬 순서',
										sortable : true,
										style : 'text-align:center',
										align : 'center',
										width : 90
									}
		
						],
						dockedItems: [ 
						    {
						    	xtype: 'toolbar', dock :'top', flex : 1, border : true,
						    	items : [ '->',
						    	         { xtype : 'button', border: 1, style: { borderColor: '#99bce8', borderStyle: 'solid'} , glyph:'xf0c7@FontAwesome', text : '저장',  // iconCls:'btn-icon-save', 
						    	        	 handler : function(){
						    	        		 alert(1);
						    	        	 }  
						    	         }
						    	] 
						    }
						]
					})
		
					]
				})
	    	}
	    	ux_combo_window_code_view.show();
	    	var codeStore = Ext.getStore('ux_combo_store_grid_store_window_code_view');
	    	codeStore.load({ params : {'code': me.code, 'ROOT' : '*'}});
    	}
    },
    setCloseTriggerDisplay : function (display) {
    	if( !this.allowBlank) {
    		this.triggerCell.item(1).setDisplayed(false);
    	} else {
    		this.triggerCell.item(1).setDisplayed(display);
    	}
    },
    setPopupTriggerDisplay : function (display) {
    	this.triggerCell.item(1).setDisplayed(false);
    }
});
