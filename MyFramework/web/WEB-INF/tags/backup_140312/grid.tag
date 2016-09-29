<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag
	import="project.jun.was.HoModel"
	import="project.jun.util.HoUtil"
	import="project.jun.util.HoValidator"
	import="project.jun.was.parameter.HoParameter"
	import="project.jun.was.spring.HoController"
	import="project.jun.util.HoServletUtil"
	import="project.jun.dao.HoDao"
	import="project.jun.util.HoSpringUtil"
	import="project.jun.dao.result.HoMap"
	import="project.jun.dao.parameter.HoQueryParameterMap"
	import="org.apache.ibatis.metadata.result.MetaData"
%><%@ attribute name="id" type="java.lang.String"
%><%@ attribute name="action" type="java.lang.String"
%><%@ attribute name="title" type="java.lang.String"
%><%@ attribute name="width" type="java.lang.String"
%><%@ attribute name="height" type="java.lang.String"
%><%@ attribute name="page" type="java.lang.String"
%><%@ attribute name="button" type="java.lang.String"
%><%@ attribute name="checkbox" type="java.lang.String"
%><%@ attribute name="rownum" type="java.lang.String"
%><%@ attribute name="fields" required="true" type="java.lang.String"
%><%
	HoModel        model     = new HoModel(request);
	HoParameter    param     = (HoParameter) model.get(HoController.HO_PARAMETER);

	String p_action_flag = param.get("p_action_flag");
	String division      = param.get("division");
	String tab_index      = param.get("tab_index");

	boolean isScript = "script".equals(division);
	boolean isHtml 	 = "html".equals(division);
	boolean isFirstTab = "0".equals(tab_index);

	String section_name =  "_grid";

%>



<% if( isScript ) { %>

<%
	int index =  HoServletUtil.getIndex(request, HoServletUtil.getArea(request)+"_row");
	HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request)+"_row");
	HoServletUtil.setInArea(request, "grid");

	String [] buttons = HoValidator.isNotEmpty(button) ? button.split("\\,") : new String [0];

	out.print(index > 0 ? "," : "" );

