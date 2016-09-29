/**
 * FormFieldUx.js로 이동...
 */

/**
 * 년월일 + 년월일 형태의 component생성..
 * FormFieldUx.js로 이동...
 */
Ext.define('Ext.ux.PeriodDate', {
    alias: 'widget.periodDate',
    extend: 'Ext.form.field.Date',
    trigger2Cls: Ext.baseCSSPrefix + 'form-clear-trigger',
    trigger3Cls: Ext.baseCSSPrefix + 'form-combo-trigger',
    altFormats : "Y/m/d|m/d/Y|n/j/Y|n/j/y|m/j/y|n/d/y|m/j/Y|n/d/Y|m-d-y|m-d-Y|m/d|m-d|md|mdy|mdY|d|Y-m-d|Ymd|n-j|n/j",
    submitFormat: 'Y-m-d H:i:s', // 'Ymd', // 참고Y-m-d H:i:s
    format : 'Y/m/d',
    submitValue : true,
    dateField : true,
    type:'date', 
    labelSeparator : '',
	constructor: function(config) {
		if( !config.afterLabelTextTpl && config.comments ) {
			config.afterLabelTextTpl =  Ext.create('Ext.XTemplate', Ext.String.format(G_HELP_TIP_TPL , '{id}-help', config.commentsTitle||'', config.comments ));
		}
		
        this.listeners = Ext.apply(config.listeners||{}, {
        	// 도움말 Comments에 기능 추가..
        	afterrender: function(_this){
 
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
		    }
        }); 
        
		this.callParent(arguments);
    },
    initComponent : function(){
    	var me = this;
    	
        me.callParent();
          
    },
    /*
    getSubmitData: function() {
        var me = this,
            data = null,
            val;
        if (!me.disabled && me.submitValue && !me.isFileUpload()) {
            val = me.getSubmitValue();
            if (val !== null) {
                data = {};
                data[me.getName()] = val;
            }
        }
        console.log(' getSubmitData : '+ data);
        return data;
    },

    
    getModelData: function() {
        var me = this,
            data = null;
        if (!me.disabled && !me.isFileUpload()) {
            data = {};
            data[me.getName()] = me.getValue();
        }
        console.log(' getModelData : '+ data);
        return data;
    },
	*/
    afterRender: function(){
        this.callParent();
        // 'X' 콤보 안보이게..
        if( !this.allowBlank ) {
        	this.triggerCell.item(1).setDisplayed(false);
        }
        // this.triggerCell.item(2);
        /* trigger에 menu달기.. 실패..
        try {
        	this.menu = Ext.create('Ext.menu.Menu', {
		        width: 120,
		        floating: false,
		        renderTo : this.triggerEl.elements[2].id,
		        items: [{
		            text: '종료일 1주 전'
		        }]});
        } catch(e) {
        	alert(e);
        }
        */
    },
    initValue: function() {
        var me = this,
            value = me.value;

        if( value == 'year') {
    		if( this.edDtId ) {
    			me.value = Ext.Date.parse(Ext.Date.format(new Date(), 'Y') + '0101', 'Ymd');
    		} else if( this.stDtId ) {
    			me.value = Ext.Date.parse(Ext.Date.format(new Date(), 'Y') + '1231', 'Ymd');
    		}		
        } else if( value == 'month') {
    		if( this.edDtId ) {
    			var stDt = Ext.Date.getFirstDateOfMonth(new Date());
    			me.value = stDt;
    		} else if( this.stDtId ) {
    			var edDt = Ext.Date.getLastDateOfMonth(new Date());
    			me.value = edDt;
    		}		
        } else if( value == 'week') {
        	var start = new Date(), offset = start.getDay() ;
            var viewStart = Ext.Date.add(start, Ext.Date.DAY, -1*offset);
            
            if( this.edDtId ) {
            	me.value = viewStart;
    		} else if( this.stDtId ) {
                var viewEnd = Ext.Date.add(viewStart, Ext.Date.DAY, 6);
    			me.value = viewEnd;
    		}		
        } else if( value == 'today') {
    		if( this.edDtId ) {
    			me.value = new Date();
    		} else if( this.stDtId ) {
    			me.value = new Date();
    		} else {
    			me.value = new Date();
    		}		
        } else if( value ) {
        	var values = this.value.replace(/ /, '').split(",");
        	
            if( this.edDtId && values[0] && Ext.isString(values[0]) ) {
            	if( values[0].indexOf('-') == 0 || values[0].indexOf('+') == 0 ) {
            		me.value = Ext.Date.add(new Date(), Ext.Date.DAY, values[0]);
            	} else {
            		me.value = me.rawToValue(values[0]);
            	}
    		} else if( this.stDtId && values[1] && Ext.isString(values[1]) ) {
    			if( values[1].indexOf('-') == 0 || values[1].indexOf('+') == 0 ) {
            		me.value = Ext.Date.add(new Date(), Ext.Date.DAY, values[1]);
            	} else {
            		me.value = me.rawToValue(values[1]);
            	}
    		} else {
    			me.value = me.rawToValue(values[0]);
    		}	
        }

        me.callParent();
    },
	onTrigger2Click: function(event) {
	    var me = this;
	    me.collapse();
	    me.setValue(null);
		me.setMinMaxValue();
		me.focus(false, 60);
	},
	onTrigger3Click: function(_this, event) {
	    var me = this, menu;
	    me.inputEl.focus();
        var trigger3El =  me.triggerEl.elements[2];
	    if( this.edDtId ) {
	    	var edDtObj = Ext.getCmp(this.edDtId);
	    	menu = me.menuSt = me.menuSt||Ext.create('Ext.menu.Menu', {
			        width: 120,
			        items: [
		        {
		            text: '종료일  5일 후',
		            handler : function() {
		            	me.add(stDtObj.getValue(), Ext.Date.DAY, -5);
		            }
		        },{
		            text: '종료일  30일 후',
		            handler : function() {
		            	me.add(stDtObj.getValue(), Ext.Date.DAY, -30);
		            }
		        },'-',{
		            text: '종료일 1주 전',
		            handler : function() {
		    			if( edDtObj ) {
		    				me.add(edDtObj.getValue(), Ext.Date.DAY, -7);
		    			}
		            }
		        },{
		            text: '종료일 2주 전',
		            handler : function() {
		    			if( edDtObj ) {
		    				me.add(edDtObj.getValue(), Ext.Date.DAY, -14);
		    			}
		            }
		        },'-',{
		            text: '종료일 1개월 전',
		            handler : function() {
		    			if( edDtObj ) {
		    				me.add(edDtObj.getValue(), Ext.Date.MONTH, -1);
		    			}
		            }
		        },{
		            text: '종료일 3개월 전',
		            handler : function() {
		    			if( edDtObj ) {
		    				me.add(edDtObj.getValue(), Ext.Date.MONTH, -3);
		    			}
		            }
		        },{
		            text: '종료일 6개월 전',
		            handler : function() {
		    			if( edDtObj ) {
		    				me.add(edDtObj.getValue(), Ext.Date.MONTH, -6);
		    			}
		            }
		        },'-',{
		            text: '종료일 1년 전',
		            handler : function() {
		    			if( edDtObj ) {
		    				me.add(edDtObj.getValue(), Ext.Date.YEAR, -1); 
		    			}
		            }
		        },{
		            text: '종료일 2년 전',
		            handler : function() {
		    			if( edDtObj ) {
		    				me.add(edDtObj.getValue(), Ext.Date.YEAR, -2); 
		    			}
		            }
		        },{
		            text: '종료일 3년 전',
		            handler : function() {
		    			if( edDtObj ) {
		    				me.add(edDtObj.getValue(), Ext.Date.YEAR, -3); 
		    			}
		            }
		        }]});
	    } else {
	    	var stDtObj = Ext.getCmp(this.stDtId);
	    	menu = me.menuEd = me.menuEd||Ext.create('Ext.menu.Menu', {
		        width: 120,
		        items: [
			        {
			            text: '시작일  5일 후',
			            handler : function() {
			            	me.add(stDtObj.getValue(), Ext.Date.DAY, 5);
			            }
			        },{
			            text: '시작일  30일 후',
			            handler : function() {
			            	me.add(stDtObj.getValue(), Ext.Date.DAY, 30);
			            }
			        },'-',{
			            text: '시작일 1주 후',
			            handler : function() {
			            	me.add(stDtObj.getValue(), Ext.Date.DAY, 7);
			            }
			        },{
			            text: '시작일 2주 후',
			            handler : function() {
			            	me.add(stDtObj.getValue(), Ext.Date.DAY, 14);
			            }
			        },'-',{
			            text: '시작일 1개월 후 ',
			            handler : function() {
			            	me.add(stDtObj.getValue(), Ext.Date.MONTH, 1);
			            }
			        },{
			            text: '시작일 3개월 후 ',
			            handler : function() {
			            	me.add(stDtObj.getValue(), Ext.Date.MONTH, 3);
			            }
			        },{
			            text: '시작일 6개월 후 ',
			            handler : function() {
			            	me.add(stDtObj.getValue(), Ext.Date.MONTH, 6);
			            }
			        },'-',{
			            text: '시작일 1년 후',
			            handler : function() {
			            	me.add(stDtObj.getValue(), Ext.Date.YEAR, 1);
			            }
			        },{
			            text: '시작일 2년 후',
			            handler : function() {
			            	me.add(stDtObj.getValue(), Ext.Date.YEAR, 12);
			            }
			        },{
			            text: '시작일 3년 후',
			            handler : function() {
			            	me.add(stDtObj.getValue(), Ext.Date.YEAR, 3);
			            }
			        }
			    ]
	    	});
	    }
        menu.showBy(me.bodyEl, 0, 0); 
	},
    add : function( date, interval, value ) {
		var newDate;
		
		switch(interval) {
			case Ext.Date.DAY :
				newDate = Ext.Date.add( Ext.Date.add(date, Ext.Date.DAY, 1*value), Ext.Date.DAY, value ==0 ? 0 : (value<0 ? 1 : -1) );
				break;
			case Ext.Date.MONTH :
				newDate = Ext.Date.add( Ext.Date.add(date, Ext.Date.MONTH, 1*value), Ext.Date.DAY, value ==0 ? 0 : (value<0 ? 1 : -1) );
				break;
			case Ext.Date.YEAR :
				newDate = Ext.Date.add( Ext.Date.add(date, Ext.Date.YEAR, 1*value), Ext.Date.DAY, value ==0 ? 0 : (value<0 ? 1 : -1) );
				break;
			default : 
				newDate = date;
				break;
		}
		this.focus(false, 60);
		this.setValue( newDate );

	}, 
	beforeBlur : function() {
		var me = this;
		me.callParent();
		me.setMinMaxValue();
		
	},
	setMinMaxValue : function() {
		var me = this;
		if( this.edDtId ) {
			var edDtObj = Ext.getCmp(this.edDtId);
			if( edDtObj ) {
				edDtObj.setMinValue(me.getValue());
				edDtObj.validate();
				me.setMaxValue(edDtObj.getValue() ) ;
			}
		} 

		if( this.stDtId ) {
			var stDtObj = Ext.getCmp(this.stDtId);
			if( stDtObj ) {
				stDtObj.setMaxValue(me.getValue());
				stDtObj.validate();
				me.setMinValue(stDtObj.getValue() ) ;
			}
			
		}		
	},
    onExpand: function() {
    	var me = this;
		me.callParent();
		me.setMinMaxValue();
    }/* ,
    getModelData: function() {
    	var format = this.submitFormat || this.format,
        value = this.getValue();
    	
    	return value ? Ext.Date.format(value, format) : '';
    } */
});


