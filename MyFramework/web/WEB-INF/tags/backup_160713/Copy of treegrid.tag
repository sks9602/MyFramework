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
%><%@ attribute name="pageYn" type="java.lang.String"
%><%@ attribute name="button" type="java.lang.String"
%><%@ attribute name="lead" type="java.lang.String"
%><%@ attribute name="fields" required="true" type="java.lang.String"
%><%@ attribute name="position" type="java.lang.String"
%><%@ attribute name="options" type="java.lang.String"
%><%
	HoModel        model     = new HoModel(request);
	HoParameter    param     = (HoParameter) model.get(HoController.HO_PARAMETER);

	String p_action_flag = param.get("p_action_flag");
	String division      = param.get("division");
	String tab_index      = param.get("tab_index");

	boolean isScript = "script".equals(division);
	boolean isHtml 	 = "html".equals(division);
	boolean isFirstTab = "0".equals(tab_index);
	boolean isScriptOut = "script_out".equals(division);

	String section_name =  "_grid";

%>



<% if( isScript || isScriptOut ) { %>

<%
	int index =  HoServletUtil.getIndex(request, HoServletUtil.getArea(request)+"_row");
	HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request)+"_row");
	HoServletUtil.setInArea(request, "grid");

	String [] buttons = HoValidator.isNotEmpty(button) ? button.split("\\,") : new String [0];

	out.print(index > 0 ? "," : "" );

%>
	Ext.create('Ext.tree.Panel', {
		<%= HoValidator.isNotEmpty(title)  ? "title : '"+title+"', " : ""  %>
<%  if(!HoValidator.isEmpty(width)) {  %>
		width   : <%=width %>, <% // = HoValidator.isEmpty(width) ? "Ext.getBody().getViewSize().width" : width %>
		minWidth : <%=width %>,
<% } %>
        rootVisible: false,
        useArrows: true,
        <%= "".equals(HoUtil.replaceNull(height)) ? ""  :  "height : " + height + "," %>   <%// = HoValidator.isEmpty(height) ? "600" : height %>
        viewConfig: {
        	forceFit: true
        },
        submitModified : false,  // form Submit시 수정된 data만 전송..
        <%= HoUtil.replaceNull(options)%>
        <% if( !"sub".equals(position) && !isScriptOut) { %>
        	region: '<%= HoUtil.replaceNull(position, "center") %>',
        <% } %>
        columnLines: true,
		<%  if( HoValidator.isEmpty(width) || HoValidator.isEmpty(height)) {  %>
        listeners : {
			render : function (_this) {
			<% if( false ) { %>
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
	        			// _this.setSize( width,  heigth );
			<% } %>	            	}
        },
		<% } %>
		id : '<%= p_action_flag %>_grid_<%=HoUtil.replaceNull(id) %>',
		store: Ext.create('Ext.data.JsonStore', {
			storeId:'<%=param.get("p_action_flag")%>_store_grid_<%=HoUtil.replaceNull(id) %>',
			autoDestroy: true,
			root: 'datas',
			totalProperty: 'totalCount',
			remoteSort:	true,
			pageSize : 5,
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
							out.print(",");
						}
						out.print("'"+md.getColumnName(i).toLowerCase()+"'");
					}
			        %>], //['TABLE_NAME', 'TABLE_ALIAS', 'TABLE_TYPE'],
			id : '<%= p_action_flag %>_grid_store_<%=HoUtil.replaceNull(id) %>',
			proxy: Ext.create('Ext.data.HttpProxy', {
				type: 'ajax', //'memory',
				url: '<%= request.getContextPath() +  action %>',
				reader: {
		            type: 'json',
		            root: 'datas'
		        },
		        writer: {
		            type: 'singlepost', // 'json',
		            writeAllFields: true,
		            encode : true,
		            root: 'datas',
		            params : { 'aa' : 'aa' }, // @TODO  이런 형태로 파라미터 추가 가능..
		            allowSingle : false 
		        },
				api: {
	                create: '<%= request.getContextPath() +  action %>',
	                update: '<%= request.getContextPath() +  action %>'
		        }		        
			}),listeners : {
				beforeload: function(store, operation, eOpts){
	                if(store.sorters && store.sorters.getCount()) {
	                	var sorter = store.sorters.getAt(0);
						
	                	var sortProp = sorter.property;
	                	
	                	Ext.apply(store.getProxy().extraParams, store.params);                	
	                    Ext.apply(store.getProxy().extraParams, {
	                        'sort'  : sortProp,
	                        'dir'   : sorter.direction
	                    }); 
	                    
	                }
	            }
	        }
		}) ,
		border : 1,
		<%
			if(HoValidator.isEmpty(lead)) {
				lead = "cellmodel";
			} else {
				if( "+".equals(lead)) {
					lead = "";
				} else if( lead.startsWith("check")) {
					lead = "checkboxmodel";
				} else {
					lead = "cellmodel";
				}
			}
			
		%>
		<%= !"".equals(lead) ? "selType: '"+lead+"'," : "" %>
		<% if ( HoServletUtil.getArea(request).indexOf("fieldcontainer") > 0 ) { %>
	 		//margin : '0 5 5 0', // !! <%= p_action_flag%> <%= index %>
		<% } else if ( index > 0 && HoServletUtil.getArea(request).indexOf("fieldcontainer") < 0 ) { %>
		 	//margin : '0 5 5 5', // ?? <%= p_action_flag%> <%= index %>
		<% } else if( HoServletUtil.getArea(request).indexOf("box") < 0 && HoServletUtil.getArea(request).indexOf("fieldcontainer") < 0 ) {   %>
			//margin : '0 5 5 5', // ++ <%= p_action_flag%> <%= index %>
		<% } %>
	    <% if( !"center".equals(HoUtil.replaceNull(position)) )  { %>
	        margin: '<%= HoUtil.replaceNull(position).equals("south") ? "5" : "0"%> <%= HoUtil.replaceNull(position).equals("west") ? "5" : "0"%> <%= HoUtil.replaceNull(position).equals("north") ? "5" : "0"%> <%= HoUtil.replaceNull(position).equals("east") ? "5" : "0"%>',
	    <% } %>
	    <jsp:doBody></jsp:doBody>
