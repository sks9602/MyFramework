package project.jun.was.parameter;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import project.jun.dao.result.HoMap;
import project.jun.util.HoUtil;
import project.jun.was.parameter.agent.HoUserAgent;
import project.jun.was.servlet.HoServlet;
import project.jun.config.HoConfig;

public abstract class HoParameter {

	protected  Logger          logger     = Logger.getLogger(HoParameter.class);
	
	protected String    requestCharacterSet = null;
	protected String    characterSet        = null;
	/**
	 * @uml.property  name="hoServlet"
	 * @uml.associationEnd
	 */
	protected HoServlet hoServlet          = null;
	/**
	 * @uml.property  name="hoConfig"
	 * @uml.associationEnd
	 */
	private HoConfig    hoConfig             = null;
	private boolean useServlet = false;

	/**
	 * @uml.property  name="names"
	 */
	protected Map<String, String>       names               = new HashMap<String, String>();
	protected Map<String, String>       defaultValueMap     = new HashMap<String, String>();

	protected HoParameter( ) {
	}
	protected HoParameter( HoServlet hoServlet)
	{
		this.hoServlet = hoServlet;

		this.requestCharacterSet = getRequest().getCharacterEncoding();

        if( requestCharacterSet == null ) {
			requestCharacterSet = "ISO-8859-1";
        }
        this.useServlet = true;
	}

	public HoParameter( HoServlet hoRequest, HoConfig hoConfig)
	{
		this(hoRequest);

		logger.info(hoConfig);

		this.setHoConfig(hoConfig);
        this.useServlet = true;
	}


	public boolean useServlet() {
		return useServlet;
	}
	/**
	 * 파리미터로 전송된 값을 characterSet에 따라 decoding한다.
	 * @param value
	 * @param defValue
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	protected String decodeValue( String value, String defValue ) {
		if( value == null || value.length() == 0 )	{
			return defValue;
		} else if( characterSet == null || characterSet.length() == 0) {
			return HoUtil.replaceNull(value);
		} else {
			if( requestCharacterSet.equalsIgnoreCase(characterSet) ) {
				return value;
			} else if( isAjaxCall() ) {
				return HoUtil.charsetEncode(value, requestCharacterSet, "utf-8");
			} else {
				return HoUtil.charsetEncode(value, requestCharacterSet, characterSet);
			}
		}

	}

	/**
	 * HttpServletRequest객체를 얻는다.
	 * @return
	 */
	public HttpServletRequest getRequest() {
		return this.getHoServlet().getRequest();
	}

	/**
	 * HttpServletResponse객체를 얻는다.
	 * @return
	 */
	public HttpServletResponse getResponse() {
		return this.getHoServlet().getResponse();
	}

	/**
	 * HoServlet객체를 얻는다.
	 * @return
	 */
	public HoServlet getHoServlet() {
		return this.hoServlet;
	}

	/**
	 * 파라미터의 값이 1건 인지 확인.
	 * @param name
	 * @return
	 */
	public boolean isSingleValue(String name) {
		String[] values = getValues(name);
		
		if (values == null || values.length <= 1) {
			return true;
		} else {
			return false;
		}
	}
	
	/**
	 * 파라미터의 값이 어러건 인지 확인.
	 * @param name
	 * @return
	 */
	public boolean isMultiValue(String name) {
		String[] values = getValues(name);
		
		if (values == null || values.length <= 1) {
			return false;
		} else {
			return true;
		}
	}
	
	/**
	 * getRequest().getParameter()대체할 method
	 * @param name
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public abstract String get(String name) throws  UnsupportedEncodingException;

	/**
	 * getRequest().getParameter()대체할 method
	 *  -> 값이 없을 경우 defaultValue를 return
	 * @param name
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public abstract String get(String name, String defaultValue) throws  UnsupportedEncodingException;

	/**
	 * 파라미터의 이름 목록을 return
	 * @return
	 * @uml.property  name="names"
	 */
	public String[] getNames() {
		List<String> list = this.getNamesList();
		String[] strArray = new String[list.size()];
		return (String[]) list.toArray( strArray );
	}

