
function hoCustomMessage(_title, _msg, _buttons) {

	new Ext.window.MessageBox({
	    buttons : _buttons
	}).show({
	    title : _title,
	    msg : _msg,
	    icon : Ext.MessageBox.QUESTION ,
	    buttonText : {
	        ok : "OK",
	        cancel : "Cancel"
	    } 
	});
}


function hoConfirm(msg, fn, scope, animateTarget) {
	Ext.MessageBox.show({
        title:'Confirm',
        msg: msg||'Save Changes?',
        buttons: Ext.MessageBox.YESNO,
        fn: fn,
        animateTarget: animateTarget,
        icon: Ext.MessageBox.QUESTION
    });
	/*
	if( typeof fn === 'function' ) {
		
		Ext.MessageBox.confirm('Confirm', msg, fn, scope );
	}
	*/
}

function hoAlert(msg, fn, time, animateTarget, component) {
	var hoMsg = Ext.MessageBox, t=0, tgt;

	// 경고 Component 확인
	// 경고 Component가 없고, animateTarget이 있을 경우
	if( (component == null || component == undefined) && animateTarget ) {
		if( typeof(animateTarget)  === 'string'  ) {
			tgt = animateTarget;
			component = Ext.getCmp(animateTarget);
		} else if( typeof(animateTarget)  === 'object'  ) {
			component = animateTarget;
		}
	} 
	// 경고 Component가 string(id)일 경우
	else if( typeof(component)  === 'string') {
		component = Ext.getCmp(component);
	}

	// 경고 Component가 있을 경우
	if( component ) {  // Ext.getCmp();
		tgt = component.id;
		try {
			component.el.frame('red', 1, 0.2).frame('red', 1, 0.2); 
		} catch(e) {
			
		}
	}

	hoMsg.show({
        title: '경고',
        msg: msg ,
        buttons: Ext.MessageBox.OK,
        fn: fn ? fn : function() {} ,
        icon: Ext.MessageBox.WARNING
        // , animateTarget : tgt // animateTarget 
    });

	if( time ) {
		/*
		var runner = new Ext.util.TaskRunner(),
			task = runner.start({
				run: function() {
					hoMsg.updateText(msg + "<br/><br/>["+ ((time-(t*1000))/1000) +"초 후에 사라집니다.]")
					t++;
					if( t*1000 > time ) {
						runner.stopAll();
						t = 0;
					}
				},
				interval: 1000
	    });
		
		hoMsg.on('close', function() {runner.stopAll();} );
		*/

		Ext.Function.defer(function() {
			hoMsg.hide();
			
		}, time);
	}
	// Ext.MessageBox.alert('Status', msg, fn ? fn : function() {} );
}

function hoError(msg, fn) {
	Ext.MessageBox.show({
        title: '오류',
        msg: msg ,
        scope : this,
        buttons: Ext.MessageBox.OK,
        fn: fn ? fn : function() {} ,
        icon: Ext.MessageBox.ERROR
    });
}

function hoMessage(msg, fn) {
	Ext.MessageBox.show({
        title: '알림',
        msg: msg ,
        buttons: Ext.MessageBox.OK,
        fn: fn ? fn : function() {} ,
        icon: Ext.MessageBox.INFO
    });
}
