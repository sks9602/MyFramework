<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag
	import="pjt.epolylms.util.HtmlUtil"
	import="java.util.HashMap"
	import="java.util.Map"
	import="java.util.List"
	import="java.util.Calendar"
%>

<%@ attribute name="title" type="java.lang.String"  %>
<%@ attribute name="area" type="java.lang.String" required="true" %> <%-- html / script / grid / span 중 택1 --%>
<%@ attribute name="view" type="java.lang.String"  %><%--  combo(default) / select(=combo) / radio / checkbox / tree --%>
<%@ attribute name="multiple" type="java.lang.String" %><%-- 멀티 : 'Y' multiple / '기타' : 단일   --%>
<%@ attribute name="require" type="java.lang.String" %><%-- 필수여부 : 'Y'필수 / 'N'선택  --%>
<%@ attribute name="groupCode" type="java.lang.String" required="true" %>
<%@ attribute name="name" type="java.lang.String" required="true"  %>
<%@ attribute name="value" type="java.lang.String" %>
<%@ attribute name="colspan" type="java.lang.String" %>
<%@ attribute name="width" type="java.lang.String" %>
<%@ attribute name="form" type="java.lang.String" %>
<%@ attribute name="function" type="java.lang.String" %><%-- 실행 할 function --%>
<%@ attribute name="head" type="java.lang.String" %><%--  "none"(default) / "all" -> "-전체-" / "choice" -> "-선택-"   --%>
<%@ attribute name="cascadeName" type="java.lang.String" %>
<%@ attribute name="append" type="java.lang.String" %><%-- 추가 적으로 부여하고 싶은 Extjs속성 (문자열의 마지막은 ,로종료) --%>
<%@ attribute name="treeLevel" type="java.lang.String" %><%-- combobox시 해당 level의 값을 표시 --%>
<%@ attribute name="forceWidth" type="java.lang.String"  %>
<jsp:useBean id="seh" class="systemwiz.jfw.jsp.SessionHelper" />
<%
	seh.getSession(request, false);

	String HO_T_SYS_MEMBER_NO = seh.get("S_MEMBER_NO");
	String HO_T_SYS_LANG = "KR"; // seh.get("S_LANG");	// en,it,de,ru, ko
	String HO_T_SYS_COMP = seh.get("S_COMP");	// 0001
	
%>

