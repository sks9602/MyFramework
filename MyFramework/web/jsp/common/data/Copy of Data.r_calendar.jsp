
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

%>
{"totalCount":"3","datas":[ 
	{"date":"20140320", "title" :"SomeDay", "isHoliday" : true},
	{"date":"20140323", "title" :"SomeDay1"},
	{"date":"20140324", "title" :"SomeDay2", "isHoliday" : true}
]}
<%
if (scriptTag) {
    out.write(");");
}
%>
