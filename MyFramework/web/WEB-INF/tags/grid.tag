<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag
	import="java.util.Map"
	import="java.util.HashMap"
	import="java.util.List"
	import="java.util.ArrayList"
	import="project.jun.was.HoModel"
	import="project.jun.util.HoUtil"
	import="project.jun.util.HoValidator"
	import="project.jun.was.parameter.HoParameter"
	import="project.jun.was.spring.HoController"
	import="project.jun.util.HoServletUtil"
	import="project.jun.dao.HoDao"
	import="project.jun.dao.HoDaoSqlResult"
	import="project.jun.util.HoSpringUtil"
	import="project.jun.dao.result.HoList"
	import="project.jun.dao.result.HoMap"
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
%><%@ attribute name="listeners" type="java.lang.String"
%><%@ attribute name="popup" type="java.lang.String"
%><%@ attribute name="formId" type="java.lang.String"
%><%-- 검색시 사용할 form의 id--%><%@ attribute name="autoLoad" type="java.lang.String"
%><%-- 로드시 GRID데이터 조회 여부(Y, true) --%><%@ attribute name="groupTpl" type="java.lang.String"%><%-- default "{name}" --%><%@ 
attribute name="groupName" type="java.lang.String"%><%-- Group을 위해서 "groupName"는 필수 --%><%@ 
attribute name="editable" type="java.lang.String"%>
<%
	String section_name =  "_grid";
	
	/*
	@TODO Message관련 참고
	HoSpringUtil hsu = new HoSpringUtil();
	org.springframework.context.support.ReloadableResourceBundleMessageSource ms = (org.springframework.context.support.ReloadableResourceBundleMessageSource) hsu.getBean(application, "messageSource");
	

	try {
		System.out.println("11 : "  +  ms.getMessage("CUD-MSG-CO0001" , new Object[0], java.util.Locale.getDefault()) );
		System.out.println("21 : "  +  ms.getMessage("CUD-MSG-CO0001" , new Object[0], null ));
	} catch(Exception e) {
		System.out.println("*1 : e -> "  + e.getMessage() );
	}
	try {
		System.out.println("12 : "  +  ms.getMessage("CUD-MSG-CO0002" , new Object[0], java.util.Locale.getDefault()) );
	} catch(Exception e) {
		System.out.println("12 : e -> "  + e.getMessage() );
	}
	try {
		System.out.println("22 : "  +  ms.getMessage("CUD-MSG-CO0002" , new Object[0], null ));
	} catch(Exception e) {
		System.out.println("22 : e -> "  + e.getMessage() );
	}
	*/
%>
<% if( isScript || isScriptOut ) { 

	int index =  HoServletUtil.getIndex(request, HoServletUtil.getArea(request)+HoServletUtil.getString(request, "data")+"_row");

	HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request)+HoServletUtil.getString(request, "data")+"_row");
	HoServletUtil.setInArea(request, "grid");

	// id = HoUtil.replaceNull(id, "grid_"+index);

	HoServletUtil.setString(request, "grid-id", HoUtil.replaceNull(id) );
	
	String [] buttons = HoValidator.isNotEmpty(button) ? button.split("\\,") : new String [0];

	out.print(index > 0 ? "," : "" );

