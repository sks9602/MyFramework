<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	String [] action_flags =  {"list","view"};
	String [] views =  {"script","html"};
%>

<%
	for( int i=0; i<views.length ; i++) {
		for( int j=0; j<action_flags.length; j++ ) {
%>
	<jsp:include page="./M1.jsp"  flush="true">
		<jsp:param name="p_action_flag" value="<%= action_flags[j] %>"/>
		<jsp:param name="view" value="<%= views[i] %>"/>
	</jsp:include>
<%
		}
	}
%>

</body>
</html>