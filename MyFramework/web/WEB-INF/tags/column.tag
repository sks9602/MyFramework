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
<%@ attribute name="id" type="java.lang.String" 
%><%@ attribute name="title" type="java.lang.String"
%><%@ attribute name="column" type="java.lang.String" required="true"
%><%@ attribute name="flex" type="java.lang.String"
%><%@ attribute name="width" type="java.lang.String"
%><%@ attribute name="renderer" type="java.lang.String"
%><%@ attribute name="editor" type="java.lang.String"
%><%@ attribute name="align" type="java.lang.String"
%><%@ attribute name="locked" type="java.lang.String"
%><%@ attribute name="resize" type="java.lang.String"
%><%@ attribute name="sortable" type="java.lang.String"
%><%@ attribute name="storeId" type="java.lang.String"
%><%@ attribute name="append" type="java.lang.String"
%><%
	int gridIndex = HoServletUtil.getIndex(request, "grid_index");
%>
<% if( isScript || isScriptOut) { 
		
		HoServletUtil.setInArea(request, "column");
		int columnIndex = HoServletUtil.getIndex(request, HoServletUtil.getArea(request)+"_row");
		HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request)+"_row");

		if( HoValidator.isEmpty(id)) {
			id = p_action_flag +"_"+ HoServletUtil.getString(request, "grid-id") +"_col_"+ column;
		}
		out.print((columnIndex>0 ? "," : "") + "{ dataIndex: '"+ column.toUpperCase()+"', "); // cls : 'colFlag',
		
		if( !"random".startsWith(HoServletUtil.getString(request, "grid-id")) || !"random".startsWith(id) ) { 
			out.print(" id : '"+id+"', ");
		}
		
		// @TODO 아래의 부분(if( !hoConfig.isProductMode() {})은 실제 운영시 제거 
		if( !hoConfig.isProductMode() ) { // 개발모드일 경우
			out.print("tooltip : '" + p_action_flag +"_"+ HoServletUtil.getString(request, "grid-id") +"_col_"+ column + "',  ");
		}
		if( HoValidator.isNotEmpty(editor) ) {
			HoServletUtil.setString(request, "column_id", column );
			String editCls = "";
			if( editor.indexOf(",") > 0 ) {
				editCls = editor.split(",")[0];
			} else {
				editCls = editor;
			}
			
			out.print("header: '<div class=\"grid-header-"+editCls+"\"></div>&nbsp;"+ title+"',  ");
		} else {
			out.print("header: '"+ title+"',  ");
		}
		
		if( HoUtil.replaceNull(sortable).equals("false") || HoUtil.replaceNull(sortable).equals("N") ) {
			out.print("sortable: false, " );
		} else {
			out.print("sortable: true, " );
		}

		if( !HoUtil.replaceNull(align).equals("center") ) {
			out.print("style: 'text-align:center', align: '"+HoUtil.replaceNull(align,"center")+"', " );
		} else {
			out.print("align: 'center', " );
		}
		if( HoValidator.isNotEmpty(locked) && ( HoUtil.replaceNull(locked).equals("Y") ||  HoUtil.replaceNull(locked).equals("true") )  ) {
			out.print("locked : true, width: "+ ( HoValidator.isEmpty(width) ? "200" : width ) +",");
		} else {
			out.print(""+ ( HoValidator.isEmpty(flex) ? "" : " flex : 1," ) +" width: "+ ( HoValidator.isEmpty(width) ? "100" : width ) +",");
		}

		if(  HoUtil.replaceNull(resize).startsWith("N") || HoUtil.replaceNull(resize).startsWith("false") ) {
			out.print("fixed: true, ");
		}

		if( HoUtil.replaceNull(renderer).equals("actioncolumn") ) {
			out.print("menuDisabled: true,  sortable: false, xtype: 'actioncolumn', ");
		} else if( HoUtil.replaceNull(renderer).equals("date") ) {
			out.print("xtype: 'datecolumn', format:'Y/m/d', ");
		} 

		if( HoValidator.isNotNull(append)) {
			out.print( append );
		}

		String gridId = HoServletUtil.getString(request, "grid-id");

		if( HoUtil.replaceNull(editor).startsWith("checkbox") ) {
			String checkRefColumn = "";
			if( editor.indexOf(":") >=0 ) {
				checkRefColumn = editor.split("\\:")[1];
			}
			out.print("xtype: 'ux_checkcolumn' , text : '"+title+"', stopSelection: false, "  ); 
			if( !"".equals(checkRefColumn)) {
				out.print(" checkReferColumn: '"+checkRefColumn+"', "  ); 
			}
			
			out.print(" pActionFlag : '"+ p_action_flag +"', gridId : '"+HoServletUtil.getString(request, "grid-id") +"', ");
			/*
			out.print("listeners : { \"checkChange\" : { scope : this.parent , fn : ");
			
			if( !HoValidator.isEmpty(storeId) ) {
				out.print("function( _column, _rowIndex, _checked, _eOpts) {  ");
				out.print("		var store = Ext.getStore('"+storeId+"');");
				out.print("		var record = store.getAt(_rowIndex);");
				out.print("		var columnIndex = _column.getIndex();");
				out.print("		record.set('"+column+"', _checked );");
				out.print("}");
			} 
			out.print(" } },");
			*/
		} 
		
		if (HoUtil.replaceNull(editor).equals("combotipple") ) {
%>
				renderer : function (value){
					var store = Ext.getStore('<%=p_action_flag%>_store_editor_<%=gridId%>_<%= HoServletUtil.getString(request, "column_id") %>');
					var index = store.findExact('VALUE',value);
					 
					if (index != -1){
	                    rs = store.getAt(index).data; 
	                    return rs.NAME; 
	                } else {
	                	return value;
	                }
				},
				scope : this,
<%		
		} else if ( HoUtil.replaceNull(editor).equals("combotree") ) {
%>
				renderer : function (value){
					var store = Ext.getStore('<%=p_action_flag%>_store_editor_<%=gridId%>_<%= HoServletUtil.getString(request, "column_id") %>');
					
					// var root = store.getRootNode( );
					//  root.findChild( attribute, value, [deep] );
					
					var node = store.getNodeById(value);
					
					if( node ) {
						return node.data.TEXT;
					} else {
						return value;
					}
				},
				scope : this,
<%
		}
