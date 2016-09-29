<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag
	import="pjt.epolylms.util.HtmlUtil"
	import="java.util.HashMap"
%>
<%@ attribute name="title" type="java.lang.String"  %>
<%@ attribute name="area" type="java.lang.String" required="true" %> <%-- html / script / grid / span 중 택1 --%>
<%@ attribute name="require" type="java.lang.String" %><%-- 필수여부 : 'Y'필수 / '기타' 선택  --%>
<%@ attribute name="name" type="java.lang.String"  required="true" %>
<%@ attribute name="value" type="java.lang.String" %>
<%@ attribute name="vtype" type="java.lang.String" %>
<%@ attribute name="function" type="java.lang.String" %>
<%@ attribute name="colspan" type="java.lang.String" %>
<%@ attribute name="width" type="java.lang.String" %>
<%@ attribute name="form" type="java.lang.String" %>
<%@ attribute name="maxLength" type="java.lang.String" %><%-- 입력 가능 최대 길이 --%>
<%@ attribute name="append" type="java.lang.String" %><%-- 추가 적으로 부여하고 싶은 Extjs속성 (문자열의 마지막은 ,로종료) --%>
<%@ attribute name="errorView" type="java.lang.String" %>
<% if( area.equalsIgnoreCase("html") ) { 
	
	HashMap<String, String[]> titleMap = new HashMap<String, String[]>();
	
	titleMap.put("memberCode", new String [] {"학생명" ,"memberCode"});
	titleMap.put("memberName", new String [] {"학생명" ,"memberName"});
	titleMap.put("voucherName", new String [] {"바우처명" ,"voucherName"});
	titleMap.put("vaildTrm", new String [] {"유효기간" ,"vaildTrm"});
	titleMap.put("lcmsProductName", new String [] {"LCMS 상품명" ,"lcmsProductName"});
	titleMap.put("grantStdDesc", new String [] {"부여기준 설명" ,"grantStdDesc"});
	titleMap.put("badgeName", new String [] {"Badge 명" ,"worldMapName"});
	titleMap.put("salePrdName", new String [] {"판매상품명" ,"salePrdName"});
	titleMap.put("sampleTitle", new String [] {"타이틀" ,"sampleTitle"});
	titleMap.put("lessonCount", new String [] {"레슨수" ,"lessonCount"});
	titleMap.put("characterName", new String [] {"캐릭터명" ,"characterName"});
	titleMap.put("refundDecisionEmpname", new String [] {"환불승인자" ,"refundDecisionEmpname"});
	titleMap.put("worldMapName", new String [] {"월드명" ,"worldMapName"});
	titleMap.put("consumerName", new String [] {"결제자명" ,"consumerName"});
	titleMap.put("refundAccountNo", new String [] {"환불 계좌번호" ,"refundAccountNo"});
	titleMap.put("depositorName", new String [] {"환불 예금주" ,"depositorName"});
	titleMap.put("articleId", new String [] {"Article명" ,"articleId"});
	titleMap.put("contentName", new String [] {"컨텐츠명" ,"contentName"});
	titleMap.put("characterCode", new String [] {"캐릭터코드" ,"characterCode"});
	titleMap.put("title", new String [] {"제목" ,"title"});
	titleMap.put("paymentTotCode", new String [] {"통합결제코드" ,"paymentTotCode"});
	titleMap.put("landmarkName", new String [] {"랜드마크명" ,"paymentTotCode"});
	
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
<td class="detail" id="id_td_<%= name %>" <%= colspan!=null ? "colspan=\""+ colspan +"\"": "" %>><span id="id_<%= form %>_<%= name %>"></span><%  if(!"".equals(HtmlUtil.replaceNull(errorView))) { %><span id="id_<%= form %>_<%= name %>_err"></span><% } %>
	<span><jsp:doBody></jsp:doBody></span>
</td>
<% } 
//span only
else if( area.equalsIgnoreCase("span") ) {
%>	
<span id="id_<%= form %>_<%= name %>"></span>
<span><jsp:doBody></jsp:doBody></span>
<%
} 
//grid editor
else if( area.equalsIgnoreCase("grid")  ) { %>
	
	{
	    width : <%= HtmlUtil.replaceNull(width, "250") %>,
		allowOnlyWhitespace : <%= "Y".equals(require) ? "false" : "true" %>,
        <%= !"".equals(HtmlUtil.replaceNull(maxLength)) ? "maxLength : " + maxLength + "," :"" %>
        <%= !"".equals(HtmlUtil.replaceNull(append)) ? append :"" %>
	    xtype: 'textfield'
	}
<%	
} 
//javascript editor
else { %>
	Ext.create('Ext.form.field.Text', {
		renderTo : 'id_<%= form %>_<%= name %>',
		id : 'cmp_<%= form %>_<%= name %>_tf',
		name : '<%= name %>',
        width : <%= HtmlUtil.replaceNull(width, "250") %>,
        enableKeyEvents : true,
        <%  if(!"".equals(HtmlUtil.replaceNull(errorView))) { %>msgTarget : 'id_<%= form %>_<%= name %>_err', <% } %>       
        <%= "Y".equals(require) ? "emptyText : Ext.form.TextField.prototype.blankText , " : "" %> 
		allowOnlyWhitespace : <%= "Y".equals(require) ? "false" : "true" %>,
        <%= !"".equals(HtmlUtil.replaceNull(maxLength)) ? "maxLength : " + maxLength + "," :"" %>
        <%= !"".equals(HtmlUtil.replaceNull(append)) ? append :"" %>
		value : '<%= HtmlUtil.replaceNull(value) %>',
		listeners : {
			scope: this,
			keydown : function(_this, e, eOpts) {
				var k = e.getKey();
				
				if( k == e.ENTER ) {
					try {
						if( '<%= form %>'.indexOf('search') >= 0 ) {
							search();
						} else {
							e.stopEvent();
						}
					} catch(E) {
					
					}
				}
			}
		}
		
	}).validate();
	cmps['<%= form %>'] = cmps['<%= form %>']||[];    
    cmps['<%= form %>'].push('cmp_<%= form %>_<%= name %>_tf');
			
<% } %>