<% if( area.equalsIgnoreCase("html") ) {
	HashMap<String, String[]> titleMap = new HashMap<String, String[]>();

	titleMap.put("pagePerRows", new String [] {"목록개수" ,"pagePerRows"});
	titleMap.put("yearCode", new String [] {"년도" ,"yearCode"});	// 확인
	titleMap.put("productClassify", new String [] {"상품 분류" ,"productClassify"});
	titleMap.put("useYn", new String [] {"사용여부" ,"useYn"});
	titleMap.put("voucherTypeCode", new String [] {"바우처유형" ,"voucherTypeCode"});
	titleMap.put("voucherSeq", new String [] {"바우처명" ,"voucherSeq"});
	titleMap.put("voucherApplyCode", new String [] {"적용구분" ,"voucherApplyCode"});
	titleMap.put("level", new String [] {"레벨" ,"level"});
	titleMap.put("courseCode", new String [] {"과정" ,"courseCode"});
	titleMap.put("applyStdCode", new String [] {"적용기준" ,"applyStdCode"});
	titleMap.put("grantStdDesc", new String [] {"부여기준" ,"grantStdDesc"});
	titleMap.put("paymentStt", new String [] {"결제 상태" ,"paymentStt"});
	titleMap.put("clientCode", new String [] {"캠퍼스" ,"clientCode"});
	titleMap.put("termGbn", new String [] {"학기" ,"termGbn"});
	titleMap.put("productGbnCode", new String [] {"상품구분" ,"productGbnCode"});
	titleMap.put("checkSttCode", new String [] {"검수상태" ,"checkSttCode"});
	titleMap.put("processYn", new String [] {"처리여부" ,"processYn"});
	titleMap.put("notificationYn", new String [] {"통보여부" ,"notificationYn"});
	titleMap.put("rcptGbnCode", new String [] {"접수구분" ,"rcptGbnCode"});
	titleMap.put("testYearCode", new String [] {"년도" ,"testYearCode"});
	titleMap.put("errorGbnCode", new String [] {"장애분류" ,"errorGbnCode"});
	titleMap.put("learningYearCode", new String [] {"년도" ,"learningYearCode"});
	titleMap.put("termGbn", new String [] {"학기" ,"termGbn"});
	titleMap.put("endYn", new String [] {"종료선택" ,"endYn"});
	titleMap.put("currencyUnitCode", new String [] {"화폐단위" ,"currencyUnitCode"});
	titleMap.put("sexCode", new String [] {"성별" ,"sexCode"});
	titleMap.put("representYn", new String [] {"대표여부" ,"representYn"});
	titleMap.put("freeChargePlcyUseYn", new String [] {"무료정책 사용여부" ,"freeChargePlcyUseYn"});
	titleMap.put("saleYn", new String [] {"판매여부" ,"saleYn"});
	titleMap.put("voucherIssueCode", new String [] {"바우처 발행" ,"voucherIssueSeq"});
	titleMap.put("paymentStt", new String [] {"결제상태" ,"paymentStt"});
	titleMap.put("salePrdId", new String [] {"판매상품명" ,"salePrdId"});
	titleMap.put("salePrdIdSp", new String [] {"별도상품명" ,"salePrdIdSp"});
	titleMap.put("requireSiteCode", new String [] {"폴리구분" ,"requireSiteCode"});
	titleMap.put("refundStt", new String [] {"환불상태" ,"refundStt"});
	titleMap.put("paymentRefund", new String [] {"결제/환불" ,"paymentRefund"});
	titleMap.put("targetCourseCode", new String [] {"대상레벨" ,"targetCourseCode"});
	titleMap.put("recommendCourseCode", new String [] {"추천레벨" ,"RecommendcourseCode"});
	titleMap.put("bankCode", new String [] {"환불 은행" ,"bankCode"});
	titleMap.put("studentSttBrn", new String [] {"구분" ,"studentSttBrn"});
	titleMap.put("refundRsn", new String [] {"환불 사유" ,"refundRsn"});
	titleMap.put("studentGbn", new String [] {"학생구분" ,"studentGbn"});
	titleMap.put("returneeYn", new String [] {"귀국여부" ,"returneeYn"});
	titleMap.put("refundCnclRsn", new String [] {"환불취소사유" ,"refundCnclRsn"});
	titleMap.put("pointGbnCode", new String [] {"발생구분" ,"pointGbnCode"});
	titleMap.put("classCode", new String [] {"클래스" ,"classCode"});
	titleMap.put("monthCode", new String [] {"월" ,"monthCode"});
	titleMap.put("answerCode", new String [] {"응답정보" ,"answerCode"});
	titleMap.put("multiCourseYn", new String [] {"복수수강여부" ,"multiCourseYn"});
	titleMap.put("pointCate", new String [] {"Category" ,"pointCate"});
	titleMap.put("productType", new String [] {"상품유형" ,"productType"});
	titleMap.put("gradeGbn", new String [] {"학년" ,"gradeGbn"});
	titleMap.put("lmsCode", new String [] {"LMS 구분" ,"lmsCode"});
	titleMap.put("BadgeRnkCode", new String [] {"Badge Rank" ,"BadgeRnkCode"});
	titleMap.put("refundStt1", new String [] {"상세 환불상태" ,"refundStt1"});
	titleMap.put("refundStt2", new String [] {"최종 환불상태" ,"refundStt2"});
	titleMap.put("", new String [] {"" ,""});
	
	if( title == null || "".equals(title)) {
		String [] titles = titleMap.get(name);
			
		if( titles == null ) {
			title = "<font color=\"red\">Title 없음</font>";
		} else {
			title = titles[0];
		}
	}

%>
<th id="id_th_<%= name %>"><%= title %><%= "Y".equals(require) ? "<img src='../images/common/bl_star_01.png'/>" : ("Y".equals(multiple) ? "<img src='../images/common/bl_multi_01.png'/>" : "") %></th>
<td class="detail" id="id_td_<%= name %>" <%= colspan!=null ? "colspan=\""+ colspan +"\"": "" %>><span id="id_<%= form %>_<%= name %>"></span></td>
<% } 
//span only
else if( area.equalsIgnoreCase("span") ) {
%>	
<span id="id_<%= form %>_<%= name %>"></span>
<% }
// div only
else if( area.equalsIgnoreCase("div") ) {
%>	
<div id="id_<%= form %>_<%= name %>"></div>
<% }
	
