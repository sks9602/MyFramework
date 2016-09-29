<%@ tag language="java" pageEncoding="UTF-8"
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
%><%@ taglib prefix="spring"  uri="http://www.springframework.org/tags" %>
<%@ include file="include.tag" %><%-- input type="XX" 형태의 component 생성 --%><%@ 
attribute name="type"   type="java.lang.String" required="true"%><%--  text, label(테두리 없이 값만 나오는 형태 - 파라미터로는 전송됨), hidden --%><%@ 
attribute name="title"  type="java.lang.String" %><%@ 
attribute name="name"   type="java.lang.String" required="true"%><%@ 
attribute name="value"  type="java.lang.String" %><%@ 
attribute name="require" type="java.lang.String" %><%-- 필수여부 : 'Y'필수 / '기타' 선택  --%><%@ 
attribute name="vtype"   type="java.lang.String" %><%@ 
attribute name="ext" type="java.lang.String" %><%-- ex) .gif, .jpg, .png, .doc  --%><%@ 
attribute name="width"    type="java.lang.String" %><%@ 
attribute name="colspan"    type="java.lang.String" %><%@ 
attribute name="rowspan"    type="java.lang.String" %><%@ 
attribute name="preview"    type="java.lang.String" %><% 	
	if( isScript || isScriptOut ) {
		String nowArea = HoServletUtil.getNowArea(request);
		
		String formId = HoServletUtil.getString(request, "form-id");

		if( !"fieldcontainer".equals(nowArea)) {
			HoServletUtil.setInArea(request, "fieldcontainer");
			HoServletUtil.initIndex(request, HoServletUtil.getArea(request));
			int itemsRow = HoServletUtil.getIndex(request, HoServletUtil.getArea(request)+"_row");
			HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request)+"_row");
			out.print( (itemsRow > 0 ? "," : "") +"		");
		}

		int itemNowIndex = HoServletUtil.getIndex(request, HoServletUtil.getArea(request));
		int increaseIndex = getIndexIncrement( type );

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

		name = HoUtil.replaceNull(name).toUpperCase();

		// 개발 모드 일경우 form의 Item을 request에 저장.
		if( !hoConfig.isProductMode() ) {
			HoQueryParameterMap item = new HoQueryParameterMap();
			
			item.put("ITEM_NM", name);
			item.put("ITEM_TT", HoUtil.replaceNull(title));
			item.put("ITEM_TP", HoUtil.replaceNull(type));
			item.put("MAX_LENGTH", "TODO");
			item.put("VTYPES", HoUtil.replaceNull(vtype));
			setFormItemInfo( request,  param, item ); 
		}
		
		if( "file".equals(type) ) {
%>
			{
				xtype      : 'uploadfilefield', <%= HoServletUtil.getArea(request).indexOf("section") >= 0 ? "margin : '0 2 1 0'," : "" %> 
				itemId     : '<%= name.toUpperCase() %>',
				id         : '<%=p_action_flag %>_<%= formId %>_<%= name.toUpperCase() %>', // _text
				fieldLabel : '<%= title %>', <%= HoValidator.isIn(require, new String[]{"Y","true"}, true) ? "allowBlank : false, labelCls   : 'x-form-item-label x-form-item-label-required'," : "" %>
				name       : '<%= name %>',
				labelWidth : <%=labelWidth %>,
				value: '<%= HoUtil.replaceNull(value) %>',
		        <jsp:doBody></jsp:doBody>
				<%= (HoValidator.isNotEmpty(colspan) && HoValidator.isEmpty(width)) ? "width: "+ componentWidth+"*"+ colspan +"," : (HoValidator.isNotEmpty(width) ? "width: "+ width +"+" +labelWidth +"," : "") %> 
				<%= HoValidator.isNotEmpty(vtype) ? "vtype: '"+vtype+"'," : "" %>		
				<%= HoValidator.isNotEmpty(colspan) ? "colspan: "+colspan+"," : ""  %><%= HoValidator.isNotEmpty(rowspan) ? "rowspan: "+rowspan+"," : ""  %>
				<% if( HoValidator.isNotEmpty(ext)){ %>
			  	listeners:{
					afterrender:function(cmp){
						cmp.fileInputEl.set({ accept:'<%= ext %>' });
					}
				},
				<% } %>
				qtip       : '<%= title %>'
			}
<%		} else { %>	
			{
				xtype      : 'imagefield', <%= HoServletUtil.getArea(request).indexOf("section") >= 0 ? "margin : '0 2 1 0'," : "" %> 
				itemId     : '<%= name.toUpperCase() %>',
				id         : '<%=p_action_flag %>_<%= formId %>_<%= name.toUpperCase() %>', // _text
				fieldLabel : '<%= title %>', <%= HoValidator.isIn(require, new String[]{"Y","true"}, true) ? "allowBlank : false, labelCls   : 'x-form-item-label x-form-item-label-required'," : "" %>
				name       : '<%= name %>',
				labelWidth : <%=labelWidth %>,
				value: '<%= HoUtil.replaceNull(value) %>',
		        <jsp:doBody></jsp:doBody>
				<%= (HoValidator.isNotEmpty(colspan) && HoValidator.isEmpty(width)) ? "width: "+ componentWidth+"*"+ colspan +"," : (HoValidator.isNotEmpty(width) ? "width: "+ width +"+" +labelWidth +"," : "") %>
				<% if( "image".equals(type) || "audio".equals(type) || "video".equals(type)  ) { %> 
					vtype : '<%= type %>FileUpload',
				<% } else { %>
				<%= HoValidator.isNotEmpty(vtype) ? "vtype: '"+vtype+"'," : "" %>			
				<% } %>
				<%= HoValidator.isNotEmpty(colspan) ? "colspan: "+colspan+"," : ""  %><%= HoValidator.isNotEmpty(rowspan) ? "rowspan: "+rowspan+"," : ""  %>
				<% if( "image".equals(type) || "audio".equals(type) || "video".equals(type)  ) { %> 
			  	listeners:{
					afterrender:function(cmp){
						cmp.fileInputEl.set({ accept:'<%= type %>/*' });
					}
				},
				<% } else if( HoValidator.isNotEmpty(ext)){ %>
			  	listeners:{
					afterrender:function(cmp){
						cmp.fileInputEl.set({ accept:'<%= ext %>' });
					}
				},
				<% } %>
				qtip       : '<%= title %>'
			}
			<% if( "Y".equals(preview)) { %>
			, Ext.create('Ext.Img', {	
				src: '',
				html : '<span id="<%=p_action_flag %>_<%= formId %>_<%= name.toUpperCase() %>_preview_text">[ 이미지 미리보기 ]</span>',
				title : '<%= title %> 미리보기',
				frame : true,
				margin : '1 1 1 <%=labelWidth+5 %>',
				id : '<%=p_action_flag %>_<%= formId %>_<%= name.toUpperCase() %>_preview',	
				autoEl: 'div',
				<%= HoValidator.isNotEmpty(colspan) ? "colspan: "+colspan+"," : ""  %>		
				// width      : <%= HoUtil.replaceNull(width, "300")  %>,
				// resizable : true,
				border : 1,
				style: {
				    borderColor: 'blue',
				    borderStyle: 'solid'
				}
				
			})
			<% } %>			
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
