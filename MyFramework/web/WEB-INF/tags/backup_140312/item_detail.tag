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
	import="project.jun.dao.parameter.HoQueryParameterHandler"
	import="project.jun.util.HoServletUtil"
%>
<%@ attribute name="title" type="java.lang.String"  %>
<%@ attribute name="type" type="java.lang.String" %>
<%@ attribute name="groupCode" type="java.lang.String" %>
<%@ attribute name="first" type="java.lang.String" %>
<%@ attribute name="name" type="java.lang.String" %>
<%@ attribute name="value" type="java.lang.String" %>

<%@ variable name-given="longDate" %>
<%!
	final int MAX_ROW_ITEM_SEARCH = 8;
%>
<%

	HoModel        model     = new HoModel(request);
	HoParameter    param     = (HoParameter) model.get(HoController.HO_PARAMETER);

	String p_action_flag = param.get("p_action_flag");
	String division      = param.get("division");
	String tab_index      = param.get("tab_index");

	boolean isScriptOut = "script_out".equals(division);
	boolean isScript = "script".equals(division);
	boolean isHtml 	 = "html".equals(division);
	boolean isFirstTab = "0".equals(tab_index);
%>



<% 	if( isScript ) {

		String nowArea = HoServletUtil.getNowArea(request);


		if( !"fieldcontainer".equals(nowArea)) {
			HoServletUtil.setInArea(request, "fieldcontainer");
			HoServletUtil.initIndex(request, HoServletUtil.getArea(request));
			int itemsRow = HoServletUtil.getIndex(request, HoServletUtil.getArea(request)+"_row");
			HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request)+"_row");
			out.println( itemsRow > 0 ? "," : "");
			out.println("{ xtype: 'fieldcontainer', layout: { type: 'hbox', defaultMargins: {top: 0, right: 5, bottom: 0, left: 5} }, items: [");
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
			out.println( itemsRow > 0 ? "," : "");
			out.println("{ xtype: 'fieldcontainer', layout: { type: 'hbox', defaultMargins: {top: 0, right: 5, bottom: 0, left: 5} }, items: [");
		}

		HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request), increaseIndex );
		HoServletUtil.setInArea(request, "item");
		out.println(HoServletUtil.getIndex(request, HoServletUtil.getArea(request)+"_row") > 0 ? "," : "");
		HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request)+"_row");

	if( "radio-old".equals(type)) {
%>
			{defaultType: 'radio',  layout: 'hbox', border : 0,
	            items: [{
	                fieldLabel: 'Favorite Color',
	                boxLabel: 'Red  &nbsp;&nbsp;',
	                name: '<%= name %>',
	                inputValue: 'red'
	            }, {
	                boxLabel: 'Blue &nbsp;&nbsp;',
	                name: '<%= name %>',
	                inputValue: 'blue'
	            }, {
	                boxLabel: 'Green  &nbsp;&nbsp;',
	                name: '<%= name %>',
	                inputValue: 'green'
	            }]
			}

<%
		} else if( "radio".equals(type)) {
%>
			{xtype: 'radiogroup',  border : 0,  columns: 3,
	         fieldLabel: '<%= title %>',
             width: 110*3,
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
            fieldLabel: 'Favorite Animals',
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
		} else if( "checkbox-old".equals(type)) {
%>
			{
            defaultType: 'checkboxfield', // each item will be a checkbox
            fieldLabel: 'Favorite Animals',
            layout: 'hbox',
            border : 0,
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
                name: '<%= name %>_monkey',
                inputValue: 'monkey'
            }]
}
<%
		} else if( "combo".equals(type) || "select".equals(type) ){
%>
	{
         width:          300,
         xtype:          'combo',
         queryMode:      'local',
         value:          'mrs',
         triggerAction:  'all',
         forceSelection: true,
         editable:       false,
         fieldLabel:     'Title',
         name:           '<%= name %>',
         displayField:   'name',
         valueField:     'value',
         store:          Ext.create('Ext.data.Store', {
             fields : ['name', 'value'],
             data   : [
                 {name : 'Mr',   value: 'mr'},
                 {name : 'Mrs',  value: 'mrs'},
                 {name : 'Miss', value: 'miss'}
             ]
         })
     }
<%
		} else if( "text".equals(type) ) {
%>
			{
				xtype     : 'textfield',
				width:          300,
				name      : '<%= name %>',
				fieldLabel: '<%= title %>',
				msgTarget: 'side'
			}
<%
		} else if( "label".equals(type) ) {
%>
			//{xtype :'label', text : '<%= title  %>:', width : <%=HoServletUtil.getArea(request).indexOf("section")>0 ? "90" : "95"%> },
			//{xtype :'label', text : '', id : '<%= name %>_label', width : 200  },
			//{
			//	xtype     : 'hidden',
			//	name      : '<%= name %>',
			//	value     : ''
			//}

			{
				xtype: 'displayfield',
				fieldLabel: '<%= title %>',
				name      : '<%= name %>',
				value: ''
			}
<%
		} else if( "file".equals(type) ) {
%>
			{
				xtype     : 'filefield',
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
<%		} else if( "grid".equals(type)) {
%> {xtype :'label', text : '<%= title  %>', width : <%=HoServletUtil.getArea(request).indexOf("section")>0 ? "90" : "95"%> },
	<jsp:doBody></jsp:doBody>
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

<%!
	public int getIndexIncrement( String type ) {
		if( "checkbox".equals(type) || "radio".equals(type) || "file".equals(type) ){
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