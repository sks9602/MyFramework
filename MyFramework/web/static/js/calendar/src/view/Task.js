/**
 * @class Ext.calendar.view.Month
 * @extends Ext.calendar.CalendarView
 * <p>Displays a calendar view by month. This class does not usually need ot be used directly as you can
 * use a {@link Ext.calendar.CalendarPanel CalendarPanel} to manage multiple calendar views at once including
 * the month view.</p>
 * @constructor
 * @param {Object} config The config object
 */
Ext.define('Ext.calendar.view.Task', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.ux_task',

    requires: [
        'Ext.data.ArrayStore'
    ],
    isCalendar : false,
    // private
    initComponent: function() {

    	var me = this;
    	
	    me.columns = [
	        Ext.create('Ext.grid.RowNumberer'),
	        {text: "Start Day", width: 120, sortable: true, renderer: Ext.util.Format.dateRenderer('m/d/Y'), dataIndex: 'StartDate'},
	        {text: "Start Time", width: 120, sortable: true, dataIndex: 'StartDate', renderer: function(_v, _p, _r) {
	        		if( _r.data['IsAllDay'] ) {
	        			return "";
	        		} else {
	        			return Ext.util.Format.date(_v, 'h:i a');
	        		}
	        	}
	        },
	        {text: "End Day", width: 120, sortable: true, renderer: Ext.util.Format.dateRenderer('m/d/Y'), dataIndex: 'EndDate'},
	        {text: "End Time", width: 120, sortable: true, dataIndex: 'EndDate', renderer: function(_v, _p, _r) {
        		if( _r.data['IsAllDay'] ) {
        			return "";
        		} else {
        			return Ext.util.Format.date(_v, 'h:i a');
        		}
        	}}
	    ];
	    me.viewConfig = {
    		listeners: {
    			itemclick : function(view, rec, node, index, e) {
    				this.fireEvent('eventclick', this, rec, e.getTarget());
    				// this.showEditWindow(rec);
    				// this.fireEvent('eventclick', this, rec, e.getTarget());
    			},
                scope: this
    		}
	    };
	    me.columnLines = true;
    	
        this.callParent(arguments);

    }
});
