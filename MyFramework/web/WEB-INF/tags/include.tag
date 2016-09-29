<%@ tag language="java" pageEncoding="UTF-8"
	import="java.util.Random"
	import="java.util.List"
	import="java.util.ArrayList"
	import="project.jun.config.HoConfig"
	import="project.jun.was.HoModel"
	import="project.jun.was.spring.HoController"
	import="project.jun.was.parameter.HoParameter"
	import="project.jun.util.HoUtil"
	import="project.jun.util.HoSpringUtil"
	import="project.jun.util.HoServletUtil"
	import="project.jun.util.cache.HoCache"	
	import="project.jun.util.cache.HoEhCache"
	import="project.jun.util.HoValidator"
	import="project.jun.dao.HoDao"
	import="project.jun.dao.result.HoList"
	import="project.jun.dao.result.transfigure.HoSetHasMap"
	import="project.jun.dao.parameter.HoQueryParameterMap"
	import="project.jun.aop.advice.HoCacheAdvice"
	import="project.constant.HoProjectConstant"
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
	HoConfig hoConfig = (HoConfig) new HoSpringUtil().getBean(application, "config");

	HoCache cache = new HoEhCache(dao.getCache());
	
	HoSetHasMap CODE_SET_MAP = (HoSetHasMap) cache.get(HoCacheAdvice.CACHED_CODE_SET);
	HoSetHasMap COLUMN_SET_MAP = (HoSetHasMap) cache.get(HoCacheAdvice.CACHED_COLUMN_SET);
	HoSetHasMap BUTTON_SET_MAP = (HoSetHasMap) cache.get(HoCacheAdvice.CACHED_BUTTON_SET);
			
	String G_CONTEXT_PATH = request.getContextPath();

	int labelWidth = 120;
	String componentWidth = "320";
%><%!
	final int MAX_ROW_ITEM_SEARCH = 4;
	final int MAX_ROW_ITEM_DETAIL = 4;
	final int MAX_ROW_ITEM_WINDOW = 2;

	public int getMaxItemByArea(HttpServletRequest request) {
		return Integer.parseInt(HoUtil.replaceNull(HoServletUtil.getString(request, "MAX_ROW_ITEM"), "4"));
		/*		
		if( HoServletUtil.getArea(request).indexOf("window") >= 0 ) {
			return MAX_ROW_ITEM_WINDOW;
		} else if( !"".equals(HoServletUtil.getString(request, "data")) ||  !"center".equals(HoServletUtil.getString(request, "data")) ) {
			return MAX_ROW_ITEM_WINDOW;
		} else {
			return MAX_ROW_ITEM_SEARCH;
		}
		*/
	}
	public int getIndexIncrement( String type ) {
		return 	getIndexIncrement(type, null);
	}

	public int getIndexIncrement( String type, String itemLength ) {
		if( HoValidator.isNumber(itemLength)) {
			return Integer.parseInt(itemLength);
		} else {
			if( "checkbox".equals(type) || "radio".equals(type) ){
				return 2; // MAX_ROW_ITEM_SEARCH;
			} else if( "selectCasecade".equals(type) || "selectMulti".equals(type) ){
				return MAX_ROW_ITEM_SEARCH;
			} else if( "period".equals(type) ){
				return 2;
			} else if( "popup".equals(type) ){
				return 2;
			} else if( "hidden".equals(type) ){
				return 0;
			} else if( "grid".equals(type) || "file".equals(type) ){
				return MAX_ROW_ITEM_SEARCH;
			} else {
				return 1;
			}
		}
	}
	
	public String random() {
		return String.valueOf(random(1, 10000));
	}
	public int random(int min, int max) {

	    // NOTE: Usually this should be a field rather than a method
	    // variable so that it is not re-seeded every call.
	    Random rand = new Random();

	    // nextInt is normally exclusive of the top value,
	    // so add 1 to make it inclusive
	    int randomNum = rand.nextInt((max - min) + 1) + min;

	    return randomNum;
	}
	
	/**
	* Form의 정보를 request에 저장
	*/
	public void setFormInfo( HttpServletRequest request,  HoParameter    param, HoQueryParameterMap value) {

		try {
			value.put("COMPANY_ID", "0000");
			value.put("SYSTEM_ID", "S");
			value.put("F_MENU_ID", param.get("MENU_ID"));
		} catch(Exception e) {
			
		}
		request.setAttribute( HoProjectConstant.HO_REQUEST_FORM_NM, value );
	}
	
	/**
	* Form의 정보를 request에 저장
	*/
	public void setFormItemInfo( HttpServletRequest request,  HoParameter    param, HoQueryParameterMap value) {
		List<HoQueryParameterMap> list = (List<HoQueryParameterMap>) request.getAttribute( HoProjectConstant.HO_REQUEST_FORM_ITEM_NM );
		if( list == null ) {
			list = new ArrayList<HoQueryParameterMap>();
		}
		try {
			value.put("COMPANY_ID", "0000");
			value.put("SYSTEM_ID", "S");
			value.put("F_MENU_ID", param.get("MENU_ID"));
			value.put("F_FORM_ID", HoServletUtil.getString(request, "F_FORM_ID"));
		} catch(Exception e) {
			
		}
		list.add(value);
		request.setAttribute( HoProjectConstant.HO_REQUEST_FORM_ITEM_NM, list );
		
	}
	
	/**
	* Form 및 Form의 구성항목의 정보를  DB에 저장
	*/
	public void insertFormInfo(HoDao dao, HttpServletRequest request ) {
		HoQueryParameterMap value = (HoQueryParameterMap) request.getAttribute( HoProjectConstant.HO_REQUEST_FORM_NM );
		List<HoQueryParameterMap> values = (List<HoQueryParameterMap>) request.getAttribute( HoProjectConstant.HO_REQUEST_FORM_ITEM_NM );
		
		if( value!= null ) {
			HoList list = dao.select("Develope.selectMenuFormList", value); 
			
			if( list.size() != 1 ) {
				dao.execute("Develope.deleteMenuForm", value);
				dao.execute("Develope.deleteMenuFormItem", value);
				
				dao.execute("Develope.insertMenuForm", value);
				if(  values!= null ) {
					dao.batch("Develope.insertMenuFormItem", values);
				}
			}
		}
		// 처리후 request에서 삭제..
		request.removeAttribute( HoProjectConstant.HO_REQUEST_FORM_NM );
		request.removeAttribute( HoProjectConstant.HO_REQUEST_FORM_ITEM_NM );
		request.removeAttribute( "F_FORM_ID");
	}

%>