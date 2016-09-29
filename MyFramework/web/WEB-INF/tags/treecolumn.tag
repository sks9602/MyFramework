<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag
	import="project.jun.was.HoModel"
	import="project.jun.util.HoUtil"
	import="project.jun.util.HoServletUtil"
	import="project.jun.was.parameter.HoParameter"
	import="project.jun.was.spring.HoController"
	import="project.jun.util.HoValidator"
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
%><%

	int gridIndex = HoServletUtil.getIndex(request, "grid_index");

%>


<% if( isScript || isScriptOut  ) { %>

<%

		HoServletUtil.setInArea(request, "column");
		int columnIndex = HoServletUtil.getIndex(request, HoServletUtil.getArea(request)+"_row");
		HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request)+"_row");
		out.print((columnIndex>0 ? "," : "") + "{ xtype: 'treecolumn', dataIndex: '"+ column.toUpperCase()+"', "); // cls : 'colFlag',
		out.print("id : '" + p_action_flag +"_"+ HoServletUtil.getString(request, "grid-id") +"_col_"+ column + "',");
		// @TODO 아래의 부분(if( !hoConfig.isProductMode() {})은 실제 운영시 제거 
		if( !hoConfig.isProductMode() ) { // 개발모드일 경우
			out.print("tooltip : '" + p_action_flag +"_"+ HoServletUtil.getString(request, "grid-id") +"_col_"+ column + "',  ");
		}
		if( HoValidator.isNotEmpty(editor) ) {
			out.print("header: '<div class=\"grid-header-"+editor+"\"></div>&nbsp;"+ title+"',  ");
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
			out.print("locked : true, width: "+ ( HoValidator.isEmpty(width) ? "200" : width ) +"," );
		} else {
			out.print(( HoValidator.isEmpty(flex) ? "" : " flex : 1," ) +" width: "+ ( HoValidator.isEmpty(width) ? "100" : width )  +"," );
		}

		if(  HoUtil.replaceNull(resize).startsWith("N") || HoUtil.replaceNull(resize).startsWith("false") ) {
			out.print("fixed: true, ");
		}
%>
			<jsp:doBody></jsp:doBody>
			isLoad : true, // Column resize 화면 로딩시 이벤트 처리 안하게 하기위해 추가 한 값.
			listeners : { 
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
						        id : '<%= p_action_flag +"_"+ HoServletUtil.getString(request, "grid-id") +"_"+ column %>',
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

%>
<% } %>

<% if( isHtml ) {%>
<% } %>