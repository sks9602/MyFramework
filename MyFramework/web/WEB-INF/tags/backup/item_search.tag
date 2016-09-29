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

    WebApplicationContext appContext =  WebApplicationContextUtils.getWebApplicationContext(application);

	HoConfig       hoConfig     = (HoConfig) appContext.getBean( "config");
	HoDao          dao          = (HoDao) appContext.getBean("proxyProjectDao");

	HoModel        model     = new HoModel(request);
	HoParameter    param     = (HoParameter) model.get(HoController.HO_PARAMETER);

	String p_action_flag = param.get("p_action_flag");
	String division      = param.get("division");

	HoQueryParameterHandler hqph = new HoQueryParameterHandler(param.getHoParameterMap(), hoConfig);

	HoQueryParameterMap queryMapValue = hqph.getForDetail();

	queryMapValue.put("SSN_COMPANY_CD", "0001");
	queryMapValue.put("GROUP_CODE", groupCode );
	queryMapValue.put("CODE_GBN", "");
	queryMapValue.put("SORT_COLUMN", "");

	HoList list = dao.select("CommonCombo.selectSearchCodeListCombo", queryMapValue);


	boolean isScript = "script".equals(division);
	boolean isHtml 	 = "html".equals(division);

	title = HoValidator.isEmpty(title) ? "" : HoUtil.replaceNull(title) + ":";


	if( isScript ) {
		int idx = HoServletUtil.getIndex(request, "search_script" + p_action_flag);
		int idx_row_item = HoServletUtil.getIndex(request, "search_script_row_item" +  p_action_flag);
		int increment = getIndexIncrement(type) ;
		boolean isClosed = HoServletUtil.isClosed(request, "search_script_row_item_closed" +  p_action_flag);

		// 다음 검색 항목의 길이를 비교
		if( (increment + idx_row_item >  MAX_ROW_ITEM_SEARCH) && !isClosed ) {
%>
					]
			} // end in search
<%
			HoServletUtil.initIndex(request, "search_script_row_item" +  p_action_flag);
			idx_row_item = 0;
			HoServletUtil.setClosed(request, "search_script_row_item_closed" +  p_action_flag, true);
		}

		if (idx !=0 ) {
			out.print("," );
		}

		// 검색 조건 한 행 시작
		if( idx_row_item==0) {
			HoServletUtil.setClosed(request, "search_script_row_item_closed" +  p_action_flag, false);
%>
			{
                xtype: 'fieldcontainer',
                // combineErrors: true,
                // msgTarget: 'under',
            	layout: { type: 'hbox', defaultMargins: {top: 0, right: 5, bottom: 0, left: 0} },
                items: [
<%
		}

		if( "radio".equals(type)) {
%>
			{defaultType: 'radio',  layout: 'hbox', border : 0,
	            items: [{
	                checked: true,
	                fieldLabel: 'Favorite Color',
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
			HoServletUtil.increaseIndex(request, "search_script_row_item" +  p_action_flag, increment);
		} else if( "checkbox".equals(type)) {
%>
			{
            defaultType: 'checkboxfield', // each item will be a checkbox
            layout: 'hbox',
            border : 0,
            items: [{
                fieldLabel: 'Favorite Animals',
                boxLabel: 'Dog',
                name: '<%= name %>',
                inputValue: 'dog'
            }, {
                checked: true,
                boxLabel: 'Cat',
                name: '<%= name %>',
                value: 'cat',
                inputValue : 'cat'
            }, {
                checked: true,
                boxLabel: 'Monkey',
                name: '<%= name %>3',
                inputValue: 'monkey'
            }]
}
<%
			HoServletUtil.increaseIndex(request, "search_script_row_item" +  p_action_flag, increment);
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
			HoServletUtil.increaseIndex(request, "search_script_row_item" +  p_action_flag, increment);
		} else if( "text".equals(type) ) {
%>
			{
				xtype     : 'textfield',
				width:          300,
				name      : '<%= name %>',
				fieldLabel: '<%= title %>',
				vtype: 'email',
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
<%		}
		HoServletUtil.increaseIndex(request, "search_script" + p_action_flag);
		HoServletUtil.increaseIndex(request, "search_script_row_item" +  p_action_flag, 2);

		idx_row_item = HoServletUtil.getIndex(request, "search_script_row_item" +  p_action_flag);

		if( idx_row_item>=8) {
%>
						]
				}
<%
			HoServletUtil.initIndex(request, "search_script_row_item" +  p_action_flag);
			HoServletUtil.setClosed(request, "search_script_row_item_closed" +  p_action_flag, true);
		}
	}

	if( isHtml ) {

	}
%>
<jsp:doBody/>
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
		} else {
			return 2;
		}
	}

%>