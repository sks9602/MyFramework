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
attribute name="groupCode" type="java.lang.String" %><%-- 기준 코드 또는 SQL.id --%><%@ 
attribute name="value"   type="java.lang.String" %><%-- 설정 값  , 여러 값일 경우 ","로 구분 ex1) "B1010" ex2) "B1010,B1020" multiSelect가 "Y"인 경우에만 다중 선택 됨.--%><%@ 
attribute name="require" type="java.lang.String" %><%@ 
attribute name="codeColumn"  type="java.lang.String"  %><%@ 
attribute name="nameColumn"  type="java.lang.String"  %><%-- 필수여부 : 'Y'필수 / '기타' 선택  --%><%@ 
attribute name="first"   type="java.lang.String" %><%-- "-선택-", "전체" 처럼 combobox 맨 위에 부가적으로 나온는 값  , ex) all("-전체-"), choice("-선택-"), none  --%><%@ 
attribute name="multiSelect" type="java.lang.String" %><%-- 다중선태 가능 여부 : 'Y' 다중선택 가능  / '기타' 다중선태 불가  --%><%@ 
attribute name="colspan"    type="java.lang.String" %><%@ 
attribute name="rowspan"    type="java.lang.String" %><%
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
		// groupCode가 없을 경우 컬럼명을 기준으로 groupCode를 구함. 
		if( HoValidator.isEmpty(groupCode)) {
			groupCode = colHoMap.getString("VALUE");
		}
		if( HoValidator.isEmpty(title)) {
			if( HoValidator.isNotEmpty(groupCode) && CODE_SET_MAP.getHoMap(groupCode) !=null ) {
				title = CODE_SET_MAP.getHoMap(groupCode).getString("NAME");
			}
			// title = colHoMap.getString("COLUMN_TITLE");
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
			out.print( itemsRow > 0 ? "," : "");
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
			out.print( itemsRow > 0 ? "," : "");
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
			setFormItemInfo( request,  param, item ); 
		}

		if( "radio".equals(type)) {
%>
			{	
				xtype      : 'radiogroup_ux',    
		        fieldLabel : '<%= title %>', <%= HoValidator.isIn(require, new String[]{"Y","true"}, true) ? "allowBlank : false, labelCls   : 'x-form-item-label x-form-item-label-required'," : "" %>
		        labelWidth : <%=labelWidth %>,
				defaults : { name: '<%= name %>', width : 100 },
				/*
				commentsTitle : 'OK 한글',  // 추가 Comments Title 
				comments : '한글 your help text or even html comes here....',  // 추가 Comments 내용
				*/
		        <jsp:doBody></jsp:doBody>
		        items : [<%		
	                    codeColumn = HoUtil.replaceNull(codeColumn, "VALUE");
	    				nameColumn = HoUtil.replaceNull(nameColumn, "NAME");
		                HoList list = null;
		                
		                // 쿼리를 통해 구성하는 경우
		                if( groupCode.indexOf(".")>0) {
		                	list = dao.select(groupCode);
		                } 
		                // 공통코드로 구하는 경우.
		                else {
		                	list = cache.getHoList(groupCode); // cache defined in "include.tag"
		                }
		                
						HoAspUtil  aspUtil = new HoAspUtil();
						
						HoList aspHoList = aspUtil.getHoListAsp( list, "0000", "1000", "COMPANY_ID", "CD");
						
						
						for(int i=0; aspHoList!=null && i<aspHoList.size(); i++) {
							/*
							if( i==0 ) {
								if("all".equals(first)) {
									out.print(" { width:100, name : '" + name + "', boxLabel : '전체', value : '', inputValue : '' }, ");	
								}								
							}
							*/
							out.print((i>0 ? "," : "") + " { xtype: 'radio', width:100, name : '" + name + "', boxLabel : '" + aspHoList.getString(i, nameColumn) + "', value : '" + aspHoList.getString(i, codeColumn) + "', inputValue : '" + aspHoList.getString(i,codeColumn) + "' ");
							if( HoValidator.isNotEmpty(aspHoList.getString(i,"COMMENTS_TITLE")) &&  HoValidator.isNotEmpty(aspHoList.getString(i,"COMMENTS")) ) {
								out.print(", afterBoxLabelTpl : Ext.String.format(G_HELP_TIP_TPL , '" + p_action_flag+"_"+HoServletUtil.getString(request, "form-id") +"_"+name +"-"+aspHoList.getString(i,"VALUE")+"-help', '"+aspHoList.getString(i,"COMMENTS_TITLE")+"', '"+aspHoList.getString(i,"COMMENTS")+"' )");
							}
							out.print(( HoUtil.replaceNull(value).equals(HoUtil.replaceNull(aspHoList.getString(i,codeColumn))) ? ", " :"") + HoUtilExtjs.getCheckedRadio(value, aspHoList.getString(i,codeColumn) ) );
							out.println("}");
						}
						// out.print(", {xtype: 'component', html: 'Heading 1', width : 70, cls:'x-form-check-group-label'} "); 
		                
		      	%>],
				<%= HoValidator.isNotEmpty(colspan) ? "colspan: "+colspan+"," : ""  %><%= HoValidator.isNotEmpty(rowspan) ? "rowspan: "+rowspan+"," : ""  %>
		        width    : (100*<%= aspHoList.size() %>) + <%=labelWidth %> // 640 //
			}
<%
		} else if( "checkbox".equals(type)) {
%>
			{
	            xtype      : 'checkboxgroup_ux',   
	            fieldLabel : '<%= title %>', <%= HoValidator.isIn(require, new String[]{"Y","true"}, true) ? "allowBlank : false, labelCls   : 'x-form-item-label x-form-item-label-required'," : "" %>
				id            : 'id_cmp_<%=p_action_flag %>_<%=HoServletUtil.getString(request, "form-id") %>_<%= name %>',
		        labelWidth : <%=labelWidth %>,
		        name : '<%= name %>',
				defaults : { name: '<%= name %>' },
				/*
				columnWidth: 0.5,
            	layout: 'column',
            	*/
  				commentsTitle : 'OK 한글',  // 추가 Comments Title 
				comments : '한글 your help text or even html comes here....',  // 추가 Comments 내용
		        <jsp:doBody></jsp:doBody>
	            items : [<%	
	                    codeColumn = HoUtil.replaceNull(codeColumn, "VALUE");
	    				nameColumn = HoUtil.replaceNull(nameColumn, "NAME");

	                    HoList list = cache.getHoList(groupCode); // cache defined in "include.tag"
						
						HoAspUtil  aspUtil = new HoAspUtil();
						
						HoList aspHoList = aspUtil.getHoListAsp( list, "0000", "0001", "COMPANY_ID", "CD");
						
						for(int i=0; aspHoList!=null && i<aspHoList.size(); i++) {
							
							if( i==0 ) {
								if("all".equals(first)) {
									
									out.print(" { width:100, name : '" + name + "_ALL', boxLabel : '전체', itemId : 'all' ");
									/*
									out.print(", listeners : { change : ");
									out.print(" function(_this, newValue, oldValue, eOpts) { ");
									out.print(" try { ");
									out.print(" 	if( newValue) { _this.up().setValue({'"+name+"' : ['SYS002001', 'SYS002002', 'SYS002003']}); }  ");
									out.print(" 	if( !newValue) { _this.up().setValue({'"+name+"' : []}); } ");
									// out.print(" for( var x in _this.up().items.items ) { if(x!=0) { _this.up().items.items[x].setValue(newValue=='on'); _this.up().checkPreChecked(); } } ");
									out.print("} catch(e) { }  ");
									out.print(" }");
									out.print(" } ");	
									*/
									out.print(" }, ");	
								}								
							}
							out.print((i>0 ? "," : "") + " { xtype: 'checkbox', width:100, boxLabel : '" + aspHoList.getString(i, nameColumn) + "', inputValue : '" + aspHoList.getString(i,codeColumn) + "' ");
							if( HoValidator.isNotEmpty(aspHoList.getString(i,"COMMENTS_TITLE")) &&  HoValidator.isNotEmpty(aspHoList.getString(i,"COMMENTS")) ) {
								out.print(", afterBoxLabelTpl : Ext.String.format(G_HELP_TIP_TPL , '" + p_action_flag+"_"+HoServletUtil.getString(request, "form-id") +"_"+name +"-"+aspHoList.getString(i,"VALUE")+"-help', '"+aspHoList.getString(i,"COMMENTS_TITLE")+"', '"+aspHoList.getString(i,"COMMENTS")+"' )");
							}
							/*
							out.print(", listeners : { change : ");
							out.print(" function(_this, newValue, oldValue, eOpts) { ");
							out.print(" try { ");
							// out.print(" _this.up().checkAllChecked( _this, newValue, oldValue, eOpts );   ");
							out.print("} catch(e) { }  ");
							out.print(" }");
							out.print(" } ");	
							*/
							out.print(( HoUtil.replaceNull(value).equals(HoUtil.replaceNull(aspHoList.getString(i,codeColumn))) ? ", " :"") + HoUtilExtjs.getCheckedCheckbox(value, aspHoList.getString(i,codeColumn) ) );
							out.println("}");
						}
						// out.print(", {xtype: 'component', html: 'Heading 1', width : 100, style : 'text-align:right;', cls:'x-form-check-group-label'} "); 
		      	%>] , 
				<%= HoValidator.isNotEmpty(colspan) ? "colspan: "+colspan+"," : ""  %><%= HoValidator.isNotEmpty(rowspan) ? "rowspan: "+rowspan+"," : ""  %>
		      	width      : (100*<%= aspHoList.size() + ("all".equals(first) ? 1 : 0) %>) + <%=labelWidth %> // 640 // 
			}
<%
		} else if( "combo".equals(type) || "select".equals(type) ){
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
			{
				xtype         : 'combotipple_ux', 
				id            : 'id_cmp_<%=p_action_flag %>_<%=HoServletUtil.getString(request, "form-id") %>_<%= name %>',
				first         : '<%= HoUtil.replaceNull(first) %>',
		        fieldLabel    : '<%= title %>', <%= HoValidator.isIn(require, new String[]{"Y","true"}, true) ? "allowBlank : false, labelCls   : 'x-form-item-label x-form-item-label-required'," : "" %>
		        labelWidth : <%=labelWidth %>,
		        name          : '<%= name %>',
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
