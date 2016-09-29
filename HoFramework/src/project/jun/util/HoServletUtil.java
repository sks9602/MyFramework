package project.jun.util;

import javax.servlet.http.HttpServletRequest;

public class HoServletUtil {

	private final static String Ho_Servlet_Util = "HoServletUtil.TAFILE_AREA";

	public static int getIndex( HttpServletRequest request, String type ) {
		Integer index = (Integer) request.getAttribute(type);

		if( index == null) {
			index = new Integer(0);
		}

		return index.intValue();
	}

	public static void increaseIndex( HttpServletRequest request, String type ) {

		increaseIndex(request, type, 1);
	}


	public static void increaseIndex( HttpServletRequest request, String type , int increment) {
		Integer index = (Integer) request.getAttribute(type);

		if( index == null) {
			index = new Integer(0);
		}

		request.setAttribute( type, new Integer(index.intValue() + increment ) );

	}

	public static void initIndex( HttpServletRequest request, String type) {

		request.setAttribute( type, new Integer(0 ) );

	}

	public static void removeIndex( HttpServletRequest request, String type) {

		request.removeAttribute( type );

	}

	public static boolean isIndexed( HttpServletRequest request, String type ) {
		Integer index = (Integer) request.getAttribute(type);

		if( index == null) {
			return false;
		} else {
			return true;
		}
	}

	public static boolean isClosed(  HttpServletRequest request, String type ) {
		Boolean closed = (Boolean) request.getAttribute(type);

		if( closed == null) {
			return false;
		} else {
			return closed.booleanValue();
		}
	}

	public static void setClosed(  HttpServletRequest request, String type, boolean closed ) {
		request.setAttribute(type, new Boolean(closed));
	}

	public static void addString(  HttpServletRequest request, String type, String text ) {
		addString(request, type, text, ",\r\n");
	}

	public static void addString(  HttpServletRequest request, String type, String text, String delemeter ) {
		String ori_text = (String) request.getAttribute(type);

		if( ori_text == null ) {
			request.setAttribute(type, text);
		} else {
			request.setAttribute(type, ori_text + delemeter + text);
		}

	}

	public static String getString(  HttpServletRequest request, String type ) {
		return HoUtil.replaceNull((String) request.getAttribute(type));
	}

	public static void setString(  HttpServletRequest request, String type, String text ) {
		if( HoValidator.isEmpty(text) ) {
			request.removeAttribute( type );
		} else {
			request.setAttribute(type, text);
		}
	}

	public static void setInArea(  HttpServletRequest request, String area ) {
		String nowArea = getArea(request);
		request.setAttribute( Ho_Servlet_Util , nowArea + ">" + area);
	}

	public static void setOutArea(  HttpServletRequest request ) {
		String area = getArea(request);
		int idx = area.lastIndexOf('>');

		if( idx == 0 ) {
			request.removeAttribute( Ho_Servlet_Util );
		} else {
			request.setAttribute( Ho_Servlet_Util , area.substring(0, idx));
		}
	}

	public static String getNowArea(  HttpServletRequest request ) {
		String area = getArea(request);
		int idx = area.lastIndexOf('>');

		if( idx == 0 ) {
			return "";
		} else {
			return area.substring(idx+1);
		}

	}

	public static String getArea(  HttpServletRequest request ) {
		return HoUtil.replaceNull((String) request.getAttribute(Ho_Servlet_Util));
	}

}
