/**
 * Class that checks if user is idle.
 */
Ext.define('Utils.IdleTimer', {
    alias: 'utils.idle_timer',
    mixins: {
        observable: 'Ext.util.Observable'
    },

    config: {
        //the amount of time (ms) before the user is considered idle
        timeout: 30000
    },

    idle: false,           // indicates if the user is idle
    tId: -1,               // timeout ID
    enabled: false,        // indicates if the idle timer is enabled

    constructor: function(config){

        config = config || {};

        var me = this;
        me.addEvents(
            'start',
            'stop',
            'idle',
            'active'
        );

        me.mixins.observable.constructor.call(me);

        if (config.listeners) {
            me.on(config.listeners);
            delete config.listeners;
        }

        me.initConfig(config);
    },

    destroy: function(){
        this.clearListeners();
    },

    isRunning: function(){
        return this.enabled;
    },

    /**
     * Indicates if the user is idle or not.
     * @return {boolean} True if the user is idle, false if not.
     */
    isIdle: function(){
        return this.idle;
    },

    /**
     * Starts the idle timer. This adds appropriate event handlers
     * and starts the first timeout.
     * @param {int} timeout (Optional) A new value for the timeout period in ms.
     * @return {void}
     * @static
     */
    start: function(timeout){

        var me = this;

        me.enabled = true;
        me.idle = false;

        if (Ext.typeOf(timeout) == "number"){
            me.setTimeout(timeout);
        }

        //assign appropriate event handlers
        Ext.getDoc().on({
            mousemove: me.handleUserEvent,
            keydown: me.handleUserEvent,
            scope: me
        });

        //set a timeout to toggle state
        me.tId = Ext.Function.defer(me.toggleIdleState, me.getTimeout(), me);
    },

    /**
     * Stops the idle timer. This removes appropriate event handlers
     * and cancels any pending timeouts.
     * @return {void}
     */
    stop: function(){
        var me = this;

        me.enabled = false;
        clearTimeout(me.tId);

        //detach the event handlers
        Ext.getDoc().un({
            mousemove: me.handleUserEvent,
            keydown: me.handleUserEvent
        });
    },


    handleUserEvent: function(event){
        var me = this;

        clearTimeout(me.tId);

        if (me.enabled){

            if (me.idle) {

                // Bugfix: We have to skip several mousemove events because when we
                // show idle screen, somehouse mousemove event emitted.
                if (event.type == 'mousemove' && me.activeSwitchCounter < 5) {
                    me.activeSwitchCounter++;
                    return;
                }
                me.activeSwitchCounter = 0;

                me.toggleIdleState();
            }

            me.tId = Ext.Function.defer(me.toggleIdleState, me.getTimeout(), me);
        }
    },

    toggleIdleState: function(){
        this.idle = !this.idle;
        this.fireEvent(this.idle ? 'idle' : 'active');
    }
});

/*
var timer = Ext.create('Utils.IdleTimer', {
    timeout: 3000,
    listeners: {
        idle: function(){
            console.log('Application went into idle state');
        },
        active: function(){
            console.log('Application went into active state');
        }
    }
});

timer.start();
*/

Ext.override(Ext.form.BasicForm, {
	findInvalid: function() {
		var result = [], me = this;
		me.getFields().filterBy(function(field) {
			if( !field.validate() ) {
				field.el.frame('red', 1, 0.2).frame('red', 1, 0.2);
				result.push( field );
			}
        });
		return result;
	},
    getValues: function(asString, dirtyOnly, includeEmptyText, useDataValues) {
        var values  = {},
            fields  = this.getFields().items,
            f,
            fLen    = fields.length,
            isArray = Ext.isArray,
            field, data, val, bucket, name;
        
        for (f = 0; f < fLen; f++) {
            field = fields[f];
           
            if (!dirtyOnly || field.isDirty()) {  // DateField에서.. getSubmitValue()안되어서. 수정.. "&&!field.dateField" 추가됨..
                data = field[useDataValues&&!field.dateField ? 'getModelData' : 'getSubmitData'](includeEmptyText);

                if (Ext.isObject(data)) {
                    for (name in data) {
                        if (data.hasOwnProperty(name)) {
                            val = data[name];

                            if (includeEmptyText && val === '') {
                                val = field.emptyText || '';
                            }

                            if (values.hasOwnProperty(name)) {
                                bucket = values[name];

                                if (!isArray(bucket)) {
                                    bucket = values[name] = [bucket];
                                }

                                if (isArray(val)) {
                                    values[name] = bucket.concat(val);
                                } else {
                                    bucket.push(val);
                                }
                            } else {
                                values[name] = val;
                            }
                        }
                    }
                }
            }
        }

        if (asString) {
            values = Ext.Object.toQueryString(values);
        }
        return values;
    }
	/*,
	getFieldValues : function(dirtyOnly){
		var o = {}, n, key, val;
		this.getFields().each(function(f) {
			if (dirtyOnly !== true || f.isDirty()) {
				n = f.getName();
				key = o[n];
				val = f.getValue();
				if(Ext.isDefined(key)){
					if(Ext.isArray(key)){
						o[n].push(val);
					}else{
						var _val = o[n];
						o[n] = [];
						o[n].push(_val);
						o[n].push(val);
                       // o[n] = [key, val];
					}
				}else{
					o[n] = val;
				}
			}
		});
		return o;
	}*/
});

