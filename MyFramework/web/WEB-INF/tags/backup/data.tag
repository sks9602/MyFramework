<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag
	import="project.jun.was.HoModel"
	import="project.jun.util.HoUtil"
	import="project.jun.was.parameter.HoParameter"
	import="project.jun.was.spring.HoController"
	import="project.jun.util.HoServletUtil"
%><%@ attribute name="layout" type="java.lang.String"
%>
<%
	HoModel        model     = new HoModel(request);
	HoParameter    param     = (HoParameter) model.get(HoController.HO_PARAMETER);

	String p_action_flag = param.get("p_action_flag");
	String division      = param.get("division");

	boolean isScript = "script".equals(division);
	boolean isHtml 	 = "html".equals(division);

%>

<% if( isScript ) {
	String area = HoServletUtil.getString(request, "search_script_item_area" +  p_action_flag);
	int idx_panel_item = HoServletUtil.getIndex(request, "search_script_panel_item_index" +  p_action_flag + area);
%>
	<%= idx_panel_item > 0 ? "," : "" %>


<%
		if( "tab".equals(layout))  {
			HoServletUtil.setString(request, "search_script_item_area" +  p_action_flag, "data");
%>
			{
            	xtype: 'tabpanel',
                collapsible: false,
                split: true,
                width: 1000, // give east and west regions a width
                minSize: 175,
                maxSize: 400,
                height : 600,
                margin: '0 5 5 5',
                activeTab: 0,
                items: [ // { html: '<p>A TabPanel component can be a region.</p>', title: 'A Tab', autoScroll: true },
                        <jsp:doBody></jsp:doBody>]
            }

<%		} else if( layout.endsWith("box"))  { %>

			{	xtype :'panel',
			    width: 1000,
			    height: 600,
			    autoScroll: true,
			    margin: '0 5 5 5',
			    border : 0,
			    layout: {
			        type: '<%= layout %>'
			        // , align: 'stretch'
			    },
			    items: [ <jsp:doBody></jsp:doBody> /*{
        xtype: 'panel',
        border : 1,
        title: 'Inner Panel One',
        flex: 2
    },{
        xtype: 'panel',
        title: 'Inner Panel Two',
        items: [ { html: '<p>A TabPanel component can be a region.</p>', autoScroll: true } ],
        flex: 1
    },{
        xtype: 'panel',
        title: 'Inner Panel Three',
        flex: 1
    }*/ ]
			}

<%		} else { %>

<jsp:doBody></jsp:doBody>

<%		} %>

<%
	HoServletUtil.setString(request, "search_script_item_area" +  p_action_flag, null);

} %>


<% if( isHtml ) { %>
	<jsp:doBody></jsp:doBody>
<% } %>
