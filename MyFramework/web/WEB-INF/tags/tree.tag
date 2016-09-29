<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag
	import="project.jun.was.HoModel"
	import="project.jun.util.HoUtil"
	import="project.jun.util.HoValidator"
	import="project.jun.was.parameter.HoParameter"
	import="project.jun.was.spring.HoController"
	import="project.jun.util.HoServletUtil"
%><%@ include file="include.tag" %>
<%@ attribute name="id" type="java.lang.String" required="true"
%><%@ attribute name="action" type="java.lang.String"
%><%@ attribute name="title" type="java.lang.String"
%><%@ attribute name="width" type="java.lang.String"
%><%@ attribute name="height" type="java.lang.String"
%><%@ attribute name="page" type="java.lang.String"
%><%@ attribute name="button" type="java.lang.String"
%><%@ attribute name="position" type="java.lang.String"
%><%@ attribute name="rootVisible" type="java.lang.String" 
%><%@ attribute name="root" type="java.lang.String" 
%><%

	String section_name =  "_tree";

%>



<% if( isScript || isScriptOut ) { %>

<%
	int index =  HoServletUtil.getIndex(request, HoServletUtil.getArea(request)+"_row");
	HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request)+"_row");
	HoServletUtil.setInArea(request, "tree");

	String [] buttons = HoValidator.isNotEmpty(button) ? button.split("\\,") : new String [0];

	out.print(index > 0 ? "," : "" );

%>
		Ext.create('Ext.tree.Panel', {
		    <%= HoValidator.isEmpty(title) ? "": "title : '"+title+"',"%>
		    width: <%= HoValidator.isEmpty(width) ? "450" : width %>,
		    height: <%= HoValidator.isEmpty(height) ? "600" : height %>,
        	region: '<%= HoUtil.replaceNull(position, "center") %>',
        	id : '<%= p_action_flag %>_tree_<%=HoUtil.replaceNull(id) %>',
        	<% if( !HoUtil.replaceNull(position, "center").equals("center") ) { %>
        	margin: '<%= HoUtil.replaceNull(position).equals("south") ? "5" : "0"%> <%= HoUtil.replaceNull(position).equals("west") ? "5" : "0"%> <%= HoUtil.replaceNull(position).equals("north") ? "5" : "0"%> <%= HoUtil.replaceNull(position).equals("east") ? "5" : "0"%>',
        	<% } %>
        	<jsp:doBody></jsp:doBody>
			store: Ext.create('Ext.data.TreeStore', {
				root: {
					text : "<%= HoUtil.replaceNull(root, "ROOT") %>",
					expanded: true
				},
				autoLoad: true,
				// autoSync: true,
				fields : ['id', 'text' ],
				proxy   : {
						    type : 'ajax', 
						    extraParams : { 
								p_action_flag : 'r_tree'
							}, 
						    url  : '<%= request.getContextPath() +  action %>',
						    reader: {
						        type: 'json'
						    }
				},
				folderSort: false
		     }),
             dockedItems: [{
                 dock: 'top',
                 xtype: 'toolbar',
                 items: [ { id: '<%= p_action_flag %>_tree_<%=HoUtil.replaceNull(id) %>_text_select', text : '[ *Not selected ]' },
                 	 '->', 
	                 {
	                    xtype: 'button',
	                    text: '펼치기',
	                    tooltip: 'Expand',
	                    iconCls:'btn-icon-expand', 
	                    listeners : {
	                 	   click : function(_button, e, eOpts) {
								var tree = Ext.getCmp('<%= p_action_flag %>_tree_<%=HoUtil.replaceNull(id) %>');
								tree.expandAll();
	                 	   }
	                    }
	                 }, 
	                 {
	                    xtype: 'button',
	                    text: '접기',
	                    tooltip: 'Collapse',
	                    iconCls:'btn-icon-collapse', 
	                    listeners : {
	                 	   click : function(_button, e, eOpts){
	                        	var tree = Ext.getCmp('<%= p_action_flag %>_tree_<%=HoUtil.replaceNull(id) %>');
	                        	tree.collapseAll();
	                 	   	}
	                    }
	                 }
                 ]
			}],
			listeners : {
				itemclick : function ( _this, record, item, index, e, eOpts ) {
					var text = Ext.getCmp('<%= p_action_flag %>_tree_<%=HoUtil.replaceNull(id) %>_text_select');
					text.setText('<b>[ '+ record.get('text') + ' ]</b>');
				}
			},
			rootVisible: <%= HoValidator.isIn(rootVisible, new String[] { "y", "true"}, true) ? "true" : "false" %>
		})

<%
	HoServletUtil.setOutArea(request);

%>

<% } %>


<% if( isHtml  ) {
%>

<%
 } %>