%>
	Ext.create('Ext.grid.Panel', {
		<%= HoValidator.isNotEmpty(title)  ? "title : '"+title+"', " : ""  %>
<%  if(!HoValidator.isEmpty(width)) {  %>
		width   : <%=width %>, <% // = HoValidator.isEmpty(width) ? "Ext.getBody().getViewSize().width" : width %>
		minWidth : <%=width %>,
<% } %>
        <%= "".equals(HoUtil.replaceNull(height)) ? ""  :  "height : " + height + "," %>   <%// = HoValidator.isEmpty(height) ? "600" : height %>
        viewConfig: {
        	forceFit: true,
        	copy: true  /* ,
        	loadingText: "I'm loading or something...",
        	loadingCls: 'custom-loader' load mask not work*/
        },
        submitModified : false,  // form Submit시 수정된 data만 전송..
        <%= HoUtil.replaceNull(options)%>
        <% if( !"sub".equals(position)) { //  && !isScriptOut%>
        	region: '<%= HoUtil.replaceNull(position, "center") %>',
        	
        	<% if( "center".equals(HoUtil.replaceNull(position, "center"))) { %>
        	collapsible : false,
        	<% } else { %>
        	collapsible : true,
        	split : true,        	
        	<% } %>
        <% } %>
        columnLines: true,
		<%-- @TODO 아래의 부분(if( !hoConfig.isProductMode() {})은 실제 운영시 제거 --%>
        <% if( !hoConfig.isProductMode() ) { // 개발모드일 경우 %>
        tools:[{
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
													html : 'Id for Header : [<%= p_action_flag %>_<%=HoUtil.replaceNull(id) %>_col_XXXXXXX]'
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
		<%  if( HoValidator.isEmpty(width) || HoValidator.isEmpty(height) || HoValidator.isNotEmpty(listeners) ) {  %>
        listeners : {
        	<%if ( HoValidator.isNotEmpty(listeners)) { %>
        	<%= HoUtil.replaceNull(listeners) %> <%= ( HoValidator.isEmpty(width) || HoValidator.isEmpty(height)) ? "," : "" %> 
        	<% } %>
        	<%  if( HoValidator.isEmpty(width) || HoValidator.isEmpty(height)) { %>
			render : function (grid, eOpts) {
				<%-- 화면 로드시 조회 하고, 검색조건 form-id가 정의된 경우. --%>
				<% if( HoValidator.isIn(autoLoad, new String[] {"Y","true"}, true) && HoValidator.isNotEmpty(formId)) { %>
				try {
					var btn = Ext.getCmp('<%=  p_action_flag+"_search_"+formId %>').down('button');
					if( btn.hasListeners.click ) {
						btn.fireEvent('click', btn);
					}
				} catch(e) {
					
				}
				<%  } %>
			},
			lockcolumn : function( grid, column, eOpts ) {
				Ext.Ajax.request({
				    url: '/s/example/example.do',
				    params: {
				        p_action_flag : 'r_list_data',
				        page : '<%= p_action_flag%>',
				        jsp : '<%= model.getString(HoController.HO_INCLUDE_JSP) %>',
				        grid : '<%= HoServletUtil.getString(request, "grid-id") %>',
				        column : column.dataIndex ,
				        locked : true,
				        id : column.id
				    },
				    success: function(response){
				        var text = response.responseText;
				    }
				});
				
			},
			unlockcolumn: function( grid, column, eOpts ) {
				Ext.Ajax.request({
				    url: '/s/example/example.do',
				    params: {
				        p_action_flag : 'r_list_data',
				        page : '<%= p_action_flag%>',
				        jsp : '<%= model.getString(HoController.HO_INCLUDE_JSP) %>',
				        grid : '<%= HoServletUtil.getString(request, "grid-id") %>',
				        column : column.dataIndex ,
				        locked : false,
				        id : column.id
				    },
				    success: function(response){
				        var text = response.responseText;
				    }
				});
			}
			<% } // end of if( HoValidator.isEmpty(width) || HoValidator.isEmpty(height)) %>
        },
		<% } %>
		<% if( !"random".equalsIgnoreCase(id)) { %>
		id : '<%= p_action_flag %>_grid_<%=HoUtil.replaceNull(id) %>',
		<% } %>
		store: Ext.create('Ext.data.JsonStore', {
			storeId:'<%=param.get("p_action_flag")%>_store_grid_<%=HoUtil.replaceNull(id) %>',
			autoDestroy: true,
			remoteSort:	true,
			pageSize : 30,
			<%if( !"".equals(HoUtil.replaceNull(groupName)) )  { %>
			groupField: '<%= HoUtil.replaceNull(groupName) %>',
			<%} %>
			fields:[<%
					HoQueryParameterMap value = new HoQueryParameterMap();
					value.put("SQL_ID", fields);
					List<Map<String, Object>> 	columnList = new ArrayList<Map<String, Object>>();

					HoList list = dao.select("Page.selectGridFieldsSql", value);

 
					// HO_T_SYS_SQL_INFO테이블에 정보가 있을 경우
					if( list.size() > 0) {
						for( int i=0;  i<list.size() ; i++) {
							Map<String, Object> colInfoMap = new HashMap<String, Object>();
							
							colInfoMap.put("SQL_ID", list.getString(i, "SQL_ID") );
							colInfoMap.put("COLUMN_NAME" , list.getString(i, "COLUMN_NAME") );
							colInfoMap.put("DATA_TYPE" , list.getString(i, "DATA_TYPE") );
							
							columnList.add(colInfoMap);
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
						
						for( int i=0;  i<md.getColumnCount() ; i++) {
							values[i] = new HoQueryParameterMap();
							values[i].add("SQL_ID", fields );
							values[i].add("COLUMN_NAME", md.getColumnName(i).toUpperCase() );
							values[i].add("COLUMN_IDX", i );
							values[i].add("DATA_TYPE", md.getColumnTypeName(i).toUpperCase() );
							
							Map<String, Object> colInfoMap = new HashMap<String, Object>();
							
							colInfoMap.put("SQL_ID", fields );
							colInfoMap.put("COLUMN_NAME" , md.getColumnName(i).toUpperCase() );
							colInfoMap.put("DATA_TYPE" , md.getColumnTypeName(i).toUpperCase() );
							
							columnList.add(colInfoMap);
						}
						
						List<HoDaoSqlResult> result = dao.batch("Page.insertGridFieldsSql", values);
					}

					for( int i=0;i<columnList.size(); i++) {
						if( i>0 ) {
							out.print(",");
						}
						if( columnList.get(i).get("DATA_TYPE").toString().indexOf("CHAR")>=0) {
							out.print("{ name : '"+columnList.get(i).get("COLUMN_NAME")+"', type : 'string' }");
							
							if( columnList.get(i).get("COLUMN_NAME").toString().endsWith("_YN")) {
								out.print(", { name : '"+columnList.get(i).get("COLUMN_NAME")+"_BOOL', type : 'boolean' }");
							} else if( columnList.get(i).get("COLUMN_NAME").toString().endsWith("_YMD")) {
								out.print(", { name : '"+columnList.get(i).get("COLUMN_NAME")+"_DT', type : 'date' }");
							}
						} else if( columnList.get(i).get("DATA_TYPE").toString().indexOf("DATE")>=0) {
							out.print("{ name : '"+columnList.get(i).get("COLUMN_NAME")+"', type : 'date' }");
						} else if( columnList.get(i).get("DATA_TYPE").toString().indexOf("NUMBER")>=0) {
							out.print("{ name : '"+columnList.get(i).get("COLUMN_NAME")+"', type : 'number' }");
						} else {
							out.print("'"+columnList.get(i).get("COLUMN_NAME")+"'");
						}
					}
			        %>], //['TABLE_NAME', 'TABLE_ALIAS', 'TABLE_TYPE'],
			id : '<%= p_action_flag %>_grid_store_<%=HoUtil.replaceNull(id) %>',
			proxy: Ext.create('Ext.data.HttpProxy', {
				type: 'ajax', //'memory',
				url: '<%= request.getContextPath() +  action %>',
				reader: {
		            type: 'json',
					totalProperty: 'totalCount',
					root: 'datas'
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
		<%if( !"".equals(HoUtil.replaceNull(groupName)))  { %><%--  group summary인 경우 --%>
		features: [Ext.create('Ext.grid.feature.GroupingSummary', {
            id: '<%= p_action_flag %>_group_<%=HoUtil.replaceNull(id) %>',
            ftype: 'groupingsummary',
            groupHeaderTpl: '<%= HoUtil.replaceNull(groupTpl,"{name}") %>',
            hideGroupedHeader: true
            , enableGroupingMenu: false
        })],
		<% } %>
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
		<% if( HoServletUtil.getArea(request).indexOf("fieldcontainer") > 0 ) { %>
			margin: '0 0 0 <%= HoServletUtil.getArea(request).indexOf("section") > 0 ? "-5" : "-10" %>',
	    <% } else if( !"center".equals(HoUtil.replaceNull(position)) )  { %>
	        // margin: '<%= HoUtil.replaceNull(position).equals("south") ? "5" : "0"%> <%= HoUtil.replaceNull(position).equals("west") ? "5" : "0"%> <%= HoUtil.replaceNull(position).equals("north") ? "5" : "0"%> <%= HoUtil.replaceNull(position).equals("east") ? "5" : "0" %>',
	    <% } %>
	    <jsp:doBody></jsp:doBody>
		plugins : [
		<%	if("+".equals(lead)) {%>
			// TODO Plugins --> ptype: 'rowexpander', ~~
		<%	} %>
		<% if( "Y".equals(editable) ) { %>
			Ext.create('Ext.grid.plugin.CellEditing', {id : '<%= p_action_flag %>_grid_editor_<%=HoUtil.replaceNull(id) %>', clicksToEdit: 1})
		<% } %>
		],
		dockedItems: [	
<% if ( "Y".equals(HoUtil.replaceNull(pageYn,"Y") )) { %>
			Ext.create('Ext.ux.PagingToolbar', {
	            displayInfo: true,
	            dock :'bottom',
	            border: <%= ("sub".equals(position) ? "0" : "1") %>,
	            itemId : '<%= p_action_flag %>_grid_bbar_<%=HoUtil.replaceNull(id)  %>_gridPageTB',
	            pageCnt : <%= HoUtil.replaceNull(page,"10") %> ,
	            displayMsg: 'Displaying topics {0} - {1} of {2}',
	            emptyMsg: "No topics to display",
	            id : '<%= p_action_flag %>_grid_bbar_<%=HoUtil.replaceNull(id)  %>',
	            store : Ext.getStore('<%=param.get("p_action_flag")%>_store_grid_<%=HoUtil.replaceNull(id) %>'),
	            items :[
	            
	            ]
	        }),
<% } %>
<%
	out.println(" {xtype: 'toolbar', dock :'top', flex : 1, border : " + ("sub".equals(position) ? "false" : "true") + ", ");
	out.println("id : 'tbar_"+p_action_flag +"_"+HoUtil.replaceNull(id)+"', ");
	out.println("items : [");
	
	if( !"".equals(HoUtil.replaceNull(groupName)))  {
		out.print(" { xtype : 'button', border: 1, style: { borderColor: '#99bce8', borderStyle: 'solid'} ,  text : '펼치기', id : '"+ param.get("p_action_flag")  + "_" + id + "_btn_펼치기'");
		out.print(" , iconCls:'btn-icon-expand', handler : function() { Ext.getCmp('"+ param.get("p_action_flag")+"_grid_"+id+"').getView().getFeature('"+ param.get("p_action_flag")+"_group_"+id+"').expandAll(); } }");
		out.print(" ,{ xtype : 'button', border: 1, style: { borderColor: '#99bce8', borderStyle: 'solid'} ,  text : '접기', id : '"+ param.get("p_action_flag")  + "_" + id + "_btn_접기'");
		out.print(" , iconCls:'btn-icon-collapse', handler : function() { Ext.getCmp('"+ param.get("p_action_flag")+"_grid_"+id+"').getView().getFeature('"+ param.get("p_action_flag")+"_group_"+id+"').collapseAll(); } }");
	}
	
	if( buttons.length> 0 ) {
			// out.println("{ xtype : 'button', iconCls:'', border: 1, style: { borderColor: '#99bce8', borderStyle: 'solid'} ,  text : '컬럼 조정', handler : function() { alert(1); } }");
		String glyph = "";
		String iconCls = "";
		String btnDisplayName = null;
		String btnSql = "";
		String [] btnInfo = null; 
		HoMap btnMap = null;
		for( int i=0 ; i< buttons.length ; i++ ) {
			btnInfo = buttons[i].split("\\:");

			if( btnInfo.length > 1 ) {
				btnSql = btnInfo[1];
			} else {
				btnSql = "";
			}
			
			btnMap = (HoMap) BUTTON_SET_MAP.get(btnInfo[0]);
			if (btnMap !=null) {
				glyph = btnMap.getString("GLYPH");
				iconCls = btnMap.getString("ICON_CLS");
				btnDisplayName = btnMap.getString("BTN_NM");
			} else {
				glyph = "";
				iconCls = "";
				btnDisplayName = btnInfo[0];
			}
			
			out.print(  (i>0||!"".equals(HoUtil.replaceNull(groupName))  ? "," :"" ) + " { xtype : 'button', border: 1, style: { borderColor: '#99bce8', borderStyle: 'solid'} ,  text : '"+ btnDisplayName + "', id : '"+ param.get("p_action_flag")  + "_" + id + "_btn_" + btnDisplayName +"'");
			if( !"".equals(glyph)) {
				out.print(" , glyph:'x"+glyph+"@FontAwesome' ");
			} else {
				out.print(( !"".equals(HoUtil.replaceNull(iconCls)) ? ", iconCls:'"+iconCls+"'" : "" ));
			}
			out.print(" , handler : fs_"+ param.get("p_action_flag")  + "_" + id + "_" + btnDisplayName);
			if( !"".equals(btnSql)) {
				out.print(" , listeners: {  ");
				out.print("			mouseover: function(_btn, e, eOpts) { ");
				out.print("				var form = Ext.getCmp('"+p_action_flag+"_detail_form_btn'); ");
				out.print("				if(form) { ");
				out.print("					var formSqlId = form.child('#SQL_ID'); ");
				out.print("					if( formSqlId ) { ");
				out.print("						formSqlId.setValue('"+btnSql+"'); ");
				out.print("						function _setButton(_form, _action) { if ( 'N' == _action.result.datas[0]['IS_AVAILABLE'] ) { _btn.setDisabled(true); _btn.setTooltip( _action.result.datas[0]['BTN_MSG'] );  }  } ");
				out.print("						form.submit({success : function(form, action) { _setButton(form, action); }, failure: function(form, action) { _setButton(form, action); },isForceSave : true}); ");
				out.print("					} ");
				out.print("				} ");
				out.print("		  	}, mouseout: function(_btn, e, eOpts ) { ");
				out.print("		  		_btn.setDisabled(false); _btn.setTooltip( null ); ");
				out.print("		  	} ");
				out.print("   }  ");
			}
			out.println("}");
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
	}) // Ext.create 'Ext.grid.Panel'
<%

	HoServletUtil.setOutArea(request);
%>

<% } %>


<% if( isHtml  ) {
%>

<%
 } %>