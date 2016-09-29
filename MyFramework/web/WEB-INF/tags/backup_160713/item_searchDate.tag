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
	import="project.jun.util.cache.HoCache"	
	import="project.jun.util.cache.HoEhCache"
	import="project.jun.dao.result.transfigure.HoMapHasList"
%>
<%@ include file="include.tag" %>
<%@ attribute name="type"  type="java.lang.String"  required="true"%>
<%@ attribute name="title" type="java.lang.String"  %>
<%@ attribute name="name"  type="java.lang.String"  required="true" %>
<%@ attribute name="value" type="java.lang.String" %>
<%@ attribute name="require" type="java.lang.String" %><%-- 필수여부 : 'Y'필수 / '기타' 선택  --%>
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

		if( "period".equals(type)) {
%>
			{
				xtype          : 'periodDate', msgTarget  : 'side', 
				width          : 260, labelWidth : <%=labelWidth %>,
				fieldLabel     : '<%= title %>', <%= HoValidator.isIn(require, new String[]{"Y","true"}, true) ? "allowBlank : false, labelCls   : 'x-form-item-label x-form-item-label-required'," : "" %>
				name           : 'stt_<%= name %>',
				value          : '<%= HoUtil.replaceNull(value) %>',
				commentsTitle : 'OK 한글',  // 추가 Comments Title 
				comments : '한글 your help text or even html comes here....',  // 추가 Comments 내용
				<jsp:doBody></jsp:doBody>
				id             : 'id_stt_<%= name %>_<%=p_action_flag%>',
				edDtId         : 'id_end_<%= name %>_<%=p_action_flag%>'
			}, {xtype           :'label', text : '~', labelCls : 'x-form-item-label', width : 10  },
			{
				xtype     : 'periodDate',  msgTarget  : 'side', 
				width     : 140,
				<%= HoValidator.isIn(require, new String[]{"Y","true"}, true) ? "allowBlank : false, labelCls   : 'x-form-item-label x-form-item-label-required'," : "" %>
				name      : 'end_<%= name %>',
				value     : '<%= HoUtil.replaceNull(value) %>',
				<jsp:doBody></jsp:doBody>
				id        : 'id_end_<%= name %>_<%=p_action_flag%>',
				stDtId    : 'id_stt_<%= name %>_<%=p_action_flag%>'
			},  
			{	
				xtype : 'periodButton',  
				name : '<%= name %>' , 
				actionFlag : '<%=p_action_flag%>' 
			} ,  
			{	
				xtype : 'label',
				width : 149
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
