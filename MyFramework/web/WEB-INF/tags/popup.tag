<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag
	import="project.jun.was.HoModel"
	import="project.jun.util.HoUtil"
	import="project.jun.util.HoServletUtil"
	import="project.jun.was.parameter.HoParameter"
	import="project.jun.was.spring.HoController"
	import="project.jun.util.HoValidator"
%><%@ include file="include.tag" %>
<%@ attribute name="name" type="java.lang.String" required="true"
%><%
	int gridIndex = HoServletUtil.getIndex(request, "grid_index");

	boolean isDockedItem = HoServletUtil.getArea(request).indexOf("dockedItems") > 0;

%>
<% if( (isScript||isScriptOut )  && !isDockedItem  ) { %>
<%
	HoServletUtil.setInArea(request, "popupWindow" );
	int itemsRow = HoServletUtil.getIndex(request, HoServletUtil.getArea(request)+"_popupWindow");
	HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request)+"_popupWindow");
	
	if( name.indexOf("member")>=0 ) { 
		out.print( (itemsRow > 0 ? "," : ""));
%>
		popupMember : Ext.create('Ext.window.ux.WindowPopupMember',{
			<jsp:doBody></jsp:doBody>
			empty : null
		})
<% 
	} 

	HoServletUtil.setOutArea(request);
%>
<% } %>

<% if( isHtml ) {%>
<% } %>