%>
	Ext.create('Ext.grid.Panel', {
    	<%= HoValidator.isNotEmpty(title)  ? "title : '"+title+"', " : ""  %>
<%  if(!HoValidator.isEmpty(width)) {  %>
       width   : <%= HoValidator.isEmpty(width) ? "Ext.getBody().getViewSize().width" : width %>,
<% } %>
        height   : <%= HoValidator.isEmpty(height) ? "600" : height %>,
        // layout : 'fit', // <%= !HoValidator.isEmpty(width)%>  <%= !HoValidator.isEmpty(height)%>
        viewConfig: {
        	forceFit: true
        },
        columnLines: true,
		<%  if( HoValidator.isEmpty(width) || HoValidator.isEmpty(height)) {  %>
        listeners : {
			render : function (_this) {
						var size = Ext.getBody().getViewSize(false), left=0, top=0,
	        			pos  = _this.getPosition(false);

	        			if(  Ext.get('id_main_west_panel') ) {	        				left = Ext.get('id_main_west_panel').getWidth() ;
	        			}
	        			if(  Ext.get('id_search_<%= p_action_flag %>') ) {
	        				top = Ext.get('id_search_<%= p_action_flag %>').getHeight();
	        			}
						// alert( _this.getPosition()[1]);
						var w = window,
						    d = document,
						    e = d.documentElement,
						    g = d.getElementsByTagName('body')[0],
						    x = w.innerWidth || e.clientWidth || g.clientWidth,
						    y = w.innerHeight|| e.clientHeight|| g.clientHeight;

	        			var width  = <%= !HoValidator.isEmpty(width) ? width : "size.width - left - pos[0]  - 20" %>;
	        			var heigth =  <%= !HoValidator.isEmpty(height) ? height : "size.height - top - 215" + (isFirstTab ? "" : "+20") %>;
	        			// var width  = Ext.getBody().getViewSize().width - 252; //
	        			// var heigth =  <%= !HoValidator.isEmpty(height) ? height : "size.height - 210 - _this.getPosition()[1]" + (isFirstTab ? "" : "+20") %>
	        			_this.setSize( width,  heigth );
	            	}
        },
		<% } %>
		id : 'grid_<%= p_action_flag %>_<%=HoUtil.replaceNull(id) %>',
	    store: new Ext.data.JsonStore({
			storeId:'store<%= section_name %>_<%=param.get("p_action_flag")%>_<%=HoUtil.replaceNull(id) %>',
			autoDestroy: true,
			root: 'datas',
			totalProperty: 'totalCount',
			remoteSort:	true,
			fields:[<%
			        HoDao dao = (HoDao) new HoSpringUtil().getBean(application, "proxyProjectDao");
					HoQueryParameterMap value = new HoQueryParameterMap();
					value.put("METADATA", "Y");
			        value.put("S_ROWNUM", "0");
			        value.put("E_ROWNUM", "0");

					HoMap map = dao.selectOne(fields, value);

					MetaData md = map.getMetaData();
					for( int i=0;  i<md.getColumnCount() ; i++) {
						if( i>0 ) {
							out.println(",");
						}
						out.println("'"+md.getColumnName(i).toLowerCase()+"'");
					}
			        %>], //['TABLE_NAME', 'TABLE_ALIAS', 'TABLE_TYPE'],
			id : 'grid_<%= p_action_flag %>_<%=HoUtil.replaceNull(id) %>_store',
			proxy: new Ext.data.HttpProxy
			({
				type: 'ajax', //'memory',
				url: '<%= request.getContextPath() +  action %>',
				reader: {
		            type: 'json',
		            root: 'datas'
		        }
			})
		}) ,
		border : 1,
		<%= HoValidator.isEmpty(checkbox) ? "selType: 'cellmodel'," : "selType: 'checkboxmodel'," %>
		<% if ( HoServletUtil.getArea(request).indexOf("fieldcontainer") > 0 ) { %>
	 	margin : '0 5 5 0', // !! <%= p_action_flag%> <%= index %>
		<% } else if ( index > 0 && HoServletUtil.getArea(request).indexOf("fieldcontainer") < 0 ) { %>
		 	margin : '0 5 5 5', // ?? <%= p_action_flag%> <%= index %>
		<% } else if( HoServletUtil.getArea(request).indexOf("box") < 0 && HoServletUtil.getArea(request).indexOf("fieldcontainer") < 0 ) {   %>
			margin : '0 5 5 5', // ++ <%= p_action_flag%> <%= index %>
		<% } %>
	    columns: [
	    <% if( !HoUtil.replaceNull(rownum).equals("N")  ) { %>
	        {xtype: 'rownumberer', width:30 },
	    <% } %>
			<jsp:doBody></jsp:doBody>

	    ],
	    bbar:
			Ext.create('Ext.ux.PagingToolbar', {
            displayInfo: true,
            <%= HoValidator.isEmpty(page) ? "" : "pageCnt : " + page + "," %>
            displayMsg: 'Displaying topics {0} - {1} of {2}',
            emptyMsg: "No topics to display",
            id : 'bbar_<%= p_action_flag %>_<%=HoUtil.replaceNull(id)  %>',
            items:[/*
                '-', {
                text: 'Show Preview',
                enableToggle: true,
                toggleHandler: function(btn, pressed) {
                    var preview = Ext.getCmp('gv').getPlugin('preview');
                    preview.toggleExpanded(pressed);
                }
            } */ ]
        }),
<%  if(HoValidator.isEmpty(width)) {  %>
		plugins : [
		 Ext.create('Ext.grid.plugin.CellEditing', {id : 'grid_editor_<%= p_action_flag %>_<%=HoUtil.replaceNull(id) %>', clicksToEdit: 1})
			//, Ext.create('Ext.ux.FitToParent', { fitWidth : <%= HoValidator.isEmpty(width) ? "true" : "false" %> , fitHeight : <%= HoValidator.isEmpty(height) ? "true" : "false" %>, offsets : [11,11] } )
		],
<% } %><%
	//if( buttons.length> 0 ) {
		out.println("dockedItems: [{xtype: 'toolbar', dock :'top', flex : 1, border : true, ");
		out.println("id : 'tbar_"+p_action_flag +"_"+HoUtil.replaceNull(id)+"', ");
		out.println("items : [");

		for( int i=0 ; i< buttons.length ; i++ ) {
			out.println((i>0  ? "," :"" ) + "{ xtype : 'button', text : '"+ buttons[i] + "' }");
		}
		out.println(", '->', { xtype: 'tool', type: 'restore', handler: function(e, target, header, tool){  ");
		out.println(" var _this =  header.ownerCt;   ");
		out.println("			var size = Ext.getBody().getViewSize(false), left=0, top=0, ");
		out.println("	pos  = _this.getPosition(false);");
		out.println("	if(  Ext.get('id_main_west_panel') ) {");		out.println("		left = Ext.get('id_main_west_panel').getWidth() ;");
		out.println("	}");
		out.println("	if(  Ext.get('id_search_"+ p_action_flag +"') ) {");
		out.println("		top = Ext.get('id_search_"+ p_action_flag +"').getHeight();");
		out.println("	}");
		out.println("	var width  =  "+ (!HoValidator.isEmpty(width) ? width+"" : "size.width -  pos[0]  - 12") +";  ");
		out.println("	var heigth =  "+ (!HoValidator.isEmpty(height) ? height+"" : "size.height - top - 112" + (isFirstTab ? "" : "+20")) +";");
		out.println("	_this.setSize( width,  heigth );");
		out.println("	}");
		out.println(" }");


		out.println("]");
		out.println("}]");
	//}
%>

	})

<%
	//out.println("<br/>&nbsp;&nbsp;&nbsp;]");
	HoServletUtil.initIndex(request, HoServletUtil.getArea(request)+">column_row");
	HoServletUtil.setOutArea(request);

%>

<% } %>


<% if( isHtml  ) {
%>

<%
 } %>