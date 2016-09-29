
<%@ page
	contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	session="true"
	import="java.util.*"
	import="java.sql.Types"
	import="project.jun.dao.result.HoList"
	import="project.jun.dao.result.transfigure.HoMapHasList"
	import="project.jun.delegate.HoDelegate"
	import="project.jun.util.HoUtil"
	import="org.apache.ibatis.metadata.result.MetaData"
%><%@include file="/jsp/common/include/include.jsp"
%><%
	boolean scriptTag = false;
	String cb = param.get("callback");
	if (!cb.equals("")) {
	    scriptTag = true;
	    response.setContentType("text/javascript");
	    response.setHeader("Content-Type", "charset=utf-8");
	} else {
	    response.setContentType("application/x-json");
	    response.setHeader("Content-Type", "charset=utf-8");
	}
	if (scriptTag) {
	    out.write(cb + "(");
	}

	long cnt = model.getLong(HoDelegate.KEY_JSON_CNT);

	HoList list = model.getHoList(HoDelegate.KEY_JSON_DATA);

	MetaData md = (list!=null ? list.getMetaData() : null );

	HoMapHasList mapList = list.toHoMapHasList("P_ID");

%>
<% if( true ) { %>
{"id" : "Root", "ID" : "Root", "expanded" : true, "children" : [
<%
	int depth = 1;

	out.print(getTree(param.get("ROOT"), mapList,  cache, depth));
%>
]}
<% } else { %>
{'expanded' : true, 'children' : [

<%--  @TODO 아래의 TREE부분... 로직 처리. 시작. --%>	
{ 'id' : 'id_1', text: "detention", 'value' : 1, name: "Detention",  leaf: true, checked : false },
{ 'id' : 'id_2', text: "homework", 'value' : 2, name: "Homework", expanded: true, children: [
    { 'id' : 'id_3',  text: "book report", 'value' : 3, name: "Book Report", leaf: true, checked : false },
    { 'id' : 'id_4', text: "algebra", 'value' : 41, name: "Algebra", leaf: true, checked : false}
] },
{ 'id' : 'id_5', text: "buy lottery tickets", 'value' : 5, name: "Buy Lottery Tickets",  leaf: true, checked : false }		
<%--  @TODO 아래의 TREE부분... 로직 처리..  끝.--%>	

]}
<% } %>
<%
if (scriptTag) {
    out.write(");");
}

/*
	{id: '1', text: 'First node', leaf: false,  children:
			[
				{id: '3', text: 'First child node', checked: false, leaf: true},
				{id: '5', text: '5 node', checked: false, leaf: true},
				{id: '4', text: 'Second child node', checked: false, leaf: true}
			]
		},
		{id: '2', text: 'Second node', checked: false, leaf: true}	
*/
%>
<%!
	String getTree(String key, HoMapHasList mapList, HoCache  cache, int depth) {
		HoSetHasMap CODE_SET_MAP = (HoSetHasMap) cache.get(HoCacheAdvice.CACHED_CODE_SET);
	
		StringBuilder sb = new StringBuilder();
		
		HoList subList = mapList.getHoList(key);
		
		HoMap hoMap = null;
		String recordString = null;
		for( int i=0; i<subList.size(); i++) {
			
			hoMap = subList.toHoMap(i);
			recordString = getRecordString(hoMap, CODE_SET_MAP, depth);
			
			sb.append((i>0 ? "," : "") + "{");
			sb.append( recordString );
			if( recordString.length() > 0 ) {
				sb.append(",");
			}
			
			
			if( mapList.containsKey(hoMap.get("ID"))) {
				sb.append("\"expanded\" : true, \"children\" : [");
				sb.append( getTree(hoMap.getString("ID"), mapList, cache, depth+1));
				sb.append("]");
			} else {
				sb.append("\"leaf\" : true  ");
			}
			sb.append("}");
		}
		return sb.toString();
	}

	String getRecordString(HoMap hoMap, HoSetHasMap CODE_SET_MAP, int depth) {
		String record = hoMap.toJson();
		
		if( !"".equals(hoMap.getString("ICON_CLS")) ) {
			record += (", \"iconCls\" : \"" + hoMap.getString("ICON_CLS") + "\"");
		}
		if( !"".equals(hoMap.getString("ID")) ) {
			record += (", \"id\" : \"" + hoMap.getString("ID") + "\"");
		}		
		if( !"".equals(hoMap.getString("TEXT")) ) {
			record += (", \"text\" : \"" + hoMap.getString("TEXT") + "\"");
		}		
		
		record += (", \"depth\" : \"" + depth + "\"");
		
		for( int i=0; i<hoMap.getMetaData().getColumnCount(); i++) {
			String column = hoMap.getMetaData().getColumnName(i).toUpperCase();
			
			if( column.endsWith("_CD")) {
				record += (", \""+ column+"_NM\" : \"" + CODE_SET_MAP.getString(hoMap.getString(column), "CD_NM") + "\"");
			}

		}

		

		return record;
	}
%>