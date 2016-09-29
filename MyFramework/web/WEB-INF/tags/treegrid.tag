<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag
	import="java.util.Set"
	import="java.util.List"
	import="java.util.HashSet"
	import="project.jun.was.HoModel"
	import="project.jun.util.HoUtil"
	import="project.jun.util.HoValidator"
	import="project.jun.was.parameter.HoParameter"
	import="project.jun.was.spring.HoController"
	import="project.jun.util.HoServletUtil"
	import="project.jun.dao.HoDao"
	import="project.jun.dao.HoDaoSqlResult"
	import="project.jun.util.HoSpringUtil"
	import="project.jun.dao.result.HoMap"
	import="project.jun.dao.result.HoList"
	import="project.jun.dao.parameter.HoQueryParameterMap"
	import="org.apache.ibatis.metadata.result.MetaData"
%><%@ include file="include.tag" %>
<%@ attribute name="id" type="java.lang.String" required="true"
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
	String section_name =  "_grid";
%>
<% if( isScript || isScriptOut) { %>
<%

	int index =  HoServletUtil.getIndex(request, HoServletUtil.getArea(request)+HoServletUtil.getString(request, "data")+"_row");
	HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request)+HoServletUtil.getString(request, "data")+"_row");
	/*
	int index =  HoServletUtil.getIndex(request, HoServletUtil.getArea(request)+"_row");
	HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request)+"_row");
	*/
	HoServletUtil.setInArea(request, "treegrid");
	HoServletUtil.setString(request, "grid-id", id);

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
        <% if( !"sub".equals(position)) { //  && !isScriptOut %>
        	region: '<%= HoUtil.replaceNull(position, "center") %>',
        <% } %>
        columnLines : true,
		<%-- @TODO 아래의 부분(if( !hoConfig.isProductMode() {})은 실제 운영시 제거 --%>
        <% if( !hoConfig.isProductMode() ) { // 개발모드일 경우 %>
        tools:[
        	{
    			type:'close',
    			tooltip: 'Delete fields Sql-ID',
    			handler: function(event, toolEl, panelHeader) {
					Ext.Ajax.request({
					    url: '/s/system/page.do',
					    params: {
					        p_action_flag : 'b_delete_grid_sqlId',
					        sql_id : '<%= HoUtil.replaceNull(fields) %>'
					    },
					    success: function(response){
					    
					        var res = Ext.JSON.decode(response.responseText);
					        
					        Ext.create('widget.uxNotification', {
								title: '삭제결과',
								position: 'br',
								manager: 'demo1',
								iconCls: 'ux-notification-icon-information',
								autoCloseDelay: 3000,
								spacing: 50,
								html: res.message
							}).show();
					        
					    }
					});
    			}
    		},{
	    		type:'help',
	    		handler: function(event, toolEl, panelHeader) {
	    			Ext.widget('window', {
					        title : '<%= HoValidator.isNotEmpty(title)  ? "title : ["+title+"] " : ""  %>Grid의 ID 정보',
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
												},
												{ 
													html : 'Id of Store : [Id for Header : [<%= p_action_flag %>_<%=HoUtil.replaceNull(id) %>_col_XXXXXXX]'
												}
											]
								}
					        ]
					    }).show();
					
	    		},
	    		tooltip: 'Id of Grid : [<%= p_action_flag %>_grid_<%=HoUtil.replaceNull(id) %>]<br/>StoreId of Store : [<%=param.get("p_action_flag")%>_store_grid_<%=HoUtil.replaceNull(id) %>]<br/>Id of Store : [<%= p_action_flag %>_grid_store_<%=HoUtil.replaceNull(id) %>]'
        	}
        ],
        <% } %>
        rowLines : true,
		id : '<%= p_action_flag %>_treegrid_<%=HoUtil.replaceNull(id) %>',
		store: Ext.create('Ext.data.TreeStore', {
			storeId:'<%=param.get("p_action_flag")%>_store_grid_<%=HoUtil.replaceNull(id) %>',
			// autoDestroy: true,
			// autoLoad: true,
			// autoSync: true,
			remoteSort:	false,
			idProperty: 'ID',
			fields:[ 'depth', 'leaf', //'id', 'text',
			<%
					HoQueryParameterMap value = new HoQueryParameterMap();
					value.put("SQL_ID", fields);
		
					HoList list = dao.select("Page.selectGridFieldsSql", value);
					
					Set<String> set = new HashSet<String>();
		
					for( int i=0;  i<list.size() ; i++) {
						set.add(list.getString(i, "COLUMN_NAME").toUpperCase());
					}
					// HO_T_SYS_SQL_INFO테이블에 정보가 있을 경우
					if( list.size() > 0) {
						for( int i=0;  i<list.size() ; i++) {
							if( i>0 ) {
								out.print(",");
							}
							out.print("'"+list.getString(i, "COLUMN_NAME").toUpperCase()+"'");

							String column = list.getString(i, "COLUMN_NAME").toUpperCase();
							
							if( (column.endsWith("_CD")|| column.endsWith("_ID")) && !set.contains(column+"_NM") ) {
								out.print(", '"+ column+"_NM'");
							}
						}
					} 
					// HO_T_SYS_SQL_INFO테이블에 정보가 없을 경우
					else {
						value = new HoQueryParameterMap();
						
						
						value.put("METADATA", "Y");
				        value.put("S_ROWNUM", "0");
				        value.put("E_ROWNUM", "0");
						
						HoMap map = dao.selectOne(fields, value);

						MetaData md = map.getMetaData();

						HoQueryParameterMap [] values = new HoQueryParameterMap[md.getColumnCount()];
						
						set.clear();
						for( int i=0;  i<md.getColumnCount() ; i++) {
							set.add(md.getColumnName(i).toUpperCase());
						}
						for( int i=0;  i<md.getColumnCount() ; i++) {
							values[i] = new HoQueryParameterMap();
							values[i].add("SQL_ID", fields );
							values[i].add("COLUMN_NAME", md.getColumnName(i).toUpperCase() );
							values[i].add("COLUMN_IDX", i );
							values[i].add("DATA_TYPE", md.getColumnTypeName(i).toUpperCase() );

							if( i>0 ) {
								out.print(",");
							}
							out.print("'"+md.getColumnName(i).toUpperCase()+"'");
							
							String column = map.getMetaData().getColumnName(i).toUpperCase();
							
							if( (column.endsWith("_CD") || column.endsWith("_ID")) && !set.contains(column+"_NM") ) {
								out.print(", '"+ column+"_NM'");
							}
						}
						List<HoDaoSqlResult>  result = dao.batch("Page.insertGridFieldsSql", values);
						
					}
			        %>], 
			id : '<%= p_action_flag %>_grid_store_<%=HoUtil.replaceNull(id) %>',
			proxy: Ext.create('Ext.data.HttpProxy', {
				type: 'ajax', //'memory',
				url: '<%= request.getContextPath() +  action %>',
				reader: {
		            type: 'json'
		            //, expanded: true
		        },
				writer: {
		            type: 'singlepost', // 'json',
		            writeAllFields: true,
		            encode : true,
		            root: 'datas',
		            params : { }, // @TODO  이런 형태로 파라미터 추가 가능..
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
		plugins : [
			Ext.create('Ext.grid.plugin.CellEditing', {id : '<%= p_action_flag %>_treegrid_editor_<%=HoUtil.replaceNull(id) %>', clicksToEdit: 1})
		],
		<%
			if(HoValidator.isEmpty(lead)) {
				lead = "cellmodel";
			} else {
				if( "+".equals(lead)) {
					lead = "";
				} else if( lead.startsWith("check")) {
					lead = "checkboxmodel";
					
					HoServletUtil.setString(request, "treegrid-checkboxmodel", "Y");
				} else {
					lead = "cellmodel";
				}
			}
			
		%>
		<%= !"cellmodel".equals(lead) ? "selType: '"+lead+"'," : "" %> // 이거 주석 풀면 "getId~~ 이런..오류" 남.. 
	    <% if( !"center".equals(HoUtil.replaceNull(position)) )  { %>
	        margin: '<%= HoUtil.replaceNull(position).equals("south") ? "5" : "0"%> <%= HoUtil.replaceNull(position).equals("west") ? "5" : "0"%> <%= HoUtil.replaceNull(position).equals("north") ? "5" : "0"%> <%= HoUtil.replaceNull(position).equals("east") ? "5" : "0"%>',
	    <% } %>
	    <jsp:doBody></jsp:doBody>
		listeners : {
			select: function (selModel, rec) {
				rec.cascadeBy(function (child) {
					selModel.select(child, true, true);
				});
			},
			deselect: function (selModel, rec) {
				rec.cascadeBy(function (child) {
					selModel.deselect(child, true);
				});
			}
		},
	
	dockedItems: [
<%

	out.println(" {xtype: 'toolbar', dock :'top', flex : 1, border : true, ");
	out.println("id : 'tbar_"+p_action_flag +"_"+HoUtil.replaceNull(id)+"', ");
	out.println("items : [");
	out.println("{ xtype : 'button', border: 1, style: { borderColor: '#99bce8', borderStyle: 'solid'} ,  iconCls:'btn-icon-expand', text : '펼치기', handler : function(){ ");
	out.println(" 	var treegrid = Ext.getCmp('"+p_action_flag+"_treegrid_"+HoUtil.replaceNull(id)+"');");
	out.println(" 	treegrid.expandAll();");
	out.println(" }}, ");
	out.println("{ xtype : 'button', border: 1, style: { borderColor: '#99bce8', borderStyle: 'solid'} ,  iconCls:'btn-icon-collapse', text : '접기', handler : function(){ ");
	out.println(" 	var treegrid = Ext.getCmp('"+p_action_flag+"_treegrid_"+HoUtil.replaceNull(id)+"');");
	out.println(" 	treegrid.collapseAll();");
	out.println(" }}, ");
	if( buttons.length> 0 ) {
		String iconCls = "";
		String btnDisplayName = null;
		HoMap btnMap = null;
		for( int i=0 ; i< buttons.length ; i++ ) {
			
			btnMap = (HoMap) BUTTON_SET_MAP.get(buttons[i]);
			if (btnMap !=null) {
				iconCls = btnMap.getString("ICON_CLS");
				btnDisplayName = btnMap.getString("BTN_NM");
			} else {
				iconCls = "";
				btnDisplayName = buttons[i];
			}
			
			out.println( (i>0  ? "," :"" ) +  "{ xtype : 'button', "+ ( !"".equals(HoUtil.replaceNull(iconCls)) ? "iconCls:'"+iconCls+"'," : ""  )+" border: 1, style: { borderColor: '#99bce8', borderStyle: 'solid'} ,  text : '"+ btnDisplayName + "', id : '"+ param.get("p_action_flag")  + "_" + id + "_btn_" + buttons[i]+"', handler : fs_"+ param.get("p_action_flag")  + "_" + id + "_" + buttons[i]+" }");
		}
		HoServletUtil.setString(request, "dockedItems-buttons", "Y");
	} // end of if( buttons.length> 0 )
	
	HoServletUtil.setInArea(request, "dockedItems");  // toolbar_detail에서 초기화 됨...
%>
	    <jsp:doBody></jsp:doBody>
<%
	HoServletUtil.setOutArea(request);
	HoServletUtil.setString(request, "grid-id", null );

	out.println("]"); // end of  items
	out.println("}"); // end of toolbar -> top
%>
	] // end of dockedItems
	}) // Ext.create('Ext.grid.Panel'
<%
	HoServletUtil.setString(request, "treegrid-checkboxmodel", null);

	HoServletUtil.setOutArea(request);

%>

<% } %>


<% if( isHtml  ) {
%>

<%
 } %>