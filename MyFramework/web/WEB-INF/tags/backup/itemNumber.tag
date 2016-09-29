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
<%@ attribute name="min" type="java.lang.String" %>
<%@ attribute name="max" type="java.lang.String" %>
<%@ attribute name="append" type="java.lang.String" %><%-- 추가 적으로 부여하고 싶은 Extjs속성 (문자열의 마지막은 ,로종료) --%>

<% if( area.equalsIgnoreCase("html") ) { 

	HashMap<String, String[]> titleMap = new HashMap<String, String[]>();
	
	titleMap.put("memberCode", new String [] {"학생명" ,"memberCode"});
	titleMap.put("applyLessonCnt", new String [] {"적용 레슨/개월 수" ,"applyLessonCnt"});
	titleMap.put("applyLessonCnt1", new String [] {"적용 레슨/개월 수" ,"applyLessonCnt1"});
	titleMap.put("voucherName", new String [] {"바우처명" ,"voucherName"});
	titleMap.put("vaildTrm", new String [] {"유효기간" ,"vaildTrm"});
	titleMap.put("applyLessonCnt", new String [] {"적용 레슨 수" ,"applyLessonCnt"});
	titleMap.put("lcmsProductName", new String [] {"LCMS 상품명" ,"lcmsProductName"});
	titleMap.put("grantStdDesc", new String [] {"부여기준" ,"grantStdDesc"});
	titleMap.put("salePrdName", new String [] {"판매상품명" ,"salePrdName"});
	titleMap.put("sampleTitle", new String [] {"타이틀" ,"sampleTitle"});
	titleMap.put("lessonCount", new String [] {"레슨/주차 수" ,"lessonCount"});
	
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
<td class="detail" id="id_td_<%= name %>"  <%= colspan!=null ? "colspan=\""+ colspan +"\"": "" %>><div><span id="id_<%= form %>_<%= name %>" style="display:inline-block; vertical-align:middle;float: left;"></span> <span style="float: left;"><jsp:doBody></jsp:doBody></span>	</div>	
</td>
<% } 
//span only
else if( area.equalsIgnoreCase("span") ) {
%>	
<span id="id_<%= form %>_<%= name %>"  style="float:left;"></span>&nbsp;<span style="display:inline-block; vertical-align:middle;float:left;"></span> <span style="float: left;"><jsp:doBody></jsp:doBody></span>
<%
} 
//grid editor
else if( area.equalsIgnoreCase("grid")  ) { %>
	
	{
	    width : <%= HtmlUtil.replaceNull(width, "250") %>,
		allowOnlyWhitespace : <%= "Y".equals(require) ? "false" : "true" %>,
        minValue : <%= !"".equals(HtmlUtil.replaceNull(min)) ?  min :"0" %>,
        <%= !"".equals(HtmlUtil.replaceNull(max)) ? "maxValue : " + max + "," :"" %>
        <%= !"".equals(HtmlUtil.replaceNull(append)) ? append :"" %>
	    xtype: 'numberfield',
		listeners: {
				keyup : function(_this, e) {
			        var code = e.browserEvent.keyCode;
			        if (!(code >= 48 && code <= 57) && !(code >= 96 && code <= 105) && code !== 46 && code !== 8) {
			        	e.stopEvent();
			        }
			    },
			    change : function(_this, newValue, oldValue ) {
			    	var val = newValue ==null ? '' : newValue.toString() ;
			      	_this.setValue(val.replace(/[^0-9]/g, ''))
			    }
			}
	}
<%	 
//javascript editor
 } else { %>
	Ext.create('Ext.form.NumberField', {
		renderTo : 'id_<%= form %>_<%= name %>',
		id : 'cmp_<%= form %>_<%= name %>_nf',
		name : '<%= name %>',
		allow: '0123456789.',
		style : "ime-mode:disabled",
        minValue : <%= !"".equals(HtmlUtil.replaceNull(min)) ?  min :"0" %>,
        <%= !"".equals(HtmlUtil.replaceNull(max)) ? "maxValue : " + max + "," :"" %>
        width : <%= HtmlUtil.replaceNull(width, "250") %>,
        <%= "Y".equals(require) ? "emptyText : Ext.form.TextField.prototype.blankText , " : "" %> 
		allowOnlyWhitespace : <%= "Y".equals(require) ? "false" : "true" %>,
		enableKeyEvents: true,
		value : '<%= HtmlUtil.replaceNull(value) %>',
        <%= !"".equals(HtmlUtil.replaceNull(append)) ? append :"" %>
		xtype: 'numberfield',
		listeners: {
				keyup : function(_this, e) {
			        var code = e.browserEvent.keyCode;
			        if (!(code >= 48 && code <= 57) && !(code >= 96 && code <= 105) && code !== 46 && code !== 8) {
			        	e.stopEvent();
			        }
			    },
			    change : function(_this, newValue, oldValue ) {
			    	var val = newValue ==null ? '' : newValue.toString() ;
			      	_this.setValue(val.replace(/[^0-9]/g, ''))
			    }
			}
	}).validate();
	cmps['<%= form %>'] = cmps['<%= form %>']||[];    
    cmps['<%= form %>'].push('cmp_<%= form %>_<%= name %>_nf');
<% } %>