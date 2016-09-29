/**
 * @class Ext.calendar.view.Month
 * @extends Ext.calendar.CalendarView
 * <p>Displays a calendar view by month. This class does not usually need ot be used directly as you can
 * use a {@link Ext.calendar.CalendarPanel CalendarPanel} to manage multiple calendar views at once including
 * the month view.</p>
 * @constructor
 * @param {Object} config The config object
 */
Ext.define('Ext.calendar.view.List', {
    extend: 'Ext.calendar.view.Month',
    alias: 'widget.listview',

    requires: [
        'Ext.data.ArrayStore'
    ],

    // private
    initComponent: function() {

    	
        this.callParent(arguments);
        
        

    },

    // private
    renderTemplate: function() {

    	Ext.create('Ext.grid.Panel', {
            store: Ext.create('Ext.data.ArrayStore', {
                model: Ext.define('Company', {
                    extend: 'Ext.data.Model',
                    fields: [
                        {name: 'company'},
                        {name: 'price', type: 'float'},
                        {name: 'change', type: 'float'},
                        {name: 'pctChange', type: 'float'},
                        {name: 'lastChange', type: 'date', dateFormat: 'n/j h:ia'},
                        {name: 'industry'},
                        {name: 'desc'}
                     ]
                }),
                data: [
                       ['3m Co',71.72,0.02,0.03,'9/1 12:00am', 'Manufacturing'],
                       ['Alcoa Inc',29.01,0.42,1.47,'9/1 12:00am', 'Manufacturing'],
                       ['Altria Group Inc',83.81,0.28,0.34,'9/1 12:00am', 'Manufacturing'],
                       ['American Express Company',52.55,0.01,0.02,'9/1 12:00am', 'Finance'],
                       ['American International Group, Inc.',64.13,0.31,0.49,'9/1 12:00am', 'Services'],
                       ['AT&T Inc.',31.61,-0.48,-1.54,'9/1 12:00am', 'Services'],
                       ['Boeing Co.',75.43,0.53,0.71,'9/1 12:00am', 'Manufacturing'],
                       ['Caterpillar Inc.',67.27,0.92,1.39,'9/1 12:00am', 'Services'],
                       ['Citigroup, Inc.',49.37,0.02,0.04,'9/1 12:00am', 'Finance'],
                       ['E.I. du Pont de Nemours and Company',40.48,0.51,1.28,'9/1 12:00am', 'Manufacturing'],
                       ['Exxon Mobil Corp',68.1,-0.43,-0.64,'9/1 12:00am', 'Manufacturing'],
                       ['General Electric Company',34.14,-0.08,-0.23,'9/1 12:00am', 'Manufacturing'],
                       ['General Motors Corporation',30.27,1.09,3.74,'9/1 12:00am', 'Automotive'],
                       ['Hewlett-Packard Co.',36.53,-0.03,-0.08,'9/1 12:00am', 'Computer'],
                       ['Honeywell Intl Inc',38.77,0.05,0.13,'9/1 12:00am', 'Manufacturing'],
                       ['Intel Corporation',19.88,0.31,1.58,'9/1 12:00am', 'Computer'],
                       ['International Business Machines',81.41,0.44,0.54,'9/1 12:00am', 'Computer'],
                       ['Johnson & Johnson',64.72,0.06,0.09,'9/1 12:00am', 'Medical'],
                       ['JP Morgan & Chase & Co',45.73,0.07,0.15,'9/1 12:00am', 'Finance'],
                       ['McDonald\'s Corporation',36.76,0.86,2.40,'9/1 12:00am', 'Food'],
                       ['Merck & Co., Inc.',40.96,0.41,1.01,'9/1 12:00am', 'Medical'],
                       ['Microsoft Corporation',25.84,0.14,0.54,'9/1 12:00am', 'Computer'],
                       ['Pfizer Inc',27.96,0.4,1.45,'9/1 12:00am', 'Medical'],
                       ['The Coca-Cola Company',45.07,0.26,0.58,'9/1 12:00am', 'Food'],
                       ['The Home Depot, Inc.',34.64,0.35,1.02,'9/1 12:00am', 'Retail'],
                       ['The Procter & Gamble Company',61.91,0.01,0.02,'9/1 12:00am', 'Manufacturing'],
                       ['United Technologies Corporation',63.26,0.55,0.88,'9/1 12:00am', 'Computer'],
                       ['Verizon Communications',35.57,0.39,1.11,'9/1 12:00am', 'Services'],
                       ['Wal-Mart Stores, Inc.',45.45,0.73,1.63,'9/1 12:00am', 'Retail'],
                       ['Walt Disney Company (The) (Holding Company)',29.89,0.24,0.81,'9/1 12:00am', 'Services']
                   ]
            }),
            columns: [
                Ext.create('Ext.grid.RowNumberer'),
                {text: "Company", flex: 1, sortable: true, dataIndex: 'company'},
                {text: "Price", width: 120, sortable: true, renderer: Ext.util.Format.usMoney, dataIndex: 'price'},
                {text: "Change", width: 120, sortable: true, dataIndex: 'change'},
                {text: "% Change", width: 120, sortable: true, dataIndex: 'pctChange'},
                {text: "Last Updated", width: 120, sortable: true, renderer: Ext.util.Format.dateRenderer('m/d/Y'), dataIndex: 'lastChange'}
            ],
            height: 200,
            dockedItems: [{xtype: 'toolbar', dock :'top', flex : 1, border : true, 
            	items : [{ xtype : 'button', text : 'Add Task' }]
            }],
            columnLines: true
    	});
    },
    forceSize : function() {
    	
    },
    getDaySize: function(contentOnly) {
    	
    },
    getMaxEventsPerDay: function() {
    },
    getDayAt: function(x, y) {
    	
    },
    // private
    renderItems: function() {
    	
    }

});
