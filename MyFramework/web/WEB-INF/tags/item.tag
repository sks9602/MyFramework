<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag
	import="project.jun.was.HoModel"
	import="project.jun.util.HoUtil"
	import="project.jun.was.parameter.HoParameter"
	import="project.jun.was.spring.HoController"
	import="project.jun.util.HoServletUtil"
	import="project.jun.util.HoValidator"
%><%@ include file="include.tag" %>
<%@ attribute name="section" type="java.lang.String"
%><%@ attribute name="action" type="java.lang.String"
%><%@ attribute name="title" type="java.lang.String"
%><%@ attribute name="button" type="java.lang.String"
%><%@ attribute name="gridId" type="java.lang.String"
%><%@ attribute name="id" type="java.lang.String"
%><%@ attribute name="position" type="java.lang.String"
%><%@ attribute name="hidden" type="java.lang.String"
%><%@ attribute name="delay" type="java.lang.String"%><%-- loading 시간이 길경우 'Y' ('검색' 버튼에서만 메시지 출력) --%>
<% if( isScript || isScriptOut ) {
	int index =  HoServletUtil.getIndex(request, HoServletUtil.getArea(request)+HoServletUtil.getString(request, "data")+"_row");

	HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request)+HoServletUtil.getString(request, "data")+"_row");

	HoServletUtil.setInArea(request, "item");
	
	HoServletUtil.setString(request, "item-id", HoUtil.replaceNull(id, "item"));

%>
	<%= index > 0 ? "," : "" %>
	<jsp:doBody></jsp:doBody>
<%
	String nowArea = HoServletUtil.getNowArea(request);
	if( "fieldcontainer".equals(nowArea)) {
		HoServletUtil.initIndex(request, HoServletUtil.getArea(request)+">item_row");
		HoServletUtil.setOutArea(request);
		
	}

	// out.println("] }  ");
	HoServletUtil.initIndex(request, HoServletUtil.getArea(request)+">fieldcontainer");
	HoServletUtil.initIndex(request, HoServletUtil.getArea(request)+">fieldcontainer_row");

	HoServletUtil.setString(request, "item-id", null);
	HoServletUtil.setOutArea(request);

	}
%>



<% if( isHtml ) {

} %>