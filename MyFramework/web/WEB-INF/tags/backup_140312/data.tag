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
	String tab_index      = param.get("tab_index");

	boolean isScript = "script".equals(division);
	boolean isHtml 	 = "html".equals(division);
	boolean isFirstTab = "0".equals(tab_index);

%>



<% if( isScript ) { %>

<%
	int index =  HoServletUtil.getIndex(request, HoServletUtil.getArea(request)+"_row");
	HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request)+"_row");
	HoServletUtil.setInArea(request, "data["+HoUtil.replaceNull(layout)+"]");

	out.print(index > 0 ? "," : "" );

	if( "tab".equals(layout))  {
%>
			{
            	xtype: 'tabpanel',
                collapsible: false,
                split: true,
                width: 100, // give east and west regions a width
                minSize: 175,
                maxSize: 400,
                height : 600,
                margin: '<%= index == 0 ? "5" : "0" %> 5 5 5',
                activeTab: 0,
                items: [ <jsp:doBody></jsp:doBody>]
            }
<%		} else if( HoUtil.replaceNull(layout).endsWith("box"))  { %>
			{	xtype :'panel',
			    // width: Ext.getBody().getViewSize(false).width,
			    // height: 600,
			    autoScroll: true,
			    margin: '<%= index == 0 ? "5" : "0" %> 5 5 5',
			    border : 0,
			    autoHeight: true,
			    // width : '100%',
			    layout: {
			        type: '<%= layout %>', pack: 'start', align: 'stretch'
			    },
			    plugins : [
					// Ext.create('Ext.ux.FitToParent', { fitWidth : true , fitHeight : true, offsets : [11,11] } )
				],
			    items: [ <jsp:doBody></jsp:doBody>  ]
			}
<%
	} else {
%>
	<jsp:doBody></jsp:doBody>
<%
	}

	HoServletUtil.setOutArea(request);

} %>



<% if( isHtml ) {
%>

<%
} %>