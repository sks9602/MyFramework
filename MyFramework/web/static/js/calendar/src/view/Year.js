/**
 * @class Ext.calendar.view.Month
 * @extends Ext.calendar.CalendarView
 * <p>Displays a calendar view by month. This class does not usually need ot be used directly as you can
 * use a {@link Ext.calendar.CalendarPanel CalendarPanel} to manage multiple calendar views at once including
 * the month view.</p>
 * @constructor
 * @param {Object} config The config object
 */
Ext.define('Ext.calendar.view.Year', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.year',

    requires: [
        'Ext.data.ArrayStore'
    ],
    // private
    initComponent: function() {
        this.setStartDate(this.startDate || new Date() );

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

    },
    
    setViewBounds: function(startDate) {
    	
    	var startMonth = Ext.calendar.data.Events.toDate(Ext.Date.format(Ext.calendar.util.Date.add( this.startDate || new Date() , {months: -3 }), 'Ym')+"01");
    	
    	this.viewStart = startMonth;
    	this.viewEnd = Ext.calendar.util.Date.add( startMonth , {months: 7  ,  days : -1 });
    },
    setStartDate: function(start, refresh) {    	
        this.startDate = Ext.Date.clearTime(start);
        
        this.setViewBounds(start);
        
        this.store.load({
            params: {
                start: Ext.Date.format(this.viewStart, 'Ymd'), //'m-d-Y'
                end: Ext.Date.format(this.viewEnd, 'Ymd') //'m-d-Y'
            }
        });
    	/** 휴일조회 **/
        this.holidayStore.load({
            params: {
                start: Ext.Date.format(this.viewStart, 'Ymd'), //'m-d-Y'
                end: Ext.Date.format(this.viewEnd, 'Ymd') //'m-d-Y'
            }
        });
        /** 휴일조회 **/
        
        this.fireEvent('datechange', this, this.startDate, this.viewStart, this.viewEnd);
    },
    
    // inherited docs
    moveNext: function() {
        return this.moveMonths(1);
    },

    // inherited docs
    movePrev: function() {
        return this.moveMonths(- 1);
    },
    moveMonths: function(value, noRefresh) {
        return this.moveTo(Ext.calendar.util.Date.add(this.startDate, {months: value}), noRefresh);
    },
    moveTo: function(dt, noRefresh) {
        if (Ext.isDate(dt)) {
            this.setStartDate(dt);
            
            return this.startDate;
        }
        return dt;
    },
    // private
    getViewBounds: function() {
        return {
            start: this.viewStart,
            end: this.viewEnd
        };
    },
    getStartDate: function() {
        return this.startDate;
    }
});