// grid editor
else if( area.equalsIgnoreCase("grid") ) {
	// 코드 목록 조회
	List<Map<String, String>> codeList = ((HashMap<String, List<Map<String, String>>>) application.getAttribute("KPS_COMMON_CODE_MAP_ATTR")).get(groupCode+ "-" + HO_T_SYS_LANG);
	Map<String, String> codeMap = null;
	boolean first = true;
%>
	<% if( view==null || "".equals(view) || "combo".equals(view) || "select".equals(view) ) { %>
			{
	                xtype: 'combobox',
		            name: '<%= name %>',
		            width : <%= "Y".equals(HtmlUtil.replaceNull(forceWidth)) ? HtmlUtil.replaceNull(width, "200") : HtmlUtil.maxWidth(width) %>,
					allowBlank : <%= "Y".equals(require) ? "false" : "true" %>,
					store: Ext.create('Ext.data.SimpleStore', {
						id : 'grid_store_combo_<%= name %>',
			            fields: ['SYSTEM_CODE', 'COMMON_CODE', 'CODE', 'NAME'],
			            data: [
			            <%
			            	if( "all".equals(head)  ) {
			            		first = false;
			    	    %>
				           		['', '', '','-<%= "all".equals(head) ? "전체" :"선택"  %>-']
			            <%
			            	}
			            	for( int i=0 ; codeList!= null && i<codeList.size() ; i++ ) {
			            		codeMap  = codeList.get(i);
			            %>
			           		<%= !first ? "," : ""  %>['<%=codeMap.get( "SYSTEM_CODE") %>', '<%= codeMap.get("COMMON_CODE") %>', '<%= codeMap.get("CODE") %>','<%= codeMap.get("NAME") %>']
			            <%		
		        				first = false;
			            	}            
			            %>
					    ],
					    sortInfo: {field: 'NAME', direction: 'ASC'}
					}),
				    queryMode: 'local',
				    displayField: 'NAME',
				    valueField: 'CODE',
				    // editable : false,
				    // hiddenName: '<%= name %>',
				     hiddenName: '<%= name %>Value',
		            typeAhead: true,
		            autoSelect: true,
					forceSelection :true,
				    value : '<%= HtmlUtil.replaceNull(value) %>',
        			<%= !"".equals(HtmlUtil.replaceNull(append)) ? append :"" %>
				    listeners: {
				    	<%= HtmlUtil.replaceNull(function)  %>
				    }
			 },
			 renderer : function(value) {
			 	var store = Ext.getStore('grid_store_combo_<%= name %>');
			 	
			 	var index = store.findExact('CODE', value);
			 	if (index != -1) {
            		return store.getAt(index).get("NAME");
        		} else {
        			return value;
        		}
			 }
	
	<% } %>
<%
} 
// javascript editor
else { 
	// 코드 목록 조회
	List<Map<String, String>> codeList = ((HashMap<String, List<Map<String, String>>>) application.getAttribute("KPS_COMMON_CODE_MAP_ATTR")).get(groupCode+ "-" + HO_T_SYS_LANG);
	Map<String, String> codeMap = null;
	boolean first = true;
	
	// 값이 지정되지 않은 경우 초기값 설정.
	if( "".equals(HtmlUtil.replaceNull(value))) {
		Calendar cal = Calendar.getInstance() ;
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH);
		
		// 학습년도
		if( "learningYearCode".equals(name)) {
			// 1~2월 인경우
			if(month<2){
				value = String.valueOf(year-1);
			} 
			// 3 ~ 12월
			else {
				value = String.valueOf(year);
			}
		} 
		// 학기구분
		else if ("termGbn".equals(name)) {
			
			// 1/2, 7~ 월 인경우.
			if(month<=1 || month>=8){
				value = "02";
			} 
			// 1~2, 9~12월 인 경우
			else {
				value = "01";
			}
		}
	}
