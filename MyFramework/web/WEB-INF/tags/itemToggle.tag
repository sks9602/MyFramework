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
<%@ attribute name="type" type="java.lang.String" %>
<%@ attribute name="title" type="java.lang.String"  %>
<%@ attribute name="name" type="java.lang.String" %>
<%@ attribute name="groupCode" type="java.lang.String" %>
<%@ attribute name="value" type="java.lang.String" %>
<%@ attribute name="require" type="java.lang.String" %><%-- 필수여부 : ('Y', true) 필수 / '기타' 선택  --%>
<%@ attribute name="id" type="java.lang.String" %><%@ 
attribute name="colspan"    type="java.lang.String" %><%@ 
attribute name="rowspan"    type="java.lang.String" %>
<% 	if( isScript || isScriptOut ) {

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

		if( itemNowIndex + increaseIndex > getMaxItemByArea(request) ) {
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
			item.put("MAX_LENGTH", "");
			item.put("VTYPES", "");
			setFormItemInfo( request, param,  item ); 
		}

	if( "toggle".equals(type)) { %>
			{	xtype      : 'toggleslidefield',  msgTarget  : 'side',  
				id         : '<%=p_action_flag %>_<%= formId %>_<%= name.toUpperCase() %>', // _toggle
				width     : 200 + <%=labelWidth %>, labelWidth : <%=labelWidth %>,
				fieldLabel: '<%= title %>',
				<%= HoValidator.isIn(require, new String[]{"Y","true"}, true) ? "allowBlank : false," : "" %>
				name      : '<%= name %>',
				booleanMode : false,
				value : '<%= HoUtil.replaceNull(value, "") %>',
				<%= HoValidator.isNotEmpty(colspan) ? "colspan: "+colspan+"," : ""  %><%= HoValidator.isNotEmpty(rowspan) ? "rowspan: "+rowspan+"," : ""  %>
	            onText: 'Y', 
	            offText: 'N'
			}
<%
		}

		HoServletUtil.setOutArea(request);
	}
%>

<%
	if( isHtml ) {
%>
<jsp:doBody/>
<%	} %>