/**
 * 날짜 combobox뒤에 붙는 기간 설정 버튼
 */
Ext.define('Ext.ux.PeriodButton', {
    alias: 'widget.periodButton',
    extend: 'Ext.button.Button',
    constructor: function(config) {
    	config.text = config.text||'기간설정';
    	
    	config.menu  = Ext.create('Ext.menu.Menu', {
			items : [
				{  text: '1주', handler : function() {
					Ext.getCmp('id_stt_'+config.name+'_'+config.actionFlag).add(new Date(),Ext.Date.DAY, -7);
					Ext.getCmp('id_end_'+config.name+'_'+config.actionFlag).add(new Date(),Ext.Date.DAY, 0);				
				}},
				{  text: '2주', handler : function() {
					Ext.getCmp('id_stt_'+config.name+'_'+config.actionFlag).add(new Date(),Ext.Date.DAY, -14);
					Ext.getCmp('id_end_'+config.name+'_'+config.actionFlag).add(new Date(),Ext.Date.DAY, 0);				
				}},
				'-',
				{  text: '1개월', handler : function() {
					Ext.getCmp('id_stt_'+config.name+'_'+config.actionFlag).add(new Date(),Ext.Date.MONTH, -1);
					Ext.getCmp('id_end_'+config.name+'_'+config.actionFlag).add(new Date(),Ext.Date.DAY, 0);				
				}},
				{  text: '3개월', handler : function() {
					Ext.getCmp('id_stt_'+config.name+'_'+config.actionFlag).add(new Date(),Ext.Date.MONTH, -3);
					Ext.getCmp('id_end_'+config.name+'_'+config.actionFlag).add(new Date(),Ext.Date.DAY, 0);				
				}},
				{  text: '6개월', handler : function() {
					Ext.getCmp('id_stt_'+config.name+'_'+config.actionFlag).add(new Date(),Ext.Date.MONTH, -6);
					Ext.getCmp('id_end_'+config.name+'_'+config.actionFlag).add(new Date(),Ext.Date.DAY, 0);				
				}},
				'-',
				{  text: '1년', handler : function() {
					Ext.getCmp('id_stt_'+config.name+'_'+config.actionFlag).add(new Date(),Ext.Date.YEAR, -1);
					Ext.getCmp('id_end_'+config.name+'_'+config.actionFlag).add(new Date(),Ext.Date.DAY, 0);				
				}},
				{  text: '2년', handler : function() {
					Ext.getCmp('id_stt_'+config.name+'_'+config.actionFlag).add(new Date(),Ext.Date.YEAR, -2);
					Ext.getCmp('id_end_'+config.name+'_'+config.actionFlag).add(new Date(),Ext.Date.DAY, 0);				
				}},
				{  text: '3년', handler : function() {
					Ext.getCmp('id_stt_'+config.name+'_'+config.actionFlag).add(new Date(),Ext.Date.YEAR, -3);
					Ext.getCmp('id_end_'+config.name+'_'+config.actionFlag).add(new Date(),Ext.Date.DAY, 0);				
				}},'-',
				{  text: '시작일 ~ 종료일 날짜 계산', handler : function() {
					var sttDt = Ext.getCmp('id_stt_'+config.name+'_'+config.actionFlag).getValue();
					var endDt = Ext.getCmp('id_end_'+config.name+'_'+config.actionFlag).getValue();
					var diff = endDt - sttDt ;
					var divideBy = { 
						w : 604800000, // week
			        	d : 86400000, // day
			        	h : 3600000, // hour
			        	m : 60000,  // minute
			        	s : 1000   // second
			        };
					alert(diff + ":"+ (diff/ divideBy[d]) ); //  diff/ divideBy[datepart] -> days, 
				}}
			]
		});
					
		this.callParent(arguments);
    },
    initComponent: function() {
    	var me = this;
    	me.callParent();
    }   
});