<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag
	import="project.jun.was.HoModel"
	import="project.jun.util.HoUtil"
	import="project.jun.was.parameter.HoParameter"
	import="project.jun.was.spring.HoController"
	import="project.jun.util.HoServletUtil"
	import="project.jun.util.HoValidator"
%><%@ attribute name="section" type="java.lang.String"
%><%@ attribute name="action" type="java.lang.String"
%>
<%
	HoModel        model     = new HoModel(request);
	HoParameter    param     = (HoParameter) model.get(HoController.HO_PARAMETER);

	String p_action_flag = param.get("p_action_flag");
	String division      = param.get("division");

	boolean isScript = "script".equals(division);
	boolean isHtml 	 = "html".equals(division);

	String section_name =  "_"+HoUtil.replaceNull(section);
	String area = HoServletUtil.getString(request, "search_script_item_area" +  p_action_flag);
	String section_area = HoUtil.replaceNull(HoServletUtil.getString(request, "section") );

	int gridIndex = HoServletUtil.getIndex(request, "grid_index");

%>

<% if( isScript ) {
	int idx_panel_item = HoServletUtil.getIndex(request, "search_script_panel_item_index" +  p_action_flag + area);

	String button_area = HoServletUtil.getString(request, "button_area" );

	String [] actions = HoValidator.isNotEmpty(action) ? action.split("\\,") : new String [0];

	for( int i=0 ; i< actions.length ; i++ ) {
		if( "조회".equals(actions[i])) {
			HoServletUtil.addString(request, "search_script_"+button_area+"_button" +  p_action_flag + ("grid".equals(button_area) ? gridIndex + "" : "" ),  "{ xtype : 'button', text: '"+actions[i]+"', handler : function () { if( this.up('form').getForm().isValid() ) { Ext.getStore('store_grid_"+param.get("p_action_flag")+"_0').load({params: this.up('form').getForm().getFieldValues()}); } } }");
		} else {
			HoServletUtil.addString(request, "search_script_"+button_area+"_button" +  p_action_flag + ("grid".equals(button_area) ? gridIndex + "" : "" ),  "{ xtype : 'button', text: '"+actions[i]+"', handler : fs_"+ param.get("p_action_flag")  + "_" + actions[i]+" }"); //
		}
		// this.up('form').getForm().submit({waitMsg: 'Uploading your photo...'});
		// Ext.Msg.show({title : '버튼 호출..', msg : '"+actions[i]+"', buttons: Ext.Msg.YESNO, icon: Ext.Msg.QUESTION});
		// Ext.TaskManager.start({ run: function() { msg.setTitle( '버튼 호출..' + new Date().toLocaleString( )  );} ,  interval: 500 }); setTimeout(function(){ Ext.MessageBox.hide(); }, 10000);
	}
	boolean formClosed = HoServletUtil.isClosed(request, "search_script_form_closed" +  p_action_flag);

	if( !formClosed && "form".equals(button_area) && "".equals(section_area) ) {
		out.print("]");
		HoServletUtil.setClosed(request, "search_script_form_closed" +  p_action_flag, true);
	}

	if( "".equals(button_area) ) {
%>


	<%= idx_panel_item > 0 ? "," : "" %>
		Ext.create('Ext.Container', {
			margin: '10 10 0 10',
		    items   : [

<%
	for( int i=0 ; i< actions.length ; i++ ) {
		out.println((i>0 ? "," : "") + "{xtype: 'button',text : '"+actions[i]+"'}," );
	}
%>


		    ]
		})
<%
	}
%>

<%
	HoServletUtil.increaseIndex(request, "search_script_panel_item_index" + p_action_flag + area);

} %>


<% if( isHtml ) { %>
	<div id="div_button<%= section_name %>_<%=param.get("p_action_flag")%>"></div>
<% } %>
