<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag
	import="project.jun.was.HoModel"
	import="project.jun.util.HoUtil"
	import="project.jun.util.HoValidator"
	import="project.jun.was.parameter.HoParameter"
	import="project.jun.was.spring.HoController"
	import="project.jun.util.HoServletUtil"
%><%@ attribute name="action" type="java.lang.String"
%><%@ attribute name="title" type="java.lang.String"
%><%@ attribute name="width" type="java.lang.String"
%><%@ attribute name="height" type="java.lang.String"
%><%@ attribute name="page" type="java.lang.String"
%><%
	HoModel        model     = new HoModel(request);
	HoParameter    param     = (HoParameter) model.get(HoController.HO_PARAMETER);

	String p_action_flag = param.get("p_action_flag");
	String division      = param.get("division");

	boolean isScript = "script".equals(division);
	boolean isHtml 	 = "html".equals(division);

	String section_name =  "_grid";
	String area = HoServletUtil.getString(request, "search_script_item_area" +  p_action_flag);
%>

<% if( isScript ) {

	String button_area = HoServletUtil.getString(request, "button_area" );

	HoServletUtil.setString(request, "button_area" , "grid" );

	int gridIndex = HoServletUtil.getIndex(request, "grid_index");

	int idx_panel_item = HoServletUtil.getIndex(request, "search_script_panel_item_index" +  p_action_flag + area);
%>
<%= idx_panel_item > 0 ? "," : "" %>
	Ext.create('Ext.grid.Panel', {
    	<%= HoValidator.isNotEmpty(title)  ? "title : '"+title+"', " : ""  %>
        width   : <%= HoValidator.isEmpty(width) ? "450" : width %>,
        height   : <%= HoValidator.isEmpty(height) ? "600" : height %>,
	    store: new Ext.data.JsonStore({
			storeId:'store<%= section_name %>_<%=param.get("p_action_flag")%>_<%=gridIndex %>',
			autoDestroy: true,
			root: 'topics',
			totalProperty: 'totalCount',
			remoteSort:	true,
			fields:['name', 'email', 'phone'],
			id : 'grid_<%= p_action_flag %>_<%=gridIndex %>',
		    data:{'totalCount' : '10', 'topics':[
		        { 'name': 'Lisa',  "email":"lisa@simpsons.com",  "phone":"555-111-1224"  },
		        { 'name': 'Bart',  "email":"bart@simpsons.com",  "phone":"555-222-1234" },
		        { 'name': 'Homer', "email":"home@simpsons.com",  "phone":"555-222-1244"  },
		        { 'name': 'Marge', "email":"marge@simpsons.com", "phone":"555-222-1254"  }
		    ]},
	    /*proxy: {
	        type: 'memory', //'ajax',
	        url : '<%= request.getContextPath() +  action %>',
	        reader: {
	            type: 'json',
	            root: 'topics'
	        }
	    }  */
			proxy: new Ext.data.HttpProxy
			({
				type: 'ajax', //'memory',
				url: '<%= request.getContextPath() +  action %>',
				reader: {
		            type: 'json',
		            root: 'topics'
		        }
			})
		}) ,
		border : 1,
		<%= HoValidator.isEmpty(area)? "margin : '5 5 5 5'," : "" %>
	    columns: [
	        {xtype: 'rownumberer', width:30 },
	        { text: 'Name',  dataIndex: 'name' },
	        { text: 'Email', dataIndex: 'email', flex: 1 },
	        { text: 'Phone', dataIndex: 'phone' }

	        ,<jsp:doBody></jsp:doBody>
	    ],
<%
	String buttons = HoServletUtil.getString( request, "search_script_grid_button" +  p_action_flag + gridIndex);

	if( !HoValidator.isEmpty(buttons)) {
%>
		  dockedItems: [{
        		xtype: 'toolbar',
        		dock: 'top',
        		flex:1,
        		border : true,
        		// ui: 'footer',
        		// componentCls : "bottom-border",
        		items : [ <%= buttons  %>]
        }],
<%
	}

	if( HoValidator.isNotEmpty(page) && HoValidator.isNumber(page) ) {
%>
	    bbar: [
			Ext.create('Ext.PagingToolbar', {
            displayInfo: true,
            displayMsg: 'Displaying topics {0} - {1} of {2}',
            emptyMsg: "No topics to display",
            id : 'bbar_<%= p_action_flag %>_<%=gridIndex %>',
            items:[
                '-', {
                text: 'Show Preview',
                enableToggle: true,
                toggleHandler: function(btn, pressed) {
                    var preview = Ext.getCmp('gv').getPlugin('preview');
                    preview.toggleExpanded(pressed);
                }
            }]
        }), { xtype: 'button', text: 'Button 1' }
		],
<% 	} %>
		plugins : [
			Ext.create('Ext.ux.FitToParent', { id :'f_to_p_<%=p_action_flag %>_<%=gridIndex %>', fitWidth : , offsets : [11,11] } )
		]
	})

<%
	HoServletUtil.setString(request, "button_area" , button_area );
	HoServletUtil.setString(request, "button_area" + button_area, null );
	HoServletUtil.increaseIndex(request, "search_script_panel_item_index" + p_action_flag + area);
	HoServletUtil.increaseIndex(request, "grid_index");
 } %>


<% if( isHtml ) { %>
		<div id="div<%= section_name %>_<%=param.get("p_action_flag")%>"></div>
<% } %>
