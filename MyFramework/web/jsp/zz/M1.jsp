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
	boolean isScript = true;
	boolean isHtml = true;

	String p_action_flag = request.getParameter("p_action_flag");
	String view = request.getParameter("view");

	isScript = "script".equals(view);
	isHtml 	 = "html".equals(view);


	out.print("<br/><br/> M1.jsp --> p_action_flag : " + p_action_flag);

	if( isScript ) {
		out.print("<br/> scipt .. M1.jsp");
	}


	if( isHtml ) {
		out.print("<br/> html .. M1.jsp");
	}

%>
</body>
</html>