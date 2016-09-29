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
	import="java.util.Date"
	import="java.text.DateFormat"
	import="project.jun.util.HoValidator"
	import="project.jun.dao.parameter.HoQueryParameterHandler"
	import="project.jun.util.HoServletUtil"
%>
<%@ include file="include.tag" %>
<%@ attribute name="title" type="java.lang.String"  %>
<%@ attribute name="type" type="java.lang.String" %>
<%@ attribute name="groupCode" type="java.lang.String" %>
<%@ attribute name="first" type="java.lang.String" %>
<%@ attribute name="name" type="java.lang.String" %>
<%@ attribute name="value" type="java.lang.String" %>
<%@ attribute name="id" type="java.lang.String" %>
<%@ attribute name="require" type="java.lang.String" %><%-- 필수여부 : ('Y', true) 필수 / '기타' 선택  --%>
<%@ attribute name="vtype" type="java.lang.String" %>
<%@ attribute name="folder" type="java.lang.String" %><%-- fileupload시 파일이 등록될 폴더명 (type="file")에서만 사용 --%>

<% 	if( isScript || isScriptOut ) {

		String nowArea = HoServletUtil.getNowArea(request);


		if( !"fieldcontainer".equals(nowArea)) {
			HoServletUtil.setInArea(request, "fieldcontainer");
			HoServletUtil.initIndex(request, HoServletUtil.getArea(request));
			int itemsRow = HoServletUtil.getIndex(request, HoServletUtil.getArea(request)+"_row");
			HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request)+"_row");
			out.println( (itemsRow > 0 ? "," : "") +"		");
			out.println("			{ xtype: 'fieldcontainer', layout: { type: 'hbox', defaultMargins: {top: "+(itemsRow > 0 ? "0" : "1")+", right: 5, bottom: 0, left: 5} }, items: [");
		}

		int itemNowIndex = HoServletUtil.getIndex(request, HoServletUtil.getArea(request));
		int increaseIndex = getIndexIncrement( type );

		// out.println("<br/>" + HoServletUtil.getArea(request) + ":" +  itemNowIndex + ":"+ increaseIndex );
		if( itemNowIndex + increaseIndex > MAX_ROW_ITEM_SEARCH ) {
			HoServletUtil.initIndex(request, HoServletUtil.getArea(request)+">item_row");
			out.println("] }");
			HoServletUtil.initIndex(request, HoServletUtil.getArea(request));
			String area = HoServletUtil.getNowArea(request);

			HoServletUtil.setOutArea(request);
			HoServletUtil.setInArea(request, "fieldcontainer");
			int itemsRow = HoServletUtil.getIndex(request, HoServletUtil.getArea(request)+"_row");
			HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request)+"_row");
			out.println( (itemsRow > 0 ? "," : "") +"		");
			if( "grid".equals(type) && HoServletUtil.getArea(request).indexOf("section")>0 )  {
				out.println("			{ xtype: 'fieldcontainer', layout: { type: 'hbox', defaultMargins: {top: 0, right: 5, bottom: 0, left: 0} }, items: [");
			} else {
				out.println("			{ xtype: 'fieldcontainer', layout: { type: 'hbox', defaultMargins: {top: 0, right: 5, bottom: 0, left: 5} }, items: [");
			}
		}

		HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request), increaseIndex );
		HoServletUtil.setInArea(request, "item");
		out.println(HoServletUtil.getIndex(request, HoServletUtil.getArea(request)+"_row") > 0 ? "," : "");
		HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request)+"_row");

	if( "radio".equals(type)) {  %>
			{	
				xtype      : 'radiogroup_ux',   columns: 'auto', msgTarget  : 'side', 
				width    : 100*3 + <%=labelWidth %>, labelWidth : <%=labelWidth %>, 
		        fieldLabel : '<%= title %>', <%= HoValidator.isIn(require, new String[]{"Y","true"}, true) ? "allowBlank : false, labelCls   : 'x-form-item-label x-form-item-label-required'," : "" %>
				defaults : { name: '<%= name %>' },
         		// TODO id : '<%=p_action_flag %>_<%= HoServletUtil.getString(request, "form-id") %>_<%= HoUtil.replaceNull(id, name) %>',
				commentsTitle : 'OK 한글',  // 추가 Comments Title 
				comments : '한글 your help text or even html comes here....',  // 추가 Comments 내용
		            items : [{
		            	width : 100,
		                boxLabel: 'Red',
	                	afterBoxLabelTpl : Ext.String.format(G_HELP_TIP_TPL , '<%= p_action_flag+"_"+HoServletUtil.getString(request, "form-id") +"_"+name %>-red-help', 'Dog', 'Help ...' ), 
		                inputValue: 'red'
		            }, {
		            	width : 100,
		                boxLabel: 'Blue',
		                inputValue: 'blue'
		            }, {
		            	width : 100,
		                boxLabel: 'Green',
		                inputValue: 'green'
		            }]
			}
<%		} else if( "checkbox".equals(type)) { %>
			{
	            xtype      : 'checkboxgroup_ux',  columns    : 'auto', msgTarget  : 'side',  
	            width      : 100*3 + <%=labelWidth %>, labelWidth : <%=labelWidth %>, 
	            fieldLabel : '<%= title %>', <%= HoValidator.isIn(require, new String[]{"Y","true"}, true) ? "allowBlank : false, labelCls   : 'x-form-item-label x-form-item-label-required'," : "" %>
				defaults : { name: '<%= name %>' },
         		// TODO id : '<%=p_action_flag %>_<%= HoServletUtil.getString(request, "form-id") %>_<%= HoUtil.replaceNull(id, name) %>',
				commentsTitle : 'OK 한글',  // 추가 Comments Title 
				comments : '한글 your help text or even html comes here....',  // 추가 Comments 내용
	            items : [{
	            	width : 100,
	                boxLabel: 'Dog ',
	                afterBoxLabelTpl : Ext.String.format(G_HELP_TIP_TPL , '<%= p_action_flag+"_"+HoServletUtil.getString(request, "form-id") +"_"+name %>-dog-help', 'OK 한글', '한글 your help text or even html comes here....' ),
	                value: 'dog',
	                inputValue: 'dog'
	            }, {
	            	width : 100,
	                boxLabel: 'Cat' ,
	                afterBoxLabelTpl : Ext.String.format(G_HELP_TIP_TPL , '<%= p_action_flag+"_"+HoServletUtil.getString(request, "form-id") +"_"+name %>-cat-help', 'OK 한글', '한글 your help text or even html comes here....' ),
	                value: 'cat',
	                inputValue : 'cat'
	            }, {
	            	width : 100,
	                boxLabel: 'Monkey'  ,
	                afterBoxLabelTpl : Ext.String.format(G_HELP_TIP_TPL , '<%= p_action_flag+"_"+HoServletUtil.getString(request, "form-id") +"_"+name %>-monkey-help', 'OK 한글', '한글 your help text or even html comes here....' ),
	                value: 'monkey',
	                inputValue: 'monkey'
	            }] 
			}
<%		} else if( "combo".equals(type) || "select".equals(type) ){ %>
			{
		        xtype         : 'combotipple', 
		        width         : 320,  labelWidth : <%=labelWidth %>,
		        fieldLabel    : '<%= title %>', <%= HoValidator.isIn(require, new String[]{"Y","true"}, true) ? "allowBlank : false, labelCls   : 'x-form-item-label x-form-item-label-required'," : "" %>
		        name          : '<%= name %>',
         		// TODO id : '<%=p_action_flag %>_<%= HoServletUtil.getString(request, "form-id") %>_<%= HoUtil.replaceNull(id, name) %>',
				commentsTitle : 'OK 한글', 
				comments : '한글 your help text or even html comes here....', 
		        displayField  : 'NAME',
		        valueField    : 'VALUE',
		        value         : 'mrs',
		        queryMode     : 'local',
		        triggerAction : 'all',
		        forceSelection: true,
		        // editable      : false,
		        code          : 'X10', 
		        store         : Ext.create('Ext.data.Store', {
		            fields    : ['NAME', 'VALUE', 'GROUP', 'COMMENTS_TITLE', 'COMMENTS' ],
		            data      : [
		                {NAME : 'Mr',   VALUE : 'mr'  , GROUP : '1', COMMENTS_TITLE : 'mr-Title'  , COMMENTS : 'mr-comments'},
		                {NAME : 'Mrs',  VALUE : 'mrs' , GROUP : '1', COMMENTS_TITLE : 'mrs-Title' , COMMENTS : 'mrs-comments'},
		                {NAME : 'Miss', VALUE : 'miss', GROUP : '1', COMMENTS_TITLE : 'miss-Title', COMMENTS : 'miss-comments'}
		            ]
		        })
		     }
<%		} else if( "text".equals(type) ) { %>
			{
				xtype      : 'textfield_ux',  msgTarget  : 'side',
				width      : 320, labelWidth : <%=labelWidth %>,
				fieldLabel : '<%= title %>', <%= HoValidator.isIn(require, new String[]{"Y","true"}, true) ? "allowBlank : false, labelCls   : 'x-form-item-label x-form-item-label-required'," : "" %>
				name       : '<%= name %>',
				id : '<%=p_action_flag %>_<%= HoServletUtil.getString(request, "form-id") %>_<%= HoUtil.replaceNull(id, name) %>',
				value     : '<%= HoUtil.replaceNull(value) %>',
				commentsTitle : 'OK 한글',  // 추가 Comments Title 
				comments : '한글 your help text or even html comes here....',  // 추가 Comments 내용
				<%=  !HoValidator.isEmpty(vtype) ? "vtype: '"+vtype+"'," : "" %>	
				// encryptType : 'sha256', <-- 암호화 하고 싶을 경우 이 속성 추가..		
				qtip       : '<%= title %>'
			}
<%		} else if( "passsword".equals(type) ) { %>
			{
				xtype     : 'password_ux', msgTarget  : 'side',
				width     : 320, labelWidth : <%=labelWidth %>,
				fieldLabel: '<%= title %>', <%= HoValidator.isIn(require, new String[]{"Y","true"}, true) ? "allowBlank : false, labelCls   : 'x-form-item-label x-form-item-label-required', " : "" %>
				name      : '<%= name %>',
				// TODO id : '<%=p_action_flag %>_<%= HoServletUtil.getString(request, "form-id") %>_<%= HoUtil.replaceNull(id, name) %>',
				value     : '<%= HoUtil.replaceNull(value) %>',
				commentsTitle : 'OK 한글',  // 추가 Comments Title 
				comments : '한글 your help text or even html comes here....',  // 추가 Comments 내용
				<%=  !HoValidator.isEmpty(vtype) ? "vtype: '"+vtype+"'," : "" %>
				msgTarget: 'side'
			}
<%		} else if( "textarea".equals(type) ) { %>
			{
				xtype     : 'textarea_ux', msgTarget: 'side' ,
				width     : 500 + <%=labelWidth %>,  labelWidth : <%=labelWidth %>,
				fieldLabel: '<%= title %>', <%= HoValidator.isIn(require, new String[]{"Y","true"}, true) ? "allowBlank : false, labelCls   : 'x-form-item-label x-form-item-label-required'," : "" %>
				name      : '<%= name %>',
				// TODO id : '<%=p_action_flag %>_<%= HoServletUtil.getString(request, "form-id") %>_<%= HoUtil.replaceNull(id, name) %>',
				commentsTitle : 'OK 한글',  // 추가 Comments Title 
				comments : '한글 your help text or even html comes here....',  // 추가 Comments 내용
				maxLength : 400, 
				plugins: ['counter']  // CounterCheck.js
			}
<%		} else if( "label".equals(type) ) { %>
			{
				xtype: 'displayfield_ux', msgTarget: 'side' ,
				width     : 320, labelWidth : <%=labelWidth %>,
				fieldLabel: '<%= title %>', <%= HoValidator.isIn(require, new String[]{"Y","true"}, true) ? "allowBlank : false, labelCls   : 'x-form-item-label x-form-item-label-required'," : "" %>
				name      : '<%= name %>',
				// TODO id : '<%=p_action_flag %>_<%= HoServletUtil.getString(request, "form-id") %>_<%= HoUtil.replaceNull(id, name) %>',
				commentsTitle : 'OK 한글',  // 추가 Comments Title 
				comments : '한글 your help text or even html comes here....',  // 추가 Comments 내용
				value: '<%= HoUtil.replaceNull(value) %>'
			}
<%		} else if( "file".equals(type) ) { %>
			{
				xtype     : 'filefield_ux',  msgTarget: 'side' ,
				width     : 500+ <%=labelWidth %>, labelWidth : <%=labelWidth %>,
				fieldLabel: '<%= title %>', <%= HoValidator.isIn(require, new String[]{"Y","true"}, true) ? "allowBlank : false, labelCls   : 'x-form-item-label x-form-item-label-required'," : "" %>
				<%= HoValidator.isIn(require, new String[]{"Y","true"}, true) ? "allowBlank : false," : "" %>
				name      : '<%= name %>',
				commentsTitle : 'OK 한글',  // 추가 Comments Title 
				comments : '한글 your help text or even html comes here....',  // 추가 Comments 내용
				value: '<%= HoUtil.replaceNull(value) %>'
			}
			<% 	if( HoValidator.isNotEmpty(folder)) { %>
			,{ xtype     : 'hidden', width     : 300, name      : 'folder_<%= name %>', value     : '<%= HoUtil.replaceNull(folder) %>' }
			<% 	} %>	
<%	} else if( "hidden".equals(type)) { %>
			{
				xtype     : 'hidden',
				width     : 320,
				name      : '<%= name %>',
				value     : '<%= HoUtil.replaceNull(value) %>'
			}
<%	} else if( "toggle".equals(type)) { %>
			{	xtype      : 'toggleslidefield',  msgTarget  : 'side',  
				width     : 200 + <%=labelWidth %>, labelWidth : <%=labelWidth %>,
				fieldLabel: '<%= title %>',
				<%= HoValidator.isIn(require, new String[]{"Y","true"}, true) ? "allowBlank : false," : "" %>
				name      : '<%= name %>',
				booleanMode : false,
	            // width      : 100*3 + <%=labelWidth %>, labelWidth : <%=labelWidth %>, 
				value : '<%= HoUtil.replaceNull(value) %>',
	            onText: 'online', 
	            offText: 'offline'
			}
<%	} else if( "grid".equals(type)) { %> 			
			{ 
				xtype :'label_ux', 
				labelWidth : <%=labelWidth %>,
				fieldLabel : '<%= title  %>', <%= HoValidator.isIn(require, new String[]{"Y","true"}, true) ? "allowBlank : false, labelCls   : 'x-form-item-label x-form-item-label-required'," : "" %>
				commentsTitle : 'OK 한글',  // 추가 Comments Title 
				comments : '한글 your help text or even html comes here....',  // 추가 Comments 내용
				value: '<%= HoUtil.replaceNull(value) %>'
			}, //, style : 'width:100px; padding-left:5px;' width : <%=HoServletUtil.getArea(request).indexOf("section")>0 ? "90" : "95"%> },
			<jsp:doBody></jsp:doBody>
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
