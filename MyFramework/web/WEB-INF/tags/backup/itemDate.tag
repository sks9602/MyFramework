<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag
	import="pjt.epolylms.util.HtmlUtil"
	import="java.util.HashMap"
%>
<%@ attribute name="title" type="java.lang.String"  %>
<%@ attribute name="area" type="java.lang.String" required="true" %> <%-- html / script 중 택1 --%>
<%@ attribute name="require" type="java.lang.String" %><%-- dual일 경우 , 로 구분, 필수여부 : 'Y' - 필수 / '기타' 선택  --%>
<%@ attribute name="name" type="java.lang.String"  required="true" %><%--  dual일 경우 name+"StartDt" / name+"EndDt" --%>
<%@ attribute name="value" type="java.lang.String" %><%--  dual일 경우 "," 로 구분 ("YYYYMMDD","year","month", "week", "today" ) / mono 일 경우  ("YYYYMMDD", "today" ) --%>
<%@ attribute name="colspan" type="java.lang.String" %>
<%@ attribute name="period" type="java.lang.String" %><%-- 선택가능 기간 지정용도. mono 일 경우  ("YYYYMMDD", "YYYYMMDD" ) ..  --%>
<%@ attribute name="view" type="java.lang.String"  %><%--  dual : default (from ~ to) / mono --%>
<%@ attribute name="form" type="java.lang.String" %>
<%@ attribute name="combo" type="java.lang.String" %><%-- 없음 : null /  학기 : SEM / 일반(LastWeek/ThisWeek/Last30Dday/ThisSemester) : GEN --%>
<%@ attribute name="width" type="java.lang.String" %>


