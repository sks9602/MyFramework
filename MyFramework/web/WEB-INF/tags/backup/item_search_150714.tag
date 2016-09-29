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
<%@ attribute name="title" type="java.lang.String"  %>
<%@ attribute name="type" type="java.lang.String" %>
<%@ attribute name="groupCode" type="java.lang.String" %>
<%@ attribute name="first" type="java.lang.String" %>
<%@ attribute name="name" type="java.lang.String" %>
<%@ attribute name="value" type="java.lang.String" %>
<%@ attribute name="vtype" type="java.lang.String" %>
<%@ attribute name="require" type="java.lang.String" %><%-- 필수여부 : 'Y'필수 / '기타' 선택  --%>

<%@ variable name-given="longDate" %>

<%!
	final int MAX_ROW_ITEM_SEARCH = 8;
%>
<%
	String labelWidth = "120";
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
		if( itemNowIndex + increaseIndex > MAX_ROW_ITEM_SEARCH ) {
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
				xtype      : 'radiogroup_ux',   columns: 'auto', msgTarget  : 'side', 
				labelWidth : <%=labelWidth %>, 
		        fieldLabel : '<%= title %>', <%= HoValidator.isIn(require, new String[]{"Y","true"}, true) ? "allowBlank : false, labelCls   : 'x-form-item-label x-form-item-label-required'," : "" %>
				defaults : { name: '<%= name %>' },
				commentsTitle : 'OK 한글',  // 추가 Comments Title 
				comments : '한글 your help text or even html comes here....',  // 추가 Comments 내용
		        items : [<%		
		                 HoList list = cache.getHoList(groupCode); // cache defined in "include.tag"
						
						HoAspUtil  aspUtil = new HoAspUtil();
						
						HoList aspHoList = aspUtil.getHoListAsp( list, "0001", "1000", "COMPANY_CD", "CODE");
						
						for(int i=0; aspUtil!=null && i<aspHoList.size(); i++) {
							out.println((i>0 ? "," : "") + " { boxLabel : '" + aspHoList.getString(i,"NAME") + "', value : '" + aspHoList.getString(i,"VALUE") + "', inputValue : '" + aspHoList.getString(i,"VALUE") + "' ");
							if( HoValidator.isNotEmpty(aspHoList.getString(i,"COMMENTS_TITLE")) &&  HoValidator.isNotEmpty(aspHoList.getString(i,"COMMENTS")) ) {
								out.println(", afterBoxLabelTpl : Ext.String.format(G_HELP_TIP_TPL , '" + p_action_flag+"_"+HoServletUtil.getString(request, "form-id") +"_"+name +"-"+aspHoList.getString(i,"VALUE")+"-help', '"+aspHoList.getString(i,"COMMENTS_TITLE")+"', '"+aspHoList.getString(i,"COMMENTS")+"' )");
							}
							out.println("}");
						}
		      	%>],
		            width    : 100*<%= aspHoList.size() %> + <%=labelWidth %>,
			}

