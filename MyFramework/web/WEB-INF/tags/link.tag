<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag
	import="project.jun.was.HoModel"
	import="project.jun.util.HoUtil"
	import="project.jun.was.parameter.HoParameter"
	import="project.jun.was.spring.HoController"
	import="project.jun.util.HoServletUtil"
	import="project.jun.util.HoValidator"
	import="project.jun.dao.HoDao"
	import="project.jun.util.HoSpringUtil"
	import="project.jun.dao.result.HoMap"
	import="project.jun.dao.result.HoList"
	import="project.jun.dao.parameter.HoQueryParameterMap"
	import="org.apache.ibatis.metadata.result.MetaData"
%><%@ include file="include.tag" %>
<%@ attribute name="position" type="java.lang.String"
%><%@ attribute name="action" type="java.lang.String"
%><%@ attribute name="targetId" type="java.lang.String"
%><%@ attribute name="args" type="java.lang.String"
%><%@ attribute name="view" type="java.lang.String"
%><%-- link 정보를 생성 (ex. Grid 내의 renderer) --%>
<% 
if( isScript || isScriptOut ) {
	if( HoValidator.isIn(HoUtil.replaceNull(position), new String[]{"", "renderer"}, true)) {
%>
	"<span class=\"in_grid_url_link\"  onclick=\"fs_<%= p_action_flag%>_<%= targetId%>_<%= action%>( <%= HoUtil.replaceNull(args) %> );\"><%= HoUtil.replaceNull(view, "{0}") %></span>"
<%
	}
}
%>


