<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag
	import="project.jun.was.HoModel"
	import="project.jun.util.HoUtil"
	import="project.jun.util.HoServletUtil"
	import="project.jun.was.parameter.HoParameter"
	import="project.jun.was.spring.HoController"
	import="project.jun.util.HoValidator"
%><%@ attribute name="title" type="java.lang.String"
%><%@ attribute name="column" type="java.lang.String"
%><%@ attribute name="flex" type="java.lang.String"
%><%@ attribute name="width" type="java.lang.String"
%><%@ attribute name="renderer" type="java.lang.String"
%><%@ attribute name="editor" type="java.lang.String"
%><%@ attribute name="align" type="java.lang.String"
%><%@ attribute name="locked" type="java.lang.String"
%><%@ attribute name="resize" type="java.lang.String"
%><%@ attribute name="sortable" type="java.lang.String"
%><%
	HoModel        model     = new HoModel(request);
	HoParameter    param     = (HoParameter) model.get(HoController.HO_PARAMETER);

	String p_action_flag = param.get("p_action_flag");
	String division      = param.get("division");
	String tab_index      = param.get("tab_index");

	boolean isScript = "script".equals(division);
	boolean isHtml 	 = "html".equals(division);
	boolean isFirstTab = "0".equals(tab_index);

	int gridIndex = HoServletUtil.getIndex(request, "grid_index");

%>


<% if( isScript ) { %>

<%

		HoServletUtil.setInArea(request, "column");
		int columnIndex = HoServletUtil.getIndex(request, HoServletUtil.getArea(request)+"_row");
		HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request)+"_row");
		out.print((columnIndex>0 ? "," : "") + "{ dataIndex: '"+ column.toLowerCase()+"' "); // cls : 'colFlag',
		String editors[] = null;

		if( HoValidator.isNotEmpty(editor) ) {
			editors = editor.split("\\,");
			out.print(",header: '<div class=\"grid-header-"+editors[0]+"\"></div>&nbsp;"+ title+"'  ");
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

		if( HoUtil.replaceNull(renderer).equals("function") ) {
			out.print(", renderer : ");
%>
			<jsp:doBody></jsp:doBody>
<%
		} else if( HoValidator.isNotEmpty(renderer) ) {
			out.print(", renderer : " + renderer );
		} /*else if( HoValidator.isNotEmpty(align) ){
			//out.print(", align:'"+HoUtil.replaceNull(align,"center")+"' " );
			//out.print(", renderer : function (value, p, record){ return Ext.String.format( \"<div style=\\\"text-align:"+align+";\\\">{0}</div>\", value, p );}");
		}*/

		if( HoUtil.replaceNull(editor).equals("function") ) {
			out.print(", editor : ");
%>
			<jsp:doBody></jsp:doBody>
<%
		} else if( HoValidator.isNotEmpty(editor) && !"link".equals(editor)  ) {
			out.print(", editor : { ");


			if( editors.length > 0 ) {
				if( "email".equals(editors[0])) {
					out.print(" xtype : 'textfield', vtype: 'email'");
				} else {
					out.print(" xtype : '" +editors[0]+"'");
				}
			}
			for( int i=1; i<editors.length; i++) {
				out.print(" , " +editors[i]);
			}

			out.print(" }");
		}

		out.print("}");
		HoServletUtil.setOutArea(request);

%>
<% } %>

<% if( isHtml ) {%>
<% } %>