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
	HoServletUtil.setString(request, "section", HoUtil.replaceNull(section) );
%>

<% if( isScript ) {
	HoServletUtil.setClosed(request, "search_script_form_closed" +  p_action_flag, false);

	HoServletUtil.setString(request, "button_area", "form" );

	//int idx_data = HoServletUtil.getIndex(request, "search_script_data" +  p_action_flag);
	//HoServletUtil.increaseIndex(request, "search_script_data" + p_action_flag);

	int idx_panel_item = HoServletUtil.getIndex(request, "search_script_panel_item_index" +  p_action_flag + area);

%>
	<%= idx_panel_item > 0 ? "," : "" %>

    Ext.create('Ext.form.Panel', {
    	<%= HoValidator.isNotEmpty(title) ? "title : '"+title+"', " : ""  %>
    	<%= HoValidator.isEmpty(area)? "margin : '5 5 0 5'," : "bodyPadding: '5 5 0 5'," %>
        autoHeight: true,
        url : '<%= request.getContextPath() + action %>',
        // width   : 400,
        // flex: 1,
        style: 'border-bottom: 0',
        defaults: {
            anchor: '100%',
            labelWidth: 100,
            layout: {
                        type: 'hbox'
                        , defaultMargins: {top: 0, right: 5, bottom: 0, left: 0}
                    }
        },
        <% if( !"search".equals(section))  { %>
        border : 1,
        <% } else { %>
		border : 0,
		<% } %>

        items   : [
       <% if( "search".equals(section))  { %>
        {
            xtype:'fieldset',
            title: '검색조건',
            // collapsed: true,
            collapsible : true,
            // hidden : true,
            layout: 'anchor',
            items : [
        <% } // end of if( "search".equals(section)) %>
		<jsp:doBody></jsp:doBody>
<%
	int idx_row_item  = HoServletUtil.getIndex(request, "search_script_row_item" +  p_action_flag);
	boolean itemClosed = HoServletUtil.isClosed(request, "search_script_row_item_closed" +  p_action_flag);

	if( !itemClosed ) {
%>
						]
				} // end item in form
<%
		HoServletUtil.setClosed(request, "search_script_row_item_closed" +  p_action_flag, true);
    }
	HoServletUtil.removeIndex(request, "search_script_row_item" +  p_action_flag);
	boolean formClosed = HoServletUtil.isClosed(request, "search_script_form_closed" +  p_action_flag);

	String buttons = HoServletUtil.getString( request, "search_script_form_button" +  p_action_flag );
%>
        <% if( "search".equals(section) && !HoValidator.isEmpty(buttons))  { %>
        	, { xtype: 'fieldcontainer', layout : {type:'hbox', pack : 'end', hideEmptyLabel: true, defaultMargins : {top: 0, right: 5, bottom: 0, left: 0} },
        	    items : [<%= buttons  %>] }
        <% } %>

		<% if( !formClosed ) { %>
        ] // end of  검색조건 fieldset
        <%
    		HoServletUtil.setClosed(request, "search_script_form_closed" +  p_action_flag, true);
			}
		%>

        <% if( "search".equals(section))  { %>
        }
        <% if( false && "search".equals(section) && !HoValidator.isEmpty(buttons))  { %>
        	, { xtype: 'fieldcontainer', layout : {type:'hbox', pack : 'end', hideEmptyLabel: true, defaultMargins : {top: 0, right: 5, bottom: 0, left: 0} },
        	    items : [<%= buttons  %>] }
        <% } %>
        ] // end of fieldset
        <% } %>

<%

	if( !"search".equals(section) &&  !HoValidator.isEmpty(buttons)) {
%>
		/* , buttons: [<%= buttons  %>] */
        , dockedItems: [{
        		xtype: 'toolbar',
        		dock: 'bottom',
        		flex:1,
        		border : true,
        		// ui: 'footer',
        		// componentCls : "bottom-border",
        		items : [ '->', <%= buttons  %>]
        }]
<%
		HoServletUtil.setString( request, "search_script_form_button" +  p_action_flag, null );
	}

%>
	})

<%
	HoServletUtil.setString(request, "button_area", null );
	HoServletUtil.increaseIndex(request, "search_script_panel_item_index" +  p_action_flag + area);
	System.out.println("--> form " + HoServletUtil.getString(request, "button_area" ));
	HoServletUtil.setString(request, "section", null );
} %>


<% if( isHtml ) { %>
	<div id="div<%= section_name %>_<%=param.get("p_action_flag")%>"></div>
<% } %>
