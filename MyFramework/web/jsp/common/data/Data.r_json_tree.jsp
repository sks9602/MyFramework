
<%@ page
	contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	session="true"
	import="java.util.*"
	import="java.sql.Types"
	import="project.jun.dao.result.HoList"
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

%>
{'children': [

<%--  @TODO 아래의 TREE부분... 로직 처리. 시작. --%>	
{ 'level' : '1', 'id' : 'id_1', 'text': "detention", 'value' : 1, name: "Detention",  leaf: true },
{ 'level' : '2', 'id' : 'id_2', 'text': "homework", 'value' : 2, name: "Homework", leaf: false, expanded: true, children: [
    { 'level' : '2-1', 'id' : 'id_3',  'text': "book report", 'value' : 3, name: "Book Report", leaf: true },
    { 'level' : '2-2', 'id' : 'id_4', 'text': "algebra", 'value' : 3, name: "Algebra", leaf: true},
    { 'level' : '2-3', 'id' : 'id_5', 'text': "alegro", 'value' : 5, name: "Alegro", leaf: false, expanded: true, children: [
    { 'level' : '2-3-1', 'id' : 'id_6',  'text': "New Leaf",'value' : 6, name: "New Lea",  leaf: true },
    { 'level' : '2-3-2', 'id' : 'id_7', 'text': "fork",'value' : 7, name: "Fork", leaf: true},
    { 'level' : '2-3-3', 'id' : 'id_8', 'text': "beef",'value' : 8, name: "Beef", leaf: true}
] } ] },
{ 'level' : '3', 'id' : 'id_9', 'text': "buy lottery tickets", 'value' : 9, name: "Buy Lottery Tickets",leaf: true }		
<%--  @TODO 아래의 TREE부분... 로직 처리..  끝.--%>	

]}
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
