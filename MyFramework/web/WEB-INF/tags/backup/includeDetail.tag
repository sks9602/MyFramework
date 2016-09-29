<%@ tag language="java" pageEncoding="UTF-8"
	import="project.jun.was.HoModel"
	import="project.jun.was.spring.HoController"
	import="project.jun.was.parameter.HoParameter"
	import="project.jun.dao.HoDao"
	import="project.jun.util.HoSpringUtil"
	import="project.jun.util.cache.HoCache"	
	import="project.jun.util.cache.HoEhCache"
	import="project.jun.dao.result.transfigure.HoSetHasMap"
	import="project.jun.aop.advice.HoCacheAdvice"
%><%
	HoModel        model     = new HoModel(request);
	HoParameter    param     = (HoParameter) model.get(HoController.HO_PARAMETER);
	
	String p_action_flag = param.get("p_action_flag");
	String division      = param.get("division");
	String tab_index      = param.get("tab_index");
	
	boolean isScriptOut = "script_out".equals(division);
	boolean isScript = "script".equals(division);
	boolean isHtml 	 = "html".equals(division);
	boolean isFirstTab = "0".equals(tab_index);
	
	HoDao dao = (HoDao) new HoSpringUtil().getBean(application, "proxyProjectDao");

	HoCache cache = new HoEhCache(dao.getCache());
	
	HoSetHasMap CODE_SET_MAP = (HoSetHasMap) cache.get(HoCacheAdvice.CACHED_CODE_SET);
	HoSetHasMap COLUMN_SET_MAP = (HoSetHasMap) cache.get(HoCacheAdvice.CACHED_COLUMN_SET);

	String labelWidth = "120";
%><%!
	final int MAX_ROW_ITEM_SEARCH = 8;

	public int getIndexIncrement( String type ) {
		if( "selectCasecade".equals(type) || "selectMulti".equals(type) ){
			return MAX_ROW_ITEM_SEARCH;
		} else if( "grid".equals(type) || "file".equals(type) ){
			return MAX_ROW_ITEM_SEARCH;
		} else if( "checkbox".equals(type) || "radio".equals(type) ){
			return 4; // MAX_ROW_ITEM_SEARCH;
		} else if( "period".equals(type) ){
			return 4;
		} else if( "popup".equals(type) ){
			return 3;
		} else if( "hidden".equals(type) ){
			return 0;
		} else {
			return 2;
		}
	}

%>