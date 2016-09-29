/**
 * 단어수 확인..
 */
Ext.define('Ext.ux.plugins.CouterCheck', {
    extend: 'Ext.util.Observable',
    alias: 'plugin.counter',
    
    constructor: function (config)
    {
        Ext.apply(this, config || {});
        this.callParent(arguments);
    },

    init: function (field)
    {
        field.on({
            scope: field,
            keyup: this.updateCounter,
            focus: this.updateCounter,
            change : this.updateCounter
        });
        if (!field.rendered) {
            field.on('afterrender', this.handleAfterRender, field);
        } else {
            this.handleAfterRender(field);
        }
    },

    handleAfterRender: function(field, plugin)
    {
    	
	    field.counterEl = field.labelEl.insertSibling({ // appendChild  insertAfter
	    	tag: 'div',
	    	style: 'width: 100%;text-align:center;margin-right:10px;',
	    	html: '[0/'+ field.maxLength +'자]'
	    },  'after');
	    field.enableKeyEvents = true;
    },

    updateCounter: function(textField)
    {
    	textField.counterEl.update( '['+ textField.getLength() +'/'+textField.maxLength +'자]' ); // textField.getValue().length
    }
    
});