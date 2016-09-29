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
	import="project.jun.util.HoUtilExtjs"
	import="project.jun.util.HoValidator"
	import="project.jun.util.HoServletUtil"
	import="project.jun.util.HoSpringUtil"
	import="project.jun.util.asp.HoAspUtil"
	import="project.jun.util.cache.HoCache"	
	import="project.jun.util.cache.HoEhCache"
	import="project.jun.dao.result.transfigure.HoMapHasList"
	import="project.jun.dao.parameter.HoQueryParameterHandler"
%><%@ taglib prefix="spring"  uri="http://www.springframework.org/tags" %>
<%@ include file="include.tag" %><%-- input type="XX" 형태의 component 생성 --%><%@ 
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
		
		if( "member".equals(type) ) {
			String groupCode = "SYS001";
			String first = "all";
			String codeColumn = "", nameColumn = "", multiSelect = "N";
			HoList list = null;
            // 쿼리를 통해 구성하는 경우
            if( groupCode.indexOf(".")>0) {
        		HoQueryParameterHandler hqph = new HoQueryParameterHandler(param, hoConfig);

        		HoQueryParameterMap value = hqph.getForDetail();

        		list = dao.select(groupCode, value);
            } 
            // 공통코드로 구하는 경우.
            else {
            	list = cache.getHoList(groupCode); // cache defined in "include.tag"
            }
			HoAspUtil  aspUtil = new HoAspUtil();

			HoList aspHoList = null;
			if( list != null ) {
				aspHoList = aspUtil.getHoListAsp( list, "0000", "1000", "COMPANY_ID", "CD");
			} 
%>
		{ 	layout: { type : 'table' , columns: 2 }, // 'hbox',
			border : 0,
			colspan : <%= HoUtil.replaceNull(colspan, "2") %>,
			items : [
			{
				xtype         : 'combotipple_ux', 
				id            : '<%=p_action_flag %>_<%=HoServletUtil.getString(request, "form-id") %>_<%= name %>_type',
				first         : '<%= HoUtil.replaceNull(first) %>',
		        fieldLabel    : '<%= title %>', <%= HoValidator.isIn(require, new String[]{"Y","true"}, true) ? "allowBlank : false, labelCls   : 'x-form-item-label x-form-item-label-required'," : "" %>
		        labelWidth : <%=labelWidth %>,
		        name          : '<%= name %>_type',
		        width : 280, margin : '0 4 0 0',
		        <%= HoValidator.isNotEmpty(codeColumn)? "valueField : '" + codeColumn +"'," : "" %><%= HoValidator.isNotEmpty(nameColumn)? "diplayField : '" + nameColumn +"'," : "" %>
		        value         : <%= HoUtilExtjs.toValueArray(value) %>, // B2020
		        <%= HoValidator.isIn(multiSelect, new String[]{"Y","true"}, true)  ? "multiSelect : true, " : ""%>
		        code          : '<%= groupCode %>', 
				<%= HoValidator.isNotEmpty(colspan) ? "colspan: "+colspan+"," : ""  %><%= HoValidator.isNotEmpty(rowspan) ? "rowspan: "+rowspan+"," : ""  %>
		        <jsp:doBody></jsp:doBody>
		        store         : Ext.create('Ext.data.Store', {
		            fields    : [<%= list!=null ? list.getMetaDataString() : "" %> ],
		            data      : [<%
						if( "all".equalsIgnoreCase(first) && !HoValidator.isIn(multiSelect, new String[]{"Y","true"}, true) ) { // all이고  multiSelect가 아닌 경우
							out.println("{NAME : '-전체-',   VALUE : ''  , group : ''},");
						}
		            
						for(int i=0; aspHoList!=null && i<aspHoList.size(); i++) {
							out.print((i>0 ? "," : "") + " {" + aspHoList.toJson(i) + "}");
						}					
		            %>
		            ]
		        })
		     },
			{
				xtype      : 'textfield_ux', // <%= HoServletUtil.getArea(request).indexOf("section") >= 0 ? "margin : '0 2 1 0'," : "" %> 
				itemId     : '<%= name.toUpperCase() %>',
				id         : '<%=p_action_flag %>_<%= formId %>_<%= name.toUpperCase() %>', // _text
				<%= HoValidator.isIn(require, new String[]{"Y","true"}, true) ? "allowBlank : false, labelCls   : 'x-form-item-label x-form-item-label-required'," : "" %>
				name       : '<%= name %>_NM',
				value: '<%= HoUtil.replaceNull(value) %>',
				width : 360,
		        <jsp:doBody></jsp:doBody>
				<!-- %= HoValidator.isNotEmpty(width) ? "width: "+width+"+" +labelWidth+"," : "" % --> 
				<%= HoValidator.isNotEmpty(vtype) ? "vtype: '"+vtype+"'," : "" %>	
				<%= HoValidator.isNotEmpty(unit) ? "afterSubTpl : '"+ unit +"'," : "" %>		
				<%= HoValidator.isNotEmpty(colspan) ? "colspan: "+colspan+"," : ""  %><%= HoValidator.isNotEmpty(rowspan) ? "rowspan: "+rowspan+"," : ""  %>
				qtip       : '<%= title %>'
			}
		]}
<%		}
		HoServletUtil.setOutArea(request);
	}
%>

<%
	if( isHtml ) {
%>
<jsp:doBody/>
<%	} %>