	/**
	 * 파라미터의 이름 목록을 return
	 * @return
	 */
	public List<String> getNamesList() {
		Set<String> set =  new TreeSet<String>(names.keySet());
		Iterator<String> it = set.iterator();
		List<String> list = new ArrayList<String>();

		while( it.hasNext() ) {
			list.add( (String)it.next() );
		}

		return list;
	}

	public abstract List<String> getNamesListOrdered();
	/**
	 * 원래의 파라미터명을 구한다.
	 * @param name
	 * @return
	 */
	protected String getName(String name) {
		return (String)names.get(name.toUpperCase());
	}

	/**
	 * getRequest().getParameterValues()대체할 method
	 * @param name
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public abstract String [] getValues(String name);

	/**
	 * getRequest().getParameterValues()대체할 method
	 * -> 값이 없을 경우 각각의 배열 순번별로 defaultValue를 return
	 * @param name
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public abstract String [] getValues(String name, String defaultValue);

	/**
	 * 금지된 스트링을 가진 파라미터명의 목록
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public abstract List getBlockNamesList();

	/**
	 * 한글 encode을 해결해서 getQueryString()
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public abstract String getQueryString();

	/**
	 * 파일정보를 조회한다.
	 *  파일업로드가 아닌 경우는 null
	 * @param name
	 * @return
	 */
	// public abstract FileItem getFileItem( String name );

	/**
	 * 파일목록 정보를 조회한다.
	 *  파일업로드가 아닌 경우는 null
	 * @param name
	 * @return
	 */
	// public abstract FileItem [] getFileItems( String name );

	/**
	 * 파일명을조회한다.
	 *  파일업로드가 아닌 경우는 null
	 * @param name
	 * @return
	 */
	public abstract File getFile( String name );

	/**
	 * 파일명을 조회한다.
	 *  파일업로드가 아닌 경우는 null
	 * @param name
	 * @return
	 */
	public abstract File [] getFiles( String name );

	/**
	 * 전체 파일 경로포함한 파일명을조회한다.
	 *  파일업로드가 아닌 경우는 null
	 * @param name
	 * @return
	 */
	public abstract String getFileName( String name );

	/**
	 * 전체 파일 경로포함한  파일명을 조회한다.
	 *  파일업로드가 아닌 경우는 null
	 * @param name
	 * @return
	 */
	public abstract String [] getFileNames( String name );

	/**
	 * 파라미터를 key가 대문자인 Map의 형태로 가공한다.
	 * @return
	 */
	public abstract HoParameterMap getHoParameterMap() ;

	/**
	 * 파라미터를 key가 대문자인 Map의 형태로 가공한다.
	 * @return
	 */
	public abstract HoParameterMap getHoParameterMap(boolean withSession) ;


	/**
	 * Map을 key별로 나누어서 세션정보를 담는다.
	 * 예를 들어,
	 * 		map.put("NAME", "이름");
	 * 		map.put("AGE", "20");인 Map은
	 * 아래와 같이 session에 저장된다.
	 * 		getSession().setAttribute(config.getSessionNamePrefix()+"NAME","이름"));
	 * 		getSession().setAttribute(config.getSessionNamePrefix()+"AGE","20"));
	 *
	 * @param map
	 */
	public void setSessionHoMap(Set set, HoMap map) {
		Iterator it = set.iterator();

		String key = null;
		while(it.hasNext()) {
			key = (String) it.next();
			setSessionObject( key.toUpperCase() ,map.get(key));
		}
	}


	/**
	 * Map을 key별로 나누어서 세션정보를 담는다.
	 * 예를 들어,
	 * 		map.put("NAME", "이름");
	 * 		map.put("AGE", "20");인 Map은
	 * 아래와 같이 session에 저장된다.
	 * 		getSession().setAttribute(config.getSessionNamePrefix() + "NAME","이름"));
	 * 		getSession().setAttribute(config.getSessionNamePrefix() + "AGE","20"));
	 *
	 * @param map
	 */
	public void setSessionMap(Map map) {
		Iterator it = map.keySet().iterator();

		String key = null;
		while(it.hasNext()) {
			key = (String) it.next();
			setSessionObject( key.toUpperCase() ,map.get(key));
		}
	}


