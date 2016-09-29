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
<!-- 공통코드를 이용한 기본 검색 조건 생성 - combobox, radio, checkbox -->
<%@ include file="include.tag" %>
<%@ attribute name="title" type="java.lang.String"  %>
<%@ attribute name="type" type="java.lang.String" %>
<%@ attribute name="groupCode" type="java.lang.String" %>
<%@ attribute name="first" type="java.lang.String" %>
<%@ attribute name="name" type="java.lang.String" required="true" %>
<%@ attribute name="value" type="java.lang.String" %>
<%@ attribute name="multiSelect" type="java.lang.String" %>
<%@ attribute name="require" type="java.lang.String" %><%-- 필수여부 : 'Y'필수 / '기타' 선택  --%>
<%@ attribute name="count" type="java.lang.String" %><%--- 몇개의 combobox를 생성 할지 --%>
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

		if( "combo".equals(type) || "select".equals(type) ){
			// GROUP_CODE를 이용해서 TITLE가져 옴. 
			// TODO title없을 때로 변경..해야 함.
			if( HoValidator.isNotEmpty(groupCode) && CODE_SET_MAP.getHoMap(groupCode) !=null ) {
				title = CODE_SET_MAP.getHoMap(groupCode).getString("CODE_NM");
			}
%>
			{
		        xtype         : 'combotipple', 
		        width         : 320,  labelWidth : <%=labelWidth %>,
		        first         : '<%= HoUtil.replaceNull(first) %>',
		        fieldLabel    : '<%= title %>', <%= HoValidator.isIn(require, new String[]{"Y","true"}, true) ? "allowBlank : false, labelCls   : 'x-form-item-label x-form-item-label-required'," : "" %>
		        name          : '<%= name %>',
				commentsTitle : 'OK 한글', 
				comments : '한글 your help text or even html comes here....', 
		        displayField  : 'NAME',
		        valueField    : 'VALUE',
		        value         : '', // B2020
		        queryMode     : 'local',
		        triggerAction : 'all',
		        forceSelection: true,
		        <%= HoValidator.isIn(multiSelect, new String[]{"Y","true"}, true)  ? " multiSelect : true, " : ""%>
		        // editable      : false,
		        code          : '<%= groupCode %>', 
		        store         : Ext.create('Ext.data.Store', {
		            fields    : ['NAME', 'VALUE', 'GROUP', 'COMPANY_CD', 'CODE', 'CODE_NM', 'UP_CD', 'USEDEF1', 'USEDEF2', 'USEDEF3', 'USEDEF4', 'USEDEF5', 'COMMENTS_TITLE', 'COMMENTS' ],
		            data      : [<%
						if( "all".equalsIgnoreCase(first) && !HoValidator.isIn(multiSelect, new String[]{"Y","true"}, true) ) { // all이고  multiSelect가 아닌 경우
							out.println("{NAME : '-전체-',   VALUE : ''  , group : ''},");
						}
		            
						HoList list = cache.getHoList(groupCode); // cache defined in "include.tag"
						
						HoAspUtil  aspUtil = new HoAspUtil();
						
						HoList aspHoList = aspUtil.getHoListAsp( list, "0001", "1000", "COMPANY_CD", "CODE");
						
						for(int i=0; aspUtil!=null && i<aspHoList.size(); i++) {
							out.println((i>0 ? "," : "") + " {NAME : '"+aspHoList.getString(i,"NAME")+"',   VALUE : '"+aspHoList.getString(i,"VALUE")+"'  , GROUP : '"+aspHoList.getString(i,"UP_CD")+"' , USEDEF1 : '"+aspHoList.getString(i,"USEDEF1")+"', USEDEF2 : '"+aspHoList.getString(i,"USEDEF2")+"', USEDEF3 : '"+aspHoList.getString(i,"USEDEF3")+"', USEDEF4 : '"+aspHoList.getString(i,"USEDEF4")+"', USEDEF5 : '"+aspHoList.getString(i,"USEDEF5")+"' ");
							if( HoValidator.isNotEmpty(aspHoList.getString(i,"COMMENTS_TITLE")) &&  HoValidator.isNotEmpty(aspHoList.getString(i,"COMMENTS")) ) {
								out.println(", COMMENTS_TITLE : '"+aspHoList.getString(i,"COMMENTS_TITLE")+"'  , COMMENTS : '"+aspHoList.getString(i,"COMMENTS")+"'");
							}
							out.println("}");
						}
		            %>
		            ]
		        })
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
