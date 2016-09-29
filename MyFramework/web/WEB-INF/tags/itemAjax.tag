<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag
	import="project.jun.was.HoModel"
	import="project.jun.was.spring.HoController"
	import="project.jun.util.HoUtil"
	import="project.jun.was.parameter.HoParameter"
	import="project.jun.dao.HoDao"
	import="project.jun.dao.result.HoList"
	import="project.jun.config.HoConfig"
	import="org.springframework.web.context.support.WebApplicationContextUtils"
	import="org.springframework.web.context.WebApplicationContext"
	import="project.jun.dao.parameter.HoQueryParameterMap"
	import="java.util.List"
	import="java.util.Date"
	import="java.text.DateFormat"
	import="project.jun.util.asp.HoAspUtil"
	import="project.jun.util.HoValidator"
	import="project.jun.dao.parameter.HoQueryParameterHandler"
	import="project.jun.util.HoServletUtil"
	import="project.jun.util.HoSpringUtil"
	import="project.jun.util.cache.HoCache"	
	import="project.jun.util.cache.HoEhCache"
	import="project.jun.dao.result.transfigure.HoMapHasList"
%><!-- Ajax를 이용한  조건 생성 - combobox  --><%@ 
include file="include.tag" %><%@ 
attribute name="type" type="java.lang.String"  required="true"%><%--  combo --%><%@ 
attribute name="title" type="java.lang.String"  %><%@ 
attribute name="name" type="java.lang.String" required="true" %><%@ 
attribute name="value" type="java.lang.String" %><%-- 설정 값  초기 설정시 다중값을 입력해도 첫번째 1개만 선택됨 @ TODO 모두 선택 되게 수정 해야하지만 현재 까지는 실패.. --%><%@ 
attribute name="require" type="java.lang.String" %><%-- 필수여부 : 'Y'필수 / '기타' 선택  --%><%@ 
attribute name="groupCode" type="java.lang.String" %><%-- 기준 코드 --%><%@ 
attribute name="multiSelect" type="java.lang.String" %><%-- 다중선태 가능 여부 : 'Y' 다중선택 가능  / '기타' 다중선태 불가  --%><%@ 
attribute name="page" type="java.lang.String" %><%-- combobox의 option이 너무 많을 경우 페이지 로 나눠서 페이지별로 몇개씩 출력 하는지 설정. --%><%@ 
attribute name="dependsNames" type="java.lang.String" %><%-- Ajax호출시 파라미터로 같이 전송될 Component의 name필드..  --%><%@ 
attribute name="width"    type="java.lang.String" %><%@ 
attribute name="colspan"    type="java.lang.String" %><%@ 
attribute name="rowspan"    type="java.lang.String" %>
<% 	if( isScript || isScriptOut ) {
		String nowArea = HoServletUtil.getNowArea(request);
		
		if( !"fieldcontainer".equals(nowArea)) {
			HoServletUtil.setInArea(request, "fieldcontainer");
			HoServletUtil.initIndex(request, HoServletUtil.getArea(request));
			int itemsRow = HoServletUtil.getIndex(request, HoServletUtil.getArea(request)+"_row");
			HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request)+"_row");
			out.print( (itemsRow > 0 ? "," : "") +"		");
		}

		int itemNowIndex = HoServletUtil.getIndex(request, HoServletUtil.getArea(request));
		int increaseIndex = getIndexIncrement( type );

		// out.println("<br/>" + HoServletUtil.getArea(request) + ":" +  itemNowIndex + ":"+ increaseIndex );
		if( itemNowIndex + increaseIndex > getMaxItemByArea(request)  ) { // MAX_ROW_ITEM_SEARCH
			HoServletUtil.initIndex(request, HoServletUtil.getArea(request)+">item_row");
			HoServletUtil.initIndex(request, HoServletUtil.getArea(request));
			String area = HoServletUtil.getNowArea(request);

			HoServletUtil.setOutArea(request);
			HoServletUtil.setInArea(request, "fieldcontainer");
			int itemsRow = HoServletUtil.getIndex(request, HoServletUtil.getArea(request)+"_row");
			HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request)+"_row");
			out.print( (itemsRow > 0 ? "," : "") +"		");
		}

		HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request), increaseIndex );
		HoServletUtil.setInArea(request, "item");
		out.println(HoServletUtil.getIndex(request, HoServletUtil.getArea(request)+"_row") > 0 ? "," : "");
		HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request)+"_row");

		if( "combo".equals(type) || "select".equals(type) ){
%>
			{
		        xtype         : 'comboajax_ux', 
		        fieldLabel    : '<%= title %>', <%= HoValidator.isIn(require, new String[]{"Y","true"}, true) ? "allowBlank : false, labelCls   : 'x-form-item-label x-form-item-label-required'," : "" %>
		        name          : '<%= name %>',
		        value         : '<%= value %>', // <%-- ['HR_ABL','HR_ABL_IDX'] <-- 이렇게 넣어도 하나만 선택됨..,   --%>
		        <jsp:doBody></jsp:doBody>
		        <%= HoValidator.isNotEmpty(page)  ? " pageSize : "+page+", " : ""%>
		        <%= HoValidator.isIn(multiSelect, new String[]{"Y","true"}, true)  ? " multiSelect : true, " : ""%>
		        <%= HoValidator.isNotEmpty(dependsNames)  ? " prefixCmp : '"+("id_cmp_"+p_action_flag+"_"+HoServletUtil.getString(request, "form-id")+"_")+"' , dependCmpNames : '"+ dependsNames +"', " : ""%>
				<%= (HoValidator.isNotEmpty(colspan) && HoValidator.isEmpty(width)) ? "width: "+ componentWidth+"*"+ colspan +"," : (HoValidator.isNotEmpty(width) ? "width: "+ width +"+" +labelWidth +"," : "") %> 
				<%= HoValidator.isNotEmpty(colspan) ? "colspan: "+colspan+"," : ""  %><%= HoValidator.isNotEmpty(rowspan) ? "rowspan: "+rowspan+"," : ""  %>
		        code          : '<%= groupCode %>'
		     }
<%
		}
		HoServletUtil.setOutArea(request);
	}
%>

<%
	if( isHtml ) {
%>
<jsp:doBody/>
<%	} %>
