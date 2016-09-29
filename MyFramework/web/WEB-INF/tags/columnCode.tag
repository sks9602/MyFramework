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
	import="project.jun.util.HoUtilExtjs"
	import="project.jun.util.HoValidator"
	import="project.jun.util.HoServletUtil"
	import="project.jun.util.HoSpringUtil"
	import="project.jun.util.cache.HoCache"	
	import="project.jun.util.cache.HoEhCache"
	import="project.jun.dao.result.HoMap"
	import="project.jun.dao.parameter.HoQueryParameterHandler"
	import="project.jun.dao.result.transfigure.HoMapHasList"
%><%-- 공통코드를 이용한 기본 검색 조건 생성 - combobox, radio, checkbox --%><%@ 
include file="include.tag" %><%@ 
attribute name="type"   type="java.lang.String"  required="true"%><%--  combo, radio, checkbox --%><%@ 
attribute name="name"   type="java.lang.String"%><%@ 
attribute name="groupCode" type="java.lang.String" %><%-- 기준 코드 --%><%@ 
attribute name="value"   type="java.lang.String" %><%-- 설정 값  , 여러 값일 경우 ","로 구분 ex1) "B1010" ex2) "B1010,B1020" multiSelect가 "Y"인 경우에만 다중 선택 됨.--%><%@ 
attribute name="require" type="java.lang.String" %><%@ 
attribute name="width"  type="java.lang.String"  %><%@ 
attribute name="codeColumn"  type="java.lang.String"  %><%@ 
attribute name="nameColumn"  type="java.lang.String"  %><%-- 필수여부 : 'Y'필수 / '기타' 선택  --%><%@ 
attribute name="multiSelect" type="java.lang.String" %><%-- 다중선태 가능 여부 : 'Y' 다중선택 가능  / '기타' 다중선태 불가  --%><%
	// Table 명
	String tName = "";
	// boolean 
	boolean isDB = false;
	// name 이 "."이 포함 된 경우 ex) HR_ABL.ABILITY_DEF -> tName : HR_ABL, name : ABILITY_DEF 로 바꿈.. 
	name = HoUtil.replaceNull(name);
	if( name.indexOf(".") >= 0) {
		String nameUp = name.toUpperCase().trim();
		String [] tcName = nameUp.split("\\.");
		
		tName = tcName[0];
		name  = tcName[1];
		isDB  = true;
		
		HoMap colHoMap = COLUMN_SET_MAP.getHoMap(nameUp);
		
		if( HoValidator.isEmpty(groupCode)) {
			groupCode = colHoMap.getString("VALUE");
		}
	}	

 	if( isScript || isScriptOut ) {
		String nowArea = HoServletUtil.getNowArea(request);
				
		int itemNowIndex = HoServletUtil.getIndex(request, HoServletUtil.getArea(request));
		// int increaseIndex = getIndexIncrement( type );

		// HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request), increaseIndex );
		HoServletUtil.setInArea(request, "columnItem");
		HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request)+"_columnCode");
		int increaseIndex = HoServletUtil.getIndex(request, HoServletUtil.getArea(request)+"_columnCode");


		// String gridId = HoUtil.replaceNull(HoServletUtil.getString(request, "grid-id"), HoServletUtil.getString(request, "treegrid-id"));
		String gridId = HoServletUtil.getString(request, "grid-id");
				
		if( HoServletUtil.getArea(request).indexOf("columns>column>") >= 0 ) { 
			out.print("editor : ");
		}

		if( "combo".equals(type) || "select".equals(type) ){
			HoList list = cache.getHoList(groupCode); // cache defined in "include.tag"
			HoAspUtil  aspUtil = new HoAspUtil();

			HoList aspHoList = aspUtil.getHoListAsp( list, "0000", "1000", "COMPANY_ID", "CD");
%>		
			{
				xtype         : 'combotipple_ux', // 
				id            : '<%= p_action_flag %>_<%= gridId %>_<%= HoUtil.replaceNull(name, groupCode+"_"+increaseIndex) %>',
		        <%= HoValidator.isIn(require, new String[]{"Y","true"}, true) ? "allowBlank : false, labelCls   : 'x-form-item-label x-form-item-label-required'," : "" %>
		        <%= HoValidator.isNotEmpty(codeColumn)? "valueField : '" + codeColumn +"'," : "" %><%= HoValidator.isNotEmpty(nameColumn)? "displayField : '" + nameColumn +"'," : "" %>
		        value         : <%= HoUtilExtjs.toValueArray(value) %>, // B2020
		        <%= HoValidator.isIn(multiSelect, new String[]{"Y","true"}, true)  ? "multiSelect : true, " : ""%>
		        code          : '<%= groupCode %>', 
		        <%= HoValidator.isNotEmpty(width) ? "width : " + width + "," : "" %>
		        <jsp:doBody></jsp:doBody>
		        store         : Ext.create('Ext.data.Store', {
					storeId           : '<%= p_action_flag %>_store_editor_<%= gridId +"_"+HoServletUtil.getString(request, "column_id") %>',
		            fields    : [<%= list != null ?  list.getMetaDataString() : "" %> ],
		            data      : [<%	
						for(int i=0; aspHoList!=null && i<aspHoList.size(); i++) {
							out.print((i>0 ? "," : "") + " {" + aspHoList.toJson(i) + "}");
						}	
		            %>
		            ]
		        })
		     }
<%
		} else if( "text".startsWith(type) ){
%>
			{
				xtype      : 'textfield_ux',  
				id         : '<%= p_action_flag %>_<%= gridId %>_<%= HoUtil.replaceNull(name, groupCode+"_"+increaseIndex) %>',
				<%= HoValidator.isIn(require, new String[]{"Y","true"}, true) ? "allowBlank : false, labelCls   : 'x-form-item-label x-form-item-label-required'," : "" %>
				<%= HoValidator.isNotEmpty(width) ? "width : " + width + "," : "" %>
		        <jsp:doBody></jsp:doBody>
				qtip       : ''
			}
<%			
		}
 		if( HoServletUtil.getArea(request).indexOf("column") >= 0 ) {
			out.print(", ");
 		}
		HoServletUtil.setOutArea(request);
	}
%>

<%
	if( isHtml ) {
%>
<jsp:doBody/>
<%	} %>
