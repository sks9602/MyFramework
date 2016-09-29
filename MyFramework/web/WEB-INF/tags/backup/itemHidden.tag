<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag
	import="pjt.epolylms.util.HtmlUtil"
	import="java.util.HashMap"
%>
<%@ attribute name="title" type="java.lang.String"  %>
<%@ attribute name="area" type="java.lang.String" required="true" %> <%-- html / script 중 택1 --%>
<%@ attribute name="name" type="java.lang.String"  required="true" %>
<%@ attribute name="value" type="java.lang.String" %>
<%@ attribute name="vtype" type="java.lang.String" %>
<%@ attribute name="form" type="java.lang.String" %>

<% if( area.equalsIgnoreCase("html") ) { 

%>
<span id="id_<%= form %>_<%= name %>"></span>
<% } else { %>
	Ext.create('Ext.form.field.Hidden', {
		renderTo : 'id_<%= form %>_<%= name %>',
		id : 'cmp_<%= form %>_<%= name %>_hf',
		name : '<%= name %>',
		value : '<%= HtmlUtil.replaceNull(value) %>'
	});
	cmps['<%= form %>'] = cmps['<%= form %>']||[];    
    cmps['<%= form %>'].push('cmp_<%= form %>_<%= name %>_hf');
			
<% } %>