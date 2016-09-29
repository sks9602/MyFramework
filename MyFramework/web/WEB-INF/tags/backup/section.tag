<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag
	import="project.jun.was.HoModel"
	import="project.jun.util.HoUtil"
	import="project.jun.was.parameter.HoParameter"
	import="project.jun.was.spring.HoController"
	import="project.jun.util.HoServletUtil"
%><%@ attribute name="title" type="java.lang.String"
%>
<%
	HoModel        model     = new HoModel(request);
	HoParameter    param     = (HoParameter) model.get(HoController.HO_PARAMETER);

	String p_action_flag = param.get("p_action_flag");
	String division      = param.get("division");

	boolean isScript = "script".equals(division);
	boolean isHtml 	 = "html".equals(division);

%>

<% if( isScript ) {

	int idx = HoServletUtil.getIndex(request, "search_script" + p_action_flag);

	System.out.println(p_action_flag + "--->  " + idx);

	int idx_section = HoServletUtil.getIndex(request, "search_script_section" +  p_action_flag);

	HoServletUtil.initIndex(request, "search_script_row_item" +  p_action_flag);
	HoServletUtil.setClosed(request, "search_script_row_item_closed" +  p_action_flag, true);

	if (idx_section !=0 || idx !=0 ) {
		out.print("," );
	}
%>

{
            xtype:'fieldset',
            title: '<%= title %>',
            // collapsed: true,
            layout: 'anchor',
            margin : '5 5 0 5',
            items : [
<jsp:doBody></jsp:doBody>
<%
	boolean itemClosed = HoServletUtil.isClosed(request, "search_script_row_item_closed" +  p_action_flag);

	if( !itemClosed ) {
%>
						]
				} // end item in form
<%
		HoServletUtil.setClosed(request, "search_script_row_item_closed" +  p_action_flag, true);
    }
	HoServletUtil.increaseIndex(request, "search_script_section" +  p_action_flag );
	HoServletUtil.removeIndex(request, "search_script_row_item" +  p_action_flag);
%>
]} // end of section fieldset
<% } %>


<% if( isHtml ) { %>

<% } %>
