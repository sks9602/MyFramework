package project.jun.was;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;

import project.jun.dao.result.HoMap;
import project.jun.config.HoConfig;

/**
 * @author  sks
 */
public class HoSession {
	private HttpSession session;
	/**
	 * @uml.property  name="hoConfig"
	 * @uml.associationEnd
	 */
	private HoConfig hoConfig = null;
	
	final public static String STATUS_FILE_UPLOAD_PROGRESS = "HoSession.STATUS_FILE_UPLOAD_PROGRESS";
	final public static String STATUS_FILE_DOWNLOAD_PROGRESS = "HoSession.STATUS_FILE_DOWNLOAD_PROGRESS";
	
	final public static String STATUS_EXCEL_UPLOAD_PROGRESS = "HoSession.STATUS_EXCEL_UPLOAD_PROGRESS";
	final public static String STATUS_EXCEL_DOWNLOAD_PROGRESS = "HoSession.STATUS_EXCEL_DOWNLOAD_PROGRESS";

	final public static String FILE_NAME_SUFFIX = "_NAME";
	final public static String FILE_INDEX_SUFFIX = "_IDX";

	final public static String STATUS_DB_PROGRESS = "HoSession.STATUS_DB_PROGRESS";

	public HoSession( HttpSession session, HoConfig hoConfig ) {
		this.session = session;
		this.hoConfig = hoConfig;
	}

	/**
	 * Map을 key별로 나누어서 세션정보를 담는다.
	 * 예를 들어,
	 * 		map.put("NAME", "이름");
	 * 		map.put("AGE", "20");인 Map은
	 * 아래와 같이 session에 저장된다.
	 * 		getSession().setAttribute(hoConfig.getSessionNamePrefix()+"NAME","이름"));
	 * 		getSession().setAttribute(hoConfig.getSessionNamePrefix()+"AGE","20"));
	 *
	 * @param map
	 */
	public void setHoMap(Set set, HoMap map) {
		Iterator it = set.iterator();

		String key = null;
		while(it.hasNext()) {
			key = (String) it.next();
			setObject( key.toUpperCase() ,map.get(key));
		}
	}


	/**
	 * Map을 key별로 나누어서 세션정보를 담는다.
	 * 예를 들어,
	 * 		map.put("NAME", "이름");
	 * 		map.put("AGE", "20");인 Map은
	 * 아래와 같이 session에 저장된다.
	 * 		getSession().setAttribute(hoConfig.getSessionNamePrefix() + "NAME","이름"));
	 * 		getSession().setAttribute(hoConfig.getSessionNamePrefix() + "AGE","20"));
	 *
	 * @param map
	 */
	public void setMap(Map map) {
		Iterator it = map.keySet().iterator();

		String key = null;
		while(it.hasNext()) {
			key = (String) it.next();
			setObject( key.toUpperCase() ,map.get(key));
		}
	}


	/**
	 * 세션정보를 담는다.
	 * @param sessionName
	 * @param entry
	 */
	public void setObject(String sessionName,  Object entry) {
		setObject(sessionName, entry, true);
	}


	/**
	 * 세션정보를 담는다.
	 * @param sessionName
	 * @param entry
	 * @param usePrefix HoConfig.getSessionNamePrefix()의 사용여부
	 */
	public void setObject(String sessionName,  Object entry, boolean usePrefix) {
		if(usePrefix) {
			if( sessionName.toUpperCase().startsWith(hoConfig.getSessionNamePrefix())) {
				this.session.setAttribute(sessionName.toUpperCase(), entry);
			} else {
				this.session.setAttribute(hoConfig.getSessionNamePrefix() + sessionName.toUpperCase(), entry);
			}
		} else {
			this.session.setAttribute(sessionName.toUpperCase(), entry);
		}
	}


	/**
	 * Session정보를 "SSN_"+key.toUpperCase()의 Map값으로 얻는다.
	 * @return
	 */
	public Map<String, String> getMap() {
		Map<String, String> map = new HashMap<String, String>();

		Enumeration sEnum = this.session.getAttributeNames();

		String key = null;
		while( sEnum.hasMoreElements() ) {
			key = sEnum.nextElement().toString();
			
			if( key.matches("(?i)HOSESSION.*") || key.matches("(?i)SPRING.*") ) {
				continue;
			}
			map.put(key.toUpperCase(), getString(key));

		}
		return map;
	}

	/**
	 * 세션정보를 String으로 가져온다..
	 * @param sessionName
	 * @param entry
	 */
	public String getString(String sessionName) {
		return getString(sessionName.toUpperCase(), true);
	}

	/**
	 * 세션정보를 String으로 가져온다..
	 * @param sessionName
	 * @param entry
	 */
	public String getString(String sessionName, boolean usePrefix) {
		Object value =  getObject(sessionName.toUpperCase(), usePrefix);
		return value == null ? "" : value.toString();
	}

	/**
	 * 세션정보를 Ojbect로 가져온다..
	 * @param sessionName
	 * @param entry
	 */
	public Object getObject(String sessionName) {
		return getObject(sessionName, true);
	}
	/**
	 * 세션정보를 Ojbect로 가져온다..
	 * @param sessionName
	 * @param entry
	 */
	public Object getObject(String sessionName, boolean usePrefix) {
		if( usePrefix ) {
			if( sessionName.toUpperCase().startsWith(hoConfig.getSessionNamePrefix())) {
				return this.session.getAttribute(sessionName.toUpperCase());
			} else {
				return this.session.getAttribute(hoConfig.getSessionNamePrefix() + sessionName.toUpperCase());
			}
		} else {
			return this.session.getAttribute(sessionName.toUpperCase());
		}
	}

	/**
	 * 세션정보를 삭제한다.
	 * @param sessionName
	 */
	public void remove(String sessionName) {
		if( sessionName.toUpperCase().startsWith(hoConfig.getSessionNamePrefix())) {
			this.session.removeAttribute(sessionName.toUpperCase());
		} else {
			this.session.removeAttribute(hoConfig.getSessionNamePrefix() + sessionName.toUpperCase());
		}
	}

}
