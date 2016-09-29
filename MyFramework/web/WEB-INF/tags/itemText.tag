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
 attribute name="id" type="java.lang.String"%><%@ 
attribute name="type"   type="java.lang.String" required="true"%><%--  text, label(테두리 없이 값만 나오는 형태 - 파라미터로는 전송됨), hidden --%><%@ 
attribute name="title"  type="java.lang.String" %><%@ 
attribute name="name"   type="java.lang.String" required="true"%><%@ 
attribute name="value"  type="java.lang.String" %><%@ 
attribute name="require" type="java.lang.String" %><%-- 필수여부 : 'Y'필수 / '기타' 선택  --%><%@ 
attribute name="vtype"   type="java.lang.String" %><%@ 
attribute name="unit"    type="java.lang.String" %><%@ 
attribute name="width"    type="java.lang.String" %><%@ 
attribute name="colspan"    type="java.lang.String" %><%@ 
attribute name="rowspan"    type="java.lang.String" %><%@ 
attribute name="maxLength"    type="java.lang.String" %><% 	
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

		name = HoUtil.replaceNull(name).toUpperCase();

		// 개발 모드 일경우 form의 Item을 request에 저장.
		if( !hoConfig.isProductMode() ) {
			HoQueryParameterMap item = new HoQueryParameterMap();
			
			item.put("ITEM_NM", name);
			item.put("ITEM_TT", HoUtil.replaceNull(title));
			item.put("ITEM_TP", HoUtil.replaceNull(type));
			item.put("MAX_LENGTH", "TODO");
			item.put("VTYPES", HoUtil.replaceNull(vtype));
			setFormItemInfo( request,  param, item ); 
		}
		
		id = HoUtil.replaceNull(id);
		
		if( "text".equals(type) ) {
%>
			{
				xtype      : 'textfield_ux', // <%= HoServletUtil.getArea(request).indexOf("section") >= 0 ? "margin : '0 2 1 0'," : "" %> 
				itemId     : '<%= name.toUpperCase() %>',
				id         : '<%=p_action_flag %>_<%= formId %>_<%= name.toUpperCase() %>', // _text
				fieldLabel : '<%= title %>', <%= HoValidator.isIn(require, new String[]{"Y","true"}, true) ? "allowBlank : false, labelCls   : 'x-form-item-label x-form-item-label-required'," : "" %>
				name       : '<%= name %>',
				labelWidth : <%=labelWidth %>,
				/*
				commentsTitle : 'OK 한글',  // 추가 Comments Title 
				comments : '한글 your help text or even html comes here....',  // 추가 Comments 내용
				*/
				value: '<%= HoUtil.replaceNull(value) %>',
		        <jsp:doBody></jsp:doBody>
				<%= HoValidator.isNotEmpty(width) ? "width: "+width+"+" +labelWidth+"," : "" %> 
				<%= HoValidator.isNotEmpty(vtype) ? "vtype: '"+vtype+"'," : "" %>	
				<%= HoValidator.isNotEmpty(unit) ? "afterSubTpl : '"+ unit +"'," : "" %>		
				<%= HoValidator.isNotEmpty(colspan) ? "colspan: "+colspan+"," : ""  %><%= HoValidator.isNotEmpty(rowspan) ? "rowspan: "+rowspan+"," : ""  %>
				qtip       : '<%= title %>'
			}
<%
		} else if( "label".equals(type) ) {
%>
			{
				xtype: 'displayfield_ux', 
				id         : '<%=p_action_flag %>_<%= formId %>_<%= name.toUpperCase() %>', // _text
				fieldLabel: '<%= title %>', <%= HoValidator.isIn(require, new String[]{"Y","true"}, true) ? "allowBlank : false, labelCls   : 'x-form-item-label x-form-item-label-required'," : "" %>
				name      : '<%= name %>',
				submitValue: true,
				value: '<%= HoUtil.replaceNull(value) %>',
		        <jsp:doBody></jsp:doBody>
				<%= HoValidator.isNotEmpty(width) ? "width: "+width+"+" +labelWidth+"," : "" %> 
				<%= HoValidator.isNotEmpty(colspan) ? "colspan: "+colspan+"," : ""  %><%= HoValidator.isNotEmpty(rowspan) ? "rowspan: "+rowspan+"," : ""  %>
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
		} else if( "passsword".equals(type) ) { %>
			{
				xtype     : 'password_ux',
				fieldLabel: '<%= title %>', <%= HoValidator.isIn(require, new String[]{"Y","true"}, true) ? "allowBlank : false, labelCls   : 'x-form-item-label x-form-item-label-required', " : "" %>
				name      : '<%= name %>',
				id         : '<%=p_action_flag %>_<%= formId %>_<%= name.toUpperCase() %>', // _password
				value     : '<%= HoUtil.replaceNull(value) %>',
				<%= HoValidator.isNotEmpty(width) ? "width: "+width+"+" +labelWidth+"," : "" %> 
				<%=  !HoValidator.isEmpty(vtype) ? "vtype: '"+vtype+"'," : "" %>
				<%= HoValidator.isNotEmpty(colspan) ? "colspan: "+colspan+"," : ""  %><%= HoValidator.isNotEmpty(rowspan) ? "rowspan: "+rowspan+"," : ""  %>
				qtip       : '<%= title %>'
			}
<%		} else if( "textarea".equals(type) ) { %>
			{
				xtype     : 'textarea_ux', 
				width     : <%= HoUtil.replaceNull(width, "505")%> + <%=labelWidth %>,  
				fieldLabel: '<%= title %>', <%= HoValidator.isIn(require, new String[]{"Y","true"}, true) ? "allowBlank : false, labelCls   : 'x-form-item-label x-form-item-label-required'," : "" %>
				name      : '<%= name %>',
				id         : '<%=p_action_flag %>_<%= formId %>_<%= name.toUpperCase() %>', // _textarea 
				<%= HoValidator.isNotEmpty(width) ? "width: "+width+"+" +labelWidth+"," : "" %> 
				maxLength : <%= HoUtil.replaceNull(maxLength, "400") %>, 
				<%= HoValidator.isNotEmpty(colspan) ? "colspan: "+colspan+"," : ""  %><%= HoValidator.isNotEmpty(rowspan) ? "rowspan: "+rowspan+"," : ""  %>
				plugins: ['counter']  // CounterCheck.js
			}
<%		}else if( "hidden".equals(type)) {
%>
			{
				xtype     : 'hidden',
				id         : '<%=p_action_flag %>_<%= formId %>_<%= name.toUpperCase() %>', //_text
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
