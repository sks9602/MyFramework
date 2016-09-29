<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page
	import="project.jun.aop.advice.HoCacheAdvice"
	import="project.jun.dao.HoDao"
	import="project.jun.dao.result.HoMap"
	import="project.jun.dao.result.transfigure.HoSetHasMap"
	import="project.jun.util.cache.HoEhCache"
	import="project.jun.dao.result.HoList"
	import="project.jun.config.HoConfig"
	import="org.springframework.web.context.support.WebApplicationContextUtils"
	import="org.springframework.web.context.WebApplicationContext"
	import="project.jun.dao.parameter.HoQueryParameterMap"
	import="java.util.Date"
	import="java.text.DateFormat"
%><%@ taglib prefix="jun"  tagdir="/WEB-INF/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

COMBO <jun:search  OWNER="SVCE" TABLE_NAME="HR_MEMBER" view="combo"></jun:search>
<br/>
<br/>
RADIO<br/> <jun:search  OWNER="SVCE" TABLE_NAME="HR_MEMBER" view="radio"></jun:search>
<br/>
<br/>
CHECKBOX<br/> <jun:search  OWNER="SVCE" TABLE_NAME="HR_MEMBER" view="checkbox"></jun:search>

<br/>
<br/>
	<% String longDate = "aaa"; %>
	longDate ( From tag file ) : <jun:search>${longDate}</jun:search>
<br/>
	longDate ( From jsp file ) : <%= longDate %>
<br/>

<br/>
<%


    WebApplicationContext appContext =  WebApplicationContextUtils.getWebApplicationContext(application);

    HoDao dao = (HoDao) appContext.getBean("proxyDbDao");
    HoEhCache cache = new HoEhCache(dao.getCache());
    HoSetHasMap hshm = (HoSetHasMap) cache.get(HoCacheAdvice.CACHED_CODE_SET);
    out.println("<br/>" + hshm.get("COMPANY_CD") );
    out.println("<br/>" + hshm.get("MEMBER_NO") );
    out.println("<br/>" + ((HoMap) hshm.get("MEMBER_NO")).get("data_type") );


%>
</body>
</html>