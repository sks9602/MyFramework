<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag
	import="project.jun.was.HoModel"
	import="project.jun.util.HoUtil"
	import="project.jun.was.parameter.HoParameter"
	import="project.jun.was.spring.HoController"
	import="project.jun.util.HoServletUtil"
	import="project.jun.util.HoValidator"
	import="project.jun.dao.HoDao"
	import="project.jun.util.HoSpringUtil"
	import="project.jun.dao.result.HoMap"
	import="project.jun.dao.result.HoList"
	import="project.jun.dao.parameter.HoQueryParameterMap"
	import="org.apache.ibatis.metadata.result.MetaData"
%><%@ include file="include.tag" %>
<%@ attribute name="name" type="java.lang.String" required="true"
%><%@ attribute name="actionFlag" type="java.lang.String"
%><%@ attribute name="targetId" type="java.lang.String"
%><%@ attribute name="id" type="java.lang.String"
%><%@ attribute name="func" type="java.lang.String"
%>
<% 
if( isScript || isScriptOut ) {
	
	if( HoValidator.isEmpty(id)) {
		targetId    = HoUtil.replaceNull(targetId, HoServletUtil.getString(request, "function-target-id"));
		actionFlag = HoUtil.replaceNull(actionFlag, p_action_flag);
		
		id = actionFlag + "_"+ targetId + "_" + name.toUpperCase();
	}
	if( "cmp".equals(func)) {
		func = "getCmp";
	} else if( "dom".equals(func)) {
		func = "getDom";
	} else {
		func = "get";
	}
%>
	var <%= name.toUpperCase() %> = Ext.<%= func %>('<%= id %>');
	try {
	<jsp:doBody></jsp:doBody>
	} catch(e) {
		fs_HoScriptLog(e, "Warn");
	}
<%
}
%>


