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
include file="include.tag" %>
<%@ attribute name="type"  type="java.lang.String"  required="true"%>
<%@ attribute name="title" type="java.lang.String"  %>
<%@ attribute name="name"  type="java.lang.String"  required="true" %>
<%@ attribute name="value" type="java.lang.String" %>
<%@ attribute name="require" type="java.lang.String" %><%-- 필수여부 : 'Y'필수 / '기타' 선택  --%><%@ 
attribute name="colspan"    type="java.lang.String" %><%@ 
attribute name="rowspan"    type="java.lang.String" %>
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
	}
%>
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
			if( "period".equals(type)) {
			
				HoQueryParameterMap item1 = new HoQueryParameterMap();
				
				item1.put("ITEM_NM", HoUtil.replaceNull("STT_"+name));
				item1.put("ITEM_TT", HoUtil.replaceNull(title));
				item1.put("ITEM_TP", HoUtil.replaceNull("date_"+type));
				setFormItemInfo( request,  param, item1 ); 
				HoQueryParameterMap item2 = new HoQueryParameterMap();
				
				item2.put("ITEM_NM", HoUtil.replaceNull("END_"+name));
				item2.put("ITEM_TT", HoUtil.replaceNull(title));
				item2.put("ITEM_TP", HoUtil.replaceNull("date_"+type));
				setFormItemInfo( request,  param, item2 ); 
			} else  if("date".equals(type)) {
				HoQueryParameterMap item = new HoQueryParameterMap();
				
				item.put("ITEM_NM", HoUtil.replaceNull(name));
				item.put("ITEM_TT", HoUtil.replaceNull(title));
				item.put("ITEM_TP", HoUtil.replaceNull("date_"+type));
				setFormItemInfo( request,  param, item ); 
			}
		}

		
		if( "period".equals(type)) {
			// 입력 값을 배열로 변경..
			String [] nValues = HoUtilExtjs.toArrayValues(value);
%>
		{ 	layout: { type : 'table' , columns: 3 }, // 'hbox',
			border : 0,
			colspan : <%= HoUtil.replaceNull(colspan, "2") %>,
			<%= HoValidator.isNotEmpty(rowspan) ? "rowspan: "+rowspan+"," : ""  %>
			items : [
						{
				xtype          : 'perioddate_ux', msgTarget  : 'side', 
				width          : 260, labelWidth : <%=labelWidth %>,
				fieldLabel     : '<%= title %>', <%= HoValidator.isIn(require, new String[]{"Y","true"}, true) ? "allowBlank : false, labelCls   : 'x-form-item-label x-form-item-label-required'," : "" %>
				name           : 'STT_<%= name %>',
				value          : '<%= HoUtil.replaceNull(value) %>',
				<jsp:doBody></jsp:doBody>
				id             : 'id_stt_<%= name %>_<%=p_action_flag%>',
				edDtId         : 'id_end_<%= name %>_<%=p_action_flag%>'
			}, 
			{xtype           :'label', text : ' ~ ', labelCls : 'x-form-item-label', margin : '0 5 0 5'  },
			{
				xtype     : 'perioddate_ux',  msgTarget  : 'side', 
				width     : 140,
				<%= HoValidator.isIn(require, new String[]{"Y","true"}, true) ? "allowBlank : false, labelCls   : 'x-form-item-label x-form-item-label-required'," : "" %>
				name      : 'END_<%= name %>',
				value     : '<%= HoUtil.replaceNull(value) %>',
				<jsp:doBody></jsp:doBody>
				id        : 'id_end_<%= name %>_<%=p_action_flag%>',
				stDtId    : 'id_stt_<%= name %>_<%=p_action_flag%>'
			} 
			/*  
			, {	
				xtype : 'periodbutton_ux',  
				name : '<%= name %>' , 
				margin : '0 0 0 5',
				actionFlag : '<%=p_action_flag%>' 
			} 
			*/
			]}
<%
		} else  if("date".equals(type)) {
%>
			{
				xtype :  'datefield_ux',
				value : '<%= HoUtil.replaceNull(value) %>',
				fieldLabel     : '<%= title %>', 
				labelWidth : <%=labelWidth %>,
				name      : '<%= name.toUpperCase() %>',
				commentsTitle : 'OK 한글',  // 추가 Comments Title 
				comments : '한글 your help text or even html comes here....',  // 추가 Comments 내용
				<%= HoValidator.isNotEmpty(colspan) ? "colspan: "+colspan+"," : ""  %><%= HoValidator.isNotEmpty(rowspan) ? "rowspan: "+rowspan+"," : ""  %>
				tip : '<%= title %>'		
			}

<%			
		}
		HoServletUtil.setOutArea(request);
	}
%>

<%	if( isHtml ) { %><jsp:doBody/><% } %>
