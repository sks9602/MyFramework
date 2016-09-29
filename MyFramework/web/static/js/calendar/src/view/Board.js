/**
 * @class Ext.calendar.view.Month
 * @extends Ext.calendar.CalendarView
 * <p>Displays a calendar view by month. This class does not usually need ot be used directly as you can
 * use a {@link Ext.calendar.CalendarPanel CalendarPanel} to manage multiple calendar views at once including
 * the month view.</p>
 * @constructor
 * @param {Object} config The config object
 */
Ext.define('Ext.calendar.view.Board', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.ux_board',

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
        	}},
	        {text: "Calendar", width: 120, sortable: true, dataIndex: 'CalendarId',  align: 'center'
        		, renderer: function(_v, _p, _r) { 
        			for( var x in Ext.calendar.data.Calendars.getData()["calendars"] ) {
        				if( Ext.calendar.data.Calendars.getData()["calendars"][x]["id"] == _v) {
        					return Ext.calendar.data.Calendars.getData()["calendars"][x]["title"];
        				}
        			}
        		} 
	        },
	        {text: "Title", flex: 1, sortable: true, dataIndex: 'Title'},
	        {text: "Period", width: 120, sortable: true, dataIndex: 'lastChange' ,  align: 'right'
	        		, renderer: function(_v, _p, _r) { 
	        			return Ext.calendar.util.Date.diffDays(_r.data['StartDate'], _r.data['EndDate']) + ' day(s)'; 
	        		} 
	        }
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
