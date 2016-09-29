package project.jun.was.parameter;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TreeSet;

import project.jun.util.HoUtil;
import project.jun.util.HoValidator;

public class HoJUnitParameter extends HoParameter {

	public  HoParameterMap hoParameterMap  = null;
	public  Map<String, Object>        valueMap        = new HashMap<String, Object>();
	
	public HoJUnitParameter() {
		// TODO Auto-generated constructor stub
	}

	public void setHoParameterMap( HoParameterMap hoParameterMap  ) {
		this.hoParameterMap = hoParameterMap;
	}
	
	@Override
	public String get(String name) throws UnsupportedEncodingException {
		
		return get(name, "");
	}

	@Override
	public String get(String name, String defaultValue) throws UnsupportedEncodingException {
		String paramName = getName(name);
		
		if( HoValidator.isEmpty(paramName) || HoValidator.isEmpty(name) ) {
			// request.getParameter()값이 없을 경우 default값을 map에 저장한다.
			if( HoValidator.isNull(defaultValue) ) {
				if( defaultValueMap.containsKey(name.toUpperCase()) ) {
					return (String) defaultValueMap.get(name.toUpperCase());
				} else {
					return "";
				}
			} else if( !defaultValue.equals("") ) {
				defaultValueMap.put(name.toUpperCase(), defaultValue);
			}
			return defaultValue;
		}

		String value = "";
		try {
			value = getStringValueFromMap(paramName);
			defaultValue = "";
		} catch(Exception e) {

		}

		return decodeValue( value, defaultValue );
	}

	@Override
	public List<String> getNamesListOrdered() {
		List<String> list = new ArrayList<String>();

		Iterator<String> it =  new TreeSet<String>(this.names.keySet()).iterator();

		String paramName = null;

		while( it.hasNext() ) {
			paramName = (String) it.next();

			list.add(paramName.toUpperCase());
		}

		return list;
	}

	@Override
	public String[] getValues(String name) {
		return getValues(name, "");
	}

	@Override
	public String[] getValues(String name, String defaultValue) {
		String paramName = getName(name);

		if( defaultValue == null ) {
			defaultValue = "";
		}

		if( HoUtil.replaceNull(name).equals("") || HoUtil.replaceNull(paramName).equals("") ) {
			return new String[0];
		}

		Object obj = getValueFromMap(paramName);
		
		String [] values = null;
		if(obj== null ) {
			return new String[0];
		} else {
			if( obj instanceof String ) {
				values = new String[] { (String) obj };
				
				return values;
			} else if( obj instanceof Object ) {
				values = new String[] { obj.toString() };
				
				return values;
			} else if( obj instanceof String [] ) {
				values = (String[]) obj;
			} else if( obj instanceof Object [] ) {
				Object [] objs = (Object []) obj;
				ArrayList<String> list = new ArrayList<String>();
				for( Object val : objs ) {
					list.add(decodeValue(val.toString(), defaultValue ));
				}
				values = new String[list.size()];

				System.arraycopy(list.toArray(), 0, values, 0, list.size());
			} else {
				values = new String[] { obj.toString() };
			}
		}

		return values;
	}

	@Override
	public List getBlockNamesList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getQueryString() {
		return null;
	}

	@Override
	public HoParameterMap getHoParameterMap() {
		return this.hoParameterMap;
	}

	@Override
	public HoParameterMap getHoParameterMap(boolean withSession) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public File getFile(String name) {
		Object obj = getValueFromMap(name);
		
		File value = null;
		if( obj != null ) {
			if( obj instanceof File) {
				value = (File) obj;
			} else if( obj instanceof File []) {
				value = ((File[]) obj)[0];
			} 
		}
			
		return value;
	}

	@Override
	public File[] getFiles(String name) {
		Object obj = getValueFromMap(name);
		
		File [] values = null;
		if( obj != null ) {
			if( obj instanceof File) {
				values = new File[] {(File) obj};
			} else if( obj instanceof File []) {
				values = ((File[]) obj);
			} 
		}
			
		return values;
	}

	@Override
	public String getFileName(String name) {
		File file = getFile(name);
		
		if( file == null ) {
			return "";
		}
		return file.getName();
	}

	@Override
	public String[] getFileNames(String name) {
		File [] files = getFiles(name);
		
		if( files == null ) {
			return new String[0];
		}
		
		ArrayList<String> list = new ArrayList<String>();

		for( File file : files ) {
			list.add(file.getName());
		}

		String [] values = new String[list.size()];

		System.arraycopy(list.toArray(), 0, values, 0, list.size());
 
		return values;
	}
	
	/**
	 * JUnit Test를 위한 parameter name / value 를 set...
	 * 
	 * @param paramName
	 * @param value (String , File)
	 */
	public void put(String paramName, Object value) {
		this.names.put(paramName.toUpperCase(), paramName);
		this.valueMap.put(paramName, value);
	}
	
	/**
	 * Value Map에 등록된 값을 String으로 조회.
	 * @param paramName
	 * @return
	 */
	private String getStringValueFromMap(String paramName) {
		Object obj = this.valueMap.get(paramName);
		
		if( obj == null ) {
			return null;
		} else {
			return obj.toString();
		}
	}

	/**
	 * Value Map에 등록된 값을 조회.
	 * @param paramName
	 * @return
	 */
	private Object getValueFromMap(String paramName) {		
		return this.valueMap.get(paramName);
	}
	

}
