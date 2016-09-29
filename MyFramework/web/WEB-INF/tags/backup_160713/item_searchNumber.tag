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
	import="java.util.List"
	import="java.util.Date"
	import="java.text.DateFormat"
	import="project.jun.util.asp.HoAspUtil"
	import="project.jun.util.HoValidator"
	import="project.jun.dao.parameter.HoQueryParameterHandler"
	import="project.jun.util.HoServletUtil"
	import="project.jun.util.HoSpringUtil"
	import="project.jun.util.HoFormatter"
	import="project.jun.util.cache.HoCache"	
	import="project.jun.util.cache.HoEhCache"
	import="project.jun.dao.result.HoMap"
	import="project.jun.dao.result.transfigure.HoMapHasList"
	import="project.jun.util.HoUtilExtjs"
%><%@ 
include file="include.tag" %><%@
attribute name="type"  type="java.lang.String"  required="true"%><%-- scope, slider --%><%@ 
attribute name="title" type="java.lang.String"  %><%@ 
attribute name="name"  type="java.lang.String"  required="true"%><%@ 
attribute name="value" type="java.lang.String" %><%-- 설정 값 --%><%@ 
attribute name="scale" type="java.lang.String" %><%-- 숫자의 범위 oracle 기준 ex) 5,2 --%><%@ 
attribute name="min"   type="java.lang.String" %><%-- 최소값 --%><%@ 
attribute name="max"   type="java.lang.String" %><%-- 최대값 --%><%@ 
attribute name="unit"  type="java.lang.String" %><%-- 단위 --%><%@ 
attribute name="step"  type="java.lang.String" %><%-- 증가 크기 --%><%@ 
attribute name="require" type="java.lang.String" %><%-- 필수여부 : 'Y'필수 / '기타' 선택  --%>
<%
	// Table 명
	String tName = "";
	// boolean 
	boolean isDB = false;
	// name 이 "."이 포함 된 경우 ex) HR_ABL.ABILITY_DEF -> tName : HR_ABL, name : ABILITY_DEF 로 바꿈.. 
	if( name.indexOf(".") >= 0) {
		String nameUp = name.toUpperCase().trim();
		String [] tcName = nameUp.split("\\.");
		
		tName = tcName[0];
		name  = tcName[1];
		isDB  = true;
		
		HoMap colHoMap = COLUMN_SET_MAP.getHoMap(nameUp);
		
		if( HoValidator.isEmpty(title)) {
			title = colHoMap.getString("COLUMN_TITLE");
		}
		
		if( HoValidator.isEmpty(scale)) {
			scale = colHoMap.getString("SCALE");
		}
	}
	min = HoUtilExtjs.min(min, scale);
	max = HoUtilExtjs.max(max, scale);
	String precision = HoUtilExtjs.getPrecision(scale);

%>
<% 	if( isScript || isScriptOut ) {
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

		if( "scope".equals(type)) {
			// 입력 값을 배열로 변경..
			String [] nValues = HoUtilExtjs.toArrayValues(value);
%>
			{
				xtype          : 'numberfield_ux', 
				width          : 210, 
				fieldLabel     : '<%= title %>', <%= HoValidator.isIn(require, new String[]{"Y","true"}, true) ? "allowBlank : false, labelCls   : 'x-form-item-label x-form-item-label-required'," : "" %>
				name           : 'stt_<%= name %>',
				value          : '<%= HoUtil.replaceNull(nValues[0]) %>',
				commentsTitle : 'OK 한글',  // 추가 Comments Title 
				comments : '한글 your help text or even html comes here....',  // 추가 Comments 내용
		        <jsp:doBody></jsp:doBody>
				id             : 'id_stt_<%= name %>_<%=p_action_flag%>',
				<%= HoValidator.isNotEmpty(min) ? "minValue : " + min + ", emptyText : 'ex) "+ min + "'," : "" %><%= HoValidator.isNotEmpty(max) ? "maxValue : " + max + "," : "" %><%= HoValidator.isNotEmpty(step) ? "step : " + step + "," : "" %>
				<%= HoValidator.isNotEmpty(precision) && HoValidator.isNumber(precision) ? "forcePrecision : true, decimalPrecision : " + precision + "," : "allowDecimals : false," %>
				edId         : 'id_end_<%= name %>_<%=p_action_flag%>'
			}
			<% if( HoValidator.isNotEmpty(unit)) { %>
			, {
		        xtype: 'label',
		        text: '<%= unit %>',
		        margins: '4 5 0 -2'
		    }
		    <% } %>
			, {xtype           :'label', text : '~', labelCls : 'x-form-item-label', width : 10  },
			{
				xtype     : 'numberfield_ux',  
				width     : 90,
				<%= HoValidator.isIn(require, new String[]{"Y","true"}, true) ? "allowBlank : false, labelCls   : 'x-form-item-label x-form-item-label-required'," : "" %>
				name      : 'end_<%= name %>',
				value     : '<%= HoUtil.replaceNull(nValues[1]) %>',
				commentsTitle : 'OK 한글',  // 추가 Comments Title 
				comments : '한글 your help text or even html comes here....',  // 추가 Comments 내용
		        <jsp:doBody></jsp:doBody>
				id        : 'id_end_<%= name %>_<%=p_action_flag%>',
				<%= HoValidator.isNotEmpty(min) ? "minValue : " + min + "," : "" %><%= HoValidator.isNotEmpty(max) ? "maxValue : " + max + ", emptyText : 'ex) "+ max + "'," : "" %><%= HoValidator.isNotEmpty(step) ? "step : " + step + "," : "" %>
				<%= HoValidator.isNotEmpty(precision) && HoValidator.isNumber(precision) ? "forcePrecision : true, decimalPrecision : " + precision + "," : "allowDecimals : false," %>
				stId    : 'id_stt_<%= name %>_<%=p_action_flag%>'
			}
			<% if( HoValidator.isNotEmpty(unit)) { %>
			, {
		        xtype: 'label',
		        text: '<%= unit %>',
		        margins: '4 5 0 -2'
		    }
		    <% } %>
<%
		} else  if("slider".equals(type)) {
%>
			{
				xtype :  'multiSlider_ux',
				values : <%= HoUtilExtjs.toValueArray(value, min, max) %>, // ['20','50'],
				fieldLabel     : '<%= title %>', 
				name      : '<%= name %>',
				commentsTitle : 'OK 한글',  // 추가 Comments Title 
				comments : '한글 your help text or even html comes here....',  // 추가 Comments 내용
				<%= HoValidator.isNotEmpty(min) ? "minValue : " + min + "," : "" %><%= HoValidator.isNotEmpty(max) ? "maxValue : " + max + "," : "" %><%= HoValidator.isNotEmpty(step) ? "increment : " + step + "," : "" %>
				tip : '<%= title %>'		
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
