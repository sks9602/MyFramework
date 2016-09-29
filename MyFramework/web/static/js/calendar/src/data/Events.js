Ext.define('Ext.calendar.data.Events', {

    statics: {
    	toDate : function(dt) {
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
        getData: function() {
            var today = Ext.Date.clearTime(new Date('2014/02/15')),
                makeDate = function(d, h, m, s) {
                    d = d * 86400;
                    h = (h || 0) * 3600;
                    m = (m || 0) * 60;
                    s = (s || 0);
                    return Ext.Date.add(today, Ext.Date.SECOND, d + h + m + s);
                };
            var toDate = function(dt) {
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
            };
            
            return {
                "evts": [{
                    "id": 999,
                    "cid": 3,
                    "title": "Here 한글은!!",
                    "start": toDate('201403221020'),
                    "end": toDate('201403241230'),
                    "notes": "Have fun"
                },{
                    "id": 1001,
                    "cid": 1,
                    "title": "Vacation",
                    "start": toDate('201403221020'),
                    "end": toDate('201403221020'),
                    "notes": "Have fun"
                }, {
                    "id": 1002,
                    "cid": 2,
                    "title": "Lunch with Matt",
                    "start": makeDate(0, 11, 30),
                    "end": makeDate(0, 13),
                    "loc": "Chuy's!",
                    "url": "http://chuys.com",
                    "notes": "Order the queso",
                    "rem": "15"
                }, {
                    "id": 1003,
                    "cid": 3,
                    "title": "Project due",
                    "start": makeDate(0, 15),
                    "end": makeDate(0, 15)
                }, {
                    "id": 1004,
                    "cid": 1,
                    "title": "Sarah's birthday",
                    "start": today,
                    "end": today,
                    "notes": "Need to get a gift",
                    "ad": true
                }, {
                    "id": 1005,
                    "cid": 2,
                    "title": "A long one...",
                    "start": makeDate(-11),
                    "end": makeDate(4, 0, 0, 0),
                    "ad": true
                }, {
                    "id": 1006,
                    "cid": 3,
                    "title": "School holiday",
                    "start": makeDate(5),
                    "end": makeDate(7, 0, 0, -1),
                    "ad": true,
                    "rem": "2880",
                    "h" : true

                }, {
                    "id": 1007,
                    "cid": 1,
                    "title": "Haircut",
                    "start": makeDate(0, 9),
                    "end": makeDate(0, 9, 30),
                    "notes": "Get cash on the way"
                }, {
                    "id": 1008,
                    "cid": 3,
                    "title": "An old event",
                    "start": makeDate(-30),
                    "end": makeDate(-28),
                    "ad": true
                }, {
                    "id": 1009,
                    "cid": 2,
                    "title": "Board meeting",
                    "start": makeDate(-2, 13),
                    "end": makeDate(-2, 18),
                    "loc": "ABC Inc.",
                    "rem": "60"
                }, {
                    "id": 1010,
                    "cid": 3,
                    "title": "Jenny's final exams",
                    "start": makeDate(-2),
                    "end": makeDate(3, 0, 0, -1),
                    "ad": true
                }, {
                    "id": 1011,
                    "cid": 1,
                    "title": "Movie night",
                    "start": makeDate(2, 19),
                    "end": makeDate(3, 23),
                    "notes": "Don't forget the tickets!",
                    "rem": "60"
                }]
            }
        }
    }
});
