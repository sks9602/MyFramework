<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag
	import="project.jun.was.HoModel"
	import="project.jun.util.HoUtil"
	import="project.jun.util.HoServletUtil"
	import="project.jun.was.parameter.HoParameter"
	import="project.jun.was.spring.HoController"
	import="project.jun.util.HoValidator"
	import="project.jun.util.asp.HoAspUtil"
	import="project.jun.dao.result.HoList"
%><%@ include file="include.tag" %>
<%@ attribute name="title" type="java.lang.String"
%><%@ attribute name="column" type="java.lang.String"
%><%@ attribute name="flex" type="java.lang.String"
%><%@ attribute name="width" type="java.lang.String"
%><%@ attribute name="renderer" type="java.lang.String"
%><%@ attribute name="editor" type="java.lang.String"
%><%@ attribute name="align" type="java.lang.String"
%><%@ attribute name="locked" type="java.lang.String"
%><%@ attribute name="resize" type="java.lang.String"
%><%@ attribute name="sortable" type="java.lang.String"
%><%@ attribute name="id" type="java.lang.String"
%><%@ attribute name="storeId" type="java.lang.String"
%><%@ attribute name="groupCode" type="java.lang.String" %><%
	int gridIndex = HoServletUtil.getIndex(request, "grid_index");
