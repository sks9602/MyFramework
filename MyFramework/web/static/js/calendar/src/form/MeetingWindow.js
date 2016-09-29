/**
 * @class Ext.calendar.form.EventWindow
 * @extends Ext.Window
 * <p>A custom window containing a basic edit form used for quick editing of events.</p>
 * <p>This window also provides custom events specific to the calendar so that other calendar components can be easily
 * notified when an event has been edited via this component.</p>
 * @constructor
 * @param {Object} config The config object
 */
Ext.define('Ext.calendar.form.MeetingWindow', {
    extend: 'Ext.window.Window',
    alias: 'widget.meetingWindow',
    
    requires: [
        'Ext.form.Panel'
    ],

    constructor: function(config) {
        var formPanelCfg = {
            xtype: 'form',
            fieldDefaults: {
                msgTarget: 'side',
                anchor: '100%',
                labelWidth: 120,
                labelSeparator : ''
            },
            frame: false,
            bodyStyle: 'background:transparent;padding:5px 10px 10px;',
            bodyBorder: false,
            border: false,
            items: [{
                itemId: 'title',
                name: 'title',
                fieldLabel: '회의제목',
                xtype: 'textfield',
                allowBlank: false,
                emptyText: 'Event Title'
            },
            {
				layout     : 'hbox',
				border : 0,
				defaults: { labelWidth: 120 },
				items : [{
					xtype     : 'datefield',
					name      : 'meet_dt',
					fieldLabel: '회의 일시'
				},{
					border : 0,
					margin : '0 10 0 0',
					html : ' '
				},{
					xtype     : 'timefield',
					width     : 80,
					name      : 'time_st'
				},{
					border : 0,
					margin : '0 10 0 10',
					html : ' ~ '
				},{
					xtype     : 'timefield',
					width     : 80,
					name      : 'time_ed'
				}]
			},
			{
				xtype     : 'textfield',
				name      : 'place',
				fieldLabel: '회의 장소'
			},
			{
				xtype     : 'textfield',
				name      : 'member_no',
				fieldLabel: '참석자'
			},
			{
				xtype     : 'textfield',
				name      : 'regi_nm',
				fieldLabel: '작성자'
			},
			{
				xtype:'meetingDetailGrid',
				title : '상세목록'
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
    }

});