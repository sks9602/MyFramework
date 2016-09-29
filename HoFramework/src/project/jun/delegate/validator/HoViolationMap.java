package project.jun.delegate.validator;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

import project.jun.util.HoHashMap;

/**
 * 유효하지 않은 값들을 관리하는 map임..
 * 배열 파리미터일 경우 [idx]로 관리
 *
 * @author sks
 *
 */
public class HoViolationMap extends HoHashMap {

	public List getList(String key, int idx) {
		String newKey = key+"["+idx+"]";
		List alist = (List) super.get(newKey);
		return alist;
	}

	public String getString(String key, int idx , int i, String column) {
		return getString(key, idx, i, column, "");
	}

	public String getString(String key, int idx , int i, String column, String defaultValue) {
		String newKey = key+"["+idx+"]";

		Object obj = getObject(newKey, i);

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

	public Object getObject(String key, int idx, int i) {
		String newKey = key+"["+idx+"]";

		ArrayList alist = (ArrayList) super.get(newKey);
		if (alist == null) {
			return null;
		} else {
			return alist.get(i);
		}
	}

	public void setValue(String key, int idx, String value) {

		setValue(key, idx);

		String newKey = key+"["+idx+"]";

		ArrayList alist = (ArrayList) super.get(newKey);
		if (alist == null) {
			alist = new ArrayList(10);
		}
		alist.add(value);

		put(newKey, alist);
	}


	public List<String []> getViolationParameterNames() {
		Set<String>     keySet = super.keySet();
		List<String []> nameList = new ArrayList<String []>();

		Iterator<String> it = new TreeSet(super.keySet()).iterator();
		String key = null;

		String [] nameValue = null;
		while( it.hasNext()) {
			key = it.next();

			if( key.matches(".*\\[\\d\\]")) {
				nameValue = new String[2];
				String [] tmp = key.split("\\[");

				nameValue[0] = tmp[0];
				nameValue[1] = tmp[1].replaceAll("\\]", "");
			} else {
				nameValue = new String[1];
				nameValue[0] =  key;
			}

			nameList.add(nameValue);
		}

		return nameList;
	}

	public boolean isViolated() {
		return !super.isEmpty();
	}

}
