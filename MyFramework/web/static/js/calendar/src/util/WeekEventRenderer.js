/* @private
 * This is an internal helper class for the calendar views and should not be overridden.
 * It is responsible for the base event rendering logic underlying all views based on a
 * box-oriented layout that supports day spanning (MonthView, MultiWeekView, DayHeaderView).
 */
Ext.define('Ext.calendar.util.WeekEventRenderer', {

    requires: ['Ext.calendar.util.Date'],

    statics: {
        // private
        getEventRow: function(id, week, index) {
            var indexOffset = 1,
                //skip row with date #'s
                evtRow,
                wkRow = Ext.get(id + '-wk-' + week);
            if (wkRow) {
                var table = wkRow.child('.ext-cal-evt-tbl', true);
                evtRow = table.tBodies[0].childNodes[index + indexOffset];
                if (!evtRow) {
                    evtRow = Ext.core.DomHelper.append(table.tBodies[0], '<tr></tr>');
                }
            }
            return Ext.get(evtRow);
        },
        toDate: function(dt) {
        	if( dt.length >= 14) {
        		return Ext.Date.parse(dt.substr(0,14), 'YmdHis');
        	} else if( dt.length >= 12 && dt.length < 14) {
        		return Ext.Date.parse(dt, 'YmdHi');
        	} else if( dt.length >= 10 && dt.length < 12) {
        		return Ext.Date.parse(dt, 'YmdH');
        	} else if( dt.length >= 8 && dt.length < 10) {
        		return Ext.Date.parse(dt, 'Ymd');
        	} else {
        		return new Date();
        	}
        },
        render: function(o) {
            var w = 0,
                grid = o.eventGrid,
                dt = Ext.Date.clone(o.viewStart),
                eventTpl = o.tpl,
                max = o.maxEventsPerDay != undefined ? o.maxEventsPerDay: 999,
                weekCount = o.weekCount < 1 ? 6: o.weekCount,
                dayCount = o.weekCount == 1 ? o.dayCount: 7,
                cellCfg, useTitlePrefix = false;

            for (; w < weekCount; w++) {
                if (!grid[w] || grid[w].length == 0) {
                    // no events or span cells for the entire week
                    if (weekCount == 1) {
                        row = this.getEventRow(o.id, w, 0);
                        cellCfg = {
                            tag: 'td',
                            cls: 'ext-cal-ev',
                            id: o.id + '-empty-0-day-' + Ext.Date.format(dt, 'Ymd'),
                            html: '&#160;'
                        };
                        if (dayCount > 1) {
                            cellCfg.colspan = dayCount;
                        }
                        Ext.core.DomHelper.append(row, cellCfg);
                    }
                    dt = Ext.calendar.util.Date.add(dt, {days: 7});
                } else {
                    var row,
                        d = 0,
                        wk = grid[w],
                        startOfWeek = Ext.Date.clone(dt),
                        endOfWeek = Ext.calendar.util.Date.add(startOfWeek, {days: dayCount, millis: -1});

                    for (; d < dayCount; d++) {
                        if (wk[d]) {
                            var ev = 0,
                                emptyCells = 0,
                                skipped = 0,
                                day = wk[d],
                                ct = day.length,
                                evt;

                            for (; ev < ct; ev++) {
                            	useTitlePrefix = false;
                                if (!day[ev]) {
                                    emptyCells++;
                                    continue;
                                }
                                if (emptyCells > 0 && ev - emptyCells < max) {
                                    row = this.getEventRow(o.id, w, ev - emptyCells);
                                    cellCfg = {
                                        tag: 'td',
                                        cls: 'ext-cal-ev',
                                        id: o.id + '-empty-' + ct + '-day-' + Ext.Date.format(dt, 'Ymd')
                                    };
                                    if (emptyCells > 1 && max - ev > emptyCells) {
                                        cellCfg.rowspan = Math.min(emptyCells, max - ev);
                                    }
                                    Ext.core.DomHelper.append(row, cellCfg);
                                    emptyCells = 0;
                                }
                                
                                if (ev >= max) {
                                    skipped++;
                                    continue;
                                }
                                evt = day[ev];

                                if (!evt.isSpan || evt.isSpanStart) {
                                    //skip non-starting span cells
                                    var item = evt.data || evt.event.data;
                                    var startDate, endDate;

                                    if( typeof item[Ext.calendar.data.EventMappings.StartDate.name] == 'string' ) {
                                    	startDate = this.toDate(item[Ext.calendar.data.EventMappings.StartDate.name]);
                                    } else {
                                    	startDate = item[Ext.calendar.data.EventMappings.StartDate.name];
                                    }
                                    
                                    if( typeof item[Ext.calendar.data.EventMappings.EndDate.name] == 'string' ) {
                                    	endDate = this.toDate(item[Ext.calendar.data.EventMappings.EndDate.name]);
                                    } else {
                                    	endDate = item[Ext.calendar.data.EventMappings.EndDate.name];
                                    }
                                    
                                    item._weekIndex = w;
                                    item._renderAsAllDay = item[Ext.calendar.data.EventMappings.IsAllDay.name] || evt.isSpanStart;
                                    item.spanLeft = startDate.getTime() < startOfWeek.getTime();
                                    item.spanRight = endDate.getTime() > endOfWeek.getTime();
                                    
                                    // 시작일자 정보
                                    item.TitlePrefix = '';
                                    if( item[Ext.calendar.data.EventMappings.ShowStartDay.name] && startDate.getTime() <= o.viewStart.getTime() && w==0  ) { //startOfWeek.getTime()
                                    	item.TitlePrefix = '[';
                                    	item.TitlePrefix += Ext.Date.format(startDate, 'Y.m.d ');
                                    	useTitlePrefix = true;
                                    } 

                                    if( startDate.getTime() > startOfWeek.getTime() && startDate.getTime() <= endOfWeek.getTime() && !item[Ext.calendar.data.EventMappings.IsAllDay.name] ) {
	                                    item.TitlePrefix += Ext.Date.format(startDate, ' g:ia '); 
                                    }
                                    if( useTitlePrefix ) {
                                    	item.TitlePrefix += ' ~ ] ';
                                    }
                                    // D-day정보
                                    item.TitleSuffix = '';
                                    //item[Ext.calendar.data.EventMappings.ShowDDay.name] && 
                                    if( startDate.getTime() < o.viewStart.getTime() || endDate.getTime() > o.viewEnd.getTime() ) { //startOfWeek.getTime()
                                    	item.TitleSuffix = '(D-';
                                    	var _dday = Ext.calendar.util.Date.diffDays(startOfWeek,Ext.calendar.util.Date.add(endDate, { days : 0 }));
                                    	item.TitleSuffix +=  (_dday == 0) ? 'day' : _dday ;
                                    	item.TitleSuffix += ')';
                                    }
                                    		
                                    item.spanCls = (item.spanLeft ? (item.spanRight ? 'ext-cal-ev-spanboth': 'ext-cal-ev-spanleft') : (item.spanRight ? 'ext-cal-ev-spanright': ''));

                                    row = this.getEventRow(o.id, w, ev);
                                    cellCfg = {
                                        tag: 'td',
                                        cls: 'ext-cal-ev',
                                        cn: eventTpl.apply(o.templateDataFn(item))
                                    };
                                    var diff = Ext.calendar.util.Date.diffDays(dt, item[Ext.calendar.data.EventMappings.EndDate.name]) + 1,
                                        cspan = Math.min(diff, dayCount - d);

                                    if (cspan > 1) {
                                        cellCfg.colspan = cspan;
                                    }
                                    Ext.core.DomHelper.append(row, cellCfg);
                                }
                            }
                            if (ev > max) {
                                row = this.getEventRow(o.id, w, max);
                                Ext.core.DomHelper.append(row, {
                                    tag: 'td',
                                    cls: 'ext-cal-ev-more',
                                    id: 'ext-cal-ev-more-' + Ext.Date.format(dt, 'Ymd'),
                                    cn: {
                                        tag: 'a',
                                        html: '+' + skipped + ' more...'
                                    }
                                });
                            }
                            if (ct < o.evtMaxCount[w]) {
                                row = this.getEventRow(o.id, w, ct);
                                if (row) {
                                    cellCfg = {
                                        tag: 'td',
                                        cls: 'ext-cal-ev',
                                        id: o.id + '-empty-' + (ct + 1) + '-day-' + Ext.Date.format(dt, 'Ymd')
                                    };
                                    var rowspan = o.evtMaxCount[w] - ct;
                                    if (rowspan > 1) {
                                        cellCfg.rowspan = rowspan;
                                    }
                                    Ext.core.DomHelper.append(row, cellCfg);
                                }
                            }
                        } else {
                            row = this.getEventRow(o.id, w, 0);
                            if (row) {
                                cellCfg = {
                                    tag: 'td',
                                    cls: 'ext-cal-ev',
                                    id: o.id + '-empty-day-' + Ext.Date.format(dt, 'Ymd')
                                };
                                if (o.evtMaxCount[w] > 1) {
                                    cellCfg.rowSpan = o.evtMaxCount[w];
                                }
                                Ext.core.DomHelper.append(row, cellCfg);
                            }
                        }
                        dt = Ext.calendar.util.Date.add(dt, {days: 1});
                    }
                }
            }
        }
    }
});