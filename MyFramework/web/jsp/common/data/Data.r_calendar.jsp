
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

%>{"totalCount":"3","datas":[
{ "date" : "20140220" , "title" : "쉬는날1", "isHoliday" : true, "lunarYear" : "2014", "lunarDate" : "02.20"},
{ "date" : "20140221" , "title" : "쉬는날2", "isHoliday" : true},
{ "date" : "20140227" , "title" : "쉬는날3", "isHoliday" : true},
{ "date" : "20140623" , "title" : "안 쉬는날1"},
{ "date" : "20140628" , "title" : "쉬는날1쉬는날1안 쉬는날2"},
{ "date" : "20140630" , "title" : "안 쉬는날3", "isHoliday" : false, "lunarYear" : "2014", "lunarDate" : "04.11"},
{ "date" : "20140629" , "title" : "쉬는날4", "isHoliday" : true},
{ "date" : "20140624" , "title" : "쉬는날4", "isHoliday" : true, "lunarYear" : "2014", "lunarDate" : "04.01"}, 
{ "date" : "20141027" , "title" : "쉬는날5", "isHoliday" : true} ,
{ "date" : "20140625" , "lunarYear" : "2014", "lunarDate" : "04.01"}
]}
<%
if (scriptTag) {
    out.write(");");
}
%>