%>
<% if( isScript || isScriptOut) { 
		
		HoServletUtil.setInArea(request, "column");
		int columnIndex = HoServletUtil.getIndex(request, HoServletUtil.getArea(request)+"_row");
		HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request)+"_row");

		id = HoUtil.replaceNull(id, String.valueOf(columnIndex +1) );

		// id지정..
		/* id = HoUtil.replaceNull(id, random()); 이 구문으로 대체..
		if( "".equals(HoUtil.replaceNull(id) )) {
			id = HoServletUtil.getArea(request).replaceAll("[\\[\\]<|>]", "_") +"_"+ String.valueOf( HoServletUtil.getIndex(request, HoServletUtil.getArea(request)+"_row" ) );
		} else {
			id = "_"+ id;
		}
		*/
		out.print((columnIndex>0 ? "," : "") + "{ id : '" + p_action_flag +"_"+ HoServletUtil.getString(request, "grid_id") + id + "', dataIndex: '"+ column.toUpperCase()+"' "); // cls : 'colFlag',
		String editors[] = null;

		if( HoValidator.isNotEmpty(editor) ) {
			editors = editor.split("\\,");
			out.print(", header: '<div class=\"grid-header-"+editors[0]+"\"></div>&nbsp;"+ title+"'  ");
		} else {
			out.print(", header: '"+ title+"'  ");
		}
		
		if( HoUtil.replaceNull(sortable).equals("false") || HoUtil.replaceNull(sortable).equals("N") ) {
			out.print(", sortable: false " );
		} else {
			out.print(", sortable: true " );
		}

		if( !HoUtil.replaceNull(align).equals("center") ) {
			out.print(", style: 'text-align:center', align: '"+HoUtil.replaceNull(align,"center")+"' " );
		} else {
			out.print(", align: 'center' " );
		}
		if( HoValidator.isNotEmpty(locked) && ( HoUtil.replaceNull(locked).equals("Y") ||  HoUtil.replaceNull(locked).equals("true") )  ) {
			out.print(" , locked : true, width: "+ ( HoValidator.isEmpty(width) ? "200" : width ) );
		} else {
			out.print(" , "+ ( HoValidator.isEmpty(flex) ? "" : " flex : 1," ) +" width: "+ ( HoValidator.isEmpty(width) ? "100" : width ) );
		}

		if(  HoUtil.replaceNull(resize).startsWith("N") || HoUtil.replaceNull(resize).startsWith("false") ) {
			out.print(", fixed: true ");
		}

		if( HoUtil.replaceNull(renderer).equals("actioncolumn") ) {
			out.print(", menuDisabled: true,  sortable: false, xtype: 'actioncolumn', ");
			HoServletUtil.setString(request, "column-function", "actioncolumn");
%>
			<jsp:doBody></jsp:doBody>
<%
			HoServletUtil.setString(request, "column-function", null);
		} else if( HoUtil.replaceNull(renderer).equals("function") ) {
			out.print(", renderer : ");
			HoServletUtil.setString(request, "column-function", "renderer");
%>
			<jsp:doBody></jsp:doBody>
<%
			HoServletUtil.setString(request, "column-function", null);
		} else if( HoValidator.isNotEmpty(renderer) ) {
			out.print(", renderer : " + renderer );
		} /*else if( HoValidator.isNotEmpty(align) ){
			//out.print(", align:'"+HoUtil.replaceNull(align,"center")+"' " );
			//out.print(", renderer : function (value, p, record){ return Ext.String.format( \"<div style=\\\"text-align:"+align+";\\\">{0}</div>\", value, p );}");
		}*/

		if( HoUtil.replaceNull(editor).equals("editors") || HoUtil.replaceNull(editor).equals("summary") ) {  // summary일 경우  group-summary-grid.js참고..
			out.print(", ");
			HoServletUtil.setString(request, "column-function", HoUtil.replaceNull(editor));
%>
			<jsp:doBody></jsp:doBody>
<%
			HoServletUtil.setString(request, "column-function", null);
		} else if( HoUtil.replaceNull(editor).equals("function") ) {
			out.print(", editor : ");
			HoServletUtil.setString(request, "column-function", "editor");
%>
			<jsp:doBody></jsp:doBody>
<%
			HoServletUtil.setString(request, "column-function", null);
		} else  if( HoUtil.replaceNull(editor).equals("checkbox") ) {
			out.print(", xtype: 'ux_checkcolumn' , text : '"+title+"' " ); //ux_checkcolumn
			// out.print(", editor : { xtype: 'checkbox', cls: 'x-grid-checkheader-editor' }");
			out.print(", listeners : { \"checkChange\" : { scope : this.parent , fn : ");
			
			if( !HoValidator.isEmpty(storeId) ) {
				out.print("function( _column, _rowIndex, _checked, _eOpts) {  ");
				out.print("		var store = Ext.getStore('"+storeId+"');");
				out.print("		var record = store.getAt(_rowIndex);");
				out.print("		var columnIndex = _column.getIndex();");
				out.print("		record.set('"+column+"', _checked );");
				out.print("}");
			} else {
				HoServletUtil.setString(request, "column-function", "checkbox");
%>
			<jsp:doBody></jsp:doBody>
<% 			
				HoServletUtil.setString(request, "column-function", null);
			}
			out.print(" } }");
		} else if( HoValidator.isNotEmpty(editor) && !"link".equals(editor)  ) {
			
			if( "combotree".equals(HoUtil.replaceNull(editor))  || "combotipple".startsWith(HoUtil.replaceNull(editor))) {
				out.print(", xtype : 'ux_combocolumn', gridId : '"+ p_action_flag +"_grid_"+ HoServletUtil.getString(request, "grid_id") +"' ");
			}
			out.print(", editor : { ");
			if("combotree".equals(HoUtil.replaceNull(editor))  ||  "combotipple".startsWith(HoUtil.replaceNull(editor))) {
				out.print("triggerAction : 'all', ");
			}

			if( editors.length > 0 ) {
				if( "email".equals(editors[0])) {
					out.print(" xtype : 'textfield', vtype: 'email'");
				} else if( "copy".equals(editors[0])) {
					out.print(" xtype : 'textfield',  readOnly:true ");
				} else {
					out.print(" xtype : '" +editors[0]+"' ");
					
					if( "combotree".equals(HoUtil.replaceNull(editors[0]))  || "combotipple_ux".startsWith(HoUtil.replaceNull(editors[0]))) {
%>
		        , store         : Ext.create('Ext.data.Store', {
		        	storeId   :'<%= p_action_flag%>_store_editor_<%= HoUtil.replaceNull(id, column) %>',
		            fields    : ['NAME', 'VALUE', 'GROUP', 'COMPANY_CD', 'CODE', 'CODE_NM', 'UP_CD', 'FREE_1', 'FREE_2', 'FREE_3', 'FREE_4', 'FREE_5', 'COMMENTS_TITLE', 'COMMENTS' ],
		            data      : [<%
						HoList list = cache.getHoList(groupCode); // cache defined in "include.tag"
						if( list != null ) {
							HoAspUtil  aspUtil = new HoAspUtil();
							
							HoList aspHoList = aspUtil.getHoListAsp( list, "0000", "1000", "COMPANY_ID", "CD");
							
							for(int i=0; aspHoList!=null && i<aspHoList.size(); i++) {
								out.print((i>0 ? "," : "") + " {NAME : '"+aspHoList.getString(i,"NAME")+"',   VALUE : '"+aspHoList.getString(i,"VALUE")+"'  , GROUP : '"+aspHoList.getString(i,"UP_CD")+"' , FREE_1 : '"+aspHoList.getString(i,"FREE_1")+"', FREE_2 : '"+aspHoList.getString(i,"FREE_2")+"', FREE_3 : '"+aspHoList.getString(i,"FREE_3")+"', FREE_4 : '"+aspHoList.getString(i,"FREE_4")+"', FREE_5 : '"+aspHoList.getString(i,"FREE_5")+"' ");
								if( HoValidator.isNotEmpty(aspHoList.getString(i,"COMMENTS_TITLE")) &&  HoValidator.isNotEmpty(aspHoList.getString(i,"COMMENTS")) ) {
									out.print(", COMMENTS_TITLE : '"+aspHoList.getString(i,"COMMENTS_TITLE")+"'  , COMMENTS : '"+aspHoList.getString(i,"COMMENTS")+"'");
								}
								out.println("}");
							}	
						}
		            %>
		            ]
		        })

<%					}
				}
			}
			for( int i=1; i<editors.length; i++) {
				out.print(" , " +editors[i]);
			}

			out.print(" }");
		}
%>			,isLoad : true // Column resize 화면 로딩시 이벤트 처리 안하게 하기위해 추가 한 값.
			,listeners : { 
				resize : function( column, width, height, oldWidth, oldHeight, eOpts ) { 
					
					if( !column.isLoad && !column.flex && width != oldWidth ) { 
						Ext.Ajax.request({
						    url: '/s/example/example.do',
						    params: {
						        p_action_flag : 'r_list_data',
						        page : '<%= p_action_flag%>',
						        jsp : '<%= model.getString(HoController.HO_INCLUDE_JSP) %>',
						        grid : '<%= HoServletUtil.getString(request, "grid_id") %>',
						        column : column.dataIndex ,
						        id : '<%= p_action_flag +"_"+ HoServletUtil.getString(request, "grid_id") + id %>',
						        width : width
						    },
						    success: function(response){
						        var text = response.responseText;
						    }
						});
					}
					column.isLoad = false;  
				}
			} 


<% 
		out.print("}");
		HoServletUtil.setOutArea(request);
	} 
%>

<% if( isHtml ) {%>
<% } %>