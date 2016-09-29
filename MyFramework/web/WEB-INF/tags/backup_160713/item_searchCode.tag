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
attribute name="title"  type="java.lang.String"  %><%@ 
attribute name="name"   type="java.lang.String" required="true" %><%@ 
attribute name="groupCode" type="java.lang.String" %><%-- 기준 코드 --%><%@ 
attribute name="value"   type="java.lang.String" %><%-- 설정 값  , 여러 값일 경우 ","로 구분 ex1) "B1010" ex2) "B1010,B1020" multiSelect가 "Y"인 경우에만 다중 선택 됨.--%><%@ 
attribute name="require" type="java.lang.String" %><%-- 필수여부 : 'Y'필수 / '기타' 선택  --%><%@ 
attribute name="first"   type="java.lang.String" %><%-- "-선택-", "전체" 처럼 combobox 맨 위에 부가적으로 나온는 값  , ex) all("-전체-"), choice("-선택-"), none  --%><%@ 
attribute name="multiSelect" type="java.lang.String" %><%-- 다중선태 가능 여부 : 'Y' 다중선택 가능  / '기타' 다중선태 불가  --%><%
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
		
		if( HoValidator.isEmpty(groupCode)) {
			groupCode = colHoMap.getString("CODE");
		}
		if( HoValidator.isEmpty(title)) {
			title = colHoMap.getString("COLUMN_TITLE");
		}		
		// System.out.println("DATA_TYPE -->" + COLUMN_SET_MAP.getHoMap(nameUp).getString("DATA_TYPE") );
	}	

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

		if( "radio".equals(type)) {
%>
			{	
				xtype      : 'radiogroup_ux',    
		        fieldLabel : '<%= title %>', <%= HoValidator.isIn(require, new String[]{"Y","true"}, true) ? "allowBlank : false, labelCls   : 'x-form-item-label x-form-item-label-required'," : "" %>
				defaults : { name: '<%= name %>' },
				commentsTitle : 'OK 한글',  // 추가 Comments Title 
				comments : '한글 your help text or even html comes here....',  // 추가 Comments 내용
		        <jsp:doBody></jsp:doBody>
		        items : [<%		
		                HoList list = cache.getHoList(groupCode); // cache defined in "include.tag"
						
						HoAspUtil  aspUtil = new HoAspUtil();
						
						HoList aspHoList = aspUtil.getHoListAsp( list, "0001", "1000", "COMPANY_CD", "CODE");
						
						for(int i=0; aspHoList!=null && i<aspHoList.size(); i++) {
							out.print((i>0 ? "," : "") + " { width:100, boxLabel : '" + aspHoList.getString(i,"NAME") + "', value : '" + aspHoList.getString(i,"VALUE") + "', inputValue : '" + aspHoList.getString(i,"VALUE") + "' ");
							if( HoValidator.isNotEmpty(aspHoList.getString(i,"COMMENTS_TITLE")) &&  HoValidator.isNotEmpty(aspHoList.getString(i,"COMMENTS")) ) {
								out.print(", afterBoxLabelTpl : Ext.String.format(G_HELP_TIP_TPL , '" + p_action_flag+"_"+HoServletUtil.getString(request, "form-id") +"_"+name +"-"+aspHoList.getString(i,"VALUE")+"-help', '"+aspHoList.getString(i,"COMMENTS_TITLE")+"', '"+aspHoList.getString(i,"COMMENTS")+"' )");
							}
							out.print(", " + HoUtilExtjs.getCheckedRadio(value, aspHoList.getString(i,"VALUE") ) );
							out.println("}");
						}
		      	%>],
		        width    : 100*<%= aspHoList.size() %> + <%=labelWidth %> // 640 //
			},  
			{	
				xtype : 'label',
				width : <%= 520 - 100 * aspHoList.size() %>
			}

<%
		} else if( "checkbox".equals(type)) {
%>
			{
	            xtype      : 'checkboxgroup_ux',   
	            fieldLabel : '<%= title %>', <%= HoValidator.isIn(require, new String[]{"Y","true"}, true) ? "allowBlank : false, labelCls   : 'x-form-item-label x-form-item-label-required'," : "" %>
				defaults : { name: '<%= name %>' },
				commentsTitle : 'OK 한글',  // 추가 Comments Title 
				comments : '한글 your help text or even html comes here....',  // 추가 Comments 내용
		        <jsp:doBody></jsp:doBody>
	            items : [<%		
	                    HoList list = cache.getHoList(groupCode); // cache defined in "include.tag"
						
						HoAspUtil  aspUtil = new HoAspUtil();
						
						HoList aspHoList = aspUtil.getHoListAsp( list, "0001", "0001", "COMPANY_CD", "CODE");
						
						for(int i=0; aspHoList!=null && i<aspHoList.size(); i++) {
							out.print((i>0 ? "," : "") + " { width:100, boxLabel : '" + aspHoList.getString(i,"NAME") + "', value : '" + aspHoList.getString(i,"VALUE") + "', inputValue : '" + aspHoList.getString(i,"VALUE") + "' ");
							if( HoValidator.isNotEmpty(aspHoList.getString(i,"COMMENTS_TITLE")) &&  HoValidator.isNotEmpty(aspHoList.getString(i,"COMMENTS")) ) {
								out.print(", afterBoxLabelTpl : Ext.String.format(G_HELP_TIP_TPL , '" + p_action_flag+"_"+HoServletUtil.getString(request, "form-id") +"_"+name +"-"+aspHoList.getString(i,"VALUE")+"-help', '"+aspHoList.getString(i,"COMMENTS_TITLE")+"', '"+aspHoList.getString(i,"COMMENTS")+"' )");
							}
							out.print(", " + HoUtilExtjs.getCheckedCheckbox(value, aspHoList.getString(i,"VALUE") ) );
							out.println("}");
						}
		      	%>] , 
		      	width      : 100*<%= aspHoList.size() %> + <%=labelWidth %> // 640 // 
			},  
			{	
				xtype : 'label',
				width : <%= 520 - 100 * aspHoList.size() %>
			}
<%
		} else if( "combo".equals(type) || "select".equals(type) ){
			// GROUP_CODE를 이용해서 TITLE가져 옴. 
			// TODO title없을 때로 변경..해야 함.
			if( HoValidator.isNotEmpty(groupCode) && CODE_SET_MAP.getHoMap(groupCode) !=null ) {
				title = CODE_SET_MAP.getHoMap(groupCode).getString("CODE_NM");
			}
%>
			{
				xtype         : 'combotipple_ux', 
				id            : 'id_cmp_<%=p_action_flag %>_<%=HoServletUtil.getString(request, "form-id") %>_<%= name %>',
				first         : '<%= HoUtil.replaceNull(first) %>',
		        fieldLabel    : '<%= title %>', <%= HoValidator.isIn(require, new String[]{"Y","true"}, true) ? "allowBlank : false, labelCls   : 'x-form-item-label x-form-item-label-required'," : "" %>
		        name          : '<%= name %>',
				commentsTitle : 'OK 한글', 
				comments : '한글 your help text or even html comes here....', 
		        value         : <%= HoUtilExtjs.toValueArray(value) %>, // B2020
		        <%= HoValidator.isIn(multiSelect, new String[]{"Y","true"}, true)  ? "multiSelect : true, " : ""%>
		        code          : '<%= groupCode %>', 
		        <jsp:doBody></jsp:doBody>
		        store         : Ext.create('Ext.data.Store', {
		            fields    : ['NAME', 'VALUE', 'GROUP', 'COMPANY_CD', 'CODE', 'CODE_NM', 'UP_CD', 'USEDEF1', 'USEDEF2', 'USEDEF3', 'USEDEF4', 'USEDEF5', 'COMMENTS_TITLE', 'COMMENTS' ],
		            data      : [<%
						if( "all".equalsIgnoreCase(first) && !HoValidator.isIn(multiSelect, new String[]{"Y","true"}, true) ) { // all이고  multiSelect가 아닌 경우
							out.println("{NAME : '-전체-',   VALUE : ''  , group : ''},");
						}
		            
						HoList list = cache.getHoList(groupCode); // cache defined in "include.tag"
						
						HoAspUtil  aspUtil = new HoAspUtil();
						
						HoList aspHoList = aspUtil.getHoListAsp( list, "0001", "1000", "COMPANY_CD", "CODE");
						
						for(int i=0; aspHoList!=null && i<aspHoList.size(); i++) {
							out.print((i>0 ? "," : "") + " {NAME : '"+aspHoList.getString(i,"NAME")+"',   VALUE : '"+aspHoList.getString(i,"VALUE")+"'  , GROUP : '"+aspHoList.getString(i,"UP_CD")+"' , USEDEF1 : '"+aspHoList.getString(i,"USEDEF1")+"', USEDEF2 : '"+aspHoList.getString(i,"USEDEF2")+"', USEDEF3 : '"+aspHoList.getString(i,"USEDEF3")+"', USEDEF4 : '"+aspHoList.getString(i,"USEDEF4")+"', USEDEF5 : '"+aspHoList.getString(i,"USEDEF5")+"' ");
							if( HoValidator.isNotEmpty(aspHoList.getString(i,"COMMENTS_TITLE")) &&  HoValidator.isNotEmpty(aspHoList.getString(i,"COMMENTS")) ) {
								out.print(", COMMENTS_TITLE : '"+aspHoList.getString(i,"COMMENTS_TITLE")+"'  , COMMENTS : '"+aspHoList.getString(i,"COMMENTS")+"'");
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
