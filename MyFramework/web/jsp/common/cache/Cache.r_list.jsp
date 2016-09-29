<%@ page language="java" contentType="text/html;  charset=utf-8" pageEncoding="utf-8"%>
<%@ page
	import="java.util.Map"
	import="java.util.Set"
	import="java.util.List"
	import="java.util.Iterator"
	import="java.util.Comparator"
	import="java.util.Collections"
	import="project.jun.util.HoUtil"
	import="project.jun.util.HoValidator"
	import="project.jun.util.HoServletUtil"
	import="project.jun.dao.HoDao"
	import="project.jun.util.HoSpringUtil"
	import="project.jun.dao.result.HoList"
	import="project.jun.dao.result.HoMap"
	import="project.jun.util.cache.HoCache"
	import="project.jun.util.cache.HoEhCache"
	import="project.jun.aop.advice.HoCacheAdvice"
	import="project.jun.dao.result.transfigure.HoSetHasMap"
	
%>
<h1>Cache List조회...</h1><br/>
<%

HoDao dao = (HoDao) new HoSpringUtil().getBean(application, "proxyProjectDao");

HoCache cache = new HoEhCache(dao.getCache());

HoSetHasMap setMap = (HoSetHasMap) cache.get(HoCacheAdvice.CACHED_CODE_SET);

%>
<div>
Cache를 이용해서 공통코드 명 가져오기..<br/> 
&lt;% HoSetHasMap setMap = (HoSetHasMap) cache.get(HoCacheAdvice.CACHED_CODE_SET);  %&gt;<br/> 
&lt;%=setMap.getHoMap("B1020").getString("CODE_NM")  %&gt; 이렇게 하면 "<%= setMap.getHoMap("B1020").get("CODE_NM")  %>" 이렇게 나옴..
</div>
<form name="form1" method="post" action="/s/jsp/common/cache/Cache.b_delete.jsp">
<table border="1">
	<tr>
		<th>No</th>
		<th>Cache Name</th>
		<th>Detail</th>
	</tr>	
<%
	
	List list = cache.keyList();

	Collections.sort( list );
	
	for( int i=0 ; i<list.size(); i++ ) {
%>		
	<tr>
		<td><%= i+1 %></td>
		<td><input type="checkbox" name="cache_name" value="<%=list.get(i)%>" /> <%=list.get(i)%></td>
		<td>
<%		
		if( ((String) list.get(i)).startsWith("HoCacheAdvice") ){
			HoSetHasMap hshm = (HoSetHasMap) cache.get((String) list.get(i));
			
			Set set = new java.util.TreeSet(hshm.keySet());
			Iterator it = set.iterator();
			out.println("<table border=\"1\">");
			while( it.hasNext() ) {
				String key = (String) it.next();
				out.println("<tr><td>" + key + "</td><td>" + hshm.get(key) +"</td></tr>");
			}
			out.println("</table>");
		} else {
			out.println(cache.get(list.get(i)).toString().replaceAll("\\}","\\}<br/>").replaceAll("[\\]\\[]",""));
		}
%>
		</td>
	</tr>	
<%
	}
%>
</table>
</form>
 