<% if( area.equalsIgnoreCase("html") ) { 

	HashMap<String, String[]> titleMap = new HashMap<String, String[]>();
	
	titleMap.put("memberCode", new String [] {"학생명" ,"memberCode"});
	titleMap.put("issueDate", new String [] {"발급일" ,"issueDate"});
	titleMap.put("exDate", new String [] {"만료일" ,"exDate"});
	titleMap.put("voucherUseDttm", new String [] {"사용일" ,"voucherUseDttm"});
	titleMap.put("useSrtDttm", new String [] {"사용시작일" ,"useSrtDttm"});
	titleMap.put("noticeDttm", new String [] {"신고일자" ,"noticeDttm"});
	titleMap.put("processDttm", new String [] {"처리일자" ,"processDttm"});
	titleMap.put("saleSrtEndDate", new String [] {"판매시작/종료일" ,"processDttm"});
	titleMap.put("purchaseDttm", new String [] {"결제등록일" ,"purchaseDttm"});
	titleMap.put("refundDecisionDttm", new String [] {"환불승인일" ,"refundDecisionDttm"});
	titleMap.put("refundPrcDttm", new String [] {"환불처리일" ,"refundPrcDttm"});
	titleMap.put("refundReqDttm", new String [] {"환불요청일" ,"refundReqDttm"});
	titleMap.put("changeDttm", new String [] {"발생일" ,"changeDttm"});
	titleMap.put("dateDttm", new String [] {"일자별" ,"dateDttm"});
	titleMap.put("retlSrtDttm", new String [] {"재수강 시작일자 " ,"retlSrtDttm"});
	titleMap.put("retlEndDttm", new String [] {"재수강 종료일자 " ,"retlEndDttm"});
	titleMap.put("retlSrtEndDttm", new String [] {"재수강일 " ,"retlSrtEndDttm"});
	titleMap.put("customDates", new String [] {"custom Dates" ,"customDates"});
	titleMap.put("refundDttm", new String [] {"환불등록일" ,"refundDttm"});
	
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
<td class="detail" id="id_td_<%= name %>" <%= colspan!=null ? "colspan=\""+ colspan +"\"": "" %>><% if( "dual".equals(view)) { %><% if(!"".equals(HtmlUtil.replaceNull(combo)) )  { %><span id="id_<%= form %>_<%= name %>_combo" style="display:inline-block; vertical-align:middle;"></span><span style="display:inline-block; vertical-align:middle;">&nbsp;&nbsp;</span><% }%> <span id="id_<%= form %>_<%= name %>_start_dt" style="display:inline-block; vertical-align:middle;"></span><span style="display:inline-block; vertical-align:middle;">&nbsp;~&nbsp;</span><span id="id_<%= form %>_<%= name %>_end_dt" style="display:inline-block; vertical-align:middle;"></span><% } else { %><div id="id_<%= form %>_<%= name %>" style="display:inline-block; vertical-align:middle;"></div><% } %></td>
<% } else if( area.equalsIgnoreCase("span") ) { %>
<% if( "dual".equals(view)) { %><% if(!"".equals(HtmlUtil.replaceNull(combo)) )  { %><span id="id_<%= form %>_<%= name %>_combo" style="display:inline-block; vertical-align:middle;"></span><span style="display:inline-block; vertical-align:middle;">&nbsp;&nbsp;</span><% }%> <span id="id_<%= form %>_<%= name %>_start_dt" style="display:inline-block; vertical-align:middle;"></span><span style="display:inline-block; vertical-align:middle;">&nbsp;~&nbsp;</span><span id="id_<%= form %>_<%= name %>_end_dt" style="display:inline-block; vertical-align:middle;"></span><% } else { %><div id="id_<%= form %>_<%= name %>" style="display:inline-block; vertical-align:middle;"></div><% } %>
<% } else { %>
	<% if( "dual".equals(view)) { 
		String [] requires = null;
		if( HtmlUtil.replaceNull(require).length()  > 0 ) {
			if( HtmlUtil.replaceNull(require).indexOf(",") >=0 ) {
				requires = HtmlUtil.replaceNull(require).split(",");
			} else {
				requires = new String[] {"N", "N"};
			}
		} else {
			requires = new String[] {"N", "N"};
		}
	%>
		<%-- 달력 From ~ to앞에  Period설정 combobox --%>
		<% if(!"".equals(HtmlUtil.replaceNull(combo)) )  { %> 
		Ext.create('Ext.form.field.ComboBox', {
            renderTo : 'id_<%= form %>_<%= name %>_combo',
            id: 'cmp_<%= form %>_<%= name %>_combo_cb',
            name: '<%= name %>_combo',
            hiddenName: '<%= name %>_combo',
            width : 110,
            value : '<%= HtmlUtil.replaceNull(value) %>',
			store: Ext.create('Ext.data.SimpleStore', {
	            fields: ['CODE', 'NAME'],
	            data: [
	            <% if("SEM".equals(HtmlUtil.replaceNull(combo)) )  {  %>
					['2014-1','2014년도 1학기'],['2014-2','2014년도 2학기']
	            <% } else { %>
					['TS','This Semester'],['LW','Last Week'],['L30','Last 30days'],['TW','This Week']
				<% } %>
			    ]
			}),
		    queryMode: 'local',
		    displayField: 'NAME',
		    valueField: 'CODE',
		    listeners : {
		    	change : function(_this, newValue , oldValue) {
		    		Ext.getCmp('cmp_<%= form %>_<%= name %>_start_dt').setComboValue(newValue);
		    		Ext.getCmp('cmp_<%= form %>_<%= name %>_end_dt').setComboValue(newValue);
		    		
		    	}
		    }
		});
		<% }%>
		Ext.create('Ext.ux.PeriodDate', {
			renderTo : 'id_<%= form %>_<%= name %>_start_dt', 
			id : 'cmp_<%= form %>_<%= name %>_start_dt',
			name      : '<%= name %>SrtDt',
			allowBlank : <%= "Y".equals(requires[0]) ? "false" : "true" %>,
			width : 110,
			edDtId : 'cmp_<%= form %>_<%= name %>_end_dt',
			format: 'Y-m-d',
			value : '<%= HtmlUtil.replaceNull(value) %>'
		}).validate();;
        cmps['<%= form %>'] = cmps['<%= form %>']||[];     
	    cmps['<%= form %>'].push('cmp_<%= form %>_<%= name %>_start_dt');
		Ext.create('Ext.ux.PeriodDate', {
			renderTo : 'id_<%= form %>_<%= name %>_end_dt',
			id : 'cmp_<%= form %>_<%= name %>_end_dt',
			name      : '<%= name %>EndDt',
			allowBlank : <%= "Y".equals(requires[0]) ? "false" : "true" %>,
			width : 110,
			stDtId : 'cmp_<%= form %>_<%= name %>_start_dt',
			format: 'Y-m-d',
			value : '<%= HtmlUtil.replaceNull(value) %>'
		}).validate();;
        cmps['<%= form %>'] = cmps['<%= form %>']||[];     
        cmps['<%= form %>'].push('cmp_<%= form %>_<%= name %>_end_dt');
		
	<% } else { %>
		Ext.create('Ext.ux.form.field.Date', {
			renderTo : 'id_<%= form %>_<%= name %>', 
			id : 'cmp_<%= form %>_<%= name %>',
			name : '<%= name %>',
			format: 'Y-m-d',
			width : <%= HtmlUtil.replaceNull(width, "130") %>,
			allowBlank : <%= "Y".equals(require) ? "false" : "true" %>,
			<%= !"".equals(HtmlUtil.replaceNull(period)) ? "period : '"+period+"', " : "" %>
			value : '<%= HtmlUtil.replaceNull(value) %>'
		}).validate();;
		cmps['<%= form %>'] = cmps['<%= form %>']||[];   
        cmps['<%= form %>'].push('cmp_<%= form %>_<%= name %>');
	
	<% }  %>
	
<% } %>