<%  if(HoValidator.isEmpty(width)) {  %>
		plugins : [
		 Ext.create('Ext.grid.plugin.CellEditing', {id : '<%= p_action_flag %>_grid_editor_<%=HoUtil.replaceNull(id) %>', clicksToEdit: 1})
			//, Ext.create('Ext.ux.FitToParent', { fitWidth : <%= HoValidator.isEmpty(width) ? "true" : "false" %> , fitHeight : <%= HoValidator.isEmpty(height) ? "true" : "false" %>, offsets : [11,11] } )
		],
<% } %>
	dockedItems: [
	
<% if ( "Y".equals(HoUtil.replaceNull(pageYn,"Y") )) { %>
		Ext.create('Ext.ux.PagingToolbar', {
            displayInfo: true,
            dock :'bottom',
            itemId : 'gridPageTB',
            <%= HoValidator.isEmpty(page) ? "" : "pageCnt : " + page + "," %>
            displayMsg: 'Displaying topics {0} - {1} of {2}',
            emptyMsg: "No topics to display",
            id : '<%= p_action_flag %>_grid_bbar_<%=HoUtil.replaceNull(id)  %>',
            store : Ext.getStore('<%=param.get("p_action_flag")%>_store_grid_<%=HoUtil.replaceNull(id) %>'),
            items:[]
        }),
<% } %>
<%
	out.println(" {xtype: 'toolbar', dock :'top', flex : 1, border : true, ");
	out.println("id : 'tbar_"+p_action_flag +"_"+HoUtil.replaceNull(id)+"', ");
	out.println("items : [");
	if( buttons.length> 0 ) {
%>
<%
%>
	<%
		String iconCls = "";
		for( int i=0 ; i< buttons.length ; i++ ) {
			
			if( "저장".equals(buttons[i])) {
				iconCls = "btn-icon-save";
			} else if( "다운로드".equals(buttons[i])){
				iconCls = "btn-icon-download";
			} else if( "삭제".equals(buttons[i])){
				iconCls = "btn-icon-delete";
			} else if( "추가".equals(buttons[i])){
				iconCls = "btn-icon-add";
			} else if( "초기화".equals(buttons[i])){
				iconCls = "btn-icon-new";
			} else {
				iconCls = "";
			}
			
			out.println( (i>0  ? "," :"" ) + "{ xtype : 'button', "+ ( !"".equals(HoUtil.replaceNull(iconCls)) ? "iconCls:'"+iconCls+"'," : ""  )+" border: 1, style: { borderColor: '#99bce8', borderStyle: 'solid'} ,  text : '"+ buttons[i] + "', handler : fs_"+ param.get("p_action_flag")  + "_" + buttons[i]+" }");
		}
		HoServletUtil.setString(request, "dockedItems-buttons", "Y");
	} // end of if( buttons.length> 0 )
	
	HoServletUtil.setInArea(request, "dockedItems");  // toolbar_detail에서 초기화 됨...
%>
	    <jsp:doBody></jsp:doBody>
<%
	HoServletUtil.setOutArea(request);
	out.println("]"); // end of  items
	out.println("}"); // end of toolbar -> top
%>
	] // end of dockedItems
	}) // Ext.create('Ext.grid.Panel'
<%
	HoServletUtil.setOutArea(request);

%>

<% } %>


<% if( isHtml  ) {
%>

<%
 } %>