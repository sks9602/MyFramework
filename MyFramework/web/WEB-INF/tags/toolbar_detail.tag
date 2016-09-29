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
	import="project.jun.util.asp.HoAspUtil"
	import="project.jun.dao.parameter.HoQueryParameterHandler"
	import="project.jun.util.HoServletUtil"
%>
<%@ include file="include.tag" %>
<%@ attribute name="title" type="java.lang.String"  %>
<%@ attribute name="type" type="java.lang.String" %>
<%@ attribute name="groupCode" type="java.lang.String" %>
<%@ attribute name="first" type="java.lang.String" %>
<%@ attribute name="name" type="java.lang.String" %>
<%@ attribute name="value" type="java.lang.String" %>
<%@ attribute name="require" type="java.lang.String" %><%-- 필수여부 : 'Y'필수 / '기타' 선택  --%>
<% 	if( isScript || isScriptOut ) {

		String nowArea = HoServletUtil.getNowArea(request);


		HoServletUtil.setInArea(request, "toolbaritem");
		
		// 이전에 버튼이 있을 경우
		if("Y".equals(HoServletUtil.getString(request, "dockedItems-buttons"))) {
			out.println(",");
			HoServletUtil.setString(request, "dockedItems-buttons", null);
		}
		if("right".equals(HoServletUtil.getString(request, "dockedItems-align"))) {
			out.println("'->',");
			HoServletUtil.setString(request, "dockedItems-align", null);
		} 
		
		out.println(HoServletUtil.getIndex(request, HoServletUtil.getArea(request)+"_row") > 0 ? "," : "");
		
		
		// out.println(HoServletUtil.getIndex(request, HoServletUtil.getArea(request)+"_row") == 0 ? "'->'," : ",");
		// out.println(HoServletUtil.getIndex(request, HoServletUtil.getArea(request)+"_row") > 0 ? "," : "");
		HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request)+"_row");

		if( "radio".equals(type)) {
%>
			{xtype: 'radiogroup',  border : 0,  columns: 5,
	         fieldLabel: '<%= title %>',labelSeparator : '',
             width: 158*3,
			 defaults: { name: '<%= name %>' },
	            items: [{
	                boxLabel: 'Red',
	                inputValue: 'red'
	            }, {
	                boxLabel: 'Blue',
	                inputValue: 'blue'
	            }, {
	                boxLabel: 'Green',
	                inputValue: 'green'
	            }]
			}

<%
		} else if( "checkbox".equals(type)) {
%>
			{
	            xtype: 'checkboxgroup',
	            fieldLabel: 'Favorite Animals',labelSeparator : '',
	            border : 0,
	            columns: 3,
	            width: 110*3,
	            items: [{
	                boxLabel: 'Dog  &nbsp;&nbsp;',
	                name: '<%= name %>',
	                value: 'dog',
	                inputValue: 'dog'
	            }, {
	                boxLabel: 'Cat  &nbsp;&nbsp;',
	                name: '<%= name %>',
	                value: 'cat',
	                inputValue : 'cat'
	            }, {
	                boxLabel: 'Monkey  &nbsp;&nbsp;',
	                name: '<%= name %>',
	                inputValue: 'monkey'
	            }]
			}
<%
		} else if( "combo".equals(type) || "select".equals(type) || "combotipple_ux".equals(type) ){
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
			HoList aspHoList = aspUtil.getHoListAsp( list, "0000", "1000", "COMPANY_ID", "CD");
%>
	'<%= title %>', {
         width:          150,
         xtype:          'combotipple_ux', <%= "Y".equals(require) ? "allowBlank : false," : "" %>
         queryMode:      'local',
         value:          '',
         triggerAction:  'all',
         forceSelection: true,
         editable:       false,
         name:           '<%= name %>',
         displayField:   'NAME',
         code          : '<%= groupCode %>', 
         valueField:     'VALUE',
         store:          Ext.create('Ext.data.Store', {
             fields : [<%= list.getMetaDataString() %>],
		            data      : [<%
						
						for(int i=0; aspHoList!=null && i<aspHoList.size(); i++) {
							out.print((i>0 ? "," : "") + " {" + aspHoList.toJson(i) + "}");
						}					
		            %>
		            ]
         })
     }
<%
		} else if( "text".equals(type) ) {
%>
			{
				xtype     : 'textfield', <%= "Y".equals(require) ? "allowBlank : false," : "" %>
				width:          300,
				name      : '<%= name %>',
				fieldLabel: '<%= title %>',labelSeparator : '',
				msgTarget: 'side'
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
		} else if( "file".equals(type) ) {
%>
			{
				xtype     : 'filefield',labelSeparator : '', <%= "Y".equals(require) ? "allowBlank : false," : "" %>
				width:          500,
				name      : '<%= name %>',
				fieldLabel: '<%= title %>',
				msgTarget: 'side'
			}
<%
		} else if( "hidden".equals(type)) {
%>
			{
				xtype     : 'hidden',
				width:          300,
				name      : '<%= name %>',
				value     : '<%= HoUtil.replaceNull(value) %>'
			}
<%
		}else if( "button".equals(type)) {
%>
			{
				xtype     : 'button',
				text      : '버튼',  
				iconCls:'top-search-btn-icon',  border: 1, style: { borderColor: '#99bce8', borderStyle: 'solid'}
			}
<%
		}

%>

<%
		HoServletUtil.setOutArea(request);
	}
%>

<%
	if( isHtml ) {
%>
<jsp:doBody/>
<%	} %>
