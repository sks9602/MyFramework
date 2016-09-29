<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag
	import="project.jun.was.HoModel"
	import="project.jun.util.HoUtil"
	import="project.jun.util.HoValidator"
	import="project.jun.was.parameter.HoParameter"
	import="project.jun.was.spring.HoController"
	import="project.jun.util.HoServletUtil"
%><%@ attribute name="id" type="java.lang.String"
%><%@ attribute name="action" type="java.lang.String"
%><%@ attribute name="title" type="java.lang.String"
%><%@ attribute name="width" type="java.lang.String"
%><%@ attribute name="height" type="java.lang.String"
%><%@ attribute name="page" type="java.lang.String"
%><%@ attribute name="button" type="java.lang.String"
%><%
	HoModel        model     = new HoModel(request);
	HoParameter    param     = (HoParameter) model.get(HoController.HO_PARAMETER);

	String p_action_flag = param.get("p_action_flag");
	String division      = param.get("division");
	String tab_index      = param.get("tab_index");

	boolean isScript = "script".equals(division);
	boolean isHtml 	 = "html".equals(division);
	boolean isFirstTab = "0".equals(tab_index);

	String section_name =  "_grid";

%>



<% if( isScript ) { %>

<%
	int index =  HoServletUtil.getIndex(request, HoServletUtil.getArea(request)+"_row");
	HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request)+"_row");
	HoServletUtil.setInArea(request, "tree");

	String [] buttons = HoValidator.isNotEmpty(button) ? button.split("\\,") : new String [0];

	out.print(index > 0 ? "," : "" );

%>
		Ext.create('Ext.tree.Panel', {
		    title: 'Simple Tree',
		    width: <%= HoValidator.isEmpty(width) ? "450" : width %>,
		    height: <%= HoValidator.isEmpty(height) ? "600" : height %>,
		    store: Ext.create('Ext.data.TreeStore', {
		         root: {
		             expanded: true,
		             children: [
		                 { text: "detention", leaf: true },
		                 { text: "homework", expanded: true, children: [
		                     { text: "book report", leaf: true },
		                     { text: "algebra", leaf: true}
		                 ] },
		                 { text: "buy lottery tickets", leaf: true }
		             ]
		         }
		     }),
		    rootVisible: true
		})

<%
	HoServletUtil.setOutArea(request);

%>

<% } %>


<% if( isHtml  ) {
%>

<%
 } %>