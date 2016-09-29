/*
 * This calendar application was forked from Ext Calendar Pro
 * and contributed to Ext JS as an advanced example of what can
 * be built using and customizing Ext components and templates.
 *
 * If you find this example to be useful you should take a look at
 * the original project, which has more features, more examples and
 * is maintained on a regular basis:
 *
 *  http://ext.ensible.com/products/calendar
 */
Ext.define('Ext.calendar.App',
	{

		requires : [ 'Ext.Viewport', 'Ext.layout.container.Border',
				'Ext.picker.Date', 'Ext.calendar.util.Date',
				'Ext.calendar.CalendarPanel',
				'Ext.calendar.data.MemoryCalendarStore',
				'Ext.calendar.data.MemoryEventStore',
				'Ext.calendar.data.Events',
				'Ext.calendar.data.Calendars',
				'Ext.calendar.form.EventWindow',
				'Ext.calendar.form.MeetingWindow'],

		constructor : function() {
			// Minor workaround for OSX Lion scrollbars
			this.checkScrollOffset();

			// This is an example calendar store that enables event
			// color-coding
			this.calendarStore = Ext.create(
					'Ext.calendar.data.MemoryCalendarStore', {
						data : Ext.calendar.data.Calendars
								.getData()
					});

			// A sample event store that loads static JSON from a
			// local file. Obviously a real
			// implementation would likely be loading remote data
			// via an HttpProxy, but the
			// underlying store functionality is the same.
			/*
			 * this.eventStore =
			 * Ext.create('Ext.calendar.data.MemoryEventStore', { //
			 * data: Ext.calendar.data.Events.getData() });
			 */
			this.eventStore = new Ext.data.JsonStore({
				model : 'Ext.calendar.data.EventModel',
				storeId : 'eventStore',
				autoDestroy : true,
				root : 'evts',
				totalProperty : 'totalCount',
				remoteSort : true,
				// fields: ['id', 'cid', 'title', 'start',
				// 'end', 'loc', 'url', 'notes', 'rem',
				// 'ad', 'ssd', 'sdd' ],
				id : 'id_eventStore',
				proxy : new Ext.data.HttpProxy(
						{
							type : 'ajax', // 'memory',
							url : '/s/example/example.do?p_action_flag=r_calendar_event',
							reader : {
								type : 'json',
								root : 'evts'
							}
						})
			});

			/*
			 * this.holidayStore =
			 * Ext.create('Ext.calendar.data.MemoryHolidayCalendarStore', {
			 * data: Ext.calendar.data.Holidays.getData() });
			 */

			this.holidayStore = new Ext.data.JsonStore({
				storeId : 'holidayStore',
				autoDestroy : true,
				root : 'datas',
				totalProperty : 'totalCount',
				remoteSort : true,
				fields : [ 'date', 'title', {
					name : 'isHoliday',
					type : 'bool'
				}, 'lunarYear', 'lunarDate' ],
				id : 'id_holidayStore',
				autoLoad : true,
				autoSync : true,
				proxy : new Ext.data.HttpProxy(
						{
							type : 'ajax', // 'memory',
							url : '/s/example/example.do?p_action_flag=r_calendar',
							reader : {
								type : 'json',
								root : 'datas',
								idProperty : 'date'
							}
						})
			});

			// This is the app UI layout code. All of the calendar
			// views are subcomponents of
			// CalendarPanel, but the app title bar and
			// sidebar/navigation calendar are separate
			// pieces that are composed in app-specific layout code
			// since they could be omitted
			// or placed elsewhere within the application.
			Ext.create('Ext.Viewport',{
			layout : 'border',
			renderTo : 'calendar-ct',
			items : [
						{
							xtype : 'component',
							id : 'app-header',
							region : 'north',
							height : 35,
							contentEl : 'app-header-content'
						},
						{
							id : 'app-center',
							title : '...', // will
											// be
											// updated
											// to
											// the
											// current
											// view's
											// date
											// range
							region : 'center',
							layout : 'border',
							listeners : {
								'afterrender' : function() {
									Ext.getCmp('app-center').header.addCls('app-center-header');
								}
							},
							items : [{
										layout : 'border',
										region : 'west',
										id : 'app-west',
										border : 0,
										split : true,
										width : 214,
										items : [
												{
													xtype : 'datepicker',
													id : 'app-nav-picker',
													cls : 'ext-cal-nav-picker',
													// border : false,
													width : 214,
													region : 'north',
													margins : '0 0 0 0',
													listeners : {
														'select' : {
															fn : function( dp, dt) {
																Ext.getCmp('app-calendar').setStartDate(dt);
																// Ext.getCmp('app-calendar').onMonthClick();
															},
															scope : this
														}
													}
												},

												{
													region : 'center',
													id : 'app-nav-accordion',
													title : 'Project 정보',
													border : 0,
													autoScroll : true,
													width : 214,
													collapsible : false,
													animCollapse : true,
													margins : '0 0 1 1',
													layout : 'accordion',
													items : [Ext.create('Ext.tree.Panel', {
																title : 'Project & Team',
																rootVisible : false,
																autoScroll : true,
																height : 400,
																bodyStyle : {
																	"background-color" : "white"
																},
																listeners : {
																	'itemclick' : {
																		fn : function(
																				_this,
																				record,
																				item,
																				index,
																				e,
																				eOpts) {

																			Ext.getCmp('app-calendar').onTeamClick();
																		},
																		scope : this
																	}
																},
																store : Ext.create( 'Ext.data.TreeStore',
																{
																	root : {
																		expanded : true,
																		children : [
																				{
																					text : "A Project",
																					leaf : true
																				},
																				{
																					text : "Y 프로젝트",
																					expanded : true,
																					children : [
																						{
																							text : "book report",
																							leaf : true
																						},
																						{
																							text : "algebra",
																							leaf : true
																						} ]
																				},
																				{
																					text : "buy lottery tickets",
																					leaf : true
																				} ]
																	}
																})
															}),
															{
																title : 'Project 자료실',
																bodyStyle : {
																	"background-color" : "white"
																},
																html : 'Panel content!<br/>Panel content!<br/>Panel content!<br/>Panel content!<br/>Panel content!<br/>Panel content!<br/>Panel content!<br/>Panel content!<br/>'
															},
															Ext.create('Ext.grid.Panel',{
															title : '할일',
															rootVisible : false,
															autoScroll : true,
															bodyStyle : {
																"background-color" : "white"
															},
															store : Ext.create('Ext.data.ArrayStore',{
																	fields : [
																			{
																				name : 'company'
																			},
																			{
																				name : 'price',
																				type : 'float'
																			},
																			{
																				name : 'change',
																				type : 'float'
																			},
																			{
																				name : 'pctChange',
																				type : 'float'
																			},
																			{
																				name : 'lastChange',
																				type : 'date',
																				dateFormat : 'n/j h:ia'
																			} ],
																	data : [
																			[
																					'3m Co',
																					71.72,
																					0.02,
																					0.03,
																					'9/1 12:00am' ],
																			[
																					'Alcoa Inc',
																					29.01,
																					0.42,
																					1.47,
																					'9/1 12:00am' ],
																			[
																					'Altria Group Inc',
																					83.81,
																					0.28,
																					0.34,
																					'9/1 12:00am' ],
																			[
																					'American Express Company',
																					52.55,
																					0.01,
																					0.02,
																					'9/1 12:00am' ],
																			[
																					'American International Group, Inc.',
																					64.13,
																					0.31,
																					0.49,
																					'9/1 12:00am' ],
																			[
																					'AT&T Inc.',
																					31.61,
																					-0.48,
																					-1.54,
																					'9/1 12:00am' ],
																			[
																					'Boeing Co.',
																					75.43,
																					0.53,
																					0.71,
																					'9/1 12:00am' ] ]
																		}),
															columns : [
																	{
																		text : '일자',
																		flex : 1,
																		sortable : false,
																		dataIndex : 'company'
																	},
																	{
																		text : '시간',
																		width : 75,
																		sortable : true,
																		renderer : 'usMoney',
																		dataIndex : 'price'
																	} 
															]
														}) 
													]
											}
										]
									},
									{
										xtype : 'calendarpanel',
										eventStore : this.eventStore,
										calendarStore : this.calendarStore,
										holidayStore : this.holidayStore,
										border : false,
										id : 'app-calendar',
										region : 'center',
										activeItem : 2, // month
														// view

										monthViewCfg : {
											showHeader : true,
											showWeekLinks : true,
											showWeekNumbers : true
										},

										listeners : {
											'eventclick' : {
												fn : function(
														vw,
														rec,
														el) {
													this.showEditWindow(
																	rec,
																	el);
													this.clearMsg();
												},
												scope : this
											},
											'eventover' : function(
													vw,
													rec,
													el) {
												// console.log('Entered
												// evt
												// rec='+rec.data.Title+',
												// view='+
												// vw.id
												// +',
												// el='+el.id);
											},
											'eventout' : function(
													vw,
													rec,
													el) {
												// console.log('Leaving
												// evt
												// rec='+rec.data.Title+',
												// view='+
												// vw.id
												// +',
												// el='+el.id);
											},
											'eventadd' : {
												fn : function(
														cp,
														rec) {
													this.showMsg('Event ' + rec.data.Title + ' was added');
												},
												scope : this
											},
											'eventupdate' : {
												fn : function(
														cp,
														rec) {
													this.showMsg('Event ' + rec.data.Title + ' was updated');
												},
												scope : this
											},
											'eventcancel' : {
												fn : function(
														cp,
														rec) {
													// edit
													// canceled
												},
												scope : this
											},
											'viewchange' : {
												fn : function(
														p,
														vw,
														dateInfo) {
													if (this.editWin) {
														this.editWin.hide();
													}
													if (!vw.isCalendar) {
														Ext.getCmp('app-center').setTitle('프로젝트 관리');

													} else {
														if (dateInfo) {
															// will
															// be
															// null
															// when
															// switching
															// to
															// the
															// event
															// edit
															// form
															// so
															// ignore
															Ext.getCmp('app-nav-picker').setValue(dateInfo.activeDate);
															this.updateTitle(dateInfo.viewStart,dateInfo.viewEnd);
														}
													}
												},
												scope : this
											},
											'dayclick' : {
												fn : function(
														vw,
														dt,
														ad,
														el) {
													this.showEditWindow(
																	{
																		StartDate : dt,
																		IsAllDay : ad
																	},
																	el);
													this.clearMsg();
												},
												scope : this
											},
											'rangeselect' : {
												fn : function(
														win,
														dates,
														onComplete) {
													this.showEditWindow(dates);
													this.editWin.on(
																	'hide',
																	onComplete,
																	this,
																	{
																		single : true
																	});
													this.clearMsg();
												},
												scope : this
											},
											'eventmove' : {
												fn : function(
														vw,
														rec) {
													var mappings = Ext.calendar.data.EventMappings, time = rec.data[mappings.IsAllDay.name] ? ''
															: ' \\a\\t g:i a';

													rec.commit();

													this.showMsg('Event ' + rec.data[mappings.Title.name]
																	+ ' was moved to '
																	+ Ext.Date.format(rec.data[mappings.StartDate.name], ('F jS' + time)));
												},
												scope : this
											},
											'eventresize' : {
												fn : function(
														vw,
														rec) {
													rec.commit();
													this.showMsg('Event ' + rec.data.Title + ' was updated');
												},
												scope : this
											},
											'eventdelete' : {
												fn : function(
														win,
														rec) {
													this.eventStore.remove(rec);
													this.showMsg('Event ' + rec.data.Title + ' was deleted');
												},
												scope : this
											},
											'initdrag' : {
												fn : function(
														vw) {
													if (this.editWin && this.editWin.isVisible()) {
														this.editWin.hide();
													}
												},
												scope : this
											}
										}
									} ]
						} ]
			});
		},

		// The edit popup window is not part of the CalendarPanel
		// itself -- it is a separate component.
		// This makes it very easy to swap it out with a different
		// type of window or custom view, or omit
		// it altogether. Because of this, it's up to the
		// application code to tie the pieces together.
		// Note that this function is called from various event
		// handlers in the CalendarPanel above.
		showEditWindow : function(rec, animateTarget) {
			if (!this.editWin) {
				this.editWin = Ext.create('Ext.calendar.form.EventWindow', {
					calendarStore : this.calendarStore,
					listeners : {
						'eventadd' : {
							fn : function(win, rec) {
								Ext.Ajax.request({
											url : '/s/example/example.do?p_action_flag=s_insert',
											params : rec.data,
											success : function(response) {
												var text = response.responseText;
											}
										});
								win.hide();
								rec.data.IsNew = false;
								this.eventStore.add(rec);
								this.eventStore.sync();
								this.showMsg('Event ' + rec.data.Title + ' was added');
							},
							scope : this
						},
						'eventupdate' : {
							fn : function(win, rec) {
								Ext.Ajax.request({
											url : '/s/example/example.do?p_action_flag=s_update',
											params : rec.data,
											success : function(response) {
												var text = response.responseText;
											}
										});
								win.hide();
								rec.commit();
								this.eventStore.sync();
								this.showMsg('Event ' + rec.data.Title + ' was updated');
							},
							scope : this
						},
						'eventdelete' : {
							fn : function(win, rec) {
								this.eventStore.remove(rec);
								this.eventStore.sync();
								win.hide();
								this.showMsg('Event ' + rec.data.Title + ' was deleted');
							},
							scope : this
						},
						'editdetails' : {
							fn : function(win, rec) {
								win.hide();
								Ext.getCmp('app-calendar').showEditForm(rec);
							}
						}
					}
				});
			}
			this.editWin.show(rec, animateTarget);
		},

		// The CalendarPanel itself supports the standard Panel title config, but that title
		// only spans the calendar views.  For a title that spans the entire width of the app
		// we added a title to the layout's outer center region that is app-specific. This code
		// updates that outer title based on the currently-selected view range anytime the view changes.
		updateTitle : function(startDt, endDt) {
			var p = Ext.getCmp('app-center'), fmt = Ext.Date.format;

			if (Ext.Date.clearTime(startDt).getTime() == Ext.Date.clearTime(endDt).getTime()) {
				p.setTitle(fmt(startDt, 'F j, Y'));
			} else if (startDt.getFullYear() == endDt.getFullYear()) {
				if (startDt.getMonth() == endDt.getMonth()) {
					p.setTitle(fmt(startDt, 'F j') + ' - ' + fmt(endDt, 'j, Y'));
				} else {
					p.setTitle(fmt(startDt, 'F j') + ' - ' + fmt(endDt, 'F j, Y'));
				}
			} else {
				p.setTitle(fmt(startDt, 'F j, Y') + ' - ' + fmt(endDt, 'F j, Y'));
			}
		},

		// This is an application-specific way to communicate CalendarPanel event messages back to the user.
		// This could be replaced with a function to do "toast" style messages, growl messages, etc. This will
		// vary based on application requirements, which is why it's not baked into the CalendarPanel.
		showMsg : function(msg) {
			Ext.fly('app-msg').update(msg).removeCls('x-hidden');

			setTimeout(this.clearMsg, 3000);
		},
		clearMsg : function() {
			Ext.fly('app-msg').update('').addCls('x-hidden');
		},

		// OSX Lion introduced dynamic scrollbars that do not take up space in the
		// body. Since certain aspects of the layout are calculated and rely on
		// scrollbar width, we add a special class if needed so that we can apply
		// static style rules rather than recalculate sizes on each resize.
		checkScrollOffset : function() {
			var scrollbarWidth = Ext.getScrollbarSize ? Ext.getScrollbarSize().width : Ext.getScrollBarWidth();

			// We check for less than 3 because the Ext scrollbar measurement gets
			// slightly padded (not sure the reason), so it's never returned as 0.
			if (scrollbarWidth < 3) {
				Ext.getBody().addCls('x-no-scrollbar');
			}
			if (Ext.isWindows) {
				Ext.getBody().addCls('x-win');
			}
		}
	}, function() {
		/*
		 * A few Ext overrides needed to work around issues in the calendar
		 */

		Ext.form.Basic.override({
			reset : function() {
				var me = this;
				// This causes field events to be ignored. This is a problem for the
				// DateTimeField since it relies on handling the all-day checkbox state
				// changes to refresh its layout. In general, this batching is really not
				// needed -- it was an artifact of pre-4.0 performance issues and can be removed.
				//me.batchLayouts(function() {
				me.getFields().each(function(f) {
					f.reset();
				});
				//});
				return me;
			}
		});

		// Currently MemoryProxy really only functions for read-only data. Since we want
		// to simulate CRUD transactions we have to at the very least allow them to be
		// marked as completed and successful, otherwise they will never filter back to the
		// UI components correctly.
		Ext.data.MemoryProxy.override({
			updateOperation : function(operation, callback, scope) {
				operation.setCompleted();
				operation.setSuccessful();
				Ext.callback(callback, scope || this,[ operation ]);
			},
			create : function() {
				this.updateOperation.apply(this, arguments);
			},
			update : function() {
				this.updateOperation.apply(this, arguments);
			},
			destroy : function() {
				this.updateOperation.apply(this, arguments);
			}
		});
	});