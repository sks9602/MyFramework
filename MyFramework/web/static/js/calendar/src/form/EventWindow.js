/**
 * @class Ext.calendar.form.EventWindow
 * @extends Ext.Window
 * <p>A custom window containing a basic edit form used for quick editing of events.</p>
 * <p>This window also provides custom events specific to the calendar so that other calendar components can be easily
 * notified when an event has been edited via this component.</p>
 * @constructor
 * @param {Object} config The config object
 */
Ext.define('Ext.calendar.form.EventWindow', {
    extend: 'Ext.window.Window',
    alias: 'widget.eventeditwindow',
    
    requires: [
        'Ext.form.Panel',
        'Ext.calendar.util.Date',
        'Ext.calendar.data.EventModel',
        'Ext.calendar.data.EventMappings'
    ],

    constructor: function(config) {
        var formPanelCfg = {
            xtype: 'form',
            fieldDefaults: {
                msgTarget: 'side',
                labelWidth: 65
            },
            frame: false,
            bodyStyle: 'background:transparent;padding:5px 10px 10px;',
            bodyBorder: false,
            border: false,
            items: [{
                itemId: 'title',
                name: Ext.calendar.data.EventMappings.Title.name,
                fieldLabel: 'Title',
                xtype: 'textfield',
                allowBlank: false,
                emptyText: 'Event Title',
                anchor: '100%'
            },
            {
                xtype: 'daterangefield',
                itemId: 'date-range',
                name: 'dates',
                anchor: '100%',
                fieldLabel: 'When'
            },
            {
                xtype: 'container',
                itemId: 'events-option',
                layout: {
                    type: 'hbox',
                    defaultMargins: { top: 0, right: 0, bottom: 0, left: 0 }
                },
                items: [{
                	fieldLabel: 'Options',
	                xtype: 'checkbox',
	                itemId: 'checkbox-ssd',
	                name: 'ssd',
	                boxLabel: 'Show Start Day &nbsp;'
                },{
	                xtype: 'checkbox',
	                itemId: 'checkbox-sdd',
	                name: 'sdd',
	                boxLabel: 'Show D-Day'
                }]
            }]
        };
    
        if (config.calendarStore) {
            this.calendarStore = config.calendarStore;
            delete config.calendarStore;
    
            formPanelCfg.items.push({
                xtype: 'calendarpicker',
                itemId: 'calendar',
                name: Ext.calendar.data.EventMappings.CalendarId.name,
                anchor: '100%',
                store: this.calendarStore
            });
        }

        formPanelCfg.items.push(
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
        }));
        
        this.callParent([Ext.apply({
            titleTextAdd: 'Add Event',
            titleTextEdit: 'Edit Event',
            width: 600,
            autocreate: true,
            border: true,
            closeAction: 'hide',
            modal: false,
            resizable: false,
            buttonAlign: 'left',
            savingMessage: 'Saving changes...',
            deletingMessage: 'Deleting event...',
            layout: 'fit',
    
            defaultFocus: 'title',
            onEsc: function(key, event) {
                        event.target.blur(); // Remove the focus to avoid doing the validity checks when the window is shown again.
                        this.onCancel();
                    },

            fbar: [{
                xtype: 'tbtext',
                text: '<a href="#" id="tblink">Edit Details...</a>'
            },
            '->',
            {
                itemId: 'delete-btn',
                text: 'Delete Event',
                disabled: false,
                handler: this.onDelete,
                scope: this,
                minWidth: 150,
                hideMode: 'offsets'
            },
            {
                text: 'Save',
                disabled: false,
                handler: this.onSave,
                scope: this
            },
            {
                text: 'Cancel',
                disabled: false,
                handler: this.onCancel,
                scope: this
            }],
            items: formPanelCfg
        },
        config)]);
    },

    // private
    newId: 10000,

    // private
    initComponent: function() {
        this.callParent();

        this.formPanel = this.items.items[0];

        this.addEvents({
            /**
             * @event eventadd
             * Fires after a new event is added
             * @param {Ext.calendar.form.EventWindow} this
             * @param {Ext.calendar.EventRecord} rec The new {@link Ext.calendar.EventRecord record} that was added
             */
            eventadd: true,
            /**
             * @event eventupdate
             * Fires after an existing event is updated
             * @param {Ext.calendar.form.EventWindow} this
             * @param {Ext.calendar.EventRecord} rec The new {@link Ext.calendar.EventRecord record} that was updated
             */
            eventupdate: true,
            /**
             * @event eventdelete
             * Fires after an event is deleted
             * @param {Ext.calendar.form.EventWindow} this
             * @param {Ext.calendar.EventRecord} rec The new {@link Ext.calendar.EventRecord record} that was deleted
             */
            eventdelete: true,
            /**
             * @event eventcancel
             * Fires after an event add/edit operation is canceled by the user and no store update took place
             * @param {Ext.calendar.form.EventWindow} this
             * @param {Ext.calendar.EventRecord} rec The new {@link Ext.calendar.EventRecord record} that was canceled
             */
            eventcancel: true,
            /**
             * @event editdetails
             * Fires when the user selects the option in this window to continue editing in the detailed edit form
             * (by default, an instance of {@link Ext.calendar.EventEditForm}. Handling code should hide this window
             * and transfer the current event record to the appropriate instance of the detailed form by showing it
             * and calling {@link Ext.calendar.EventEditForm#loadRecord loadRecord}.
             * @param {Ext.calendar.form.EventWindow} this
             * @param {Ext.calendar.EventRecord} rec The {@link Ext.calendar.EventRecord record} that is currently being edited
             */
            editdetails: true
        });
    },

    // private
    afterRender: function() {
        this.callParent();

        this.el.addCls('ext-cal-event-win');

        Ext.get('tblink').on('click', this.onEditDetailsClick, this);
        
        this.titleField = this.down('#title');
        this.dateRangeField = this.down('#date-range');
        this.calendarField = this.down('#calendar');
        this.deleteButton = this.down('#delete-btn');
    },
    
    // private
    onEditDetailsClick: function(e){
        e.stopEvent();
        this.updateRecord(this.activeRecord, true);
        this.fireEvent('editdetails', this, this.activeRecord, this.animateTarget);
    },

    /**
     * Shows the window, rendering it first if necessary, or activates it and brings it to front if hidden.
	 * @param {Ext.data.Record/Object} o Either a {@link Ext.data.Record} if showing the form
	 * for an existing event in edit mode, or a plain object containing a StartDate property (and 
	 * optionally an EndDate property) for showing the form in add mode. 
     * @param {String/Element} animateTarget (optional) The target element or id from which the window should
     * animate while opening (defaults to null with no animation)
     * @return {Ext.Window} this
     */
    show: function(o, animateTarget) {
        // Work around the CSS day cell height hack needed for initial render in IE8/strict:
        var me = this,
            anim = (Ext.isIE8 && Ext.isStrict) ? null: animateTarget,
            M = Ext.calendar.data.EventMappings;

        this.callParent([anim, function(){
            me.titleField.focus(true);
        }]);
        
        this.deleteButton[o.data && o.data[M.EventId.name] ? 'show': 'hide']();

        var rec,
        f = this.formPanel.form;

        if (o.data) {
            rec = o;
            this.setTitle(rec.phantom ? this.titleTextAdd : this.titleTextEdit);
            f.loadRecord(rec);
        }
        else {
            this.setTitle(this.titleTextAdd);

            var start = o[M.StartDate.name],
                end = o[M.EndDate.name] || Ext.calendar.util.Date.add(start, {hours: 1});

            rec = Ext.create('Ext.calendar.data.EventModel');
            rec.data[M.StartDate.name] = start;
            rec.data[M.EndDate.name] = end;
            rec.data[M.IsAllDay.name] = !!o[M.IsAllDay.name] || start.getDate() != Ext.calendar.util.Date.add(end, {millis: 1}).getDate();

            f.reset();
            f.loadRecord(rec);
        }

        if (this.calendarStore) {
            this.calendarField.setValue(rec.data[M.CalendarId.name]);
        }
        this.dateRangeField.setValue(rec.data);
        this.activeRecord = rec;

        return this;
    },

    // private
    roundTime: function(dt, incr) {
        incr = incr || 15;
        var m = parseInt(dt.getMinutes(), 10);
        return dt.add('mi', incr - (m % incr));
    },

    // private
    onCancel: function() {
        this.cleanup(true);
        this.fireEvent('eventcancel', this);
    },

    // private
    cleanup: function(hide) {
        if (this.activeRecord && this.activeRecord.dirty) {
            this.activeRecord.reject();
        }
        delete this.activeRecord;

        if (hide === true) {
            // Work around the CSS day cell height hack needed for initial render in IE8/strict:
            //var anim = afterDelete || (Ext.isIE8 && Ext.isStrict) ? null : this.animateTarget;
            this.hide();
        }
    },

    // private
    updateRecord: function(record, keepEditing) {
        var fields = record.fields,
            values = this.formPanel.getForm().getValues(),
            name,
            M = Ext.calendar.data.EventMappings,
            obj = {};

        fields.each(function(f) {
            name = f.name;
            if (name in values) {
                obj[name] = values[name];
            }
        });
        
        var dates = this.dateRangeField.getValue();
        obj[M.StartDate.name] = dates[0];
        obj[M.EndDate.name] = dates[1];
        obj[M.IsAllDay.name] = dates[2];

        record.beginEdit();
        record.set(obj);
        
        if (!keepEditing) {
            record.endEdit();
        }

        return this;
    },
    
    // private
    onSave: function(){
        if(!this.formPanel.form.isValid()){
            return;
        }
        if(!this.updateRecord(this.activeRecord)){
            this.onCancel();
            return;
        }
        this.fireEvent(this.activeRecord.phantom ? 'eventadd' : 'eventupdate', this, this.activeRecord, this.animateTarget);

        // Clear phantom and modified states.
        this.activeRecord.commit();
    },
    
    // private
    onDelete: function(){
        this.fireEvent('eventdelete', this, this.activeRecord, this.animateTarget);
    }
});