	/**
	 * 세션정보를 담는다.
	 * @param sessionName
	 * @param entry
	 */
	public void setSessionObject(String sessionName,  Object entry) {
		this.getHoServlet().getHoSession().setObject(sessionName, entry, true);
	}


	/**
	 * 세션정보를 담는다.
	 * @param sessionName
	 * @param entry
	 * @param usePrefix HoConfig.getSessionNamePrefix()의 사용여부
	 */
	public void setSessionObject(String sessionName,  Object entry, boolean usePrefix) {
		if(usePrefix) {
			if( sessionName.toUpperCase().startsWith(this.getHoConfig().getSessionNamePrefix())) {
				this.getHoServlet().getSession().setAttribute(sessionName.toUpperCase(), entry);
			} else {
				this.getHoServlet().getSession().setAttribute(this.getHoConfig().getSessionNamePrefix() + sessionName.toUpperCase(), entry);
			}
		} else {
			this.getHoServlet().getSession().setAttribute(sessionName.toUpperCase(), entry);
		}
	}

	/**
	 * @deprecated
	 * obj에 해당하는 key를 가진 session정보만 Map으로 얻는다.
	 */
	protected Map getSessionMap(Object obj) {
		Map map = new HashMap();

		if( obj instanceof Set) {
			Iterator it = ((Set) obj).iterator();

			String key = null;
			while(it.hasNext()) {
				key = (String) it.next();
				map.put(this.getHoConfig().getSessionNamePrefix()+key.toUpperCase(), this.getHoServlet().getHoSession().getString(hoConfig.getSessionNamePrefix() + key));
			}
		} else if( obj instanceof List) {

			String key = null;
			for( int i=0 ; i<((List) obj).size() ; i++ ) {
				key = (String) ((List) obj).get(i);
				map.put(this.getHoConfig().getSessionNamePrefix()+key.toUpperCase(), this.getHoServlet().getHoSession().getString(hoConfig.getSessionNamePrefix() + key));
			}
		} else if( obj instanceof String []) {

			String key = null;
			for( int i=0 ; i<((String []) obj).length ; i++ ) {
				key = ((String []) obj)[i];
				map.put(this.getHoConfig().getSessionNamePrefix()+key.toUpperCase(), this.getHoServlet().getHoSession().getString(hoConfig.getSessionNamePrefix() + key));
			}
		} else if( obj instanceof String) {

			String key = (String) obj;
			map.put(this.getHoConfig().getSessionNamePrefix()+key.toUpperCase(), this.getHoServlet().getHoSession().getString(hoConfig.getSessionNamePrefix() + key));
		}

		return map;
	}

	/**
	 *  Ajax 방식으로 호출했는지 여부
	 * @return
	 */
	public boolean isAjaxCall() {
		HoUserAgent hoAgent = new HoUserAgent(getRequest());
		
		return hoAgent.isAjaxCall();
	}

	/**
	 * 배열을 ','로 구분하여 새로운 배열을 만든다.
	 * @param values
	 * @return
	 */
	protected String [] getValuesToArray(String [] values) {
		List list = new ArrayList();

		if( values == null ) {
			return new String[0];
		}

		String [] newValues = null;
		for( int i=0 ; i<values.length ; i++ ) {
			newValues = values[i].split(",");

			for( int j=0 ; j<newValues.length ; j++ ) {
				list.add(newValues[j]);
			}

		}

		String [] array = new String[list.size()];

		System.arraycopy(list.toArray(), 0, array, 0, list.size());

		return array;
	}


	/**
	 * @return
	 * @uml.property  name="hoConfig"
	 */
	public HoConfig getHoConfig() {
		return hoConfig;
	}

	/**
	 * @param hoConfig
	 * @uml.property  name="hoConfig"
	 */
	public void setHoConfig(HoConfig hoConfig) {
		this.hoConfig = hoConfig;
	}