%>
			<jsp:doBody></jsp:doBody>
			isLoad : true, // Column resize 화면 로딩시 이벤트 처리 안하게 하기위해 추가 한 값.
			listeners : { 
<%		
				if( HoUtil.replaceNull(editor).equals("checkbox") ) {
					out.print("\"checkChange\" : { scope : this.parent , fn : ");
					
					if( !HoValidator.isEmpty(storeId) ) {
						out.print("function( _column, _rowIndex, _checked, _eOpts) {  ");
						out.print("		var store = Ext.getStore('"+storeId+"');");
						out.print("		var record = store.getAt(_rowIndex);");
						out.print("		var columnIndex = _column.getIndex();");
						out.print("		record.set('"+column+"', _checked );");
						out.print("}");
					} 
					out.print(" } ,");
				} 
%>
				resize : function( column, width, height, oldWidth, oldHeight, eOpts ) { 
					if( !column.isLoad && !column.flex && width != oldWidth ) { 
						Ext.Ajax.request({
						    url: '/s/example/example.do',
						    params: {
						        p_action_flag : 'r_list_data',
						        page : '<%= p_action_flag%>',
						        jsp : '<%= model.getString(HoController.HO_INCLUDE_JSP) %>',
						        grid : '<%= HoServletUtil.getString(request, "grid-id") %>',
						        column : column.dataIndex ,
						        id : '<%= id %>',
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