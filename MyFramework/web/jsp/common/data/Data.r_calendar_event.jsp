
<%@ page
	contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	session="true"
	import="java.util.*"
	import="java.sql.Types"
	import="project.jun.dao.result.HoList"
	import="project.jun.delegate.HoDelegate"
	import="project.jun.util.HoUtil"
	import="org.apache.ibatis.metadata.result.MetaData"
%><%@include file="/jsp/common/include/include.jsp"
%><%
	boolean scriptTag = false;
	String cb = param.get("callback");
	if (!cb.equals("")) {
	    scriptTag = true;
	    response.setContentType("text/javascript");
	    response.setHeader("Content-Type", "charset=utf-8");
	} else {
	    response.setContentType("application/x-json");
	    response.setHeader("Content-Type", "charset=utf-8");
	}
	if (scriptTag) {
	    out.write(cb + "(");
	}

	long cnt = model.getLong(HoDelegate.KEY_JSON_CNT);

	HoList list = model.getHoList(HoDelegate.KEY_JSON_DATA);

	MetaData md = (list!=null ? list.getMetaData() : null );

%>{"totalCount":"5",
"evts": [{
                    "id": 999,
                    "cid": 3,
                    "title": "Here 한글은!!",
                    "start": Ext.calendar.data.Events.toDate("20140315"),
                    "end": Ext.calendar.data.Events.toDate("2014031714"),
                    "notes": "Have fun",
                    "ssd": true
                },{
                    "id": 998,
                    "cid": 2,
                    "title": "Here 한글은!!",
                    "start": new Date(),
                    "end": Ext.Date.add(new Date(),  Ext.Date.DAY, 5 ),
                    "notes": "Have fun",
                    "sdd": true,
                    "ssd": true
                },{
                    "id": 997,
                    "cid": 1,
                    "title": " 3일간 수해하는 회의 !!",
                    "start": Ext.calendar.data.Events.toDate("20140422"),
                    "end": Ext.calendar.data.Events.toDate("20140504"),
                    "notes": "Have fun",
                    "ad": false ,
                    "loc": "ABC Inc.",
                    "rem": "60" ,
                    "sdd": true,
                    "ssd": true
                },{
                    "id": 996,
                    "cid": 3,
                    "title": "2일간 워크숍 !!",
                    "start": Ext.calendar.data.Events.toDate("20140423"),
                    "end": Ext.calendar.data.Events.toDate("20140424"),
                    "notes": "Have fun",
                    "ad": true,
                    "sdd": true
                }, {
                    "id": 1002,
                    "cid": 2,
                    "title": "Lunch with Matt",
                    "start": Ext.calendar.data.Events.toDate("201404241000"),
                    "end": Ext.calendar.data.Events.toDate("201404241130"),
                    "loc": "Chuy's!",
                    "url": "http://chuys.com",
                    "notes": "Order the queso",
                    "rem": "15",
                    "ssd": true
                }]}
<%
if (scriptTag) {
    out.write(");");
}
%>
