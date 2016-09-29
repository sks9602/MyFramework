<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag
	import="project.jun.dao.result.HoMap"
	import="project.jun.dao.parameter.HoQueryParameterMap"
	import="project.jun.was.HoModel"
	import="project.jun.util.HoUtil"
	import="project.jun.was.parameter.HoParameter"
	import="project.jun.was.spring.HoController"
	import="project.jun.util.HoServletUtil"
	import="project.jun.util.HoValidator"
%><%@ include file="include.tag" %>
<%@ attribute name="section" type="java.lang.String"
%><%@ attribute name="action" type="java.lang.String"
%><%@ attribute name="title" type="java.lang.String"
%><%@ attribute name="button" type="java.lang.String"
%><%@ attribute name="gridId" type="java.lang.String"
%><%@ attribute name="id" type="java.lang.String"  required="true"
%><%@ attribute name="position" type="java.lang.String"
%><%@ attribute name="hidden" type="java.lang.String"
%><%@ attribute name="delay" type="java.lang.String"
%><%-- loading 시간이 길경우 'Y' ('검색' 버튼에서만 메시지 출력) --%>
<%@ attribute name="maxItem" type="java.lang.String"
%>
<% if( isScript || isScriptOut ) {
	
	int index =  HoServletUtil.getIndex(request, HoServletUtil.getArea(request)+HoServletUtil.getString(request, "data")+"_row");

	id = HoUtil.replaceNull(id, String.valueOf(index));

	HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request)+HoServletUtil.getString(request, "data")+"_row");

	HoServletUtil.setInArea(request, "form");
	
	HoServletUtil.setString(request, "form-id", HoUtil.replaceNull(id, "form" + index));
	
	String MAX_ROW_ITEM = HoUtil.replaceNull(maxItem, "4");
	HoServletUtil.setString(request, "MAX_ROW_ITEM", MAX_ROW_ITEM);
	
