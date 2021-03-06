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
		int idx_section = HoServletUtil.getIndex(request, "search_script_section" +  p_action_flag);
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

		if (idx_section !=0 || idx !=0 ) {
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
                border : 1,
                margins : '0 0 0 0',
            	layout: {
                        type: 'hbox',
                        defaultMargins: {top: 0, right: 5, bottom: 0, left: 5}
                    },

                items: [
<%
		}

		if( "radio".equals(type)) {
%>
{
            defaultType: 'radio', // each item will be a radio button
            layout: 'hbox',
            border : 0,
            items: [{
                checked: true,
                fieldLabel: 'Favorite Color',
                boxLabel: 'Red ',
                name: 'fav-color',
                inputValue: 'red'
            }, {
                boxLabel: 'Blue ',
                name: 'fav-color',
                inputValue: 'blue'
            }, {
                boxLabel: 'Green ',
                name: 'fav-color',
                inputValue: 'green'
            }]
        }

<%
			HoServletUtil.increaseIndex(request, "search_script_row_item" +  p_action_flag, increment);
		} else if( "checkbox".equals(type)) {
%>
{
            defaultType: 'checkbox', // each item will be a checkbox
            layout: 'hbox',
            border : 0,
            defaults: {
                anchor: '100%',
                margin : '0 10 0 0'
                // , hideEmptyLabel: false
            },
            items: [{
                fieldLabel: 'Favorite Animals',
                boxLabel: 'Dog',
                name: 'fav-animal',
                inputValue: 'dog'
            }, {
                boxLabel: 'Cat-aljldjflas',
                name: 'fav-animal',
                inputValue: 'cat'
            }, {
                checked: true,
                boxLabel: 'Monkey',
                name: 'fav-animal',
                inputValue: 'monkey'
            }, {
                checked: true,
                boxLabel: 'Monkey-akdjljaldsf-alkjlfkdjlaksjdf-aljldjflas',
                name: 'fav-animal',
                inputValue: 'monkey'
            }]
}
<%
			HoServletUtil.increaseIndex(request, "search_script_row_item" +  p_action_flag, increment);
		} else if( "combo".equals(type) || "select".equals(type) ){
%>
	{
         width:          200,
         xtype:          'combo',
         queryMode:      'local',
         value:          'mrs',
         triggerAction:  'all',
         forceSelection: true,
         editable:       false,
         fieldLabel:     'Title',
         name:           'title',
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
				width:          200,
				name      : '<%= name %>',
				fieldLabel: '<%= title %>',
				vtype: 'email',
				msgTarget: 'side'
			}
<%
		}else if( "hidden".equals(type)) {
%>
			{
				xtype     : 'hidden',
				width:          300,
				name      : '<%= name %>',
				value     : '<%= HoUtil.replaceNull(value) %>'
			}
<%		} else if( "grid".equals(type)) {
%> {xtype :'label', text : '<%= title  %>', width : 100 },
	<jsp:doBody></jsp:doBody>
<%
			HoServletUtil.increaseIndex(request, "search_script_row_item" +  p_action_flag, increment);
		}

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