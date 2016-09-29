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


<% if( (isScript||isScriptOut ) && !isDockedItem ) { %>

<%

		HoServletUtil.setInArea(request, "listeners");
		HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request)+"_row");
%>
		<% if( "Y".equals(HoServletUtil.getString(request, "treegrid-checkboxmodel"))) { %>
		/*selModel: {
            renderer: function(value, metaData, record, rowIndex, colIndex, store, view) {
                var baseCSSPrefix = Ext.baseCSSPrefix;
                metaData.tdCls = baseCSSPrefix + 'grid-cell-special ' + baseCSSPrefix + 'grid-cell-row-checker';
                return !record.get('leaf') ? '' : '<div class="' + baseCSSPrefix + 'grid-row-checker"> </div>';
            },
        },*/
        <% } %>
		listeners: {
			<% if( "Y".equals(HoServletUtil.getString(request, "treegrid-checkboxmodel"))) { %>
			select: function (selModel, rec) {
	            rec.cascadeBy(function (child) {
	                selModel.select(child, true, true);
	            });
	        },
	        deselect: function (selModel, rec) {
	            rec.cascadeBy(function (child) {
	                selModel.deselect(child, true);
	            });
	        },
	        <% } %>
			<jsp:doBody></jsp:doBody>
		},
<%
		HoServletUtil.setOutArea(request);
%>
<% } %>

<% if( isHtml ) {%>
<% } %>