	public void infoParameter(boolean debugParameterOrdered) {
		StringBuffer sb = new StringBuffer();

		int maxLength = getMaxNameLength();
		if(logger.isInfoEnabled()) {
			List namesList = debugParameterOrdered ? getNamesListOrdered() : getNamesList();
			String [] values = null;
			String  name = null;

			sb.append("\r\n *** parameter.infoParameter() ***" );

			try {
				for( int i=0 ; i<namesList.size() ; i++ ) {
					name = (String)namesList.get(i);
					values = getValues(name);
					if( values == null) {
						sb.append("\r\n String " + HoUtil.rPad(name.toLowerCase(), maxLength+3, " ") + " = param.get(\""+name+"\"); //null " + getName(name) );
					} else if( values.length == 0) {
						sb.append("\r\n String " + HoUtil.rPad(name.toLowerCase(), maxLength+3, " ") + " = param.get(\""+name+"\"); //0 " + getName(name)  );
					} else if( values.length == 1) {
						sb.append("\r\n String " + HoUtil.rPad(name.toLowerCase(), maxLength+3, " ") + " = param.get(\""+name+"\"); // " + getName(name) );
					} else {
						sb.append("\r\n String [] " + HoUtil.rPad(name.toLowerCase(), maxLength, " ") + " = param.getValues(\""+name+"\"); // ["+values.length+"] "  + getName(name) );
					}
				}

				logger.info(sb);

			} catch (Exception e) {
				logger.warn(e.getMessage());
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	public void infoParameterValue(boolean debugParameterOrdered) {
		StringBuffer sb = new StringBuffer();
		int maxLength = getMaxNameLength();
		if(logger.isInfoEnabled()) {

			List namesList = debugParameterOrdered ? getNamesListOrdered() : getNamesList();
			String [] values = null;
			String  name = null;
			sb.append("\r\n *** parameter.infoParameterValue() ***" );
			try {
				for( int i=0 ; i<namesList.size() ; i++ ) {
					name = (String)namesList.get(i);
					values = getValues(name);
					if( values == null) {
						sb.append("\r\n " + (i+1) + "( " + HoUtil.rPad(getName(name), maxLength, " ") +" ) : "+ HoUtil.rPad(name, maxLength, " ") + " = null" );
					} else if( values.length == 0) {
						sb.append("\r\n " + (i+1) + "( " + HoUtil.rPad(getName(name), maxLength, " ") +" ) : "+ HoUtil.rPad(name, maxLength, " ") + " = null" );
					} else if( values.length == 1) {
						sb.append("\r\n " + (i+1) + "( " + HoUtil.rPad(getName(name), maxLength, " ") +" ) : "+ HoUtil.rPad(name, maxLength, " ") + " = "+ values[0]);
					} else {
						sb.append("\r\n " + (i+1) + "( " + HoUtil.rPad(getName(name), maxLength, " ") +" ) : "+ HoUtil.rPad(name, maxLength, " ") + " = ["+ values.length +"], [" );
						for( int j=0; j<values.length ; j++ ) {
							if(j!=0) {
								sb.append(" ,");
							}

							sb.append(j + "{" + values[j] + "}" );
						}
						sb.append(']');
					}
				}

				logger.info(sb);

			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	/**
	 * 파라미터명중 가장 긴 파라미터명의 길이를 조회한다.
	 * @return
	 */
	private int getMaxNameLength() {
		int length = 0;
		String [] names = this.getNames();
		for( int i=0 ; i<names.length ; i++ ) {
			if( names[i].length() > length ) {
				length = names[i].length();
			}
		}
		return length;

	}

	/**
	 * 세션과 applicationContext.xml을 비교해서 default값을 가져온다.
	 * 세션에 있으면 세션에 있는 값을,  없을 경우 applicationContext.xml에서 가져온다.
	 * @param gbn
	 * @return
	 */
	public String getDefaut(String gbn) {
		String result = "";
		if(gbn.equalsIgnoreCase("DateFormat")) {
			if(!HoUtil.replaceNull(hoServlet.getHoSession().getString(hoConfig.getSessionNamePrefix() + "YMD")).equals("")) {
				return hoServlet.getHoSession().getString(hoConfig.getSessionNamePrefix() + "YMD");
			} else {
				return hoConfig.getDisplayFormat().get("YMD").toString();
			}
		}
		return result;
	}

}
