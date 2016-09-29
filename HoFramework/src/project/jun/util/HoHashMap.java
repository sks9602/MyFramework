package project.jun.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import project.jun.dao.result.HoMap;


public class HoHashMap<K,V> extends HashMap {

	/**
	 * Result에서 key값에 해당하는 List를 return한다.
	 *
	 * @param key
	 * @return
	 */
	public List getList(String key) {
		List alist = (List) super.get(key);
		return alist;
	}

	public String getString(String key, int i, String column) {
		return getString(key, i, column, "");
	}

	public String getString(String key, int i, String column, String defaultValue) {

		Object obj = getObject(key, i);

		if( obj != null ) {
			if( obj instanceof String ) {
				return (String) obj;
			} else if( obj instanceof String [] ) {
				String [] values = ((String []) obj);

				return values[0]+" [0/" + values.length +"]";
			} else {
				return obj.toString();
			}
		} else {
			return defaultValue;
		}
	}

	public Object getObject(String key, int i) {
		ArrayList alist = (ArrayList) super.get(key);
		if (alist == null) {
			return null;
		} else {
			return alist.get(i);
		}
	}

	public void setValue(String key, Object obj) {
		ArrayList alist = (ArrayList) super.get(key);
		if (alist == null) {
			alist = new ArrayList(10);
		}
		alist.add(obj);
		put(key, alist);
	}
}