/**
 * Form Panel 전송시 Form에 포함된 Grid의 정보 까지 포함하여 submit
 */
Ext.define('Ext.ux.FormPanel', {
    alias: 'widget.formPanel',
    extend: 'Ext.form.Panel',
    autoSubmit : false,
    autoSubmitInterval : 2000,
    /*
    listeners : {
    	collapse : function(p, e) {
    		p.getDockedComponent( p.id + '_buttonToolbar' ).setVisible(true);
    	}
    },
    */
    constructor: function(config) {
    	this.callParent(arguments);
    },
    initComponent: function() {
    	var me = this;
    	me.callParent();
    },
    loadRecord : function(record, ignoreObjectNames) {
    	var me = this;
    	
    	if( record.get("totalCount") < 0 && record.get("message") ) {
    		hoAlert('연결이 종료 되었습니다.', fs_goLoginPage );
    	}
    	return me.callParent(arguments);
    	
    	/*
    	if( ignoreObjectNames ) {
            this._record = record;
            return this.setValuesHasIgnore(record.getData(), ignoreObjectNames);   		
    	} else {
    		
    	}
    	*/
    },
    setValuesHasIgnore: function(values, ignoreObjectNames) {
        var me = this,
            v, vLen, val, field;

        function setVal(fieldId, val) {
            var field = me.findField(fieldId);
            if (field) {
                field.setValue(val);
                if (me.trackResetOnLoad) {
                    field.resetOriginalValue();
                }
            }
        }

        Ext.suspendLayouts();
        
        if (Ext.isArray(values)) {
            
            vLen = values.length;

            for (v = 0; v < vLen; v++) {
                val = values[v];

                setVal(val.id, val.value);
            }
        } else {
            
            Ext.iterate(values, setVal);
        }
        Ext.resumeLayouts(true);
        return this;
    },
    getField : function(name) {
    	var me = this, field = null;
    	
    	if( name && me.query('[id*='+name+']') ) {
    		field = me.query('[id*='+name+']')[0];
    	}
    	return field;
    },
    getFields : function(name) {
    	var me = this, fields = null;
    	
    	if( name && me.query('[id*='+name+']') ) {
    		fields = me.query('[id*='+name+']');
    	}
    	return fields;
    },
    getFieldValue : function(name) {
    	var me = this, field = null;
    	
    	if( name && me.query('[id*='+name+']') ) {
    		field = me.query('[id*='+name+']')[0];
    	}
    	return field.getValue();
    },
    setFieldChangeStatus : function( field ) {
    	var me = this;
    	if( me.autoSubmit ) {
	    	if( this.timerId ) {
	    		clearInterval( this.timerId );
	    	}
	    	this.timerId = setTimeout(function(){
	    		if( me.down('toolbar').down('#id_auto_save_msg') ) {
	    			var saveMsg = me.down('toolbar').down('#id_auto_save_msg');
	        		saveMsg.setText('# Saving draft...');
	        		
	        		Ext.defer(function(){
						saveMsg.setText('Draft auto-saved at ' + Ext.Date.format(new Date(), 'g:i:s A'));
			        }, 2000);
	    		}
	    		
	    		me.submit({ isForceSave : true })
	    		
	    		clearInterval( me.timerId );
	    		
	        }, this.autoSubmitInterval );
    	}
    },
    submit: function(options) {
    		
    	var me = this, 
    		isForceSave = options&&options['isForceSave'],   // 오류와 상관없이 강제소 SUBMIT
    		msgTxt = options&&options['msgConfirm'], 
    		errorsNote = options&&options['errorsNote'] ;
    	
    	// Form을 강제로 저장하는 경우
    	if( isForceSave ) {
	    	var grid, store, records, params = {}, totalCnt = 0, idx=0, pActionFlag = '';
	    	
	    	// Grid 찾기
	    	for( var i=0; i < me.query('grid').length ; i++ ) {
	    		grid = me.query('grid')[i];
	    		store = grid.getStore();

	    		if( grid.submitModified ) {
	    			records = store.getModifiedRecords();
	    		} else {
	    			records = store.getRange(0, store.getCount( ) );
	    		}
	    		
	    		if( !records || records.length == 0 ) {
	    			continue;
	    		}
	    		var keys = [];

	    		for(var key =0; key< records[0].fields.length; key++){
	    			keys.push(records[0].fields.get(key)['name'] );
	    		}
	    		for(var k=0;k < keys.length;k++){
	    			params[keys[k]] = params[keys[k]]||[];
	    			for(var j=0;j < records.length;j++){
	    				params[keys[k]].push(records[j].get(keys[k]));
	    			}
	    		}  
	    	}   
	    	pActionFlag =  me.query('[id*=P_ACTION_FLAG]')[0].getValue();
	    	if( options && options['p_action_flag'] && me.query('[id*=P_ACTION_FLAG]') ) {
	    		me.query('[id*=P_ACTION_FLAG]')[0].setValue(options['p_action_flag']);
	    	}
			me.form.submit(Ext.applyIf(options||{},{	    				
    			success : function(form, action) {
    				
    				if( options&&options['uxNotification'] ) {
	    				Ext.create('widget.uxNotification', { 
	    					title: '알림',
	    					position: 'br',
	    					manager: options['manager'],
	    					iconCls: 'ux-notification-icon-information', 
	    					autoCloseDelay: 3000,
	    					spacing: 20,
	    					html: '저장 되었습니다.'
	    					}).show(); 
    				}
    				
    				me.query('[id*=P_ACTION_FLAG]')[0].setValue(pActionFlag);
					// Ext.Msg.alert('Success', getResultMessageForm(form, action)); // action.result.message);
				},
				failure: function(form, action) {
					me.query('[id*=P_ACTION_FLAG]')[0].setValue(pActionFlag);
					// Ext.Msg.alert('Failure', getResultMessageForm(form, action)); // action.result.message);
				}, 
				clientValidation : false,
				params : params}) 
			); //, headers: {'Content-Type': 'application/json'}
    		
    	} 
    	// Form을 강제로 저장하지 않는 경우
    	else {
	    	if( me.isValid() ) {
		    	hoConfirm( msgTxt||'저장하시겠습니까?' , function(btn, text, opt) { 
		    		if( btn == 'yes' ) {
		    			var mBox = Ext.MessageBox;
		    			
		    	    	var grid, store, records, params = {}, totalCnt = 0, idx=0, pActionFlag = '';;
		    	    	
		    	    	// Grid 찾기
		    	    	for( var i=0; i < me.query('grid').length ; i++ ) {
		    	    		grid = me.query('grid')[i];
		    	    		store = grid.getStore();
		
		    	    		if( grid.submitModified ) {
		    	    			records = store.getModifiedRecords();
		    	    		} else {
		    	    			records = store.getRange(0, store.getCount( ) );
		    	    		}
		    	    		
		    	    		if( !records || records.length == 0 ) {
		    	    			continue;
		    	    		}
		    	    		var keys = [];
		
		    	    		for(var key =0; key< records[0].fields.length; key++){
		    	    			keys.push(records[0].fields.get(key)['name'] );
		    	    		}
		    	    		for(var k=0;k < keys.length;k++){
		    	    			params[keys[k]] = params[keys[k]]||[];
		    	    			for(var j=0;j < records.length;j++){
		    	    				params[keys[k]].push(records[j].get(keys[k]));
		    	    			}
		    	    		}  
		    	    	}   
		    	    	/*
		    	    	var toggle;
		    	    	
		    	    	for( var i=0; i < me.query('toggleslide').length ; i++ ) {
		    	    		toggle = me.query('toggleslide')[i];
		    	    		params[toggle.getName()].push(toggle.getValue());
		    	    	}
		    	    	*/
		    	    	pActionFlag =  me.query('[id*=P_ACTION_FLAG]')[0].getValue();
		    	    	if( options && options['p_action_flag'] && me.query('[id*=P_ACTION_FLAG]') ) {
		    	    		me.query('[id*=P_ACTION_FLAG]')[0].setValue(options['p_action_flag']);
		    	    	}
		    	    	
		    			me.form.submit(Ext.applyIf(options||{},{	
		    				// waitMsg: 'Saving...',
			    			success : function(form, action) {
				    			me.query('[id*=P_ACTION_FLAG]')[0].setValue(pActionFlag);
		    					Ext.Msg.alert('Success', getResultMessageForm(form, action)); // action.result.message);
		    				},
		    				failure: function(form, action) {
				    			me.query('[id*=P_ACTION_FLAG]')[0].setValue(pActionFlag);
		    					Ext.Msg.alert('Failure', getResultMessageForm(form, action)); // action.result.message);
		    				},
		    				params : params}) 
		    			); //, headers: {'Content-Type': 'application/json'}
		   			
		    			
		    	    	if( me.form.hasUpload() ) {
		    	    		mBox.show({
		    	    		    title: 'Please wait',
		    	    		    msg: 'File Uploading...',
		    	    		    progressText: 'Initializing...',
		    	    		    width:300,
		    	    		    progress:true,
		    	    		    closable:false
		    	    		});
		    	    		
		    	    		var runner = new Ext.util.TaskRunner(),
		    	    		task = runner.newTask({
		    	    		     run: function () {
		    	    		    		Ext.Ajax.request({
		    	    		        		url: '/s/example/file.do?p_action_flag=r_up_progress',
		    	    		        		method: 'POST',
		    	    		        		success : function(response,options){
		    	    		        			var percentage =  Ext.decode(response.responseText).percentage ;
		    	    		        			
		    	    		        			mBox.updateProgress(percentage/100, percentage+'% completed');
		    	    		        			
		    	    		        			// 완료시
		    	    		        			if( percentage >= 100 ) {
		    	    		        				try {
		    	    		        					task.stop();
		    	    		        					task.destroy();
		    	    		        				} catch(e) {
		    	    		        					alert('task.destroy' +e);
		    	    		        				}
		    	    		        				
		    	    		        				// 메시시 박스 사라지게..
		    	    		        				Ext.Function.defer(function() {
		    	    		        					
		    	    		        					Ext.MessageBox.hide();
		    	    		        					
		    	    		        					Ext.Ajax.request({
		    	    		        						url: '/s/example/file.do?p_action_flag=r_up_progress&destroy=true',
		    	    		        						method: 'POST'
		    	    		        					});
		    	    		        					
		    	    		        				}, 1000);
		    	    		        				
		    	    		        			} 
		    	    		        			//오류 발생시
		    	    		        			else if( percentage < 0 ) {
		    	    		        				try {
		    	    		        					task.stop();
		    	    		        					task.destroy();
		    	    		        				} catch(e) {
		    	    		        					alert('task.destroy' +e);
		    	    		        				}
		    	    		        				var msg = 'Canceled.';
		    	    		        				if( percentage != -1 ) {
		    	    		        					msg = 'Error.';
		    	    		        				}
		    	    		        				mBox.updateProgress(0, msg );
		    	    		        				// 메시시 박스 사라지게..
		    	    		        				Ext.Function.defer(function() {
		    	    		        					
		    	    		        					Ext.MessageBox.hide();
		    	    		        					
		    	    		        					Ext.Ajax.request({
		    	    		        						url: '/s/example/file.do?p_action_flag=r_up_progress&destroy=true',
		    	    		        						method: 'POST'
		    	    		        					});
		    	    		        					
		    	    		        				}, 1000);	
		    	    		        			}
		    	    		        		},
		    	    		        		failure: function(){
		    	    		        			
		    	    		        		},
		    	    		        		scope: this
		    	    		        	});
	
		    	    		     },
		    	    		     interval: 1000
		    	    		 });
	
		    	    		task.start();
		    	    		/*
			    			setTimeout(function(){
			    				try {
			    					mBox.hide();
			    				} catch(e) {
			    					
			    				}
			    				
			    	        }, 10000);
			    	        */
		    	    	} else { // --> waitMsg: 'Saving...',
			    			mBox.show({
				 		           msg: 'Saving your data, please wait...',
				 		           progressText: 'Saving...',
				 		           width:300,
				 		           wait:true,
				 		           waitConfig: {interval:200},
				 		           icon:'ext-mb-download', 
				 		           iconHeight: 50
				    			});
			    			
			    			setTimeout(function(){
			    				mBox.hide();
			    	        }, 3000);
		    	    		
		    	    	} 
	
		    		}
		    	}, me); // , me.getId()
	    	} else {
	    		if(errorsNote) {
	    			for( var x in errorsNote ) {
	    				fs_Frame(errorsNote[x].id , errorsNote[x].color);
	    				
	    				if( errorsNote[x].msg ) {
	    					if( errorsNote[x].time ) {
	    						hoAlert( errorsNote[x].msg, errorsNote[x].fn, errorsNote[x].time );
	    					} else {
	    						hoAlert( errorsNote[x].msg, errorsNote[x].fn);
	    					}
	    					
	    				}
	    			}
	    		}
	    		me.getForm().findInvalid();
	    	}
    	}
    }
});
