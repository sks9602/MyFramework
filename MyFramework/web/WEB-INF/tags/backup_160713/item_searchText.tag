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
%><%@ include file="include.tag" %><%-- input type="XX" 형태의 component 생성 --%><%@ 
attribute name="type"   type="java.lang.String" required="true"%><%--  text, label(테두리 없이 값만 나오는 형태 - 파라미터로는 전송됨), hidden --%><%@ 
attribute name="title"  type="java.lang.String" %><%@ 
attribute name="name"   type="java.lang.String" required="true"%><%@ 
attribute name="value"  type="java.lang.String" %><%@ 
attribute name="require" type="java.lang.String" %><%-- 필수여부 : 'Y'필수 / '기타' 선택  --%><%@ 
attribute name="vtype"   type="java.lang.String" %><%@ 
attribute name="unit"    type="java.lang.String" %><% 	
	if( isScript || isScriptOut ) {
		String nowArea = HoServletUtil.getNowArea(request);
		
		if( !"fieldcontainer".equals(nowArea)) {
			HoServletUtil.setInArea(request, "fieldcontainer");
			HoServletUtil.initIndex(request, HoServletUtil.getArea(request));
			int itemsRow = HoServletUtil.getIndex(request, HoServletUtil.getArea(request)+"_row");
			HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request)+"_row");
			out.print( (itemsRow > 0 ? "," : "") +"		");
			out.println("{ xtype: 'fieldcontainer', layout: { type: 'hbox', defaultMargins: {top: "+(itemsRow > 0 ? "0" : "1")+", right: 5, bottom: 0, left: 0} }, ");
			out.print("		");
			out.println("items: [");
		}

		int itemNowIndex = HoServletUtil.getIndex(request, HoServletUtil.getArea(request));
		int increaseIndex = getIndexIncrement( type );

		// out.println("<br/>" + HoServletUtil.getArea(request) + ":" +  itemNowIndex + ":"+ increaseIndex );
		if( itemNowIndex + increaseIndex > getMaxItemByArea(request)  ) { // MAX_ROW_ITEM_SEARCH
			HoServletUtil.initIndex(request, HoServletUtil.getArea(request)+">item_row");
			out.println("] }");
			HoServletUtil.initIndex(request, HoServletUtil.getArea(request));
			String area = HoServletUtil.getNowArea(request);

			HoServletUtil.setOutArea(request);
			HoServletUtil.setInArea(request, "fieldcontainer");
			int itemsRow = HoServletUtil.getIndex(request, HoServletUtil.getArea(request)+"_row");
			HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request)+"_row");
			out.print( (itemsRow > 0 ? "," : "") +"		");
			out.println("{ xtype: 'fieldcontainer', layout: { type: 'hbox', defaultMargins: {top: 0, right: 5, bottom: 0, left: 0} },");
			out.print("		");
			out.println("items: [");
		}

		HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request), increaseIndex );
		HoServletUtil.setInArea(request, "item");
		out.println(HoServletUtil.getIndex(request, HoServletUtil.getArea(request)+"_row") > 0 ? "," : "");
		HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request)+"_row");

		if( "text".equals(type) ) {
%>
			{
				xtype      : 'textfield_ux',  
				fieldLabel : '<%= title %>', <%= HoValidator.isIn(require, new String[]{"Y","true"}, true) ? "allowBlank : false, labelCls   : 'x-form-item-label x-form-item-label-required'," : "" %>
				name       : '<%= name %>',
				commentsTitle : 'OK 한글',  // 추가 Comments Title 
				comments : '한글 your help text or even html comes here....',  // 추가 Comments 내용
		        <jsp:doBody></jsp:doBody>
				<%= HoValidator.isNotEmpty(vtype) ? "vtype: '"+vtype+"'," : "" %>			
				qtip       : '<%= title %>'
			}
			<% if( HoValidator.isNotEmpty(unit)) { %>
			, {
		        xtype: 'label',
		        text: '<%= unit %>',
		        margins: '4 5 0 -2'
		    }
		    <% } %>
<%
		} else if( "label".equals(type) ) {
%>
			{
				xtype: 'displayfield',
				fieldLabel: '<%= title %>',labelSeparator : '',
				name      : '<%= name %>',
				value: '<%= HoUtil.replaceNull(value) %>',
		        <jsp:doBody></jsp:doBody>
				qtip       : '<%= title %>'
			}
			<% if( HoValidator.isNotEmpty(unit)) { %>
			, {
		        xtype: 'label',
		        text: '<%= unit %>',
		        margins: '4 5 0 -2'
		    }
		    <% } %>
<%
		} else if( "hidden".equals(type)) {
%>
			{
				xtype     : 'hidden',
				width     : 320,
				name      : '<%= name %>',
				value     : '<%= HoUtil.replaceNull(value) %>',
		        <jsp:doBody></jsp:doBody>
				qtip       : '<%= title %>'
			}
<%		}
		HoServletUtil.setOutArea(request);
	}
%>

<%
	if( isHtml ) {
%>
<jsp:doBody/>
<%	} %>
