<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag
	import="project.jun.was.HoModel"
	import="project.jun.util.HoUtil"
	import="project.jun.was.parameter.HoParameter"
	import="project.jun.was.spring.HoController"
	import="project.jun.util.HoServletUtil"
	import="project.jun.util.HoValidator"
%><%@ include file="include.tag" %>
<%@ attribute name="layout" type="java.lang.String"
%><%@ attribute name="position" type="java.lang.String"
%><%@ attribute name="id" type="java.lang.String"
%><%@ attribute name="collapse" type="java.lang.String"
%><%@ attribute name="title" type="java.lang.String"
%><%@ attribute name="width" type="java.lang.String"
%><%@ attribute name="height" type="java.lang.String"
%><%@ attribute name="min" type="java.lang.String"
%><%@ attribute name="max" type="java.lang.String"
%>
<% if( isScript || isScriptOut ) { 
	out.println(" // ->" + HoServletUtil.getArea(request) );
	int index =  HoServletUtil.getIndex(request, HoServletUtil.getArea(request)+ "_row");
	HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request)+ "_row");
	HoServletUtil.setInArea(request, "data["+HoUtil.replaceNull(layout)+"]");

	HoServletUtil.setString(request, "data", HoUtil.replaceNull(position));
	
	
	out.print((index > 0 ? "," : "") + "// index - "  + index );

	if( "tab".equals(layout))  {
%>
			{
            	xtype: 'tabpanel',
                collapsible: false,
                split: true,
                cls : 'detail_tabpanel',
				<%= "".equals(HoUtil.replaceNull(title)) ? "" :  "title : '"+HoUtil.replaceNull(title)+"',"  %>
        		<%= "".equals(HoUtil.replaceNull(id)) ? "" : "id : '" + param.get("p_action_flag") + "_data_" + id +"'," %>
                width: 600, // give east and west regions a width
                // minSize: 500,
                // maxSize: 400,
                // height : 800,
                region: '<%= HoUtil.replaceNull(position, "center") %>',
                margin: '<%= index == 0 ? "0" : "0" %> 0 0 0',
                activeTab: 0,
                items: [ <jsp:doBody></jsp:doBody>]
            }
<%		} else if( HoUtil.replaceNull(layout).endsWith("box"))  { %>
			{	xtype :'panel',
			    // width: Ext.getBody().getViewSize(false).width,
			    // height: 600,
			    autoScroll: true,
				<%= "".equals(HoUtil.replaceNull(title)) ? "" :  "title : '"+HoUtil.replaceNull(title)+"',"  %>
        		<%= "".equals(HoUtil.replaceNull(id)) ? "" : "id : '" + param.get("p_action_flag") + "_data_" + id +"'," %>
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
<%		} else if( HoUtil.replaceNull(layout).equals("border"))  { %>
			{	xtype :'panel',
			    autoScroll: true,
				layout : '<%= layout %>',
        		region: '<%= HoUtil.replaceNull(position, "center") %>',
				<%= "".equals(HoUtil.replaceNull(title)) ? "" :  "title : '"+HoUtil.replaceNull(title)+"',"  %>
        		<%= "".equals(HoUtil.replaceNull(id)) ? "" : "id : '" + param.get("p_action_flag") + "_data_" + id +"'," %>
			    // margin: '<%= index == 0 ? "5" : "0" %> 5 5 5',
			    border : 0,
			    autoHeight: true,
			    style: {
	            		color: '#FFFFFF',
	            		backgroundColor: '#000000'
				},

			    items: [ <jsp:doBody></jsp:doBody>  ]
			}
<%		} else if( !HoUtil.replaceNull(layout).equals(""))  { %>
			{	
                collapsible: true,
                animCollapse: true,
                layout : '<%= layout %>',
                region: '<%= HoUtil.replaceNull(position, "center") %>',
			    autoScroll: Ext.isChrome  ? false : true,
				split: true,
				<%= "".equals(HoUtil.replaceNull(title)) ? "" :  "title : '"+HoUtil.replaceNull(title)+"',"  %>
				<%= "".equals(HoUtil.replaceNull(collapse)) ? "" :  "split: true, collapsed : true,collapsible  : true, animCollapse: true, collapseDirection : '"+HoUtil.replaceNull(collapse, "header")+"',"  %>
				<%= "".equals(HoUtil.replaceNull(id)) ? "" : "id : '" + param.get("p_action_flag") + "_data_" + id +"'," %>
			    <% if("east".equals(position) ||"west".equals(position) ) {  %>
			    width : <%= "".equals(HoUtil.replaceNull(width, "")) ? "400" : HoUtil.replaceNull(width, "") %>,   minWidth : <%= "".equals(HoUtil.replaceNull(width, "")) ? "400" : HoUtil.replaceNull(width, "") %>, maxWidth : <%= "".equals(HoUtil.replaceNull(width, "")) ? "400" : HoUtil.replaceNull(width, "") %>, collapsible: <%= "N".equals(HoUtil.replaceNull(collapse)) ? "false" : "true"%> ,
                <% } %>
			    border :  <%= "center".equals(HoUtil.replaceNull(position, "center")) ? "0" :  "1"  %> , //  "0" :  "1" 
			    // autoHeight: true,
			    // anchorSize : 500,
			    style: {
			    		color: '#FFFFFF',
			    		backgroundColor: '#000000'
				},
		<%-- @TODO 아래의 부분(if( !hoConfig.isProductMode() {})은 실제 운영시 제거 --%>
        <% if( !hoConfig.isProductMode() ) { // 개발모드일 경우 %>
        tools:[{
    		type:'help',
    		handler: function(event, toolEl, panelHeader) {
    			Ext.widget('window', {
				        title : '<%= HoValidator.isNotEmpty(title)  ? "title : ["+title+"] " : ""  %>  정보',
				        height: 200,
				        width: 500,
				        layout: 'fit',
				        modal: true,
				        items : [
							{
								xtype :'panel',
								items : [
											{ 
												html : 'Id of Grid : [<%=HoUtil.replaceNull(id) %>]'
											},
											{ 
												html : 'Id of Grid(Full) : [<%= p_action_flag %>_grid_<%=HoUtil.replaceNull(id) %>]'
											},
											{ 
												html : 'StoreId of Store : [<%=param.get("p_action_flag")%>_store_grid_<%=HoUtil.replaceNull(id) %>]'
											},
											{ 
												html : 'Id of Store : [<%= p_action_flag %>_grid_store_<%=HoUtil.replaceNull(id) %>]'
											}
										]
							}
				        ]
				    }).show();
				
    		},
    		tooltip: 'Id of Grid : [<%= p_action_flag %>_grid_<%=HoUtil.replaceNull(id) %>]<br/>StoreId of Store : [<%=param.get("p_action_flag")%>_store_grid_<%=HoUtil.replaceNull(id) %>]<br/>Id of Store : [<%= p_action_flag %>_grid_store_<%=HoUtil.replaceNull(id) %>]'
        }],
        <% } %>
			    items: [ <jsp:doBody></jsp:doBody>  ]
			}
<%		} else if( HoUtil.replaceNull(layout).equals(""))  { %>
			{	xtype :'panel',
			    // autoScroll: Ext.isChrome  ? false : true,
			    layout: 'border',
			    split: true,
			    formBind : true,
			    autoHeight: true,
				<%= "".equals(HoUtil.replaceNull(title)) ? "" :  "title : '"+HoUtil.replaceNull(title)+"',"  %>
				<%= "".equals(HoUtil.replaceNull(collapse)) ? "" :  "animCollapse: true, collapseDirection : '"+HoUtil.replaceNull(collapse, "header")+"',"  %>
	    		<%= "".equals(HoUtil.replaceNull(id)) ? "" : "id : '" + param.get("p_action_flag") + "_data_" + id +"'," %>
	    		region: '<%= HoUtil.replaceNull(position, "center") %>',
			    // margin: '<%= index == 0 ? "5" : "0" %> 5 5 5',
			    border :  <%= "center".equals(HoUtil.replaceNull(position, "center")) ? "0" :  "1"  %> ,
			    <% if("east".equals(position) ||"west".equals(position) ) {  %>
			    <%= HoValidator.isNotEmpty(max) ? "maxWidth : "+max+"," : "" %>
			    <%= HoValidator.isNotEmpty(min) ? "minWidth : "+min+"," : "" %>
			    width : <%= HoUtil.replaceNull(width, "400") %>, collapsible : <%= "N".equals(HoUtil.replaceNull(collapse)) ? "false" : "true"%> ,
			    <% } else if("east".equals(position) ||"west".equals(position) ) {  %>
			    <%= HoValidator.isNotEmpty(max) ? "maxHeight : "+max+"," : "" %>
			    <%= HoValidator.isNotEmpty(min) ? "minHeight : "+min+"," : "" %>
			    height : <%= HoUtil.replaceNull(height, "500") %> ,  collapsible : <%= "N".equals(HoUtil.replaceNull(collapse)) ? "false" : "true"%>,
			    <% } %>
			    style: {
	            		color: '#FFFFFF',
	            		backgroundColor: '#000000'
				},
			    items: [ <jsp:doBody></jsp:doBody>  ]
			}
<%
		} else {
%>
	<jsp:doBody></jsp:doBody>
<%
		}
	HoServletUtil.setString(request, "data", null);

	HoServletUtil.setOutArea(request);

} %>



<% if( isHtml ) {
%>

<%
} %>