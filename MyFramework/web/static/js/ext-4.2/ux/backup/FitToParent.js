Ext.define('Ext.ux.FitToParent', {
	alias : 'plugin.fittoparent',
	extend : 'Ext.AbstractPlugin',
	width : null,
	heigth : null,
	/**
	 * @cfg {HTMLElement/Ext.Element/String} parent The element to fit the
	 *      component size to (defaults to the element the component is rendered
	 *      to).
	 */
	/**
	 * @cfg {Boolean} fitWidth If the plugin should fit the width of the
	 *      component to the parent element (default <tt>true</tt>).
	 */
	fitWidth : true,
	/**
	 * @cfg {Boolean} fitHeight If the plugin should fit the height of the
	 *      component to the parent element (default <tt>true</tt>).
	 */
	fitHeight : true,
	/**
	 * @cfg {Boolean} offsets Decreases the final size with [width, height]
	 *      (default <tt>[0, 0]</tt>).
	 */
	offsets : [ 0, 0 ],
	/**
	 * @constructor
	 * @param {HTMLElement/Ext.Element/String/Object}
	 *            config The parent element or configuration options.
	 * @ptype fittoparent
	 */
	constructor : function(config) {
		config = config || {};
		if (config.tagName || config.dom || Ext.isString(config)) {
			config = {
				parent : config
			};
		}
		Ext.apply(this, config);
	},

	init : function(grid) {
		grid.on('render', this.onRender, this, {
			single : true
		});
	},

	onRender : function(grid) {
		var me = this;
		me.component = grid;
		me.parent = Ext.get(me.parent || grid.getPositionEl().dom.parentNode);
		if (grid.doLayout) {
			grid.monitorResize = true;
			grid.doLayout = Ext.Function.createInterceptor(grid.doLayout,
					me.fitSize, me);
		} else {
			me.fitSize();
			// Ext.EventManager.onWindowResize(me.fitSize, me);
		}
		// Ext.EventManager.onDocumentReady( me.fitSize, me );
		// Ext.EventManager.onWindowResize(me.fitSize, me);
	},

	fitSize : function() {
		var me = this, pos = me.component.getPosition(false), size = Ext
				.getBody().getViewSize(false);

		// verify with getStyleSize for IE
		/*
		 * if (Ext.isIE && Ext.isStrict && (size.width == 0 || size.height ==
		 * 0)) { size = me.parent.getStyleSize(); }
		 */

		me.component.setSize(me.fitWidth ? size.width - pos[0] - me.offsets[0]
				: undefined, me.fitHeight ? size.height - pos[1]
				- me.offsets[1] : undefined); // size.

		// alert( me.component.getSize().width + "::" +
		// me.component.getSize().height);
		return true;
	}
});
