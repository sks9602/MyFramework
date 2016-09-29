<%@ tag language="java" pageEncoding="UTF-8"
	import="project.jun.was.HoModel"
	import="project.jun.was.spring.HoController"
	import="project.jun.util.HoUtil"
	import="project.jun.was.parameter.HoParameter"
	import="project.jun.dao.HoDao"
	import="project.jun.dao.result.HoList"
	import="project.jun.config.HoConfig"
	import="org.springframework.web.context.support.WebApplicationContextUtils"
	import="org.springframework.web.context.WebApplicationContext"
	import="project.jun.dao.parameter.HoQueryParameterMap"
	import="java.util.List"
	import="java.util.Date"
	import="java.text.DateFormat"
	import="project.jun.util.asp.HoAspUtil"
	import="project.jun.util.HoValidator"
	import="project.jun.dao.parameter.HoQueryParameterHandler"
	import="project.jun.util.HoServletUtil"
	import="project.jun.util.HoSpringUtil"
	import="project.jun.util.cache.HoCache"	
	import="project.jun.util.cache.HoEhCache"
	import="project.jun.dao.result.transfigure.HoMapHasList"
%><%@ taglib prefix="spring"  uri="http://www.springframework.org/tags" %>
<%@ include file="include.tag" %><%-- input type="XX" 형태의 component 생성 --%><%@ 
attribute name="type"   type="java.lang.String" required="true"%><%--  text, label(테두리 없이 값만 나오는 형태 - 파라미터로는 전송됨), hidden --%><%@ 
attribute name="width"  type="java.lang.String" %><%@ 
attribute name="name"   type="java.lang.String" %><%@ 
attribute name="value"  type="java.lang.String" %><%@ 
attribute name="colspan"    type="java.lang.String" %><%@ 
attribute name="rowspan"    type="java.lang.String" %><%@ 
attribute name="isAlert"    type="java.lang.String" %><% 	
	if( isScript || isScriptOut ) {
		String nowArea = HoServletUtil.getNowArea(request);
		
		String formId = HoServletUtil.getString(request, "form-id");

		if( !"fieldcontainer".equals(nowArea)) {
			HoServletUtil.setInArea(request, "fieldcontainer");
			HoServletUtil.initIndex(request, HoServletUtil.getArea(request));
			int itemsRow = HoServletUtil.getIndex(request, HoServletUtil.getArea(request)+"_row");
			HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request)+"_row");
			out.print( (itemsRow > 0 ? "," : "") +"		");
		}

		int itemNowIndex = HoServletUtil.getIndex(request, HoServletUtil.getArea(request));
		int increaseIndex = getIndexIncrement( type );

		if( itemNowIndex + increaseIndex > getMaxItemByArea(request)  ) { // MAX_ROW_ITEM_SEARCH
			HoServletUtil.initIndex(request, HoServletUtil.getArea(request)+">item_row");
			HoServletUtil.initIndex(request, HoServletUtil.getArea(request));
			String area = HoServletUtil.getNowArea(request);

			HoServletUtil.setOutArea(request);
			HoServletUtil.setInArea(request, "fieldcontainer");
			int itemsRow = HoServletUtil.getIndex(request, HoServletUtil.getArea(request)+"_row");
			HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request)+"_row");
			out.print( (itemsRow > 0 ? "," : "") +"		");
		}


		HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request), increaseIndex );
		HoServletUtil.setInArea(request, "item");
		out.println(HoServletUtil.getIndex(request, HoServletUtil.getArea(request)+"_row") > 0 ? "," : "");
		HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request)+"_row");
		
		value = HoUtil.replaceNull(value, "");
%>
			Ext.create('Ext.Component', {	
				// xtype : 'label',
				<%= HoValidator.isNotEmpty(name) ? "id : '" + p_action_flag +"_"+ formId +"_"+ name.toUpperCase()+"'," : "" %>
				/*
				style: {
			        color: '#FFFFFF'
			    },
			    */
			    <% if( "Y".equals(isAlert )) { %>
				html  : "<font color='red'>* <%= value%></font>",	
				<% } else { %>	
				html  : "<%= value%>",
				<% } %>	
				<%= HoValidator.isNotEmpty(colspan) ? "colspan: "+colspan+"," : ""  %><%= HoValidator.isNotEmpty(rowspan) ? "rowspan: "+rowspan+"," : ""  %>
				width      : <%= HoUtil.replaceNull(width, "320")  %> <%= HoValidator.isNotEmpty(colspan) ? ("*"+colspan) : "" %>
			})
			
<%		
		HoServletUtil.setOutArea(request);
	}
%>

<%
	if( isHtml ) {
%>
<jsp:doBody/>
<%	} %>