<%
		} else if( "radio-old".equals(type)) {
%>
			{defaultType : 'radio',  layout: 'hbox', border : 0,
	            items : [{
	                checked: true,
	                fieldLabel: '<%= title %>',
	                boxLabel: 'Red ',
	                name: '<%= name %>',
	                inputValue: 'red'
	            }, {
	                boxLabel: 'Blue ',
	                name: '<%= name %>',
	                inputValue: 'blue'
	            }, {
	                boxLabel: 'Green ',
	                name: '<%= name %>',
	                inputValue: 'green'
	            }]
			}

<%
		} else if( "checkbox".equals(type)) {
%>
			{
	            xtype      : 'checkboxgroup_ux',  columns    : 'auto', msgTarget  : 'side',  
	            labelWidth : <%=labelWidth %>, 
	            fieldLabel : '<%= title %>', <%= HoValidator.isIn(require, new String[]{"Y","true"}, true) ? "allowBlank : false, labelCls   : 'x-form-item-label x-form-item-label-required'," : "" %>
				defaults : { name: '<%= name %>' },
				commentsTitle : 'OK 한글',  // 추가 Comments Title 
				comments : '한글 your help text or even html comes here....',  // 추가 Comments 내용
	            items : [
	            <%		HoList list = cache.getHoList(groupCode); // cache defined in "include.tag"
						
						HoAspUtil  aspUtil = new HoAspUtil();
						
						HoList aspHoList = aspUtil.getHoListAsp( list, "0001", "1000", "COMPANY_CD", "CODE");
						
						for(int i=0; aspUtil!=null && i<aspHoList.size(); i++) {
							out.println((i>0 ? "," : "") + " { boxLabel : '" + aspHoList.getString(i,"NAME") + "', value : '" + aspHoList.getString(i,"VALUE") + "', inputValue : '" + aspHoList.getString(i,"VALUE") + "' ");
							if( HoValidator.isNotEmpty(aspHoList.getString(i,"COMMENTS_TITLE")) &&  HoValidator.isNotEmpty(aspHoList.getString(i,"COMMENTS")) ) {
								out.println(", afterBoxLabelTpl : Ext.String.format(G_HELP_TIP_TPL , '" + p_action_flag+"_"+HoServletUtil.getString(request, "form-id") +"_"+name +"-"+aspHoList.getString(i,"VALUE")+"-help', '"+aspHoList.getString(i,"COMMENTS_TITLE")+"', '"+aspHoList.getString(i,"COMMENTS")+"' )");
							}
							out.println("}");
						}
		      	%>] , 
		      	width      : 100*<%= aspHoList.size() %> + <%=labelWidth %>
			}
<%
		} else if( "checkbox-old".equals(type)) {
%>
			{
	            defaultType : 'checkboxfield', // each item will be a checkbox
	            layout      : 'hbox',
	            border      : 0,
	            items : [{
	                fieldLabel: '<%= title %>',
	                boxLabel: 'Dog',
	                name: '<%= name %>',
	                value: 'dog1',
	                inputValue: 'dog',
	                qtip :  'dog'
	            }, {
	                // checked: true,
	                boxLabel: 'Cat',
	                name: '<%= name %>',
	                value: 'cat1',
	                inputValue : 'cat',
	                qtip :  'cat'
	            }, {
	                // checked: true,
	                boxLabel: 'Monkey',
	                name: '<%= name %>',
	                value: 'monkey1',
	                inputValue: 'monkey'
	            }]
			}
<%
		} else if( "combo".equals(type) || "select".equals(type) ){
			// GROUP_CODE를 이용해서 TITLE가져 옴. 
			// TODO title없을 때로 변경..해야 함.
			if( HoValidator.isNotEmpty(groupCode) && setMap.getHoMap(groupCode) !=null ) {
				title = setMap.getHoMap(groupCode).getString("CODE_NM");
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
		        // editable      : false,
		        code          : '<%= groupCode %>', 
		        store         : Ext.create('Ext.data.Store', {
		            fields    : ['NAME', 'VALUE', 'GROUP', 'COMPANY_CD', 'CODE', 'CODE_NM', 'UP_CD', 'USEDEF1', 'USEDEF2', 'USEDEF3', 'USEDEF4', 'USEDEF5', 'COMMENTS_TITLE', 'COMMENTS' ],
		            data      : [
		            	
		            <%
						if( "all".equalsIgnoreCase(first)) {
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
		} else if( "text".equals(type) ) {
%>
			{
				xtype      : 'textfield_ux',  msgTarget  : 'side', 
				width      : 320, labelWidth : <%=labelWidth %>,
				fieldLabel : '<%= title %>', <%= HoValidator.isIn(require, new String[]{"Y","true"}, true) ? "allowBlank : false, labelCls   : 'x-form-item-label x-form-item-label-required'," : "" %>
				name       : '<%= name %>',
				commentsTitle : 'OK 한글',  // 추가 Comments Title 
				comments : '한글 your help text or even html comes here....',  // 추가 Comments 내용
				<%=  !HoValidator.isEmpty(vtype) ? "vtype: '"+vtype+"'," : "" %>			
				qtip       : '<%= title %>'
			}, {
		        xtype: 'label',
		        text: '건',
		        margins: '4 5 0 -2'
		    }
<%
		} else if( "label".equals(type) ) {
%>
			{
				xtype: 'displayfield',
				fieldLabel: '<%= title %>',labelSeparator : '',
				name      : '<%= name %>',
				value: '<%= HoUtil.replaceNull(value) %>'
			}
<%
		} else if( "hidden".equals(type)) {
%>
			{
				xtype     : 'hidden',
				width     : 320,
				name      : '<%= name %>',
				value     : '<%= HoUtil.replaceNull(value) %>'
			}
<%		}else if( "period".equals(type)) {
%>
			{
				xtype          : 'periodDate', msgTarget  : 'side', 
				width          : 260, labelWidth : <%=labelWidth %>,
				fieldLabel     : '<%= title %>', <%= HoValidator.isIn(require, new String[]{"Y","true"}, true) ? "allowBlank : false, labelCls   : 'x-form-item-label x-form-item-label-required'," : "" %>
				name           : 'stt_<%= name %>',
				value          : '<%= HoUtil.replaceNull(value) %>',
				commentsTitle : 'OK 한글',  // 추가 Comments Title 
				comments : '한글 your help text or even html comes here....',  // 추가 Comments 내용
				id             : 'id_stt_<%= name %>_<%=p_action_flag%>',
				edDtId         : 'id_end_<%= name %>_<%=p_action_flag%>'
			}, {xtype           :'label', text : '~', labelCls : 'x-form-item-label', width : 10  },
			{
				xtype     : 'periodDate',  msgTarget  : 'side', 
				width     : 140,
				<%= HoValidator.isIn(require, new String[]{"Y","true"}, true) ? "allowBlank : false, labelCls   : 'x-form-item-label x-form-item-label-required'," : "" %>
				name      : 'end_<%= name %>',
				value     : '<%= HoUtil.replaceNull(value) %>',
				id        : 'id_end_<%= name %>_<%=p_action_flag%>',
				stDtId    : 'id_stt_<%= name %>_<%=p_action_flag%>'
			},  
			{	
				xtype : 'periodButton',  
				name : '<%= name %>' , 
				actionFlag : '<%=p_action_flag%>' 
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

<%!
	public int getIndexIncrement( String type ) {
		if( "checkbox".equals(type) || "radio".equals(type) ){
			return MAX_ROW_ITEM_SEARCH;
		} else if( "selectCasecade".equals(type) || "selectMulti".equals(type) ){
			return MAX_ROW_ITEM_SEARCH;
		} else if( "period".equals(type) ){
			return 3;
		} else if( "popup".equals(type) ){
			return 3;
		} else if( "hidden".equals(type) ){
			return 0;
		} else if( "grid".equals(type) ){
			return MAX_ROW_ITEM_SEARCH;
		} else {
			return 2;
		}
	}

%>