<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag
	import="project.jun.was.HoModel"
	import="project.jun.util.HoUtil"
	import="project.jun.util.HoServletUtil"
	import="project.jun.was.parameter.HoParameter"
	import="project.jun.was.spring.HoController"
	import="project.jun.util.HoValidator"
%><%@ include file="include.tag" %>
<%@ attribute name="name" type="java.lang.String"
%><%
	int gridIndex = HoServletUtil.getIndex(request, "grid_index");

	boolean isDockedItem = HoServletUtil.getArea(request).indexOf("dockedItems") > 0;

%>
<% if( (isScript||isScriptOut )  && !isDockedItem  ) { %>
<%
		HoServletUtil.setInArea(request, name );
		HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request)+"_object");
%>
		<%= HoValidator.isEmpty(name) ? "" : name + " : " %>{
			<jsp:doBody></jsp:doBody>
			<% if( "listeners".equals(name) && "Y".equals(HoServletUtil.getString(request, "treegrid-checkboxmodel"))) { %>
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
	        <% } else if( "listeners".equals(name)) {%>
			none : function() {
			}
	        <% } %>
		},

<%
		HoServletUtil.setOutArea(request);
%>
<% } %>

<% if( isHtml ) {%>
<% } %>