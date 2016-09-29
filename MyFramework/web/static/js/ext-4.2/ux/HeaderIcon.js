Ext.define('IconLabel', {
    extend:'Ext.form.Label',
    alias: 'widget.iconlabel',
    iconCls: null,
    constructor: function(config) {
		var me = this;
        me.componentCls= config.iconCls ? config.iconCls + ' ' + 'x-label-icon' : null
        me.callParent( arguments );
    }
});


Ext.define('Ext.ux.panel.header.HeaderIcon', {
	extend: 'Ext.AbstractPlugin',
	alias: 'plugin.headericon',
	alternateClassName: 'Ext.ux.PanelHeaderIcon',
 
	iconCls: '',
	index: undefined,
 
	headerButtons: [],
 
	init: function(panel) {
		this.panel = panel;
		this.callParent();
		panel.on('render', this.onAddIcons, this, {single: true});
	},
 
	onAddIcons :function () {
		if (this.panel.getHeader) {
			this.header = this.panel.getHeader();
		} else if (this.panel.getOwnerHeaderCt) {
			this.header = this.panel.getOwnerHeaderCt();
		}
		this.header.insert(this.index || this.header.items.length, this.headerButtons);
	}
});