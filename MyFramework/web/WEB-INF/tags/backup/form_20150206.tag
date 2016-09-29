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
%><%@ attribute name="title" type="java.lang.String"
%><%@ attribute name="button" type="java.lang.String"
%><%@ attribute name="gridId" type="java.lang.String"
%><%@ attribute name="id" type="java.lang.String"
%><%@ attribute name="position" type="java.lang.String"
%><%-- 검색 조건을 fieldset으로.. --%>
<%
	HoModel        model     = new HoModel(request);
	HoParameter    param     = (HoParameter) model.get(HoController.HO_PARAMETER);

	String p_action_flag = param.get("p_action_flag");
	String division      = param.get("division");
	String tab_index      = param.get("tab_index");

	boolean isScriptOut = "script_out".equals(division);
	boolean isScript = "script".equals(division);
	boolean isHtml 	 = "html".equals(division);
	boolean isFirstTab = "0".equals(tab_index);

%>

<% if( isScript ) {
	int index =  HoServletUtil.getIndex(request, HoServletUtil.getArea(request)+"_row");
	HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request)+"_row");
	HoServletUtil.setInArea(request, "form");
%>
	<%= index > 0 ? "," : "" %>
    Ext.create('Ext.form.Panel', {
    	<%= HoValidator.isNotEmpty(title) ? "title : '"+title+"', " : ""  %>

    <% if( !"search".equals(section) )  { %>
    	// margin : '<%= "search".equals(section) ? "5" : (HoServletUtil.getArea(request).indexOf("box") < 0 ? "5" : index > 0 ? "5" : "0") %> 5 0 5',
        margin: '<%= HoUtil.replaceNull(position).equals("south") ? "0" : "0"%> <%= HoUtil.replaceNull(position).equals("west") ? "5" : "0"%> <%= HoUtil.replaceNull(position).equals("north") ? "5" : "0"%> <%= HoUtil.replaceNull(position).equals("east") ? "5" : "0"%>',
    <% } %>
        autoHeight: true,
        defaults: {
	    	autoScroll: true
	    },
	    autoScroll: true,
	    <% if( "search".equals(section) )  { %>
        region: '<%= HoUtil.replaceNull(position, "north") %>',
        <% } else { %>
        region: '<%= HoUtil.replaceNull(position, "center") %>', <%= !"center".equals(HoUtil.replaceNull(position, "center")) ? "collapsible  : true, split: true," : "" %>
        <% } %>
        url : '<%= request.getContextPath() + action %>',
        style: 'border-bottom: 0; ',
        defaults: { anchor: '100%',   labelWidth: 100, layout: { type: 'hbox' , defaultMargins: {top: 0, right: 5, bottom: 0, left: 0} }  },
        <% if( !"search".equals(section))  { %>
        border : 1,
        <% } else { %>
		border : 0,
		<% } %>
<%
	if( "search".equals(section))  {
		out.println(" id : 'id_search_"+p_action_flag+"' , ");
	} else {
		out.println(" id : 'id_detail_"+p_action_flag+ ( HoValidator.isEmpty(id) ? "" : "_"+HoUtil.replaceNull(id) )+"' ,  ");
	}

%>

        items   : [

<%
	if( "search".equals(section))  {
		out.println("{xtype:'fieldset',title: '검색조건', collapsible : true, layout: 'anchor',items : [ ");
	}

	String [] buttons = HoValidator.isNotEmpty(button) ? button.split("\\,") : new String [0];

%>
	<jsp:doBody></jsp:doBody>
<%
	String nowArea = HoServletUtil.getNowArea(request);
	if( "fieldcontainer".equals(nowArea)) {
		HoServletUtil.initIndex(request, HoServletUtil.getArea(request)+">item_row");
		HoServletUtil.setOutArea(request);
	}

	out.println("]}");
	if( "search".equals(section))  {
		out.println("]} ");
	}

	if( buttons.length> 0 ) {


		if( "search".equals(section))  {
			out.println(", { xtype: 'fieldcontainer', layout : {type:'hbox', pack : 'end', hideEmptyLabel: true, defaultMargins : {top: 0, right: 5, bottom: 0, left: 0} }, items : [");
		} else {
			out.println("] ,  dockedItems: [{xtype: 'toolbar', dock: 'bottom', flex:1, border : true,  items : [ '->', ");
		}
		for( int i=0 ; i< buttons.length ; i++ ) {
			out.print( i>0 ? "," : "");
			if( "조회".equals(buttons[i])) {
				out.println("{ xtype : 'button', text: '"+buttons[i]+"', handler : function () { if( this.up('form').getForm().isValid() ) { var store = Ext.getStore('store_grid_"+param.get("p_action_flag")+"_"+HoUtil.replaceNull(gridId) +"'); store.load({page : 1, params: this.up('form').getForm().getFieldValues(false)}); store.currentPage = 1; store.params = this.up('form').getForm().getFieldValues(false); } else { this.up('form').getForm().findInvalid(); } } }");
			} else {
				out.println("{ xtype : 'button', text: '"+buttons[i]+"', handler : fs_Alert_ }"); //"+ param.get("p_action_flag") +"
			}
		}
		if( "search".equals(section))  {
			out.println("] } ");
		} else {
			out.println("] } ] ");
		}
	}

	if( "search".equals(section))  {
		out.println("]");
	}

	out.println("}) ");
	HoServletUtil.initIndex(request, HoServletUtil.getArea(request)+">fieldcontainer");
	HoServletUtil.initIndex(request, HoServletUtil.getArea(request)+">fieldcontainer_row");
	HoServletUtil.setOutArea(request);

	}
%>



<% if( isHtml ) {

} %>