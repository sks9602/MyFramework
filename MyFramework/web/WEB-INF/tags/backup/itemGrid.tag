<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag
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
	import="java.util.Date"
	import="java.text.DateFormat"
	import="project.jun.util.HoValidator"
	import="project.jun.dao.parameter.HoQueryParameterHandler"
	import="project.jun.util.HoServletUtil"
%>
<%@ include file="include.tag" %>
<%@ attribute name="title" type="java.lang.String"  %>
<%@ attribute name="type" type="java.lang.String" %>
<%@ attribute name="groupCode" type="java.lang.String" %>
<%@ attribute name="first" type="java.lang.String" %>
<%@ attribute name="name" type="java.lang.String" %>
<%@ attribute name="value" type="java.lang.String" %>
<%@ attribute name="id" type="java.lang.String" %>
<%@ attribute name="require" type="java.lang.String" %><%-- 필수여부 : ('Y', true) 필수 / '기타' 선택  --%>
<%@ attribute name="vtype" type="java.lang.String" %>
<%@ attribute name="folder" type="java.lang.String" %><%-- fileupload시 파일이 등록될 폴더명 (type="file")에서만 사용 --%><%@ 
attribute name="colspan"    type="java.lang.String" %>

<% 	if( isScript || isScriptOut ) {

		String nowArea = HoServletUtil.getNowArea(request);
		
		String MAX_ROW_ITEM = HoServletUtil.getString(request, "MAX_ROW_ITEM");
		colspan = HoValidator.isNotEmpty(colspan) ? colspan : MAX_ROW_ITEM;

		if( !"fieldcontainer".equals(nowArea)) {
			HoServletUtil.setInArea(request, "fieldcontainer");
			HoServletUtil.initIndex(request, HoServletUtil.getArea(request));
			int itemsRow = HoServletUtil.getIndex(request, HoServletUtil.getArea(request)+"_row");
			HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request)+"_row");
			out.print( (itemsRow > 0 ? "," : "") +"		");
		}

		int itemNowIndex = HoServletUtil.getIndex(request, HoServletUtil.getArea(request));
		int increaseIndex = getIndexIncrement( type );

		// out.println("<br/>" + HoServletUtil.getArea(request) + ":" +  itemNowIndex + ":"+ increaseIndex );
		if( itemNowIndex + increaseIndex > MAX_ROW_ITEM_SEARCH ) {
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
		HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request)+"_row");

%> 		
	{ 	layout: { type : 'table' , columns: 2 , tdAttrs: {valign: 'top'} }, 
		border : 0,
		defaults: {style : 'margin-top:1px;' },
		colspan : <%= colspan %>,
		items : [	
			{ 
				xtype :'label_ux', 
				margin : '0 <%= HoServletUtil.getArea(request).indexOf("section") > 0 ? "10" : "15" %> 0 0',
				labelWidth : <%=labelWidth %>,
				cls : 'x-form-item-label <%= HoValidator.isIn(require, new String[]{"Y","true"}, true) ? " x-form-item-label-required" : "" %>', 
				text : '<%= title  %>', 
				commentsTitle : 'OK 한글',  // 추가 Comments Title 
				comments : '한글 your help text or even html comes here....',  // 추가 Comments 내용
				value: '<%= HoUtil.replaceNull(value) %>'
			} // , //, style : 'width:100px; padding-left:5px;' width : <%=HoServletUtil.getArea(request).indexOf("section")>0 ? "90" : "95"%> },
			<jsp:doBody></jsp:doBody>
		] 
	}
<%

		HoServletUtil.setOutArea(request);
	}
%>

<%
	if( isHtml ) {
%>
<jsp:doBody/>
<%	} %>