%>
	<%= index > 0 ? "," : "" %>
    Ext.create('Ext.ux.FormPanel', { //Ext.form.Panel
    	<%= HoValidator.isNotEmpty(title) ? "title : '"+title+"', " : ""  %>

    <% if( !"search".equals(section) )  { %>
    	// margin : '<%= "search".equals(section) ? "5" : (HoServletUtil.getArea(request).indexOf("box") < 0 ? "5" : index > 0 ? "5" : "0") %> 5 0 5',
        // margin: '<%= HoUtil.replaceNull(position).equals("south") ? "0" : "0"%> <%= HoUtil.replaceNull(position).equals("west") ? "5" : "0"%> <%= HoUtil.replaceNull(position).equals("north") ? "0" : "0"%> <%= HoUtil.replaceNull(position).equals("east") ? "5" : "0"%>',
    <% } %>
	    autoScroll: true, // Ext.isChrome  ? false : true,
	    autoHeight: true,
        url : '<%= request.getContextPath() + action %>',
        style: 'border-bottom: 1; ', // padding : 5px; 
        bodyStyle: {  'padding-top': '1px' },
        layout: { type: 'table' , columns: <%= MAX_ROW_ITEM %>, defaultMargins: {top: 0, right: 0, bottom: 1, left: 0} },   //tableAttrs: { cellspacing : Ext.isChrome ? 0 : 0  }, 
        defaults: { autoScroll: false, anchor: '100%', labelWidth: 120, margin : '0 3 1 1' }, // , tdAttrs : { cls : 'x-grid-cell' } , style : 'margin-right:5px;' , tdAttrs : { style : {border:'1px', borderColor: '#ffffff', borderStyle: 'solid'} }
        border : 1,
	    <%= "Y".equals(hidden) ? "hidden : true," : "" %> 
	    <% if( "search".equals(section) )  { %>
	    title: '검색조건', split: true, collapsible  : true, 
        region: '<%= HoUtil.replaceNull(position, "north") %>',
        iconCls:'top-search-title-icon',  // --> dockedItems에 Ext.create('Ext.panel.Header', { title : '검색조건', dock: 'top', collapsible  : true,  iconCls:'top-search-title-icon', collapsedCls : 'top-search-title'}),
        collapsedCls : 'top-search-title', // --> dockedItems에  Ext.create('Ext.panel.Header', { title : '검색조건', dock: 'top', collapsible  : true,  iconCls:'top-search-title-icon', collapsedCls : 'top-search-title'}),
        cls : 'top-search-title',
        splitterResize : false,
        section : 'search',
        <% } else { %>
        region: '<%= HoUtil.replaceNull(position, "center") %>', <%= !"center".equals(HoUtil.replaceNull(position, "center")) ? "collapsible  : true, split: true," : "" %>
        section : 'detail',
        <% } %>
       <%-- @TODO 아래의 부분(if( !hoConfig.isProductMode() {})은 실제 운영시 제거 --%>
       	<% if( !hoConfig.isProductMode() ) { // 개발모드일 경우  %>
        tools:[{
    		type:'help',
    		handler: function(event, toolEl, panelHeader) {
    			Ext.widget('window', {
				        title : '<%= HoValidator.isNotEmpty(title)  ? "["+title+"] " : ""  %>Form의 ID 정보',
				        height: 200,
				        width: 500,
				        layout: 'fit',
				        modal: true,
				        items : [
							{
								xtype :'panel',
								items : [
											{ 
												html : 'Type of Form : [<%=HoUtil.replaceNull(section, "detail") %>]'
											},
											{ 
												<%
													if( "search".equals(section))  {
														out.println(" html : 'Result Grid of Form : [" + param.get("p_action_flag")+"_grid_"+HoUtil.replaceNull(gridId) +"]'  "); // 
													} else {
														out.println(" html : 'Result Grid of Form : none'   ");
													}
												%>
											},
											{ 
												<%
													if( "search".equals(section))  {
														out.println(" html : 'Result Store of Form : [" + param.get("p_action_flag")+"_store_grid_"+HoUtil.replaceNull(gridId) +"]'  "); // 
													} else {
														out.println(" html : 'Result Store of Form : none'   ");
													}
												%>
											},
											{ 
												<%
													if( "search".equals(section))  {
														out.println(" html : 'Id of Form(Full) : ["+p_action_flag+"_search"+(HoValidator.isEmpty(id) ? "" : "_"+HoUtil.replaceNull(id))+"]'  "); // 
													} else {
														out.println(" html : 'Id of Form(Full) : ["+p_action_flag+"_detail_"+( HoValidator.isEmpty(id) ? "" : HoUtil.replaceNull(id) )+"]'   ");
													}
												%>
											},
											{ 
												<%
													if( "search".equals(section))  {
														out.println(" html : 'Id of Form : ["+ HoUtil.replaceNull(id) +"]'  "); // 
													} else {
														out.println(" html : 'Id of Form : ["+HoUtil.replaceNull(id) +"]'   ");
													}
												%>
											},
											{ 
												<%
													if( "search".equals(section))  {
														out.println(" html : 'Id of Item : ["+p_action_flag+(HoValidator.isEmpty(id) ? "" : "_"+HoUtil.replaceNull(id))+"]'  "); // 
													} else {
														out.println(" html : 'Id of Item : ["+p_action_flag+( HoValidator.isEmpty(id) ? "" : "_"+HoUtil.replaceNull(id) )+"]'   ");
													}
												%>
											}
										]
							}
				        ]
				    }).show();
				}        
			}],
        <% } %>
<%
	String formId = "";
	if( "search".equals(section))  {
		formId = p_action_flag+"_search"+(HoValidator.isEmpty(id) ? "" : "_"+HoUtil.replaceNull(id));
		out.println(" id : '"+formId+"' , "); //  p_action_flag+"_search"+(HoValidator.isEmpty(id) ? "" : "_"+HoUtil.replaceNull(id))
	} else {
		formId = p_action_flag+"_detail_"+( HoValidator.isEmpty(id) ? "" : HoUtil.replaceNull(id) );
		out.println(" id : '"+formId+"' , "); // p_action_flag+"_detail_"+( HoValidator.isEmpty(id) ? "" : HoUtil.replaceNull(id) )
	}
	// Form정보 저장을 위한 정보..
	HoServletUtil.setString(request, "F_FORM_ID", formId );

	// 개발 모드 일경우 form의 정보를을 request에 저장.
	if( !hoConfig.isProductMode() ) {
		HoQueryParameterMap item = new HoQueryParameterMap();
		
		item.put("F_FORM_ID", formId);
		item.put("F_FORM_NM", "search".equals(section)  ? "검색조건" : HoUtil.replaceNull(title, "[타이틀 없음]") );
		setFormInfo( request, param,  item ); 
	}

%>
        items   : [
<%
	String [] buttons = HoValidator.isNotEmpty(button) ? button.split("\\,") : new String [0];
%>
	<jsp:doBody></jsp:doBody>
<%

	// Form 및 Form의 구성항목의 정보를  DB에 저장
	if( !hoConfig.isProductMode() ) {
		insertFormInfo( dao, request );
	}
	String nowArea = HoServletUtil.getNowArea(request);

	if( "fieldcontainer".equals(nowArea)) {
		HoServletUtil.initIndex(request, HoServletUtil.getArea(request)+">item_row");
		HoServletUtil.setOutArea(request);
	}

	out.println("]");
	if( "search".equals(section) || buttons.length> 0 ) {
		out.println(",  dockedItems: [ {xtype: 'toolbar', dock: 'bottom', flex:1, border : true, itemId : '"+formId+"_buttonToolbar', items : [ '->', ");
		String glyph = "";
		String iconCls = "";

		String search = "";
		
		// 조회 버튼을 맨 앞에 보여 주기 위해.. 
		if( "search".equals(section) ) {
			search = "조회";  // "formBind : true," <-- form validate 전까지 버튼 비활성활 할 경우 필요 속성..
			out.print("{ xtype : 'button', glyph:'xf002@FontAwesome',  border: 1, style: { borderColor: '#99bce8', borderStyle: 'solid'},  text: '"+search+"', itemId : 'btn_"+param.get("p_action_flag") + "_" + id + "_search',  listeners : { click : function (_this, e, eOpts) { if( this.up('form').getForm().isValid() ) { "); // iconCls:'btn-icon-find', 
			// out.print("try { ");
			// 해당 jsp "xxx_조회" 함수가 있을 경우 수행.. 
			// out.print("fs_"+ param.get("p_action_flag") + "_" + HoUtil.replaceSpace(search) +"();");
			// out.print("} catch(e) { ");
			if("Y".equalsIgnoreCase(delay)) {
				out.print("Ext.MessageBox.show({ title : 'Search' , msg: 'Data is loading. Please wait...', closable : true, progressText: 'Loading...', width:300, waitConfig: {interval:100}, wait:true });  ");
			}
			out.print("try { ");
			out.print("var store = Ext.getStore('"+ param.get("p_action_flag")+"_store_grid_"+HoUtil.replaceNull(gridId) +"'); if( this.up('form').query('[id*=PAGE_SIZE]') && this.up('form').query('[id*=PAGE_SIZE]').length > 0) { store.setPageSize( this.up('form').query('[id*=PAGE_SIZE]')[0].getValue()); }     ");
			out.print("store.load({page : 1, limit : ((this.up('form').query('[id*=PAGE_SIZE]') && this.up('form').query('[id*=PAGE_SIZE]').length > 0 ) ? this.up('form').query('[id*=PAGE_SIZE]')[0].getValue() : 30 ) , params: this.up('form').getForm().getFieldValues(false)}); store.currentPage = 1; store.params = this.up('form').getForm().getFieldValues(false); ");
			out.print("try { ");
			// grid - checkbox unchecked 처리..
			out.println("var cols = Ext.getCmp('"+param.get("p_action_flag")+"_grid_"+HoUtil.replaceNull(gridId)+"').columns ");
			out.println("for( var x in cols) { ");
			out.println("	if( cols[x].getXType().indexOf('checkcolumn') >= 0 ) { ");
			out.println("		Ext.get(cols[x].getId()).down('img').removeCls('x-grid-checkcolumn-checked'); cols[x].checked = false;");
			out.println("	} ");
			out.println("} ");
			
			out.print("fs_"+ param.get("p_action_flag") + "_" + HoUtil.replaceNull(gridId) + "_" + HoUtil.replaceSpace(search) +"();");
			out.print("} catch(e) {  } ");
			out.print("store.on('load', function( _this ){ ");
			if("Y".equalsIgnoreCase(delay)) { // load 메시지팝 삭제
				out.print("Ext.MessageBox.hide(); ");
			}
			out.print("  if( (_this.getTotalCount && _this.getTotalCount() < 0) ) { "); // totalCount가 0보다 작을 경우 오류
			out.print("  	hoAlert('연결이 종료 되었습니다.', fs_goLoginPage );");
			out.print("  } else if(!_this.getTotalCount) { "); // TreeStore인 경우
			out.print("  	var records = arguments[2]; ");
			out.print("  	if(records[0].get('id') < 0 ) {  ");
			out.print("  		hoAlert('연결이 종료 되었습니다.', fs_goLoginPage );");
			out.print("  	}  ");
			out.print("  }  ");
			out.println("}); "); // end of store.on
			out.print("} catch(e) {   "); //
			out.print("	 	alert(' form.tag -> ' + e);	");
			out.print("}"); // end of catch
			out.print("} else { this.up('form').getForm().findInvalid(); } } } }");
		}
		HoMap btnMap = null;
		String btnDisplayName = null;
		String btnSql = "";
		String [] btnInfo = null; 
		for( int i=0 ; i< buttons.length ; i++ ) {
			btnInfo = buttons[i].split("\\:");
			
			if( btnInfo.length > 1 ) {
				btnSql = btnInfo[1];
			} else {
				btnSql = "";
			}
			if( !"조회".equals( btnInfo[0] )) {
				out.print( (!"".equals(search) || i>0) ? "," : "");

				btnMap = (HoMap) BUTTON_SET_MAP.get( btnInfo[0] );
 				if (btnMap !=null) {
 					glyph = btnMap.getString("GLYPH");
 					iconCls = btnMap.getString("ICON_CLS");
 					btnDisplayName = btnMap.getString("BTN_NM");
 				} else {
 					glyph = "";
 					iconCls = "";
 					btnDisplayName = btnInfo[0] ;
 				}
 				

				out.print("{ xtype : 'badgebutton',  border: 1, style: { borderColor: '#99bce8', borderStyle: 'solid'} , text: '"+btnDisplayName+"', itemId : 'btn_"+param.get("p_action_flag") + "_" + id + "_" + HoUtil.replaceSpace(btnDisplayName) + "'");
				if( !"".equals(glyph)) {
					out.print(" , glyph:'x"+glyph+"@FontAwesome' ");
				} else {
					out.print(( !"".equals(HoUtil.replaceNull(iconCls)) ? ", iconCls:'"+iconCls+"'" : "" ));
				}
				// out.print(" , handler : fs_"+ param.get("p_action_flag") + "_" + id + "_" + HoUtil.replaceSpace(btnDisplayName) ); //"+ param.get("p_action_flag") +"
				out.print(" , listeners: {  ");
				out.print("			click: function() { ");
				out.print(" 			Ext.Function.defer(fs_"+ param.get("p_action_flag") + "_" + id + "_" + HoUtil.replaceSpace(btnDisplayName) +", 0, this )" ); //"+ param.get("p_action_flag") +"
				out.print("			} ");
				/*
				if( !"".equals(btnSql)) {
					out.print("			,mouseover: function(_btn, e, eOpts) { ");
					out.print("				var form = Ext.getCmp('"+p_action_flag+"_detail_form_btn'); ");
					out.print("				if(form) { ");
					out.print("					var formSqlId = form.child('#SQL_ID'); ");
					out.print("					if( formSqlId ) { ");
					out.print("						formSqlId.setValue('"+btnSql+"'); ");
					out.print("						function _setButton(_form, _action) { if ( 'N' == _action.result.datas[0]['IS_AVAILABLE'] ) { _btn.setDisabled(true); _btn.setTooltip( _action.result.datas[0]['BTN_MSG'] );  }  } ");
					out.print("						form.submit({success : function(form, action) { _setButton(form, action); }, failure: function(form, action) { _setButton(form, action); },isForceSave : true}); ");
					out.print("					} ");
					out.print("				} ");
					out.print("		  	}, mouseout: function(_btn, e, eOpts ) { ");
					out.print("		  		_btn.setDisabled(false); _btn.setTooltip( null ); ");
					out.print("		  	} ");
				}
				*/
				out.print("   }  ");
				out.print("}"); //"+ param.get("p_action_flag") +"
			}
		}
		if( !hoConfig.isProductMode() ) { // 개발모드일 경우 
			// @TODO FORM저장 & GRID에서 조회 & RESTOR처리..
			out.println(", { xtype : 'button', border: 1, iconCls:'formItemSave', style: { borderColor: '#99bce8', borderStyle: 'solid'} , text: '내용저장', itemId : 'btn_"+param.get("p_action_flag") + "_" + id + "_form_list', ");
			out.println("	 handler : function() { ");
			out.println("		Ext.MessageBox.prompt('Name', '이력  제목 :', fs_form_submit); ");
			out.println("			function fs_form_submit(btn, text) { ");
			out.println("				if( btn == 'ok') { ");
			out.println("					var form = Ext.getCmp('"+ formId +"'); ");
			out.println("					form.submit({ uxNotification : true, manager : 'form1', url : '"+ request.getContextPath()+"/system/develope.do', isForceSave : true, p_action_flag : 'b_list_form_history', params : { COMPANY_ID : '0000', SYSTEM_ID : 'S', F_MENU_ID : '"+param.get("MENU_ID")+"', F_FORM_ID : '"+formId+"', 'HISTORY_NM' : text } }); ");
			out.println("				} ");
			out.println("			} ");
			out.println("		} ");
			out.println("	}"); // TODO F_MEMBER_ID 세션에서 가져오는 것으로 수정,  fs_"+ param.get("p_action_flag") + "_" + id + "_내용저장
			out.println(", { xtype : 'button', border: 1, iconCls:'formItemList', style: { borderColor: '#99bce8', borderStyle: 'solid'} , text: '이력조회', itemId : 'btn_"+param.get("p_action_flag") + "_" + id + "_form_hist', ");
			out.println("    handler : function(btn, e) { ");
			out.println("    	var win = Ext.getCmp('id_win_develop_form_grid');  ");
			out.println("       if( !win ) { ");
			out.println("           try { win = Ext.create('Ext.window.ux.DevelopeFormGrid',{ }); } catch(e) { fs_HoScriptLog('DevelopeFormGrid.js : ' + e, 'ERROR'); } ");
			out.println("       } ");
			out.println("       win.setMenuId('"+param.get("MENU_ID")+"'); win.setFormId('"+formId+"');  win.show(btn); win.expand(true);"); // // TODO MEMBER_NO 세션에서 가져오는 것으로 수정, 
			out.println("    } ");
			out.println("   }"); // fs_"+ param.get("p_action_flag") + "_" + id + "_내용저장
		}
		out.println("] } ] ");
	}

	out.println("}) ");
	HoServletUtil.initIndex(request, HoServletUtil.getArea(request)+">fieldcontainer");
	HoServletUtil.initIndex(request, HoServletUtil.getArea(request)+">fieldcontainer_row");

	HoServletUtil.setString(request, "form-id", null);
	HoServletUtil.setOutArea(request);
 }
%>



<% if( isHtml ) {

} %>