
<%@ page
	contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	session="true"
	import="java.util.*"
	import="java.sql.Types"
	import="project.jun.dao.result.HoList"
	import="project.jun.delegate.HoDelegate"
	import="project.jun.util.HoUtil"
	import="project.jun.was.listener.HoFileUploadProgressListener"
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

	if( "true".equals(param.get("destroy"))) {
		request.getSession().removeAttribute(HoSession.STATUS_FILE_DOWNLOAD_PROGRESS);
		request.getSession().removeAttribute(HoSession.STATUS_FILE_DOWNLOAD_PROGRESS + HoSession.FILE_NAME_SUFFIX);
		request.getSession().removeAttribute(HoSession.STATUS_FILE_DOWNLOAD_PROGRESS + "_TOTAL");
		request.getSession().removeAttribute(HoSession.STATUS_FILE_DOWNLOAD_PROGRESS + "_DOWNLOAD");
	}
	String progress  = (String) request.getSession().getAttribute(HoSession.STATUS_FILE_DOWNLOAD_PROGRESS);
	String fileName  = (String) request.getSession().getAttribute(HoSession.STATUS_FILE_DOWNLOAD_PROGRESS + HoSession.FILE_NAME_SUFFIX);

	long total = 0;
	long download = 0;
	
	try {
		total = Long.parseLong((String) request.getSession().getAttribute(HoSession.STATUS_FILE_DOWNLOAD_PROGRESS + "_TOTAL"));
	} catch(Exception e) {
		
	}
	
	try {
		download = Long.parseLong((String) request.getSession().getAttribute(HoSession.STATUS_FILE_DOWNLOAD_PROGRESS + "_DOWNLOAD"));
	} catch(Exception e) {
		
	}

	
	if (progress == null) {
%>
		{"percentage": -1 , "message" : "No File Download.."}
<%
	} else {
%>
		{"percentage": <%= progress %> , "fileName" : "<%= fileName %>", total : <%= total %>, download : <%=download %> }
<%
	}
if (scriptTag) {
    out.write(");");
}
%>