%>

        
	<% if( view==null || "".equals(view) || "combo".equals(view) || "select".equals(view) ) { %>
		<% if("courseCode".equals(name)) { 
			HashMap<String, String[]> rootMap = new HashMap<String, String[]>();

			rootMap.put("courseCode", new String [] {"과정" ,"treeCourseCode"});
			
			String [] rootNames = rootMap.get(name);
			String rootName = "";
			if(rootNames!=null) {
				rootName = rootNames[0];
			}
		%> 
			Ext.create('Ext.ux.TreeCombo', {
				renderTo: 'id_<%= form %>_<%= name %>',
	            id : 'cmp_<%= form %>_<%= name %>_cb',
	            width : <%= HtmlUtil.maxWidth(width) %>,
	        	<%= "Y".equals(require) ? "emptyText : Ext.form.ComboBox.prototype.blankText , " : "" %> 
				<%= "Y".equals(require) ? "allowBlank : false, " : "" %>
	            name: '<%= name %>',
	            hiddenName: '<%= name %>Value',
	            value : '<%= HtmlUtil.replaceNull(value) %>',
				typeAhead: false,
				multiselect : <%= "Y".equals(multiple) ? "true" : "false" %>,
				minChars : 0,
				triggerAction: 'all',
	            listeners : {
	            	'itemclick' : function(me, record, item, index, e, eOpts, records, values) {
	            		Ext.get(item.id).focus();
	        		}
	            },
				store: Ext.create('Ext.data.TreeStore', {
						root : {
							name : "<%=rootName %>",
							text : "Root",
							expanded: true
						},
						autoLoad: true,
						autoSync: true,
						fields : ['id', 'text', 'name', {name: 'disabled', type:'bool', defaultValue:false}  ],
						proxy   : {
						    type : 'ajax',
						    extraParams : { 
								name : '<%= name %>',
								multiple : '<%= HtmlUtil.replaceNull(multiple) %>'
							},
						    url  : '../json/TreeJson.jsp',
						    reader: {
						        type: 'json'
						    }
						},
						folderSort: false
					})
			}).validate();
	        cmps['<%= form %>'] = cmps['<%= form %>']||[];     
	        cmps['<%= form %>'].push('cmp_<%= form %>_<%= name %>_cb');
		<% } else { %>
			<% if("Y".equals(multiple)) { %>
			Ext.create('Ext.ux.form.field.BoxSelect', {
	                renderTo : 'id_<%= form %>_<%= name %>',
	                id: 'cmp_<%= form %>_<%= name %>_cb',
	                name: '<%= name %>',
			    	hiddenName: '<%= name %>Value',
					msgTarget: 'title',
	            	width : <%= "Y".equals(HtmlUtil.replaceNull(forceWidth)) ? HtmlUtil.replaceNull(width, "200") : HtmlUtil.maxWidth(width) %>,
	        		<%= "Y".equals(require) ? "emptyText : Ext.form.ComboBox.prototype.blankText , " : "" %> 
	                <%= "Y".equals(require) ? "allowBlank : false, editable: false, " : "" %>
	                queryMode: 'local',
	                displayField: 'NAME',
	                displayFieldTpl: '{NAME} ({CODE})',
	                valueField: 'CODE',
	                forceSelection :true,
	                value :  [<%= HtmlUtil.spiltAndConcat(value) %>],
	                store: new Ext.data.SimpleStore({
		            fields: ['SYSTEM_CODE', 'COMMON_CODE', 'CODE', 'NAME'],
		            data: [
		            <%
	            		if( "all".equals(head) ) {
	            			first = false;
		    	    %>
			           		['', '', '','-<%= "all".equals(head) ? "전체" :"선택"  %>-']
		            <%
	            		}
		            	for( int i=0 ; codeList!= null && i<codeList.size() ; i++ ) {
		            		codeMap  = codeList.get(i);
		            		// tree level이 1인 코드 조회)
		            		if( !HtmlUtil.replaceNull(treeLevel,"1").equals(codeMap.get("TREE_LEVEL")))  {
		            			continue;
		            		}
		            %>
		           		<%= !first ? "," : ""  %>['<%=codeMap.get( "SYSTEM_CODE") %>', '<%= codeMap.get("COMMON_CODE") %>', '<%= codeMap.get("CODE") %>','<%= codeMap.get("NAME") %>']
		            <%		
		            		first = false;
		            	}            
		            %>
				    ],
				    sortInfo: {field: 'NAME', direction: 'ASC'}
		        }),
	        	<%= !"".equals(HtmlUtil.replaceNull(append)) ? append :"" %>
			    listeners: {
	            	expand : function() {
			    		fs_HideFile();
			    	},
	            	collapse : function() {
			    		fs_ShowFile();
			    	} 
			    	<% if( !"".equals(HtmlUtil.replaceNull(cascadeName )))  { %>
			    	, change : function (_this, newValue, oldValue, eOpts) {
			    		try {Ext.getCmp('cmp_<%= form %>_<%=cascadeName %>_cb').setValue('');} catch(E) {}
				    	try {Ext.getCmp('cmp_<%= form %>_<%=cascadeName %>_cb').store.clearFilter( );} catch(E) {}
						try {Ext.getCmp('cmp_<%= form %>_<%=cascadeName %>_cb').store.filter('UP_CODE',newValue);} catch(E) {}
						// try {Ext.getCmp('cmp_<%= form %>_<%=cascadeName %>_cb').store.filterBy( function(rec) { return rec.get('UP_CODE') === newValue || rec.get('UP_CODE') ==''; } ); } catch(E) {}
						
			    	<% }  %>
			    	
			    	<%= ((!"".equals(HtmlUtil.replaceNull(cascadeName )) &&  !"".equals(HtmlUtil.replaceNull(function))) ? "," : "") + HtmlUtil.replaceNull(function)  %>
			    }
	        }).validate();
	        
	        cmps['<%= form %>'] = cmps['<%= form %>']||[];     
	        cmps['<%= form %>'].push('cmp_<%= form %>_<%= name %>_cb');
			<% } else { %>
			Ext.create('Ext.form.field.ComboBox', {
	            renderTo : 'id_<%= form %>_<%= name %>',
	            id: 'cmp_<%= form %>_<%= name %>_cb',
	            name: '<%= name %>',
	            hiddenName: '<%= name %>Value',
	            typeAhead: true,
	            autoSelect: true,
				forceSelection :true,
	            width : <%= "Y".equals(HtmlUtil.replaceNull(forceWidth)) ? HtmlUtil.replaceNull(width, "200") : HtmlUtil.maxWidth(width) %>,
	        	<%= "Y".equals(require) ? "emptyText : Ext.form.ComboBox.prototype.blankText , " : "" %> 
				allowBlank : <%= "Y".equals(require) ? "false" : "true" %>,
				<%// = "Y".equals(require) ? " editable: false, triggerAction: 'all', " : ""%>
				store: Ext.create('Ext.data.SimpleStore', {
		            fields: ['SYSTEM_CODE', 'COMMON_CODE', 'CODE', 'NAME', 'TREE_ID_HIER'],
		            data: [
		            <%
		            	if( "all".equals(head) ) {
		            		first = false;
		    	    %>
			           		['', '', '','-<%= "all".equals(head) ? "전체" :"선택"  %>-']
		            <%
		            	}
		            	for( int i=0 ; codeList!= null && i<codeList.size() ; i++ ) {
		            		codeMap  = codeList.get(i);
		            		// tree level이 1인 코드 조회)
		            		if( !HtmlUtil.replaceNull(treeLevel,"1").equals(codeMap.get("TREE_LEVEL")))  {
		            			continue;
		            		}
		            %>
		           		<%= !first ? "," : ""  %>['<%=codeMap.get( "SYSTEM_CODE") %>', '<%= codeMap.get("COMMON_CODE") %>', '<%= codeMap.get("CODE") %>','<%= codeMap.get("NAME") %>', '<%= codeMap.get("TREE_ID_HIER") %>']
		            <%		
	        				first = false;
		            	}            
		            %>
				    ],
				    sortInfo: {field: 'NAME', direction: 'ASC'}
				}),
			    queryMode: 'local',
			    displayField: 'NAME',
			    valueField: 'CODE',
			    value : '<%= HtmlUtil.replaceNull(value) %>',
	        	<%= !"".equals(HtmlUtil.replaceNull(append)) ? append :"" %>
			    listeners: {
	            	expand : function() {
			    		fs_HideFile();
			    	},
	            	collapse : function() {
			    		fs_ShowFile();
			    	} 
			    	<% if( !"".equals(HtmlUtil.replaceNull(cascadeName )))  { %>
			    	, change : function (_this, newValue, oldValue, eOpts) {
				    	if(newValue == null || newValue == ''){
					    	this.lastSelection = [];
					    	this.doQueryTask.cancel();
				        	this.assertValue();
					    }
			    		try {Ext.getCmp('cmp_<%= form %>_<%=cascadeName %>_cb').setValue('');} catch(E) {}
				    	try {Ext.getCmp('cmp_<%= form %>_<%=cascadeName %>_cb').store.clearFilter( );} catch(E) {}
				    	try {
							Ext.getCmp('cmp_<%= form %>_<%=cascadeName %>_cb').store.filter([
							    {property: "UP_CODE", value: _this.getStore().findRecord( 'CODE' , newValue).get('TREE_ID_HIER') },
							    {filterFn: function(rec) {return rec.get('UP_CODE') === _this.getStore().findRecord( 'CODE' , newValue).get('TREE_ID_HIER'); } }
							]);
						} catch(e) {}
						// try {Ext.getCmp('cmp_<%= form %>_<%=cascadeName %>_cb').store.filter('UP_CODE',_this.getStore().findRecord( 'CODE' , newValue).get('TREE_ID_HIER'));} catch(E) {}
						// try {Ext.getCmp('cmp_<%= form %>_<%=cascadeName %>_cb').store.filterBy( function(rec) { return rec.get('UP_CODE') === _this.getStore().findRecord( 'CODE' , newValue).get('TREE_ID_HIER')); || rec.get('UP_CODE') ==''; } ); } catch(E) {}
					}
			    	<% }  %>
			    	
			    	<%= ( !"".equals(HtmlUtil.replaceNull(function)) ? "," : "") + HtmlUtil.replaceNull(function)  %>
			    }
			}).validate(); 
	        cmps['<%= form %>'] = cmps['<%= form %>']||[];     
	        cmps['<%= form %>'].push('cmp_<%= form %>_<%= name %>_cb');
			<% } %>
		<% } %>
	<% } else if( "radio".equals(view) ) { %>
	
		Ext.create('Ext.form.RadioGroup', {
            renderTo: 'id_<%= form %>_<%= name %>',
            id : 'cmp_<%= form %>_<%= name %>_rg',
            width : <%= "Y".equals(HtmlUtil.replaceNull(forceWidth)) ? HtmlUtil.replaceNull(width, "200") : HtmlUtil.maxWidth(width) %>,
            name : '<%= name %>',
        	<%= !"".equals(HtmlUtil.replaceNull(append)) ? append :"" %>
            items: [
	            <%
	            	for( int i=0 ; codeList!= null && i<codeList.size() ; i++ ) {
	            		codeMap  = codeList.get(i);
	            		// tree level이 1인 코드 조회)
	            		if( !HtmlUtil.replaceNull(treeLevel,"1").equals(codeMap.get("TREE_LEVEL")))  {
	            			continue;
	            		}
	            %>
	           		<%= i>0 ? "," : ""  %>{name : '<%= name %>', boxLabel:  '<%= codeMap.get("NAME") %>', inputValue: '<%= codeMap.get("CODE") %>', checked: <%= (HtmlUtil.replaceNull(value).replaceAll(" ","")+",").indexOf(codeMap.get("CODE")) >=0 ? "true" : "false" %> }
	            <%		
	            	}            
	            %>
            ]
        });
        cmps['<%= form %>'] = cmps['<%= form %>']||[];     
        cmps['<%= form %>'].push('cmp_<%= form %>_<%= name %>_rg');
        
	<% }  else if( "checkbox".equals(view) ) { %>
	
		Ext.create('Ext.form.CheckboxGroup', {
	        renderTo: 'id_<%= form %>_<%= name %>',
            id : 'cmp_<%= form %>_<%= name %>_cg',
            name : '<%= name %>',
            width : <%= "Y".equals(HtmlUtil.replaceNull(forceWidth)) ? HtmlUtil.replaceNull(width, "200") : HtmlUtil.maxWidth(width) %>,
	        <%= "Y".equals(require) ? "allowBlank : false, " : "" %>
        	<%= !"".equals(HtmlUtil.replaceNull(append)) ? append :"" %>
	        items: [
	        	<% if( "checkAll".equals(groupCode) ){ %>
		        	{name : '<%= name %>', xtype: 'checkbox' , checked:<%= !"".equals(HtmlUtil.replaceNull(value)) ? "true" :"false" %>}
	        	<% }else{ %>
	            <%
	            	for( int i=0 ; codeList!= null && i<codeList.size() ; i++ ) {
	            		codeMap  = codeList.get(i);
	            		// tree level이 1인 코드 조회)
	            		if( !HtmlUtil.replaceNull(treeLevel,"1").equals(codeMap.get("TREE_LEVEL")))  {
	            			continue;
	            		}
	            %>
	           		<%= i>0 ? "," : ""  %>{name : '<%= name %>', xtype: 'checkbox', boxLabel:  '<%= codeMap.get("NAME") %>', inputValue: '<%= codeMap.get("CODE") %>', checked: <%= (HtmlUtil.replaceNull(value).replaceAll(" ","")+",").indexOf(codeMap.get("CODE")) >=0 ? "true" : "false" %> }
	            <%		
	            	}            
	            %>
	        	<% } %>
	        ],
		    listeners: {
		    	<%= HtmlUtil.replaceNull(function)  %>
		    }
	    });
        cmps['<%= form %>'] = cmps['<%= form %>']||[];     
        cmps['<%= form %>'].push('cmp_<%= form %>_<%= name %>_cg');
    
	<% } %>
<% } %>
