Ext.define('Ext.calendar.data.Holidays', {
    statics: {
        getData: function(){
            return {
                "holidays":[{
                    "date":  "20140323",
                    "title": "Home"
                },{
                    "date":   "20140328",
                    "title": "Work",
                    "isHoliday" : true
                },{
                    "date":    "20140330",
                    "title": "School"
                },{
                    "date":    "20140324",
                    "title": "Etc"
                }]
            };
        }
    }
});