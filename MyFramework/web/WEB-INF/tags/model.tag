<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag
	import="java.util.List"
	import="project.jun.was.HoModel"
	import="project.jun.util.HoUtil"
	import="project.jun.was.parameter.HoParameter"
	import="project.jun.was.spring.HoController"
	import="project.jun.util.HoServletUtil"
	import="project.jun.util.HoValidator"
	import="project.jun.dao.HoDao"
	import="project.jun.dao.HoDaoSqlResult"
	import="project.jun.util.HoSpringUtil"
	import="project.jun.dao.result.HoMap"
	import="project.jun.dao.result.HoList"
	import="project.jun.dao.parameter.HoQueryParameterMap"
	import="org.apache.ibatis.metadata.result.MetaData"
%><%@ include file="include.tag" %>
<%@ attribute name="var" type="java.lang.String" required="true"
%><%@ attribute name="name" type="java.lang.String" required="true"
%><%@ attribute name="fields" type="java.lang.String"
%>
<% if( isScriptOut ) {%>
	Ext.define('<%= name %>',{
		extend : 'Ext.data.Model',
		fields : [
<%
	if( HoValidator.isNotEmpty(fields)) {
		HoQueryParameterMap value = new HoQueryParameterMap();
		
		value.put("SQL_ID", fields);

		HoList list = dao.select("Page.selectGridFieldsSql", value);
		String column = null;
		// HO_T_SYS_SQL_INFO테이블에 정보가 있을 경우
		if( list.size() > 0) {
			for( int i=0;  i<list.size() ; i++) {
				if( i>0 ) {
					out.print(",");
				}
				column = list.getString(i, "COLUMN_NAME").toUpperCase();
				out.print("'"+ column +"'");
				if( column.endsWith("_CD")) {
					out.print(", '"+ column +"_NM'");
				}
			}
		} 
		// HO_T_SYS_SQL_INFO테이블에 정보가 없을 경우
		else {
			
			value = new HoQueryParameterMap();
		
			value.put("METADATA", "Y");
	        value.put("S_ROWNUM", "0");
	        value.put("E_ROWNUM", "0");
	
			HoMap map = dao.selectOne(fields, value);
	
			MetaData md = map.getMetaData();
			
			HoQueryParameterMap [] values = new HoQueryParameterMap[md.getColumnCount()];
			
			for( int i=0;  i<md.getColumnCount() ; i++) {
				values[i] = new HoQueryParameterMap();
				column =   md.getColumnName(i).toUpperCase();
				values[i].add("SQL_ID", fields );
				values[i].add("COLUMN_NAME", column );
				values[i].add("COLUMN_IDX", i );
				values[i].add("DATA_TYPE", md.getColumnTypeName(i).toUpperCase() );
				
				if( i>0 ) {
					out.print(",");
				}
				out.print("'"+ column +"'");
				if( column.endsWith("_CD")) {
					out.print(", '"+ column +"_NM'");
				}
			}
			
			List<HoDaoSqlResult> result = dao.batch("Page.insertGridFieldsSql", values);
		}
	}
%>		
		]
	});
	
	var <%= var %> = Ext.create('<%= name %>', {
		<jsp:doBody></jsp:doBody>
	});
<%	} %>
	

