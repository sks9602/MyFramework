//@define Ext.calendar.data.CalendarMappings
/**
 * @class Ext.calendar.data.CalendarMappings
 * @extends Object
 * A simple object that provides the field definitions for Calendar records so that they can be easily overridden.
 */
Ext.ns('Ext.calendar.data');

Ext.calendar.data.HolidayMappings = {
	HolidayId: {
        name:    'date',
        mapping: 'date',
        type:    'string'
    },
    Title: {
        name:    'title',
        mapping: 'title',
        type:    'string'
    },
    isHoliday: {
        name:    'isHoliday',
        mapping: 'isHoliday',
        type:    'boolean'
    },
    lunarYear: {
        name:    'lunarYear',
        mapping: 'lunarYear',
        type:    'string'
    },
    lunarDate: {
        name:    'lunarDate',
        mapping: 'lunarDate',
        type:    'string'
    }
};