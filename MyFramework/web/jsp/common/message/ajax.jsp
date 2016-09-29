<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %><%@ 
	page import="project.jun.was.result.message.HoMessage" 
	     import="project.jun.exception.HoException" %><%@ 
	taglib prefix="spring" uri="http://www.springframework.org/tags" %><%@
	include file="/jsp/common/include/include.jsp" %>
<%
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

	String code = "";
	Object [] paramVar = null;
	Object result = model.get(HoController.HO_CUD_RESULT);
	
	if( result instanceof HoMessage ) {
		HoMessage hm = (HoMessage) result;
		
		code = hm.getCode();
		paramVar = hm.getMessage();
	} else if( result instanceof HoException ) {
		HoException he = (HoException) result;	
		
		code = he.getCode();
		paramVar = he.getErrMessage();
	}
	
	Boolean success = (Boolean) model.get(HoController.HO_SUCCESS);
%>
	{
		"success": <%= success %>, 
		"message" : "성공", 
		"msg" : "<spring:message code="<%= code %>" arguments="<%= paramVar %>"></spring:message>" 
	}
<%
	if (scriptTag) {
	    out.write(");");
	}
%>