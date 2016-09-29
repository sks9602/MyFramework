<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag
	import="pjt.epolylms.util.HtmlUtil"
	import="java.util.HashMap"
%>
<%@ attribute name="title" type="java.lang.String"  %>
<%@ attribute name="area" type="java.lang.String" required="true" %> <%-- html / script  / span 중 택1 --%>
<%@ attribute name="require" type="java.lang.String" %><%-- 필수여부 : 'Y'필수 / '기타' 선택  --%>
<%@ attribute name="name" type="java.lang.String"  required="true" %>
<%@ attribute name="value" type="java.lang.String" %>
<%@ attribute name="vtype" type="java.lang.String" %>
<%@ attribute name="function" type="java.lang.String" %>
<%@ attribute name="colspan" type="java.lang.String" %>
<%@ attribute name="width" type="java.lang.String" %>
<%@ attribute name="height" type="java.lang.String" %>
<%@ attribute name="form" type="java.lang.String" %>
<%@ attribute name="maxLength" type="java.lang.String" %><%-- 입력 가능 최대 길이 --%>
<%@ attribute name="append" type="java.lang.String" %><%-- 추가 적으로 부여하고 싶은 Extjs속성 (문자열의 마지막은 ,로종료) --%>
<% if( area.equalsIgnoreCase("html") ) { 
	
	HashMap<String, String[]> titleMap = new HashMap<String, String[]>();
	
	titleMap.put("memberCode", new String [] {"학생명" ,"memberCode"});
	titleMap.put("memberName", new String [] {"학생명" ,"memberName"});
	titleMap.put("voucherName", new String [] {"바우처명" ,"voucherName"});
	titleMap.put("vaildTrm", new String [] {"유효기간" ,"vaildTrm"});
	titleMap.put("lcmsProductName", new String [] {"LCMS 상품명" ,"lcmsProductName"});
	titleMap.put("grantStdDesc", new String [] {"부여기준" ,"grantStdDesc"});
	titleMap.put("salePrdName", new String [] {"판매상품명" ,"salePrdName"});
	titleMap.put("sampleTitle", new String [] {"타이틀" ,"sampleTitle"});
	titleMap.put("lessonCount", new String [] {"레슨수" ,"lessonCount"});
	titleMap.put("note", new String [] {"비고" ,"note"});
	titleMap.put("historyNote", new String [] {"사유" ,"historyNote"});
	titleMap.put("refundRsnNote", new String [] {"환불사유비고" ,"refundRsnNote"});
	titleMap.put("refundDecisionNote", new String [] {"환불확정비고" ,"refundDecisionNote"});
	titleMap.put("refundCnclRsnNote", new String [] {"환불취소사유비고" ,"refundCnclRsnNote"});
	titleMap.put("content", new String [] {"내용" ,"content"});
	
	if( title == null || "".equals(title)) {
		String [] titles = titleMap.get(name);
		if( titles == null ) {
			title = "<font color=\"red\">Title 없음</font>";
		} else {
			title = titles[0];
		}
	}

%>
<th id="id_th_<%= name %>"><%= title %><%= "Y".equals(require) ? "<img src='../images/common/bl_star_01.png'/>" : "" %></th>
<td class="detail" id="id_td_<%= name %>" <%= colspan!=null ? "colspan=\""+ colspan +"\"": "" %>><span id="id_<%= form %>_<%= name %>"></span>
	<span><jsp:doBody></jsp:doBody></span>
</td>
<% } else if( area.equalsIgnoreCase("span") ) {%>
<span id="id_<%= form %>_<%= name %>"></span>
<span><jsp:doBody></jsp:doBody></span>
<% } else { %>
	<%
		String []   arr = HtmlUtil.replaceNull(value).split("\r\n");
	%>
	var arr<%= name %> = new Array;
	<% for( int i=0 ; i<arr.length;  i++) { %>
		arr<%= name %>.push('<%= arr[i] %>');
	<% } %>
	Ext.create('Ext.form.field.TextArea', {
		renderTo : 'id_<%= form %>_<%= name %>',
		id : 'cmp_<%= form %>_<%= name %>_ta',
		name : '<%= name %>',
		multiline: true,
        width : <%= "".equals(width) ? "500" : ""+ width  %>, 
        height : <%= "".equals(width) ? "100" : ""+ height  %>, 
        
		allowBlank : <%= "Y".equals(require) ? "false" : "true" %>,
		<%= !"".equals(HtmlUtil.replaceNull(maxLength)) ? "maxLength : " + maxLength + "," :"" %>
        <%= !"".equals(HtmlUtil.replaceNull(append)) ? append :"" %>
		value : arr<%= name %>.join('\n')
	}).validate();
	cmps['<%= form %>'] = cmps['<%= form %>']||[];    
    cmps['<%= form %>'].push('cmp_<%= form %>_<%= name %>_ta');
			
<% } %>