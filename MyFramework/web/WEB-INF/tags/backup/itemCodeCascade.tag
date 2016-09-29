<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag
	import="pjt.epolylms.util.HtmlUtil"
	import="java.util.HashMap"
	import="java.util.Map"
	import="java.util.List"
%>

<%@ attribute name="title" type="java.lang.String"  %>
<%@ attribute name="area" type="java.lang.String" required="true" %> <%-- html / script / grid 중 택1 --%>
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
<%@ attribute name="dependsName" type="java.lang.String"  required="true" %> <%-- Cascading대상  --%>
<%@ attribute name="treeLevel" type="java.lang.String" %><%-- combobox시 해당 level의 값을 표시 --%>


<%@ attribute name="td_name" type="java.lang.String" %>

<jsp:useBean id="seh" class="systemwiz.jfw.jsp.SessionHelper" />
<%
	seh.getSession(request, false);

	String HO_T_SYS_MEMBER_NO = seh.get("S_MEMBER_NO");
	String HO_T_SYS_LANG = "KR"; // seh.get("S_LANG");	// en,it,de,ru, ko
	String HO_T_SYS_COMP = seh.get("S_COMP");	// 0001
	
%>

<% if( area.equalsIgnoreCase("html") ) {
	HashMap<String, String[]> titleMap = new HashMap<String, String[]>();

	titleMap.put("voucherTypeCode", new String [] {"바우처유형" ,"voucherTypeCode"});
	titleMap.put("voucherSeq", new String [] {"바우처명" ,"voucherSeq"});
	titleMap.put("salePrdIdSp", new String [] {"별도상품명" ,"salePrdIdSp"});
	titleMap.put("badgeName", new String [] {"종류" ,"badgeName"});
	titleMap.put("badgeSeq", new String [] {"종류" ,"badgeSeq"});
	titleMap.put("lessonSeq", new String [] {"Lesson" ,"lessonSeq"});
	titleMap.put("activityCode", new String [] {"Activity" ,"activityCode"});
	titleMap.put("", new String [] {"" ,""});
	
	if( title == null || "".equals(title)) {
		String [] titles = titleMap.get(name);
		if(td_name != null) titles = titleMap.get(td_name);
			
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
		            width : <%= HtmlUtil.maxWidth(width) %>,
					allowBlank : <%= "Y".equals(require) ? "false" : "true" %>,
					store: Ext.create('Ext.data.SimpleStore', {
						id : 'grid_store_combo_<%= name %>',
			            fields: ['SYSTEM_CODE', 'COMMON_CODE', 'CODE', 'NAME','UP_CODE'],
			            data: [
			            <%
			            	if( "all".equals(head) || "choice".equals(head)  ) {
			            		first = false;
			    	    %>
				           		['', '', '','-<%= "all".equals(head) ? "전체" :"선택"  %>-', '']
			            <%
			            	}
			            	for( int i=0 ; codeList!= null && i<codeList.size() ; i++ ) {
			            		codeMap  = codeList.get(i);
			            %>
			           		<%= !first ? "," : ""  %>['<%=codeMap.get( "SYSTEM_CODE") %>', '<%= codeMap.get("COMMON_CODE") %>', '<%= codeMap.get("CODE") %>','<%= codeMap.get("NAME") %>', "<%= codeMap.get("UP_CODE") %>"]
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
				    // hiddenName: '<%= name %>',
				    value : '<%= HtmlUtil.replaceNull(value) %>',
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
%>

        
	<% if( view==null || "".equals(view) || "combo".equals(view) || "select".equals(view) ) { %>
		<% if("Y".equals(multiple)) { %>
		Ext.create('Ext.ux.form.field.BoxSelect', {
                renderTo : 'id_<%= form %>_<%= name %>',
                id: 'cmp_<%= form %>_<%= name %>_cb',
                name: '<%= name %>',
		    	hiddenName: '<%= name %>Value',
				msgTarget: 'title',
                // emptyText: 'Pick a state, any state',
            	width : <%= HtmlUtil.maxWidth(width) %>,
        		<%= "Y".equals(require) ? "emptyText : Ext.form.ComboBox.prototype.blankText , " : "" %> 
                <%= "Y".equals(require) ? "allowBlank : false, " : "" %>
                queryMode: 'local',
                displayField: 'NAME',
                displayFieldTpl: '{NAME} ({CODE})',
                valueField: 'CODE',
			    value :  '<%= HtmlUtil.replaceNull(value) %>',
                store: new Ext.data.SimpleStore({
	            fields: ['SYSTEM_CODE', 'COMMON_CODE', 'CODE', 'NAME','UP_CODE'],
	            data: [
	            <%
            		if( "all".equals(head) || "choice".equals(head)  ) {
            			first = false;
	    	    %>
		           		["", "", "","-<%= "all".equals(head) ? "전체" :"선택"  %>-", ""]
	            <%
            		}
	            	for( int i=0 ; codeList!= null && i<codeList.size() ; i++ ) {
	            		codeMap  = codeList.get(i);
	            		if( !HtmlUtil.replaceNull(treeLevel,"1").equals(codeMap.get("TREE_LEVEL")))  {
	            			continue;
	            		}
	            %>
	           		<%= !first ? "," : ""  %>["<%=codeMap.get( "SYSTEM_CODE") %>", "<%= codeMap.get("COMMON_CODE").replaceAll(" ", "") %>", "<%= codeMap.get("CODE").replaceAll(" ", "") %>","<%= codeMap.get("NAME") %>", "<%= codeMap.get("UP_CODE") %>"]
	            <%		
	            		first = false;
	            	}            
	            %>
			    ],
			    sortInfo: {field: 'NAME', direction: 'ASC'},
			    listeners: {            	
				    expand : function() {
			    		fs_HideFile() ;
			    	},
	            	collapse : function() {
			    		fs_ShowFile();
			    	} 	
			    	<%= (!"".equals(HtmlUtil.replaceNull(function)) ? "," : "") +  HtmlUtil.replaceNull(function)  %>
			    }
	        })
        }).validate();
		//try {Ext.getCmp('cmp_<%= form %>_<%=name %>_cb').store.clearFilter( );} catch(E) {}
        // Ext.getCmp('cmp_<%= form %>_<%=name %>_cb').store.filter('UP_CODE',Ext.getCmp('cmp_<%= form %>_<%=dependsName %>_cb').getValue());
        
		try {
			Ext.getCmp('cmp_<%= form %>_<%=name %>_cb').store.filter([
			    {property: "UP_CODE", value: Ext.getCmp('cmp_<%= form %>_<%=dependsName %>_cb').getValue() },
			    {filterFn: function(rec) { return (rec.get('CODE') === '' || rec.get('UP_CODE') === Ext.getCmp('cmp_<%= form %>_<%=dependsName %>_cb').getValue()); }}
			]);
		} catch(e) {}
        
		/* 
        //Ext.getCmp('cmp_<%= form %>_<%=name %>_cb').store.filterBy( function(rec) {
       	//	return (rec.get('UP_CODE') === Ext.getCmp('cmp_<%= form %>_<%=dependsName %>_cb').getValue() || rec.get('UP_CODE') === '');
        // } ); // 'UP_CODE',Ext.getCmp('cmp_<%= form %>_<%=dependsName %>_cb').getValue());
        */
        cmps['<%= form %>'] = cmps['<%= form %>']||[];     
        cmps['<%= form %>'].push('cmp_<%= form %>_<%= name %>_cb');
		<% } else { %>
		Ext.create('Ext.form.field.ComboBox', {
            renderTo : 'id_<%= form %>_<%= name %>',
            id: 'cmp_<%= form %>_<%= name %>_cb',
            name: '<%= name %>',
            hiddenName: '<%= name %>Value',
            width : <%= HtmlUtil.maxWidth(width) %>,
        	<%= "Y".equals(require) ? "emptyText : Ext.form.ComboBox.prototype.blankText , " : "" %> 
			allowBlank : <%= "Y".equals(require) ? "false" : "true" %>,
			store: Ext.create('Ext.data.SimpleStore', {
	            fields: ['SYSTEM_CODE', 'COMMON_CODE', 'CODE', 'NAME','UP_CODE'],
	            data: [
	            <%
	            	if( "all".equals(head) || "choice".equals(head)  ) {
	            		first = false;
	    	    %>
		           		["", "", "","-<%= "all".equals(head) ? "전체" :"선택"  %>-", ""]
	            <%
	            	}
	            	for( int i=0 ; codeList!= null && i<codeList.size() ; i++ ) {
	            		codeMap  = codeList.get(i);
	            		if( !HtmlUtil.replaceNull(treeLevel,"1").equals(codeMap.get("TREE_LEVEL")))  {
	            			continue;
	            		}
	            %>
	           		<%= !first ? "," : ""  %>["<%=codeMap.get( "SYSTEM_CODE").replaceAll(" ", "") %>", "<%= codeMap.get("COMMON_CODE").replaceAll(" ", "") %>", "<%= codeMap.get("CODE").replaceAll(" ", "") %>","<%= codeMap.get("NAME") %>","<%= codeMap.get("UP_CODE") %>"]
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
		    // hiddenName: '<%= name %>',
		    forceSelection :true,
		    value : '<%= HtmlUtil.replaceNull(value) %>',
		    listeners: {
            	expand : function() {
		    		fs_HideFile() ;
		    	},
            	collapse : function() {
		    		fs_ShowFile(); 
		    	} 	
		    	<%= (!"".equals(HtmlUtil.replaceNull(function)) ? "," : "") + HtmlUtil.replaceNull(function)  %>
		    }
		}).validate(); 
        //Ext.getCmp('cmp_<%= form %>_<%=name %>_cb').store.filter('UP_CODE', '1');
        Ext.getCmp('cmp_<%= form %>_<%=name %>_cb').store.filter('UP_CODE',Ext.getCmp('cmp_<%= form %>_<%=dependsName %>_cb').getValue());
        //Ext.getCmp('cmp_<%= form %>_<%=name %>_cb').store.filterBy( function(rec) { return rec.get('UP_CODE') === Ext.getCmp('cmp_<%= form %>_<%=dependsName %>_cb').getValue() || rec.get('UP_CODE') == '1'; } );
        cmps['<%= form %>'] = cmps['<%= form %>']||[];     
        cmps['<%= form %>'].push('cmp_<%= form %>_<%= name %>_cb');
		<% } %>
	<% } %>
<% } %>
