/*
 * A simple reusable store that loads static calendar field definitions into memory
 * and can be bound to the CalendarCombo widget and used for calendar color selection.
 */
Ext.define('Ext.calendar.data.MemoryHolidayCalendarStore', {
    extend: 'Ext.data.Store',
    model: 'Ext.calendar.data.HolidayModel',
    
    requires: [
        'Ext.data.proxy.Memory',
        'Ext.data.reader.Json',
        'Ext.data.writer.Json',
        'Ext.calendar.data.HolidayModel',
        'Ext.calendar.data.HolidayMappings'
    ],
    
    proxy: {
        type: 'memory',
        reader: {
            type: 'json',
            root: 'holidays'
        },
        writer: {
            type: 'json'
        }
    },

    autoLoad: true,
 
    // private
    constructor: function(config){
        this.callParent(arguments);

        var me = this,
        calendarData = Ext.calendar.data;

        var me = this,
        calendarData = Ext.calendar.data;

        this.sorters = this.sorters || [{
            property: Ext.calendar.data.HolidayMappings.Title.name,
            direction: 'ASC'
        }];
        
        me.idProperty = me.idProperty || calendarData.HolidayMappings.HolidayId.name || 'id';
        me.fields = calendarData.HolidayModel.prototype.fields.getRange();
    }
});