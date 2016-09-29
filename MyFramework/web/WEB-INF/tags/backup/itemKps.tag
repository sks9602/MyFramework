
<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag
	import="pjt.epolylms.util.HtmlUtil"
	import="java.util.HashMap"
	import="java.util.Map"
	import="java.util.List"
%>
<%--
    단위 시스템 명 : KPS 특화 tag file
    서브 시스템 명 : tag file
    프 로 그 램 명   : itemKps.tag
    작       성       자 : SKS
    작       성       일 : 2014/08/20
    설                  명 : KPS에 특화된 컴포넌트 생성 tag file
 ver      : 1.0
--%>
<%@ attribute name="title" type="java.lang.String"  %>
<%@ attribute name="name" type="java.lang.String"  %>
<%@ attribute name="area" type="java.lang.String" required="true" %> <%-- html / script 중 택1 --%>
<%@ attribute name="value" type="java.lang.String" %>
<%@ attribute name="subValue" type="java.lang.String" %>
<%@ attribute name="colspan" type="java.lang.String" %>
<%@ attribute name="width" type="java.lang.String" %>
<%@ attribute name="form" type="java.lang.String" %>
<%@ attribute name="function" type="java.lang.String" %><%-- 실행 할 function --%>
<%@ attribute name="groupCode" type="java.lang.String" %>
<%@ attribute name="subGroupCode" type="java.lang.String" %>
<%@ attribute name="head" type="java.lang.String" %><%--  "none"(default) / "all" -> "-전체-" / "choice" -> "-선택-"   --%>
<%@ attribute name="require" type="java.lang.String" %><%-- 필수여부 : 'Y'필수 / '기타' 선택  --%>
<%@ attribute name="cascadeName" type="java.lang.String" %>
<%@ attribute name="dependsName" type="java.lang.String"  %> <%-- Cascading대상  --%>
<%@ attribute name="nameGroup" type="java.lang.String"  %> <%-- for 문으로 name 을 고정할수없을경우 사용. --%>
<%@ attribute name="paramValues" type="java.lang.String"  %> <%-- sql 파라미터로 전송할 값 (,로 구분)--%>
<%@ attribute name="auth" type="java.lang.String"  %> <%-- 권한에 따른 구분이 필요한 경우. 'Y' / 기타 권한 미사용..--%>
<%@ attribute name="multiple" type="java.lang.String" %><%-- 멀티 : 'Y' multiple / '기타' : 단일   --%>

<jsp:useBean id="seh" class="systemwiz.jfw.jsp.SessionHelper" />
<jsp:useBean id="sh" class="systemwiz.jfw.sql.SqlHelper" />
<jsp:useBean id="hh" class="systemwiz.jfw.jsp.HtmlHelper" />
<%
	seh.getSession(request, false);

	String HO_T_SYS_MEMBER_NO = seh.get("S_MEMBER_NO");
	String HO_T_SYS_LANG = "KR"; // seh.get("S_LANG");	// en,it,de,ru, ko
	String HO_T_SYS_COMP = seh.get("S_COMP");	// 0001
	
	sh.setCompLangMember(S_COMP, HO_T_SYS_LANG, HO_T_SYS_MEMBER_NO);
	hh.setRequest(request);

%>

<% if( area.equalsIgnoreCase("html") ) {

	HashMap<String, String[]> titleMap = new HashMap<String, String[]>();
	
	titleMap.put("badgesBase", new String [] {"Badge<br/>부여 기준" ,"badgesBase"});
	titleMap.put("applyLessonCnt", new String [] {"적용 레슨/개월 수" ,"applyLessonCnt"});
	titleMap.put("applyLessonCnt1", new String [] {"적용 레슨/개월 수" ,"applyLessonCnt1"});
	titleMap.put("voucherName", new String [] {"바우처명" ,"voucherName"});
	titleMap.put("vaildTrm", new String [] {"유효기간" ,"vaildTrm"});
	titleMap.put("applyLessonCnt", new String [] {"적용 레슨 수" ,"applyLessonCnt"});
	titleMap.put("lcmsProductName", new String [] {"LCMS 상품명" ,"lcmsProductName"});
	titleMap.put("grantStdDesc", new String [] {"부여기준" ,"grantStdDesc"});
	titleMap.put("salePrdName", new String [] {"판매상품명" ,"salePrdName"});
	titleMap.put("sampleTitle", new String [] {"타이틀" ,"sampleTitle"});
	titleMap.put("lessonCount", new String [] {"레슨수" ,"lessonCount"});
	titleMap.put("discountRate", new String [] {"할인율(%)" ,"discountRate"});
	titleMap.put("productGbnCode", new String [] {"상품구분" ,"productGbnCode"});
	titleMap.put("voucherSeq", new String [] {"바우처명" ,"voucherSeq"});
	titleMap.put("salePrdId", new String [] {"판매상품명" ,"salePrdId"});
	titleMap.put("salePrdIdSp", new String [] {"별도상품명" ,"salePrdIdSp"});
	titleMap.put("clientUp", new String [] {"지사" ,"clientUp"});
	titleMap.put("clientUpCode", new String [] {"지사/캠퍼스" ,"clientUpCode"});
	titleMap.put("clientUpCodeClass", new String [] {"지사/캠퍼스/Class" ,"clientUpCodeClass"});
	titleMap.put("clientCode", new String [] {"캠퍼스" ,"clientCode"});
	titleMap.put("clientCodeClass", new String [] {"캠퍼스/Class" ,"clientCode"});
	titleMap.put("clientClass", new String [] {"Class" ,"clientClass"});
	titleMap.put("lessonCodeSrt", new String [] {"판매상품 시작레슨" ,"lessonCodeSrt"});
	titleMap.put("lessonCodeSrtSp", new String [] {"별도상품 시작레슨" ,"lessonCodeSrtSp"});
	titleMap.put("treeClassify", new String [] {"상품분류" ,"clientClass", "상품분류"});
	titleMap.put("treeCourseCode", new String [] {"과정" ,"treeCourseCode"});
	titleMap.put("worldMapSeq", new String [] {"월드맵" ,"worldMapSeq"});
	titleMap.put("lesson", new String [] {"Lesson" ,"lesson"});
	titleMap.put("lcmsPrdId", new String [] {"LCMS 상품명" ,"lcmsPrdId"});
	titleMap.put("courseCode", new String [] {"과정명" ,"courseCode"});
	titleMap.put("activityCode", new String [] {"Activity" ,"activityCode"});
	titleMap.put("lessonSeq", new String [] {"Lesson" ,"lessonSeq"});
	titleMap.put("targetCourseCode", new String [] {"대상레벨" ,"targetCourseCode"});
	titleMap.put("recommendCourseCode", new String [] {"추천레벨" ,"recommendCourseCode"});
	
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
<%
		// 배지 부여 기준 
		if( "badgesBase".equals(name) ) {
%>
<td class="detail" id="id_td_<%= name %>" <%= colspan!=null ? "colspan=\""+ colspan +"\"": "" %>><span id="id_<%= form %>_<%= name %>_cb"></span> <span id="id_<%= form %>_<%= name %>_cg"></span></td>
<%
		}
		// 레슨수
		else if( "lessonCount".equals(name) ) {
%>
<td class="detail" id="id_td_<%= name %>" <%= colspan!=null ? "colspan=\""+ colspan +"\"": "" %>><span id="id_<%= form %>_<%= name %>"></span></td>
<%			
		}
		// 할인율(%)
		else if ( "discountRate".equals(name) ) {
%>
<td class="detail" id="id_td_<%= name %>" <%= colspan!=null ? "colspan=\""+ colspan +"\"": "" %>><span id="id_<%= form %>_<%= name %>_From"></span><span>&nbsp;~&nbsp;</span><span id="id_<%= form %>_<%= name %>_To"></span></td>
<%		}
		// 상품구분		
		else if ( "productGbnCode".equals(name) ){ %>
<td class="detail" id="id_td_<%= name %>" <%= colspan!=null ? "colspan=\""+ colspan +"\"": "" %>><span id="id_<%= form %>_<%= name %>_cb" style="float:left;"></span><span>&nbsp;&nbsp;</span><span id="id_<%= form %>_<%= name %>_cg" <%if(!"SL".equals(name)){ %> style="float:left;display: block;"<%}else{ %>style="float:left;display: none;"<%} %>></span></td>
<%		}
		// lesson		
		else if ( "lesson".equals(name) ){  
		%>
<td class="detail" id="id_td_<%= name %>" <%= colspan!=null ? "colspan=\""+ colspan +"\"": "" %>><span id="id_<%= form %>_<%= name %>_cb"></span></td>
<%		}
		// 지사/캠퍼스/클래스
		else if ( name.startsWith("client") ){ %>
<td class="detail" id="id_td_<%= name %>" <%= colspan!=null ? "colspan=\""+ colspan +"\"": "" %>>
	<% 
	// 지사
	if( name.indexOf("Up")>=0) { %>
		<span id="id_<%= form %>_clientUpCode_cb"></span><span>&nbsp;&nbsp;</span>
	<% } %>
	<% 
	// 거래처
	if( name.indexOf("Code")>=0) { %>
		<span id="id_<%= form %>_clientCode_cb" ></span><span>&nbsp;&nbsp;</span>
	<% } %>
	<% 
	// Class
	if( name.indexOf("Class")>=0) { %>
		<span id="id_<%= form %>_classCode_cb" ></span>
	<% } %>
</td>
<%		}// end of client
		else if( name.startsWith("tree") || name.startsWith("targetCourseCode") || name.startsWith("recommendCourseCode") ){ %>
<td class="detail" id="id_td_<%= name %>" <%= colspan!=null ? "colspan=\""+ colspan +"\"": "" %>><span id="id_<%= form %>_<%= name %>_tc"></span><span id="id_<%= form %>_<%= name %>_tc_tree"></span></td>
<%		} // enf of tree 
		else { %>
<td class="detail" id="id_td_<%= name %>" <%= colspan!=null ? "colspan=\""+ colspan +"\"": "" %>><span id="id_<%= form %>_<%= name %>_fd" style="display:inline-block; vertical-align:middle;float: left;"></span>
<span style="float: left; margin-left:5px;"><jsp:doBody></jsp:doBody></span>
</td>
<%		} %>
<% } 

