/**
 * Grid Parameter를 form형태로 전송할수 일도록 생성.
 * 
 */
Ext.define('Ext.data.writer.SinglePost', {
    extend: 'Ext.data.writer.Writer',
    alternateClassName: 'Ext.data.SinglePostWriter',
    alias: 'writer.singlepost',
    writeRecords: function(request, data) {
    	if(data && data[0]){
        	var keys = [];
            for(var key in data[0]){
            	keys.push(key);
            }

            for(var i=0;i<keys.length;i++){
            	request.params[keys[i]] = [];
            	for(var j=0;j<data.length;j++){
            		request.params[keys[i]].push((data[j])[keys[i]]);
            	}
            }
        }
        for( var x in this.params ) {
        	request.params[x] = request.params[x]||[];
            request.params[x].push(this.params[x]);
        }
        
        return request;
    },
    setParams : function(params) {
    	if( typeof params  === 'object' ) {
    		Ext.apply(this.params, params);
    	} else if( typeof params  === 'string' ) {
    		var form = Ext.getCmp(params);
    		
    		if( form && form.getForm() ) {
    			Ext.apply(this.params,form.getForm().getFieldValues(false));
    		}
    	}
    }
});


Ext.define('Ext.data.writer.UxJson', {
    extend:  Ext.data.writer.Json ,
    alternateClassName: 'Ext.data.UxJsonWriter',
    alias: 'writer.ux_json',
    
    writeRecords: function(request, data) {
        var root = this.root;
        var isCUDMode = false;
        
        if (this.expandData) {
            data = this.getExpandedData(data);
        }
        
    	if(data && data[0]){
        	var keys = [];
            for(var key in data[0]){
            	keys.push(key);
            }

            for(var i=0;i<keys.length;i++){
            	request.params[keys[i]] = [];
            	for(var j=0;j<data.length;j++){
                	if( keys[i] == 'mode' && !isCUDMode ) {
                		isCUDMode =  (((data[j])[keys[i]] == 'insert' || (data[j])[keys[i]] == 'update'));
                	}
            		request.params[keys[i]].push((data[j])[keys[i]]);
            	}
            }
        }
        for( var x in this.params ) {
        	request.params[x] = request.params[x]||[];
            request.params[x].push(this.params[x]);
        }
        if( isCUDMode ) {
        	return request;
        } else {
        	request.params = {};
        	request.jsonData = {};
        	return request;
        }
    },
    setParams : function(params) {
    	if( typeof params  === 'object' ) {
    		Ext.apply(this.params, params);
    	} else if( typeof params  === 'string' ) {
    		var form = Ext.getCmp(params);
    		
    		if( form && form.getForm() ) {
    			Ext.apply(this.params,form.getForm().getFieldValues(false));
    		}
    	}
    }
});
