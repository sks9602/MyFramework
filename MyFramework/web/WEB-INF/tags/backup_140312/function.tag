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
	import="project.jun.dao.parameter.HoQueryParameterMap"
	import="org.apache.ibatis.metadata.result.MetaData"
%><%@ attribute name="section" type="java.lang.String"
%><%@ attribute name="action" type="java.lang.String"
%><%@ attribute name="args" type="java.lang.String"
%><%@ attribute name="url" type="java.lang.String"
%><%@ attribute name="fields" type="java.lang.String"
%>
<%
	HoModel        model     = new HoModel(request);
	HoParameter    param     = (HoParameter) model.get(HoController.HO_PARAMETER);

	String p_action_flag = param.get("p_action_flag");
	String division      = param.get("division");

	boolean isScript = "script".equals(division);
	boolean isScriptOut = "script_out".equals(division);
	boolean isHtml 	 = "html".equals(division);

%>

<% if( isScriptOut ) {
%>
<% if( HoValidator.isNotEmpty(action) && !HoUtil.replaceNull(action).startsWith("fs") )  { %>
function fs_Alert_<%//=param.get("p_action_flag") %> ( <%= HoUtil.replaceNull(args)  %> ) {
<% } else if( HoValidator.isNotEmpty(action) )  { %>
function <%= action %> ( <%= HoUtil.replaceNull(args)  %> ) {
<%
	String [] arg = HoUtil.replaceNull(args).split(",");

	out.print("var args = {");
	for( int i=0; i<arg.length; i++) {
		if( i>0) {
			out.print(",");
		}
		out.print( arg[i].toLowerCase() + ":" + arg[i].toLowerCase());
	}
	out.print("};");

	if( HoValidator.isNotEmpty(url)) {
		out.print("var store = Ext.create('Ext.data.JsonStore', {");
		out.print("root: 'datas', ");
		out.print("fields : [");

        HoDao dao = (HoDao) new HoSpringUtil().getBean(application, "proxyProjectDao");
		HoQueryParameterMap value = new HoQueryParameterMap();
		value.put("METADATA", "Y");
        value.put("S_ROWNUM", "0");
        value.put("E_ROWNUM", "0");

		HoMap map = dao.selectOne(fields, value);

		MetaData md = map.getMetaData();
		for( int i=0;  i<md.getColumnCount() ; i++) {
			if( i>0 ) {
				out.println(",");
			}
			out.println("'"+md.getColumnName(i).toLowerCase()+"'");
		}

		out.print("], ");
		out.print("proxy: new Ext.data.HttpProxy({ type: 'ajax', ");
		out.print(" url: '" + url + "' ,");
		out.print(" reader: { type: 'json', root: 'datas' } }) ");
		out.print("});");

		out.print("store.load({params: args});");

		/*
		out.print("var store = Ext.create('Ext.data.Store', {");
		out.print("proxy: { type: 'ajax', ");
		out.print(" url: '" + url + "' ,");
		out.print(" reader: { type: 'json', root: 'datas', totalProperty: 'totalCount' } }, autoLoad: true ");
		out.print("});");
		*/
	}
%>

<% }%>
	<jsp:doBody></jsp:doBody>
<% if( HoValidator.isNotEmpty(action) )  { %>
}
<% } %>
<%
	}
%>