else if ( area.equalsIgnoreCase("span") ) {
%>	
<span id="id_<%= form %>_<%= name %>_cb"></span>
<%
}
// td내용
else { 

	// 코드 목록 조회
	List<Map<String, String>> codeList = ((HashMap<String, List<Map<String, String>>>) application.getAttribute("KPS_COMMON_CODE_MAP_ATTR")).get(groupCode+ "-" + HO_T_SYS_LANG);
	Map<String, String> codeMap = null;
	boolean first = true;
	
	List<Map<String, String>> subCodeList = ((HashMap<String, List<Map<String, String>>>) application.getAttribute("KPS_COMMON_CODE_MAP_ATTR")).get(subGroupCode+ "-" + HO_T_SYS_LANG);
	Map<String, String> subCodeMap = null;
	boolean subFirst = true;
	
	String [] param = null;

	//배지 부여 기준 (Combox + checkbox)
	if( "badgesBase".equals(name) ) {
%>

		Ext.create('Ext.form.field.ComboBox', {
            renderTo : 'id_<%= form %>_<%= name %>_cb',
            id: 'cmp_<%= form %>_<%= name %>_cb',
            name: '<%= name %>',
            width : 150,
        	<%= "Y".equals(require) ? "emptyText : '* Select Type' , " : "" %> 
            allowBlank : <%= "Y".equals(require) ? "false" : "true" %>,
			store: Ext.create('Ext.data.ArrayStore', {
	            fields: ['SYSTEM_CODE', 'COMMON_CODE', 'CODE', 'NAME', 'UP_CODE'],
	            data: [
	            <%
            		if( "all".equals(head) ) {
            			first = false;
	    	    %>
		           		["", "", "",'-<%= "all".equals(head) ? "전체" :"선택"  %>-', ""]
	            <%
            		}
	            	for( int i=0 ; codeList!= null && i<codeList.size() ; i++ ) {
	            		codeMap  = codeList.get(i);
	            %>
	           		<%= !first ? "," : ""  %>["<%=codeMap.get( "SYSTEM_CODE") %>", "<%= codeMap.get("COMMON_CODE") %>", "<%= codeMap.get("CODE") %>","<%= codeMap.get("NAME") %>", "<%= codeMap.get("UP_CODE") %>"]
	            <%		
	            		first = false;
	            	}            
	            %>
			    ]}),
		    queryMode: 'local',
		    displayField: 'NAME',
		    valueField: 'CODE',
		    forceSelection :true,
		    hiddenName: '<%= name %>Value',
		    value : '<%= HtmlUtil.replaceNull(value) %>',
		    listeners: {
            	expand : function() {
		    		fs_HideFile();
		    		try {this.setValue('');} catch(E) {}
			    	try {this.store.clearFilter( );} catch(E) {}
					this.store.filter([
					    {property: "UP_CODE", value: Ext.getCmp('cmp_<%= form %>_<%=dependsName %>_cb').getValue() },
					    {filterFn: function(rec) { if(Ext.getCmp('cmp_<%= form %>_<%=dependsName %>_cb').getValue()=='') { return false; } else { return rec.get('UP_CODE') === Ext.getCmp('cmp_<%= form %>_<%=dependsName %>_cb').getValue(); } }}
					]);
		    	},
            	collapse : function() {
		    		fs_ShowFile();
		    	} 
		    }
		}).validate(); 
		// Ext.getCmp('cmp_<%= form %>_<%=name %>_cb').store.filter('UP_CODE', Ext.getCmp('cmp_<%= form %>_<%=dependsName %>_cb').getValue());
		Ext.getCmp('cmp_<%= form %>_<%=name %>_cb').store.filter([
		    {property: "UP_CODE", value: Ext.getCmp('cmp_<%= form %>_<%=dependsName %>_cb').getValue() },
		    {filterFn: function(rec) { if(Ext.getCmp('cmp_<%= form %>_<%=dependsName %>_cb').getValue()=='') { return false; } else { return rec.get('UP_CODE') === Ext.getCmp('cmp_<%= form %>_<%=dependsName %>_cb').getValue(); } }}
		]);
        cmps['<%= form %>'] = cmps['<%= form %>']||[];     
        cmps['<%= form %>'].push('cmp_<%= form %>_<%= name %>_cb');
	
		Ext.create('Ext.form.CheckboxGroup', {
	        renderTo: 'id_<%= form %>_<%= name %>_cg',
            id : 'cmp_<%= form %>_<%= name %>_cg',
            width : 700,
	        items: [
	            <%
	            	for( int i=0 ; subCodeList!= null && i<subCodeList.size() ; i++ ) {
	            		subCodeMap  = subCodeList.get(i);
	            %>
	           		<%= i>0 ? "," : ""  %>{name : "<%= name %>", boxLabel:  "<%= subCodeMap.get("NAME") %>", inputValue: "<%= subCodeMap.get("CODE") %>", checked: <%= (HtmlUtil.replaceNull(subValue).replaceAll(" ","")+",").indexOf(subCodeMap.get("CODE")) >=0 ? "true" : "false" %> }
	            <%		
	            	}            
	            %>
            ],
		    listeners: {
		    	<%= HtmlUtil.replaceNull(function)  %>
		    }
	    });
        cmps['<%= form %>'] = cmps['<%= form %>']||[];     
        cmps['<%= form %>'].push('cmp_<%= form %>_<%= name %>_cg');
<% 	}
	// 레슨수
	else if( "lessonCount".equals(name) ){%>
	Ext.create('Ext.form.TextField', {
		renderTo : 'id_<%= form %>_<%= name %>',
		id : 'cmp_<%= form %>_<%= name %>_tf',
		name : '<%= name %>',
        width : <%= HtmlUtil.maxWidth(width) %>,
        <%= "Y".equals(require) ? "emptyText : Ext.form.TextField.prototype.blankText , " : "" %> 
		allowBlank : <%= "Y".equals(require) ? "false" : "true" %>,
		value : '<%= HtmlUtil.replaceNull(value) %>'
	}).validate();
	cmps['<%= form %>'] = cmps['<%= form %>']||[];    
    cmps['<%= form %>'].push('cmp_<%= form %>_<%= name %>_tf');
<% 	}
	// 할인율(%) (text ~ text)
	else if( "discountRate".equals(name) ){%>
	Ext.create('Ext.form.NumberField', {
		renderTo : 'id_<%= form %>_<%= name %>_From',
		id : 'cmp_<%= name %>_From',
		name : '<%= name %>_From',
		width : 92,
		minValue : 0,
		maxValue : 100,
        <%= "Y".equals(require) ? "emptyText : Ext.form.NumberField.prototype.blankText , " : "" %> 
		allowBlank : <%= "Y".equals(require) ? "false" : "true" %>,
		value : '<%= HtmlUtil.replaceNull(value) %>'
	}).validate();
	cmps['<%= form %>'] = cmps['<%= form %>']||[];    
    cmps['<%= form %>'].push('cmp_<%= name %>_From');
    Ext.create('Ext.form.NumberField', {
		renderTo : 'id_<%= form %>_<%= name %>_To',
		id : 'cmp_<%= name %>_To',
		name : '<%= name %>_To',
		width : 92,
		minValue : 0,
		maxValue : 100,
		allowBlank : <%= "Y".equals(require) ? "false" : "true" %>,
		value : '<%= HtmlUtil.replaceNull(value) %>'
	}).validate();
	cmps['<%= form %>'] = cmps['<%= form %>']||[];    
    cmps['<%= form %>'].push('cmp_<%= name %>_To');
    
<%	}
	//상품구분 (Combobox + Combobox)
	else if( "productGbnCode".equals(name) ){ %>
	
	Ext.create('Ext.form.field.ComboBox', {
            renderTo : 'id_<%= form %>_<%= name %>_cb',
            id: 'cmp_<%= form %>_<%= name %>_cb',
            name: '<%= name %>First',
            width : 150,
        	<%= "Y".equals(require) ? "emptyText : Ext.form.ComboBox.prototype.blankText , " : "" %> 
			allowBlank : <%= "Y".equals(require) ? "false" : "true" %>,
			store: Ext.create('Ext.data.SimpleStore', {
	           fields: ['SYSTEM_CODE', 'COMMON_CODE', 'CODE', 'NAME'],
	           data: [
	            <%
            		if( "all".equals(head) ) {
            			first = false;
	    	    %>
		           		["", "", "",'-<%= "all".equals(head) ? "전체" :"선택"  %>-']
	            <%
            		}
	            	for( int i=0 ; codeList!= null && i<codeList.size() ; i++ ) {
	            		codeMap  = codeList.get(i);
	            %>
	           		<%= !first ? "," : ""  %>["<%=codeMap.get( "SYSTEM_CODE") %>", "<%= codeMap.get("COMMON_CODE") %>", "<%= codeMap.get("CODE") %>","<%= codeMap.get("NAME") %>"]
	            <%		
	            		first = false;
	            	}            
	            %>
			    ]}),
		    queryMode: 'local',
		    displayField: 'NAME',
		    valueField: 'CODE',
		    hiddenName: '<%= name %>Value',
		    value : '<%= HtmlUtil.replaceNull(value) %>',
		    listeners: {
		    	<%= HtmlUtil.replaceNull(function)  %>
		    }
		}).validate(); 
        cmps['<%= form %>'] = cmps['<%= form %>']||[];     
        cmps['<%= form %>'].push('cmp_<%= form %>_<%= name %>_cb');
		
		
		Ext.create('Ext.form.field.ComboBox', {
            renderTo : 'id_<%= form %>_<%= name %>_cg',
            id: 'cmp_<%= form %>_<%= name %>_cg',
            name: '<%= name %>Second',
            width : 500,
			queryCaching : false,
		    queryMode: 'remote',
		    displayTpl: '<tpl for=".">{SALE_PRD_NAME}</tpl>',
		    displayField: 'SALE_PRD_NAME',
		    valueField: 'SALE_PRD_ID',
		    hiddenName: '<%= name %>Value',
			forceSelection : true,
			typeAhead: false,
			//allowBlank : <%= "Y".equals(require) ? "false" : "true" %>,
            findRecord: function(field, value) {
			    var ds = this.store,params ={},
			        idx = ds.find(field, value);
			    if(idx === -1 && !this.initialRecordFound && this.queryMode === 'remote' && value!= '' ) {
			      this.initialRecordFound = true;
			      this.store.on({
			        load: {
			          fn: Ext.Function.bind(function(value) {
			            if (this.forceSelection) {
			            	if('<%= HtmlUtil.replaceNull(value) %>'== '') {
							    idx = ds.find(field, value);  // 처음 선택시 선택 안될대.. 처리.
							    return idx !== -1 ? ds.getAt(idx) : false;  // 처음 선택시 선택 안될대.. 처리.
			            	}
			              this.setValue(value);
			            }
			            this.store.removeAll();
			          }, this, [value]),
			          single: true
			        }
			      });
			      params[this.queryParam]=value;
			      var values = '<%= HtmlUtil.replaceNull(paramValues) %>'.split(',');
			      ds.load({
			      	params: { learningYearCode : values[0],  termGbn : values[1], productGbnCode : 'BS' }
			      });
			    }
			    idx = ds.find(field, value);
			    return idx !== -1 ? ds.getAt(idx) : false;
			  }, 
			
			listeners : {
	           	expand : function() {
		    		fs_HideFile();
		    	},
            	collapse : function() {
		    		fs_ShowFile();
		    	}, 
            	'beforequery' : function() {
            		this.store.proxy.setExtraParam ('learningYearCode', Ext.getCmp('cmp_<%= form %>_learningYearCode_cb') ? Ext.getCmp('cmp_<%= form %>_learningYearCode_cb').getValue() : Ext.getCmp('cmp_<%= form %>_learningYearCode_hf').getValue());
            		this.store.proxy.setExtraParam ('termGbn', Ext.getCmp('cmp_<%= form %>_termGbn_cb') ? Ext.getCmp('cmp_<%= form %>_termGbn_cb').getValue() : Ext.getCmp('cmp_<%= form %>_termGbn_hf').getValue() );
            		this.store.proxy.setExtraParam ('productGbnCode', 'BS' );
            	}
            },
			store: Ext.create('Ext.data.JsonStore', {
						//autoLoad : true,
						//autoSync : true,
						remoteSort:	true,
						root: 'topics',
	           			fields: ['SALE_PRD_ID', 'SALE_PRD_NAME'],
						proxy: {type: 'ajax',
            					url : '../json/SalesProductListJson.jsp',
								extraParams : { 
									learningYearCode: '<%= hh.get("learningYearCode") %>'
									, termGbn: '<%= hh.get("termGbn") %>' 
									, productGbnCode:'BS'
 								},
								reader: {
											type: 'json',
											root: 'topics'
										}
								}
			    }),
		    value : '<%= HtmlUtil.replaceNull(subValue) %>'
		}).validate(); 
		
        cmps['<%= form %>'] = cmps['<%= form %>']||[];     
        cmps['<%= form %>'].push('cmp_<%= form %>_<%= name %>_cg');
        
        Ext.get('cmp_sendForm_productGbnCode_cg').setVisible( Ext.getCmp('cmp_sendForm_productGbnCode_cb').getValue() == 'SP' );
        
<%	}
	// 지사 , 캠퍼스, Class출력 (Combobox + Combobox)
	else if( name.startsWith("client") ){ %>
	<% 
	// 지사
	if( name.indexOf("Up")>=0) { %>
		<% if("Y".equals(multiple)) { %>

		Ext.create('Ext.ux.form.field.BoxSelect', {
                renderTo : 'id_<%= form %>_clientUpCode_cb',
                id: 'cmp_<%= form %>_clientUpCode_cb',
                name: 'clientUpCode',
		    	//hiddenName: 'clientUpCodeValue',
				msgTarget: 'title',
            	width : <%= HtmlUtil.maxWidth(width) %>,
        		<%= "Y".equals(require) ? "emptyText : Ext.form.ComboBox.prototype.blankText , " : "" %> 
                <%= "Y".equals(require) ? "allowBlank : false, " : "" %>
                queryMode: 'local',
                displayField: 'UP_CLIENT_NAME',
                // displayTpl: '<tpl for=".">{UP_CLIENT_NAME} ({CLIENT_CODE})</tpl>', // '{UP_CLIENT_NAME} ({CLIENT_CODE})',
                valueField: 'CLIENT_CODE',
                forceSelection :true,
                value :  [<%= HtmlUtil.spiltAndConcat(value) %>],
                store: new Ext.data.SimpleStore({
	           fields: ['CLIENT_CODE', 'UP_CLIENT_NAME'],
	            data: [
	            <%
	            		if( "Y".equals(auth) ) {
	            			sh.query("com/Common.sql", "searchNotAllUpCampusAuthList", null);
	            		} else {
	            			sh.query("com/Common.sql", "searchNotAllUpCampusList", null);
	            		}
	            
            			
            			if( "all".equals(head) ) {
            				subFirst = false;
	    	    %>
		           			["", "",  "-<%= "all".equals(head) ? "전체" :"선택"  %>-"]
	            <%
            			}
	            	int i = 0;
	            	while( sh.next()) {
	            %>
	           		<%= !subFirst ? "," : ""  %>["<%= sh.get("CLIENT_CODE") %>", "<%= sh.get("UP_CLIENT_NAME") %>"]
	            <%		
	           			subFirst = false;
	           			i++;
	            	}         
		           		
		           		sh.close();
	            %>
			    ]
	        }),
		    listeners: {
            	expand : function() {
		    		fs_HideFile();
		    	},
            	collapse : function() {
		    		fs_ShowFile();
		    	} 
		    	, change : function (_this, newValue, oldValue, eOpts) {
		    	}
		    }
        }).validate();
        cmps['<%= form %>'] = cmps['<%= form %>']||[];     
        cmps['<%= form %>'].push('cmp_<%= form %>_clientUpCode_cb');
        
		<% } else {%>
	Ext.create('Ext.form.field.ComboBox', {
            renderTo : 'id_<%= form %>_clientUpCode_cb',
            id: 'cmp_<%= form %>_clientUpCode_cb',
            name: 'clientUpCode',
		    hiddenName: 'clientUpCodeValue',
            width : 150,
			store: Ext.create('Ext.data.JsonStore', {
						root: 'topics',
						pageSize: 20,
						remoteSort:	true,
						autoLoad : true,
						autoSync : true,
						fields:	['CLIENT_CODE', 'UP_CLIENT_NAME'],
						proxy: {type: 'ajax',
								api : { read : '../json/BranchListJson.jsp'  },
								extraParams : { 
												auth : '<%= HtmlUtil.replaceNull(auth, "N") %>' 
												<%= "choice".equals(head)?",head : 'choice'":"" %>
								}, 
            					<% if( !"".equals(HtmlUtil.replaceNull(dependsName))) { %>
            					<% } %>
								reader: {
											type: 'json',
											root: 'topics',
											totalProperty: 'totalCount'
										}
								}
					}),
		    queryMode: 'remote',
		    displayField: 'UP_CLIENT_NAME',
		    valueField: 'CLIENT_CODE',
		    value : '<%= HtmlUtil.replaceNull(value) %>',
		  
		    listeners: {
		    	<%= HtmlUtil.replaceNull(function)  %>
		    	change : function (_this, newValue, oldValue, eOpts) {
		    	<% if( !"".equals(HtmlUtil.replaceNull(cascadeName )))  { %>
		    		try {Ext.getCmp('cmp_<%= form %>_<%=cascadeName %>_cb').setValue('');} catch(E) {}
			    	try {Ext.getCmp('cmp_<%= form %>_<%=cascadeName %>_cb').store.clearFilter( );} catch(E) {}
					try {Ext.getCmp('cmp_<%= form %>_<%=cascadeName %>_cb').store.filter('PARENT_CLIENT_CODE',newValue);} catch(E) {}
					// try {Ext.getCmp('cmp_<%= form %>_<%=cascadeName %>_cb').store.filterBy( function(rec) { return rec.get('PARENT_CLIENT_CODE') === newValue || rec.get('PARENT_CLIENT_CODE') ==''; } ); } catch(E) {}
		    	<% }  %>
		    	<% 
				// 거래처까지 같이 출력하는 경우
				if( name.indexOf("Code")>=0) { %>
				
			    	if(newValue == null || newValue == ""){
				    	this.lastSelection = [];
				    	this.doQueryTask.cancel();
			        	this.assertValue();
				    }
		    		try {Ext.getCmp('cmp_<%= form %>_clientCode_cb').setValue("");} catch(E) {}
			    	try {Ext.getCmp('cmp_<%= form %>_clientCode_cb').store.clearFilter( );} catch(E) {}
			    	if( newValue != null && newValue != "" ) {
			    		try {
			    			Ext.getCmp('cmp_<%= form %>_clientCode_cb').store.filter('PARENT_CLIENT_CODE',newValue);
			    			/*
			    			//Ext.getCmp('cmp_<%= form %>_clientCode_cb').store.filterBy(function(record) {
			    			//	if( record.get('PARENT_CLIENT_CODE') == newValue || record.get('PARENT_CLIENT_CODE') == "" ) {
			    			//		return true;
			    			//	} else {
			    			//		return false;
			    			//	}
			    			//});
			    			*/
			    		} catch(E) {}
			    	} else {
			    		Ext.getCmp('cmp_<%= form %>_clientCode_cb').store.filter('PARENT_CLIENT_CODE','');
			    	}
				<% }  %>
				}
		    }
		}).validate(); 
        cmps['<%= form %>'] = cmps['<%= form %>']||[];     
        cmps['<%= form %>'].push('cmp_<%= form %>_clientUpCode_cb');
		<%} %>
	<% } %>	
	<% 
	// 거래처
	if( name.indexOf("Code")>=0) { %>
		<% if("Y".equals(multiple)) { %>
		Ext.create('Ext.ux.form.field.BoxSelect', {
                renderTo : 'id_<%= form %>_clientCode_cb',
                id: 'cmp_<%= form %>_clientCode_cb',
                name: 'clientCode',
		    	hiddenName: 'clientCodeValue',
				msgTarget: 'title',
            	width : <%= HtmlUtil.maxWidth(width) %>,
        		<%= "Y".equals(require) ? "emptyText : Ext.form.ComboBox.prototype.blankText , " : "" %> 
                <%= "Y".equals(require) ? "allowBlank : false, " : "" %>
                queryMode: 'local',
                displayField: 'CLIENT_NAME',
                displayFieldTpl: '{CLIENT_NAME} ({CLIENT_CODE})',
                valueField: 'CLIENT_CODE',
                forceSelection :true,
                value :  [<%= HtmlUtil.spiltAndConcat(value) %>],
                store: new Ext.data.SimpleStore({
	           fields: ['CLIENT_CODE', 'PARENT_CLIENT_CODE', 'CLIENT_NAME'],
	            data: [
	            <%
	            		if( "Y".equals(auth) ) {
	            			sh.query("com/Common.sql", "searchCampusAuthList", null);
	            			
	            		} else {
	            			sh.query("com/Common.sql", "searchCampusList", null);
	            		}
	            
            			
            			if( "all".equals(head)  ) {
            				subFirst = false;
	    	    %>
		           			["", "",  "-<%= "all".equals(head) ? "전체" :"선택"  %>-"]
	            <%
            			}
	            	int i = 0;
	            	while( sh.next()) {
	            %>
	           		<%= !subFirst ? "," : ""  %>["<%= sh.get("CLIENT_CODE") %>", "<%= sh.get("PARENT_CLIENT_CODE") %>","<%= sh.get("CLIENT_NAME") %>"]
	            <%		
	           			subFirst = false;
	           			i++;
	            	}         
		           		
		           		sh.close();
	            %>
			    ]
	        }),
		    listeners: {
            	expand : function() {
		    		fs_HideFile();
		    	},
            	collapse : function() {
		    		fs_ShowFile();
		    	} 
		    	, change : function (_this, newValue, oldValue, eOpts) {
		    		// 캠퍼스 변경시 function호출
			    	try { fs_onClientChange(_this, newValue, oldValue, eOpts);} catch(e){  } 
		    	<% if( name.indexOf("Class")>=0) { %>
			    	
			    	if(newValue == null || newValue == ""){
				    	this.lastSelection = [];
				    	this.doQueryTask.cancel();
			        	this.assertValue();
				    }
		    		try {Ext.getCmp('cmp_<%= form %>_classCode_cb').setValue("");} catch(E) {}
			    	try {Ext.getCmp('cmp_<%= form %>_classCode_cb').store.clearFilter( );} catch(E) {}
			    	if( newValue != null && newValue != "" ) {
			    		try {
			    			Ext.getCmp('cmp_<%= form %>_classCode_cb').store.filter('CLIENT_CODE',newValue);
			    			/*
			    			//Ext.getCmp('cmp_<%= form %>_classCode_cb').store.filterBy(function(record) {
			    			//	if( record.get('CLIENT_CODE') == newValue || record.get('CLIENT_CODE') == "" ) {
			    			//		return true;
			    			//	} else {
			    			//		return false;
			    			//	}
			    			//});
			    			*/
			    		} catch(E) {}
			    	}
		    	<% }  %>
		    	}
		    }
        }).validate();
        
		<% } else {%>
		Ext.create('Ext.form.field.ComboBox', {
            renderTo : 'id_<%= form %>_clientCode_cb',
            id: 'cmp_<%= form %>_clientCode_cb',
            name: 'clientCode',
		    hiddenName: 'clientCodeValue',
            width : <%= HtmlUtil.maxWidth(width) %>,
        	<%= "Y".equals(require) ? "emptyText : Ext.form.ComboBox.prototype.blankText , " : "" %> 
             <%= "Y".equals(require) ? "allowBlank : false, " : "" %>
			store: Ext.create('Ext.data.SimpleStore', {
	           fields: ['CLIENT_CODE', 'PARENT_CLIENT_CODE', 'CLIENT_NAME'],
	           data: [
	            <%
            		if( "Y".equals(auth) ) {
            			sh.query("com/Common.sql", "searchCampusAuthList", null);
            		} else {
            			sh.query("com/Common.sql", "searchCampusList", null);
            		}
            
            		if( "all".equals(head) ) {
           			subFirst = false;
    	    %>
	           		["", "","", "-<%= "all".equals(head) ? "전체" :"선택"  %>-"]
            <%
            		}
            		
	            	int i = 0;
	            	while( sh.next()) {
	            %>
	           		<%= !subFirst ? "," : ""  %>["<%= sh.get("CLIENT_CODE") %>", "<%= sh.get("PARENT_CLIENT_CODE") %>","<%= sh.get("CLIENT_NAME") %>"]
	            <%		
	           			subFirst = false;
	           			i++;
	            	}         
		           		
		           		sh.close();
	            %>
			    ]
			    }),
		    queryMode: 'local',
		    displayField: 'CLIENT_NAME',
		    valueField: 'CLIENT_CODE',
		    forceSelection :true,
		    value : '<%= HtmlUtil.replaceNull(subValue) %>',
		    triggerAction: 'all',
			lastQuery: '',
		    listeners: {
		    	<%= HtmlUtil.replaceNull(function)  %>
		    	change : function (_this, newValue, oldValue, eOpts) {
		    	
		    		// 캠퍼스 변경시 function호출
			    	try { fs_onClientChange();} catch(e){  } 
		    	<% 
				// 거래처까지 같이 출력하는 경우
				if( name.indexOf("Class")>=0) { %>
			    	if(newValue == null || newValue == ""){
				    	this.lastSelection = [];
				    	this.doQueryTask.cancel();
			        	this.assertValue();
				    }
		    		try {Ext.getCmp('cmp_<%= form %>_classCode_cb').setValue("");} catch(E) {}
			    	try {Ext.getCmp('cmp_<%= form %>_classCode_cb').store.clearFilter( );} catch(E) {}
			    	if( newValue != null && newValue != "" ) {
			    		try {
			    			/*
			    			Ext.getCmp('cmp_<%= form %>_classCode_cb').store.filterBy(function(record) {
			    				if( record.get('CLIENT_CODE') == newValue || record.get('CLIENT_CODE') == "" ) {
			    					return true;
			    				} else {
			    					return false;
			    				}
			    			});
			    			*/
			    		} catch(E) {}
			    	} 
				<% }  %>
				}
		    }
		}).validate(); 
		
	<% } %>  
        <% if( !"".equals(HtmlUtil.replaceNull(dependsName))) { %>
        Ext.getCmp('cmp_<%= form %>_clientCode_cb').store.filter('PARENT_CLIENT_CODE',Ext.getCmp('cmp_<%= form %>_<%=dependsName %>_cb').getValue());
        <% } %>
        cmps['<%= form %>'] = cmps['<%= form %>']||[];     
        cmps['<%= form %>'].push('cmp_<%= form %>_clientCode_cb');
	<% }  %>
	<% 
	// Class(클래스)
	if( name.indexOf("Class")>=0) { %>
		<% if("Y".equals(multiple)) { %>
		Ext.create('Ext.ux.form.field.BoxSelect', {
            renderTo : 'id_<%= form %>_classCode_cb',
            id: 'cmp_<%= form %>_classCode_cb',
            name: 'classCode',
            hiddenName: 'classCodeValue',
            width : <%= HtmlUtil.maxWidth(width) %>,
			queryParam : 'className',
			hideLabel: true,
			typeAhead: false,
			queryCaching : false,
			minChars : 0,
			triggerAction: 'all',
			emptyText: '* Select Campus',
			forceSelection :true,
			store: Ext.create('Ext.data.JsonStore', {
						root: 'topics',
	           			fields: ['CLIENT_CODE', 'CLASS_CODE', 'CLIENT_NAME', 'CLASS_NAME','CLASS_SEQ','GRADE_GBN','GRADE_GBN_NAME'],
						proxy: {type: 'ajax',
            					url : '../json/ClassListJson.jsp',
								extraParams : { 
									learningYearCode: '<%= hh.get("learningYearCode") %>'
									, termGbn: '<%= hh.get("termGbn") %>' 
            					<% if( !"".equals(HtmlUtil.replaceNull(dependsName))) { %>
									, clientCode: Ext.getCmp('cmp_<%= form %>_<%= dependsName %>_cb').getValue() 
            					<% } %>
								},
								reader: {
											type: 'json',
											root: 'topics'
										}
								}
			    }),
		    //queryMode: 'remote',
		    valueField: 'CLASS_CODE',
		    //displayField :'CLASS_NAME',
			displayTpl: '<tpl for=".">{CLIENT_NAME} {CLASS_NAME}<tpl if="CLASS_CODE!=\'\'">[{GRADE_GBN_NAME}]</tpl></tpl>',
            listConfig: {
                itemTpl: Ext.create('Ext.XTemplate', '<tpl for=".">{CLIENT_NAME} {CLASS_NAME}', '<tpl if="CLASS_CODE!=\'\'">',  '[{GRADE_GBN_NAME}]',  '</tpl></tpl>')
            },		    
            listeners : {
            	'beforequery' : function() {
            		this.store.proxy.setExtraParam ('learningYearCode', Ext.getCmp('cmp_<%= form %>_learningYearCode_cb') ? Ext.getCmp('cmp_<%= form %>_learningYearCode_cb').getValue() : Ext.getCmp('cmp_<%= form %>_learningYearCode_hf').getValue());
            		this.store.proxy.setExtraParam ('termGbn', Ext.getCmp('cmp_<%= form %>_termGbn_cb') ? Ext.getCmp('cmp_<%= form %>_termGbn_cb').getValue() : Ext.getCmp('cmp_<%= form %>_termGbn_hf').getValue() );
            		this.store.proxy.setExtraParam ('clientCode', Ext.getCmp('cmp_<%= form %>_clientCode_cb') ? Ext.getCmp('cmp_<%= form %>_clientCode_cb').getValue() : Ext.getCmp('cmp_<%= form %>_clientCode_hf').getValue() );
            	}
            },
		    value : '<%= HtmlUtil.replaceNull(subValue) %>'
		}).validate(); 
		<% } else { %>
		Ext.create('Ext.form.field.ComboBox', {
            renderTo : 'id_<%= form %>_classCode_cb',
            id: 'cmp_<%= form %>_classCode_cb',
            name: 'classCode',
		    hiddenName: 'classCodeValue',
            width : <%= HtmlUtil.maxWidth(width) %>,
			queryParam : 'className',
			typeAhead: false,
			queryCaching : false,
			minChars : 0,
			triggerAction: 'all',
			store: Ext.create('Ext.data.JsonStore', {
	           fields: ['CLIENT_CODE', 'CLASS_CODE', 'CLIENT_NAME', 'CLASS_NAME','CLASS_SEQ','GRADE_GBN','GRADE_GBN_NAME'],
						proxy: {type: 'ajax',
            					url : '../json/ClassListJson.jsp',
								extraParams : { 
									learningYearCode: '<%= hh.get("learningYearCode") %>'
									, termGbn: '<%= hh.get("termGbn") %>' 
            					<% if( !"".equals(HtmlUtil.replaceNull(dependsName))) { %>
									, clientCode: Ext.getCmp('cmp_<%= form %>_<%= dependsName %>_cb').getValue() 
            					<% } %>
								},
								reader: {
											type: 'json',
											root: 'topics',
											totalProperty: 'totalCount'
										}
								}
			    }),
		    queryMode: 'remote',
		    valueField: 'CLASS_CODE',
		    displayField: 'CLASS_NAME',
			displayTpl: Ext.create('Ext.XTemplate', '<tpl for=".">{CLIENT_NAME} {CLASS_NAME}', '<tpl if="CLASS_CODE!=\'\'">',  '[{GRADE_GBN_NAME}]',  '</tpl></tpl>'),
            listConfig: {
                itemTpl: Ext.create('Ext.XTemplate', '<tpl for=".">{CLIENT_NAME} {CLASS_NAME}', '<tpl if="CLASS_CODE!=\'\'">',  '[{GRADE_GBN_NAME}]',  '</tpl></tpl>')
            },		    
            listeners : {
            	'beforequery' : function() {
            		this.store.proxy.setExtraParam ('learningYearCode', Ext.getCmp('cmp_<%= form %>_learningYearCode_cb') ? Ext.getCmp('cmp_<%= form %>_learningYearCode_cb').getValue() : Ext.getCmp('cmp_<%= form %>_learningYearCode_hf').getValue());
            		this.store.proxy.setExtraParam ('termGbn', Ext.getCmp('cmp_<%= form %>_termGbn_cb') ? Ext.getCmp('cmp_<%= form %>_termGbn_cb').getValue() : Ext.getCmp('cmp_<%= form %>_termGbn_hf').getValue() );
            		this.store.proxy.setExtraParam ('clientCode', Ext.getCmp('cmp_<%= form %>_clientCode_cb') ? Ext.getCmp('cmp_<%= form %>_clientCode_cb').getValue() : Ext.getCmp('cmp_<%= form %>_clientCode_hf').getValue() );
            	}
            },
		    value : '<%= HtmlUtil.replaceNull(subValue) %>'
		}).validate(); 
		<% } %>
        cmps['<%= form %>'] = cmps['<%= form %>']||[];     
        cmps['<%= form %>'].push('cmp_<%= form %>_classCode_cb');	
   <% } %>   
<%	}
	// 판매상품 (Combobox - dynamic)
	else if("salePrdId".equals(name) ){ %>
		Ext.create('Ext.form.field.ComboBox', {
			renderTo : 'id_<%= form %>_<%= name %>_fd',
			id: 'cmp_<%= form %>_<%= name %>_cb',
			name: '<%= name %>',
			width : <%= HtmlUtil.maxWidth(width) %>,
			<%= "Y".equals(require) ? "allowBlank : false, " : "" %>
			displayTpl: '<tpl for=".">{SALE_PRD_NAME}</tpl>',
			valueField: 'SALE_PRD_ID',
			emptyText: '* Select Year/Semister',
			hideLabel: true,
			queryCaching : false,
			queryMode : 'remote',
			queryParam : 'salePrdName',
            listConfig: {
                loadingText: 'Searching...',
                itemTpl: Ext.create('Ext.XTemplate', '{SALE_PRD_NAME}'),
                emptyText: 'No matching Product found.'
            },
            listeners : {
            	'beforequery' : function() {
            		this.store.proxy.setExtraParam ('learningYearCode', Ext.getCmp('cmp_<%= form %>_learningYearCode_cb').getValue());
            		this.store.proxy.setExtraParam ('termGbn', Ext.getCmp('cmp_<%= form %>_termGbn_cb').getValue());
            		this.store.proxy.setExtraParam ('productGbnCode', 'BS');
            	}
		    	<% if( !"".equals(HtmlUtil.replaceNull(cascadeName )))  { %>
		    	, change : function (_this, newValue, oldValue, eOpts) {
		    		Ext.getCmp('cmp_<%= form %>_lessonCodeSrt_cb').setValue("");
			    	Ext.getCmp('cmp_<%= form %>_lessonCodeSrt_cb').store.clearFilter( );
		    		Ext.getCmp('cmp_<%= form %>_<%=cascadeName %>_cb').setValue("");
			    	Ext.getCmp('cmp_<%= form %>_<%=cascadeName %>_cb').store.clearFilter( );
				}
		    	<% }  %>
			    	
		    	<%= ( !"".equals(HtmlUtil.replaceNull(function)) ? "," : "") + HtmlUtil.replaceNull(function)  %>
            },
			store: Ext.create('Ext.data.JsonStore', {
						root: 'topics',
						pageSize: 20,
						remoteSort:	true,
						fields:	[ 'LEARNING_YEAR_CODE', 'TERM_GBN', 'SALE_PRD_ID', 'SALE_PRD_NAME' ],
						proxy: {type: 'ajax',
            					url : '../json/SalesProductListJson.jsp',
								reader: {
											type: 'json',
											root: 'topics',
											totalProperty: 'totalCount'
										}
								}
					})
       	}).validate();
        cmps['<%= form %>'] = cmps['<%= form %>']||[];     
        cmps['<%= form %>'].push('cmp_<%= form %>_<%= name %>_cb');
<%	}
	// 판매상품 (Combobox - dynamic)
	else if("salePrdIdSp".equals(name) ){ %>
		Ext.create('Ext.form.field.ComboBox', {
			renderTo : 'id_<%= form %>_<%= name %>_fd',
			id: 'cmp_<%= form %>_<%= name %>_cb',
			name: '<%= name %>',
			width : <%= HtmlUtil.maxWidth(width) %>,
			<%= "Y".equals(require) ? "allowBlank : false, " : "" %>
			displayTpl: '<tpl for=".">{SALE_PRD_NAME}</tpl>',
			valueField: 'SALE_PRD_ID',
			emptyText: '* Select Year/Semister',
			hideLabel: true,
			queryCaching : false,
			queryMode : 'remote',
			queryParam : 'salePrdName',
            listConfig: {
                loadingText: 'Searching...',
                itemTpl: Ext.create('Ext.XTemplate', '{SALE_PRD_NAME}'),
                emptyText: 'No matching Product found.'
            },
            listeners : {
            	'beforequery' : function() {
            		this.store.proxy.setExtraParam ('learningYearCode', Ext.getCmp('cmp_<%= form %>_learningYearCode_cb').getValue());
            		this.store.proxy.setExtraParam ('termGbn', Ext.getCmp('cmp_<%= form %>_termGbn_cb').getValue());
            		this.store.proxy.setExtraParam ('productGbnCode', 'SL');
            		this.store.proxy.setExtraParam ('basicPrdId', Ext.getCmp('cmp_<%= form %>_salePrdId_cb').getValue());
            	}
		    	, change : function (_this, newValue, oldValue, eOpts) {
		    		Ext.getCmp('cmp_<%= form %>_lessonCodeSrtSp_cb').setValue("");
			    	Ext.getCmp('cmp_<%= form %>_lessonCodeSrtSp_cb').store.clearFilter( );
				}
			    	
		    	<%= ( !"".equals(HtmlUtil.replaceNull(function)) ? "," : "") + HtmlUtil.replaceNull(function)  %>
            },
			store: Ext.create('Ext.data.JsonStore', {
						root: 'topics',
						pageSize: 20,
						remoteSort:	true,
						fields:	[ 'LEARNING_YEAR_CODE', 'TERM_GBN', 'SALE_PRD_ID', 'SALE_PRD_NAME' ],
						proxy: {type: 'ajax',
            					url : '../json/SalesProductListJson.jsp',
								reader: {
											type: 'json',
											root: 'topics',
											totalProperty: 'totalCount'
										}
								}
					})
       	}).validate();
        cmps['<%= form %>'] = cmps['<%= form %>']||[];     
        cmps['<%= form %>'].push('cmp_<%= form %>_<%= name %>_cb');
<%	}
	// 환불시작레슨
	else if("refundLessonCodeSrt".equals(nameGroup) ){ %>
		Ext.create('Ext.form.field.ComboBox', {
			renderTo : 'id_<%= form %>_<%= name %>_cb',
			id: 'cmp_<%= form %>_<%= name %>_cb',
			name: '<%= name %>',
			width : <%= HtmlUtil.maxWidth(width) %>,
        	<%= "Y".equals(require) ? "emptyText : Ext.form.ComboBox.prototype.blankText , " : "" %> 
			<%= "Y".equals(require) ? "allowBlank : false, " : "" %>
		    queryMode: 'local',
		    displayField: 'LESSON_NAME',
		    valueField: 'LESSON_SEQ',
		    hiddenName: '<%= name %>Value',
		    value : '<%= HtmlUtil.replaceNull(subValue) %>',
		    listeners: {
            	expand : function() {
		    		fs_HideFile() ;
		    	},
            	collapse : function() {
		    		fs_ShowFile();
		    	}
			    <%= ( !"".equals(HtmlUtil.replaceNull(function)) ? "," : "") + HtmlUtil.replaceNull(function)  %>
		    },
			store: Ext.create('Ext.data.SimpleStore', {
	           fields:	[ 'SALE_PRD_ID', 'LESSON_SEQ', 'LESSON_NAME' ],
	           data: [
	            <%
	            	String paramArr[] = null;
	            	param = new String [7];
	            	if( !"".equals(HtmlUtil.replaceNull(paramValues))) {
	            		//hh.log("paramValues => "+paramValues);
	            		paramArr = paramValues.split(",");
	            		//hh.log("paramArr[0] => "+paramArr[0]);
	            		//hh.log("paramArr[1] => "+paramArr[1]);
	            		//hh.log("paramArr[2] => "+paramArr[2]);
	            		//hh.log("paramArr[3] => "+paramArr[3]);
	            		//hh.log("paramArr[4] => "+paramArr[4]);
		            	param[0] = paramArr[0];
		            	param[1] = null;
		            	param[2] = null;
		            	param[3] = paramArr[1];
		            	param[4] = paramArr[2];
		            	param[5] = "".equals(paramArr[3])?null:paramArr[3];
		            	param[6] = paramArr[4];
	            	}
	            	sh.query("com/Common.sql", "selectJsonSalesProductCostList", param);
	            	subFirst = true;	
	            	while( sh.next()) {
	            %>
	           		<%= !subFirst ? "," : ""  %>["<%= sh.get("SALE_PRD_ID") %>", "<%= sh.get("LESSON_SEQ") %>","<%= sh.get("LESSON_NAME") %>"]
	            <%		
	            	subFirst = false;
	            	}         
		           		
		           		sh.close();
	            %>
			    ]
			    })
		}).validate(); 
        cmps['<%= form %>'] = cmps['<%= form %>']||[];     
        cmps['<%= form %>'].push('cmp_<%= form %>_<%= name %>_cb');
<%	}
	// 결제시작레슨
	else if( "lessonCodeSrt".equals(name) || "lessonCodeSrtSp".equals(name) ){ %>
		Ext.create('Ext.form.field.ComboBox', {
			renderTo : 'id_<%= form %>_<%= name %>_fd',
			id: 'cmp_<%= form %>_<%= name %>_cb',
			name: '<%= name %>',
			width : <%= HtmlUtil.maxWidth(width) %>,
        	<%= "Y".equals(require) ? "emptyText : Ext.form.ComboBox.prototype.blankText , " : "" %> 
			<%= "Y".equals(require) ? "allowBlank : false, " : "" %>
			displayTpl: '<tpl for=".">{LESSON_NAME}</tpl>',
			valueField: 'LESSON_SEQ',
			hideLabel: true,
			queryCaching : false,
			queryMode : 'remote',
			queryParam : 'salePrdName',
            listConfig: {
                loadingText: 'Searching...',
                itemTpl: Ext.create('Ext.XTemplate', '{LESSON_NAME}'),
                emptyText: 'No matching Lesson found.'
            },
            listeners : {
            	'beforequery' : function() {
            		this.store.proxy.setExtraParam ('salePrdId', Ext.getCmp('cmp_<%= form %>_<%= dependsName %>_cb').getValue());
            	}
			    	
		    	<%= ( !"".equals(HtmlUtil.replaceNull(function)) ? "," : "") + HtmlUtil.replaceNull(function)  %>
            },
			store: Ext.create('Ext.data.JsonStore', {
						root: 'topics',
						pageSize: 20,
						remoteSort:	true,
						fields:	[ 'SALE_PRD_ID', 'LESSON_SEQ', 'LESSON_NAME' ],
						proxy: {type: 'ajax',
            					url : '../json/SalesProductCostListJson.jsp',
								reader: {
											type: 'json',
											root: 'topics',
											totalProperty: 'totalCount'
										}
								}
					})
       	}).validate();
        cmps['<%= form %>'] = cmps['<%= form %>']||[];     
        cmps['<%= form %>'].push('cmp_<%= form %>_<%= name %>_cb');
<%	}else if( name.equals("treeClassify") ){ 
	HashMap<String, String[]> rootMap = new HashMap<String, String[]>();
	
	rootMap.put("treeClassify", new String [] {"상품 분류" ,"treeClassify"});
	
	String [] rootNames = rootMap.get(name);
	String rootName = "";
	if(rootNames!=null) {
		rootName = rootNames[0];
	}

%>
		
		Ext.create('Ext.ux.TreeCombo', {
			renderTo: 'id_<%= form %>_<%= name %>_tc',
            id : 'cmp_<%= form %>_<%= name %>_tc',
            width : <%= HtmlUtil.maxWidth(width) %>,
        	<%= "Y".equals(require) ? "emptyText : Ext.form.ComboBox.prototype.blankText , " : "" %> 
			<%= "Y".equals(require) ? "allowBlank : false, " : "" %>
            name: '<%= name %>',
            hiddenName: '<%= name %>Value',
            value : '<%= HtmlUtil.replaceNull(value) %>',
			typeAhead: false,
			queryCaching : false,
			minChars : 0,
			triggerAction: 'all',
            listeners : {
            	'beforequery' : function() {
            		this.store.proxy.setExtraParam ('learningYearCode', Ext.getCmp('cmp_<%= form %>_learningYearCode_cb') ? Ext.getCmp('cmp_<%= form %>_learningYearCode_cb').getValue() : Ext.getCmp('cmp_<%= form %>_learningYearCode_hf').getValue());
            		this.store.proxy.setExtraParam ('termGbn', Ext.getCmp('cmp_<%= form %>_termGbn_cb') ? Ext.getCmp('cmp_<%= form %>_termGbn_cb').getValue() : Ext.getCmp('cmp_<%= form %>_termGbn_hf').getValue() );
            	},
            	'itemclick' : function() {
        			
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
					fields : ['id', 'text', 'name'],
					proxy   : {
					    type : 'ajax',
					    extraParams : { 
							auth : '<%= HtmlUtil.replaceNull(auth, "N") %>' ,
							name : '<%= name %>' ,
							learningYearCode: '<%= hh.get("learningYearCode") %>' ,
							termGbn: '<%= hh.get("termGbn") %>' 
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
        cmps['<%= form %>'].push('cmp_<%= form %>_<%= name %>_tc');
<%	}else if( name.startsWith("treeCourseCode") || name.startsWith("targetCourseCode") || name.startsWith("recommendCourseCode") ){ 
	HashMap<String, String[]> rootMap = new HashMap<String, String[]>();
	
	rootMap.put("treeCourseCode", new String [] {"과정" ,"treeCourseCode"});
	rootMap.put("targetCourseCode", new String [] {"대상과정" ,"targetCourseCode"});
	rootMap.put("recommendCourseCode", new String [] {"추천과정" ,"recommendCourseCode"});
	
	
	String [] rootNames = rootMap.get(name);
	String rootName = "";
	if(rootNames!=null) {
		rootName = rootNames[0];
	}

%>
		Ext.create('Ext.ux.TreeCombo', {
			renderTo: 'id_<%= form %>_<%= name %>_tc',
            id : 'cmp_<%= form %>_<%= name %>_tc',
            width : <%= HtmlUtil.maxWidth(width) %>,
        	<%= "Y".equals(require) ? "emptyText : Ext.form.ComboBox.prototype.blankText , " : "" %> 
			<%= "Y".equals(require) ? "allowBlank : false, " : "" %>
            name: '<%= name %>',
            hiddenName: '<%= name %>Value',
            // initValues : [<%= HtmlUtil.spiltAndConcat(value) %>],
            value : '<%= HtmlUtil.spiltAndConcat(value).replace("\'", "").replace(" ", "") %>',
			typeAhead: false,
			// queryCaching : false,
			minChars : 0,
			triggerAction: 'all',
            listeners : {
            	'beforequery' : function() {
            		this.store.proxy.setExtraParam ('learningYearCode', Ext.getCmp('cmp_<%= form %>_learningYearCode_cb') ? Ext.getCmp('cmp_<%= form %>_learningYearCode_cb').getValue() : Ext.getCmp('cmp_<%= form %>_learningYearCode_hf').getValue());
            		this.store.proxy.setExtraParam ('termGbn', Ext.getCmp('cmp_<%= form %>_termGbn_cb') ? Ext.getCmp('cmp_<%= form %>_termGbn_cb').getValue() : Ext.getCmp('cmp_<%= form %>_termGbn_hf').getValue() );
            	},
            	'itemclick' : function(me, record, item, index, e, eOpts, records, values) {
            		// e.stopPropagation();
            		// Ext.get(item.id).scrollIntoView(false);
            		Ext.get(item.id).focus();
            		// Ext.get(item.id).scroll( "t",  0 );
            		// Ext.get(item.id).scrollBy(10, 30, true);
        			// Ext.get(record.id + '-listEl').scroll("down", me.beforeRefreshScrollTop, false);
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
					fields : ['id', 'text', 'name'],
					proxy   : {
					    type : 'ajax',
					    extraParams : { 
							auth : '<%= HtmlUtil.replaceNull(auth, "N") %>' ,
							name : '<%= name %>' ,
							learningYearCode: '<%= hh.get("learningYearCode") %>' ,
							termGbn: '<%= hh.get("termGbn") %>' 
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
        cmps['<%= form %>'].push('cmp_<%= form %>_<%= name %>_tc');
<%	}
	// 결제시작레슨
	else if( "lessonCodeSrt".equals(name) || "lessonCodeSrtSp".equals(name) ){ %>
		Ext.create('Ext.form.field.ComboBox', {
			renderTo : 'id_<%= form %>_<%= name %>_fd',
			id: 'cmp_<%= form %>_<%= name %>_cb',
			name: '<%= name %>',
			width : <%= HtmlUtil.maxWidth(width) %>,
        	<%= "Y".equals(require) ? "emptyText : Ext.form.ComboBox.prototype.blankText , " : "" %> 
			<%= "Y".equals(require) ? "allowBlank : false, " : "" %>
			displayTpl: '<tpl for=".">{LESSON_NAME}</tpl>',
			valueField: 'LESSON_SEQ',
			hideLabel: true,
			queryCaching : false,
			queryMode : 'remote',
			queryParam : 'salePrdName',
            listConfig: {
                loadingText: 'Searching...',
                itemTpl: Ext.create('Ext.XTemplate', '{LESSON_NAME}'),
                emptyText: 'No matching Lesson found.'
            },
            listeners : {
            	'beforequery' : function() {
            		this.store.proxy.setExtraParam ('salePrdId', Ext.getCmp('cmp_<%= form %>_<%= dependsName %>_cb').getValue());
            	}
			    	
		    	<%= ( !"".equals(HtmlUtil.replaceNull(function)) ? "," : "") + HtmlUtil.replaceNull(function)  %>
            },
			store: Ext.create('Ext.data.JsonStore', {
						root: 'topics',
						pageSize: 20,
						remoteSort:	true,
						fields:	[ 'SALE_PRD_ID', 'LESSON_SEQ', 'LESSON_NAME' ],
						proxy: {type: 'ajax',
            					url : '../json/SalesProductCostListJson.jsp',
								reader: {
											type: 'json',
											root: 'topics',
											totalProperty: 'totalCount'
										}
								}
					})
       	}).validate();
        cmps['<%= form %>'] = cmps['<%= form %>']||[];     
        cmps['<%= form %>'].push('cmp_<%= form %>_<%= name %>_cb');
<%	}else if("worldMapSeq".equals(name) ){ %>
		Ext.create('Ext.form.field.ComboBox', {
			renderTo : 'id_<%= form %>_<%= name %>_fd',
			id: 'cmp_<%= form %>_<%= name %>_cb',
			name: '<%= name %>',
			width : <%= HtmlUtil.maxWidth(width) %>,
        	<%= "Y".equals(require) ? "emptyText : Ext.form.ComboBox.prototype.blankText , " : "" %> 
			<%= "Y".equals(require) ? "allowBlank : false, " : "" %>
		    queryMode: 'local',
		    displayField: 'WORLD_MAP_NAME',
		    valueField: 'WORLD_MAP_SEQ',
		    hiddenName: '<%= name %>Value',
		    value : '<%= HtmlUtil.replaceNull(value) %>',
		    listeners: {
            	expand : function() {
		    		fs_HideFile() ;
		    	},
            	collapse : function() {
		    		fs_ShowFile();
		    	}
			    <%= ( !"".equals(HtmlUtil.replaceNull(function)) ? "," : "") + HtmlUtil.replaceNull(function)  %>
		    },
			store: Ext.create('Ext.data.SimpleStore', {
	           fields:	[ 'WORLD_MAP_SEQ', 'WORLD_MAP_NAME' ],
	           data: [
	            <%
	            	sh.query("com/Common.sql", "selectWorldMapList", null);
	            	subFirst = true;	
	            	while( sh.next()) {
	            %>
	           		<%= !subFirst ? "," : ""  %>["<%= sh.get("WORLD_MAP_SEQ") %>", "<%= sh.get("WORLD_MAP_NAME") %>"]
	            <%		
	            	subFirst = false;
	            	}         
		           		
		           		sh.close();
	            %>
			    ]
			    })
		}).validate(); 
        cmps['<%= form %>'] = cmps['<%= form %>']||[];     
        cmps['<%= form %>'].push('cmp_<%= form %>_<%= name %>_cb');
        
<%	}else if("lesson".equals(name) ){ 
%>
		<% if("Y".equals(multiple)) { %>
		
		Ext.create('Ext.ux.form.field.BoxSelect', {
            renderTo : 'id_<%= form %>_<%= name %>_cb',
            id: 'cmp_<%= form %>_<%= name %>_cb',
            name: '<%= name %>',
	    	hiddenName: '<%= name %>Value',
			msgTarget: 'title',
        	width :  <%= HtmlUtil.maxWidth(width) %>,
        	<%= "Y".equals(require) ? "emptyText : Ext.form.ComboBox.prototype.blankText , " : "" %> 
        	<%= "Y".equals(require) ? "allowBlank : false, " : "" %>
            queryMode: 'local',
            displayField: 'NAME',
            displayFieldTpl: '{NAME} ({CODE})',
            valueField: 'CODE',
            forceSelection :true,
            value :  [<%= HtmlUtil.spiltAndConcat(value) %>],
            listeners: {
				    	<%= HtmlUtil.replaceNull(function)  %>
						change : function (_this, newValue, oldValue, eOpts) {
			    		
				    	try { fs_onLessonChange(_this, newValue, oldValue, eOpts);} catch(e){  } 
						}
				    },
            store: new Ext.data.SimpleStore({
            fields: ['CODE', 'NAME', 'ORG_NAME'],
            data: [
            <%
            param = new String[3];
         	param[0] = hh.get("courseCode");
         	param[1] = hh.get("learningYearCode");
         	param[2] = hh.get("termGbn");
         	sh.query("learnProgress/EnrollRisk.sql", "selectLessonCode", param);
         	
        	int i = 0;
        	while( sh.next()) {
            %>
           	<%= !first ? "," : ""  %>['<%=sh.get( "LESSON_SEQ") %>', '<%= sh.get( "LESSON_NAME") %>', '<%= sh.get( "LESSON_NAME_ORG") %>']
            <%		
            	first = false;
           		i++;
            }  
        	sh.close();
            %>
		    ]
            })
	    }).validate();
	    
	    cmps['<%= form %>'] = cmps['<%= form %>']||[];     
	    cmps['<%= form %>'].push('cmp_<%= form %>_<%= name %>_cb');
	    
	   <%} %>

<%	}
	// lcms상품 조회.
	else if("lcmsPrdId".equals(name) ){ %>
		Ext.create('Ext.form.field.ComboBox', {
			renderTo : 'id_<%= form %>_<%= name %>_fd',
			id: 'cmp_<%= form %>_<%= name %>_cb',
			name: '<%= name %>',
			width : <%= HtmlUtil.maxWidth(width) %>,
			<%= "Y".equals(require) ? "allowBlank : false, " : "" %>
			displayTpl: '<tpl for=".">{N_LOCALE_VALUE}</tpl>',
			valueField: 'LMS_PRD_CODE',
			forceSelection :true,
		    value : '<%= HtmlUtil.replaceNull(value) %>',
			emptyText: '* Select Year/Semister',
			hideLabel: true,
			hiddenName: '<%= name %>Value',
			queryCaching : false,
			queryMode : 'remote',
			queryParam : 'productName',
			forceSelection : true,
			// typeAhead: false,
			// minChars : 4,
			trigger1Cls: 'x-form-search-trigger',
            listConfig: {
                loadingText: 'Searching...',
                itemTpl: Ext.create('Ext.XTemplate', '{N_LOCALE_VALUE}'),
                emptyText: 'No matching Product found.'
            }, 
            findRecord: function(field, value) {
			    var ds = this.store,params ={},
			        idx = ds.find(field, value);
			    if(idx === -1 && this.store.isLoading()== false && !this.initialRecordFound && this.queryMode === 'remote' && value!= '') {
			      this.initialRecordFound = true;
			      this.store.on({
			        load: {
			          fn: Ext.Function.bind(function(value) {
			            if (this.forceSelection) {
			            	if('<%= HtmlUtil.replaceNull(value) %>'== '') {
							    idx = ds.find(field, value);  // 처음 선택시 선택 안될대.. 처리.
							    return idx !== -1 ? ds.getAt(idx) : false;  // 처음 선택시 선택 안될대.. 처리.
			            	}
			            	
			              	this.setValue(value);
			            }
			            this.store.removeAll();
			          }, this, [value]),
			          single: true
			        }
			      });
			      params[this.queryParam]=value;
			      var values = '<%= HtmlUtil.replaceNull(paramValues) %>'.split(',');
			      ds.load({
			      	params: { productCode : '<%= HtmlUtil.replaceNull(value) %>',  learningYearCode : values[0],  termGbn : values[1], productGbnCode : 'BS' }
			      });
			    }
			    idx = ds.find(field, value);
			    return idx !== -1 ? ds.getAt(idx) : false;
			  }, 
            listeners : { 
            	'beforequery' : function() {
            		try { this.store.proxy.setExtraParam ('learningYearCode', Ext.getCmp('cmp_<%= form %>_learningYearCode_cb').getValue()); } catch(E) {}
            		try { this.store.proxy.setExtraParam ('termGbn', Ext.getCmp('cmp_<%= form %>_termGbn_cb').getValue());} catch(E) {}
            		try { this.store.proxy.setExtraParam ('productGbnCode', 'BS' );} catch(E) {}
            	}
		    	, change : function (_this, newValue, oldValue, eOpts) {
		    	<% if( !"".equals(HtmlUtil.replaceNull(cascadeName )))  { %>
		    		Ext.getCmp('cmp_<%= form %>_<%=cascadeName %>_cb').setValue("");
			    	Ext.getCmp('cmp_<%= form %>_<%=cascadeName %>_cb').store.clearFilter( );
		    	<% }  %>
			    	
			    	<% if( "Y".equals(require) ) { %>
			    		if( newValue == '') {
			    			_this.setRawValue('');
			    		}
			    	<% } %>
				}
			    	
		    	<%= ( !"".equals(HtmlUtil.replaceNull(function)) ? "," : "") + HtmlUtil.replaceNull(function)  %>
            },
			store: Ext.create('Ext.data.JsonStore', {
						root: 'topics',
						pageSize: 20,
						remoteSort:	true,
						fields:	[ 'PRODUCT_BRN_CODE', 'PRODUCT_BRN_ID', 'LMS_PRD_CODE', 'N_LOCALE_VALUE' ],
						proxy: {type: 'ajax',
            					url : '../json/LcmsProductListJson.jsp',
								reader: {
											type: 'json',
											root: 'topics'
										}
								
								},
            			listeners : {
							
						}		
					})
       	}).validate();
       	
        cmps['<%= form %>'] = cmps['<%= form %>']||[];     
        cmps['<%= form %>'].push('cmp_<%= form %>_<%= name %>_cb');
<%	}else if("courseCode".equals(name) ){ %>
		Ext.create('Ext.form.field.ComboBox', {
			renderTo : 'id_<%= form %>_<%= name %>_fd',
			id: 'cmp_<%= form %>_<%= name %>_cb',
			name: '<%= name %>',
			width : <%= HtmlUtil.maxWidth(width) %>,
        	<%= "Y".equals(require) ? "emptyText : Ext.form.ComboBox.prototype.blankText , " : "" %> 
			<%= "Y".equals(require) ? "allowBlank : false, " : "" %>
			displayField: 'COURSE_FULL_NAME',
			valueField: 'COURSE_CODE',
			forceSelection :true,
		    value : '<%= HtmlUtil.replaceNull(value) %>',
			hiddenName: '<%= name %>Value',
			hideLabel: true,
			queryMode : 'remote',
            findRecord: function(field, value) {
			    var ds = this.store,params ={},
			        idx = ds.find(field, value);
			    if(idx === -1 && !this.initialRecordFound && this.queryMode === 'remote' && value!= '' ) {
			      this.initialRecordFound = true;
			      this.store.on({
			        load: {
			          fn: Ext.Function.bind(function(value) {
			            if (this.forceSelection) {
			            	if('<%= HtmlUtil.replaceNull(value) %>'== '') {
							    idx = ds.find(field, value);  // 처음 선택시 선택 안될대.. 처리.
							    return idx !== -1 ? ds.getAt(idx) : false;  // 처음 선택시 선택 안될대.. 처리.
			            	}
			              this.setValue(value);
			            }
			            this.store.removeAll();
			          }, this, [value]),
			          single: true
			        }
			      });
			      params[this.queryParam]=value;
			      var values = '<%= HtmlUtil.replaceNull(paramValues) %>'.split(',');
			      ds.load({
			      	params: { productCode : '<%= HtmlUtil.replaceNull(value) %>',  learningYearCode : values[0],  termGbn : values[1], productGbnCode : 'BS' }
			      });
			    }
			    idx = ds.find(field, value);
			    return idx !== -1 ? ds.getAt(idx) : false;
			  }, 
            listeners : {
		    	<% if( !"".equals(HtmlUtil.replaceNull(cascadeName )))  { %>
		    	change : function (_this, newValue, oldValue, eOpts) {
		    		Ext.getCmp('cmp_<%= form %>_<%=cascadeName %>_cb').setValue("");
			    	Ext.getCmp('cmp_<%= form %>_<%=cascadeName %>_cb').store.clearFilter( );
			    	Ext.getCmp('cmp_<%= form %>_<%=cascadeName %>_cb').store.filter('UP_CODE',newValue);
			    	// Ext.getCmp('cmp_<%= form %>_<%=cascadeName %>_cb').store.filterBy( function(rec) { return rec.get('UP_CODE') === newValue || rec.get('UP_CODE') ==''; } ); 
				}
		    	<% }  %>
			    	
		    	<%= ( !"".equals(HtmlUtil.replaceNull(function)) ? "," : "") + HtmlUtil.replaceNull(function)  %>
            },
			store: Ext.create('Ext.data.JsonStore', {
						root: 'topics',
						pageSize: 20,
						remoteSort:	true,
						fields:	[ 'COURSE_FULL_NAME', 'COURSE_CODE', 'COURSE_NAME', 'LMS_CODE', 'TREE_ID_HIER' ],
						proxy: {type: 'ajax',
            					url : '../json/LcmsCourseListJson.jsp',
            					extraParams : { lmsCodeList: 'NP' }, // TODO NP로 변경..
								reader: {
											type: 'json',
											root: 'topics'
										}
								}
					})
       	}).validate();
        cmps['<%= form %>'] = cmps['<%= form %>']||[];     
        cmps['<%= form %>'].push('cmp_<%= form %>_<%= name %>_cb');
        
 <%	}else if("activityCode".equals(name) ){ %>
 
 		Ext.create('Ext.form.field.ComboBox', {
			renderTo : 'id_<%= form %>_<%= name %>_fd',
			id: 'cmp_<%= form %>_<%= name %>_cb',
			name: '<%= name %>',
			width : <%= HtmlUtil.maxWidth(width) %>,
        	<%= "Y".equals(require) ? "emptyText : Ext.form.ComboBox.prototype.blankText , " : "" %> 
			<%= "Y".equals(require) ? "allowBlank : false, " : "" %>
		    queryMode: 'local',
		    displayField: 'NAME',
		    valueField: 'CODE',
		    hiddenName: '<%= name %>Value',
		    forceSelection :true,
		    value : '<%= HtmlUtil.replaceNull(value) %>',
			store: Ext.create('Ext.data.SimpleStore', {
	           fields:	[ 'CODE', 'NAME' ],
	           data: [
	            <%
	            	sh.query("com/Common.sql", "selectActivityCodeList", null);
	           		if( "all".equals(head)  ) {
           				subFirst = false;
    	    %>
	           			["", "-<%= "all".equals(head) ? "전체" :"선택"  %>-"]
            <%
            		}	
	            	while( sh.next()) {
	            %>
	           		<%= !subFirst ? "," : ""  %>["<%= sh.get("CODE") %>", "<%= sh.get("NAME") %>"]
	            <%	
	            		subFirst = false;
	            	}         
		           		
		           		sh.close();
	            %>
			    ]
			    })
		}).validate(); 
        cmps['<%= form %>'] = cmps['<%= form %>']||[];     
        cmps['<%= form %>'].push('cmp_<%= form %>_<%= name %>_cb');
        
<%	}else if("lessonSeq".equals(name) ){ %>
		Ext.create('Ext.form.field.ComboBox', {
			renderTo : 'id_<%= form %>_<%= name %>_fd',
			id: 'cmp_<%= form %>_<%= name %>_cb',
			name: '<%= name %>',
			width : <%= HtmlUtil.maxWidth(width) %>,
			<%= "Y".equals(require) ? "allowBlank : false, " : "" %>
			displayField: 'LESSON_NAME',
			valueField: 'LESSON_SEQ',
			forceSelection :true,
		    value : '<%= HtmlUtil.replaceNull(value) %>',
			hiddenName: '<%= name %>Value',
			queryCaching : false,
			hideLabel: true,
			queryMode : 'remote',
			emptyText: '* Select LCMS Product',
            findRecord: function(field, value) {
			    var ds = this.store,params ={},
			        idx = ds.find(field, value);
			    if(idx === -1 && !this.initialRecordFound && this.queryMode === 'remote' && value!= '' ) {
			      this.initialRecordFound = true;
			      this.store.on({
			        load: {
			          fn: Ext.Function.bind(function(value) {
			            if (this.forceSelection) {
			            	if('<%= HtmlUtil.replaceNull(value) %>'== '') {
							    idx = ds.find(field, value);  // 처음 선택시 선택 안될대.. 처리.
							    return idx !== -1 ? ds.getAt(idx) : false;  // 처음 선택시 선택 안될대.. 처리.
			            	}
			              this.setValue(value);
			            }
			            this.store.removeAll();
			          }, this, [value]),
			          single: true
			        }
			      });
			      params[this.queryParam]=value;
			      var values = '<%= HtmlUtil.replaceNull(paramValues) %>'.split(',');
			      ds.load({
			      	params: { lmsProductCode:  values[0] }
			      });
			    }
			    idx = ds.find(field, value);
			    return idx !== -1 ? ds.getAt(idx) : false;
			  },
            listeners : { 
            	'beforequery' : function() {
            		try { this.store.proxy.setExtraParam ('lmsProductCode', Ext.getCmp('cmp_<%= form %>_<%=dependsName%>_cb').getValue()); } catch(E) {}
            	}
            },
			store: Ext.create('Ext.data.JsonStore', {
						root: 'topics',
						pageSize: 20,
						remoteSort:	true,
						fields:	[ 'LESSON_NAME', 'LESSON_SEQ'],
						proxy: {type: 'ajax',
            					url : '../json/LessonJson.jsp',
            					extraParams : { lmsProductCode:  Ext.getCmp('cmp_<%= form %>_<%=dependsName %>_cb').getValue() }, 
								reader: {
											type: 'json',
											root: 'topics'
										}
								}
					})
       	}).validate();
        cmps['<%= form %>'] = cmps['<%= form %>']||[];     
        cmps['<%= form %>'].push('cmp_<%= form %>_<%= name %>_cb');
               
    
<%	}else if("TODO".equals(name) ){ %>

<%	}else {%>

<% } %>
<%} %>
<% sh.close(); %>