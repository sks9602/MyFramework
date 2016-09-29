<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag
	import="project.jun.was.HoModel"
	import="project.jun.util.HoUtil"
	import="project.jun.util.HoValidator"
	import="project.jun.was.parameter.HoParameter"
	import="project.jun.was.spring.HoController"
	import="project.jun.util.HoServletUtil"
%><%@ include file="include.tag" %>
<%@ attribute name="title" type="java.lang.String"
%><%@ attribute name="id" type="java.lang.String"
%><%@ attribute name="expand" type="java.lang.String"
%><%@ attribute name="expandable" type="java.lang.String"
%><%@ 
attribute name="colspan"    type="java.lang.String" %><%@ 
attribute name="rowspan"    type="java.lang.String" %><%@ 
attribute name="maxItem" type="java.lang.String"
%>

<% if( isScript || isScriptOut ) { %>

<%
	String nowArea = HoServletUtil.getNowArea(request);

	String MAX_ROW_ITEM = HoUtil.replaceNull(maxItem, HoServletUtil.getString(request, "MAX_ROW_ITEM"));
	
	colspan = HoValidator.isNotEmpty(colspan) ? colspan : MAX_ROW_ITEM;
	
	if( HoValidator.isEmpty(HoServletUtil.getString(request, "MAX_ROW_ITEM")) ) {
		HoServletUtil.setString(request, "MAX_ROW_ITEM", MAX_ROW_ITEM);
	}
	
	if( "fieldcontainer".equals(nowArea)) {
		HoServletUtil.initIndex(request, HoServletUtil.getArea(request)+">item_row");
		HoServletUtil.setOutArea(request);
	}

	int sectionRow = HoServletUtil.getIndex(request, HoServletUtil.getArea(request)+">fieldcontainer_row");
	HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request)+">fieldcontainer_row");
	HoServletUtil.setInArea(request, "section");

	id = HoUtil.replaceNull(id, "section_"+ sectionRow );

	out.print((sectionRow > 0 ? "," : "" ) );
	out.print("Ext.create('Ext.form.FieldSet', {title: '"+title+"',  margin : '1 2 1 2', style: 'padding:3px 2px 3px 2px',  bodyStyle: 'padding:5px', ");
	if( HoValidator.isIn(expandable, new String[] {"N","false"}, true)) {
		out.print(" collapsible: false, ");
	} else {
		out.print(" collapsible: true, ");
	}
	out.print( HoValidator.isNotEmpty(colspan) ? "colspan: "+colspan+"," : "" );
	out.print( HoValidator.isNotEmpty(rowspan) ? "rowspan: "+rowspan+"," : "" );
	if( !"random".equalsIgnoreCase(id)) {
		out.print("id : '" + p_action_flag +"_" + HoServletUtil.getString(request, "form-id") + "_"+ id +"'," );
	}
	if( !"".equals(MAX_ROW_ITEM)) {
		out.print("layout: { type: 'table' , columns : "+MAX_ROW_ITEM+", defaultMargins: {top: 0, right: 5, bottom: 1, left: 0}  }, " ); // , defaultMargins: {top: 0, right: 5, bottom: 0, left: 0}
		out.print(" defaults: {  margin : '0 3 1 0' }, "); // tableAttrs : { style : { padding:'0 5 0 0' } }
	}
	
	if( HoValidator.isIn(expand, new String[] {"N","false"}, true)) {
		out.print("collapsed : true, " );
	} else {
		out.print("collapsed : false, " );
	}
	
	out.print("items : [ ");

	HoServletUtil.setInArea(request, "fieldcontainer");
	int itemsRow = HoServletUtil.getIndex(request, HoServletUtil.getArea(request)+"_row");
	HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request)+"_row");
	out.print((itemsRow > 0 ? "," : "" ) +"		" );


%>
<jsp:doBody></jsp:doBody>
<%
	String nowEndArea = HoServletUtil.getNowArea(request);

	if( "fieldcontainer".equals(nowEndArea)) {
		HoServletUtil.initIndex(request, HoServletUtil.getArea(request)+">item_row");
		HoServletUtil.setOutArea(request);
	}

	HoServletUtil.initIndex(request, HoServletUtil.getArea(request)+">fieldcontainer");
	HoServletUtil.initIndex(request, HoServletUtil.getArea(request)+">fieldcontainer_row");

	out.println("] } )");
	HoServletUtil.setOutArea(request);
%>
<% } %>



<% if( isHtml ) {

%>

<% } %>