
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
		request.getSession().removeAttribute(HoSession.STATUS_FILE_UPLOAD_PROGRESS);
	}
	
	HoFileUploadProgressListener hoFileProgressListener  = (HoFileUploadProgressListener) hoServlet.getHoSession().getObject(HoSession.STATUS_FILE_UPLOAD_PROGRESS);

	if (hoFileProgressListener == null) {
		out.write("{ \"fileUploading\" : false ,\"percentage\": -1 }");
	} else {
%>
{"fileUploading" : true
,"percentage": <%= hoFileProgressListener.getPercentDone() %>
,"message": "<%=hoFileProgressListener.getMessage() %>"
,"contentLengthKnown":"<%=hoFileProgressListener.isContentLengthKnown() %>"
,"whichItem":"<%=hoFileProgressListener.getWhichItem() %>"
,"contentLength":"<%=hoFileProgressListener.getContentLength() %>"
,"bytesRead":"<%=hoFileProgressListener.getBytesRead() %>"
,"num100Ks":"<%=hoFileProgressListener.getNum100Ks() %>"
,"finished": <%= hoFileProgressListener.getPercentDone() >= 100 ? "true" : "false" %>
}
<%
	}
if (scriptTag) {
    out.write(");");
}
%>
