<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag
	import="project.jun.was.HoModel"
	import="project.jun.util.HoUtil"
	import="project.jun.util.HoServletUtil"
	import="project.jun.was.parameter.HoParameter"
	import="project.jun.was.spring.HoController"
	import="project.jun.util.HoValidator"
%><%@ include file="include.tag" %>
<%@ attribute name="rownum" type="java.lang.String"
%><%

	int gridIndex = HoServletUtil.getIndex(request, "grid_index");

	boolean isDockedItem = HoServletUtil.getArea(request).indexOf("dockedItems") > 0;
%>


<% if( (isScript || isScriptOut) && !isDockedItem) { %>
<%

		HoServletUtil.setInArea(request, "columns");
		HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request)+"_row");
%>
	    columns: { 
	    	items : [
	    <% if( !HoUtil.replaceNull(rownum).equals("N")  ) { %>
	        {xtype: 'rownumberer', text : 'No', width: 40, style: 'text-align:center' },
	    <% } %>
			<jsp:doBody></jsp:doBody>
	   		] ,
	   		listeners : {
	   			<%-- 컬럼 변경시 컬럼 위치 정보 저장. --%>
	   			columnmove : function( header, column, fromIdx, toIdx, eOpts ) {
					// alert("columns.tag : " +  header.ownerCt.getXType() + ":" + header.ownerCt.getId() + ":" + column.getId() + ":" + fromIdx +"->" + toIdx );
					
					Ext.Ajax.request({
					    url: '/s/example/example.do',
					    params: {
					        p_action_flag : 'r_list_data',
					        page : '<%= p_action_flag%>',
					        grid : '<%= HoServletUtil.getString(request, "grid-id") %>',
					        header_Ct : header.ownerCt.getId() ,
					        from_Idx : fromIdx,
					        to_Idx : toIdx
					    },
					    success: function(response){
					        var text = response.responseText;
					    }
					});
				},
				<%-- 컬럼 Render시 저장된 위치정보에 따라 컬럼 위지 조정. @TODO --%>
				afterrender : function( header, eOpts ) {
					if( header.ownerCt.getId() == 'v_list_grid_grid_1-normal' ) {
						<%-- 아래와 같이 컬럼 위치 조정 --%>
						// header.move(2,0) ;
					}
				}
	   		}
	   	} ,
<%
		HoServletUtil.initIndex(request, HoServletUtil.getArea(request)+">column_row");
		HoServletUtil.setOutArea(request);
%>
<% } %>

<% if( isHtml ) {%>
<% } %>