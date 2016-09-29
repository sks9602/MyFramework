package project.jun.was.parameter;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

import project.jun.util.HoUtil;

public class HoParameterMap extends HashMap {

	/**
	 *
	 */
	private static final long serialVersionUID = 5353473971313230729L;

	/**
	 * 키값의 최고 길이를 구한다.
	 * @return
	 */
	public int getMaxKeyLength(Set<String> key) {
		Iterator<String> keyIt = key.iterator();
		int length = 0;

		String keyStr = null;
		while(keyIt.hasNext()) {
			keyStr = (String) keyIt.next();

			if( keyStr.length() > length ) {
				length = keyStr.length();
			}

		}
		return length;
	}


	public Object get(String key) {

		Object obj = super.get(key.toUpperCase());

		if( obj == null ) {
			if( key.toUpperCase().endsWith("_ES")) {
				obj = new String[0];
			} else {
				obj = "";
			}
		}

		return obj;
	}

	public String [] getValues(String key) {
		Object obj = super.get(key.toUpperCase());

		if( obj == null ) {
			return new String[0];
		} else {
			if( obj instanceof String []) {
				return (String []) obj;
			} else if ( obj instanceof String) {
				String [] _str = new String[1] ;
				_str[0] = (String) obj;
				 return _str;
			} else {
				return new String[0];
			}
		}

	}

	/**
	 * 파라미터의 명을 조회(String[])한다.
	 */
	public String[] getNames() {
		List list = this.getNamesList();
		String[] strArray = new String[list.size()];
		return (String[]) list.toArray( strArray );
	}

	/**
	 * 파라미터의 명을 조회(List)한다.
	 */
	public List getNamesList() {
		Set set =  new TreeSet(this.keySet());
		Iterator it = set.iterator();
		List list = new ArrayList();

		while( it.hasNext() ) {
			list.add( (String)it.next() );
		}

		return list;
	}

	public Object put(String key, Object entry) {
		return super.put(key.toUpperCase(), entry == null ? "" : entry);
	}

	public String toString() {
		StringBuffer sb = new StringBuffer(512);

		Set<String> keySet = new TreeSet(this.keySet());
		Iterator<String> keyIt = keySet.iterator();
		String keyStr = null;

		sb.append("[ Parameter Size : "+this.size()+"]\r\n");

		int maxLength = getMaxKeyLength(keySet);
		Object entry = null;

		keyStr = "P_ACTION_FLAG";


		entry = this.get(keyStr);
		sb.append("\t>>>>> ").append(HoUtil.rPad(keyStr, maxLength , " "));
		sb.append(" : " + entry.toString() ).append("\r\n");
		int idx = 1;

		while(keyIt.hasNext()) {
			keyStr = (String) keyIt.next();
			if( !keyStr.equals("P_ACTION_FLAG")) {
				sb.append("\t["+ HoUtil.lPad(String.valueOf(idx++), 3, " ") + "] ");
				entry = this.get(keyStr);
				sb.append(HoUtil.rPad(keyStr, maxLength , " "));
				if( entry instanceof Object [] ) {
					sb.append(" : "+ entry.getClass().getName() +" [" + ((Object[]) entry ).length + "]") ;
					sb.append(" {") ;
					for( int i=0 ; i<((Object[]) entry ).length; i++ ) {
						if( i!=0 ) {
							sb.append(", ");
						}
						sb.append(i+"="+ ((Object[]) entry )[i]) ;
					}
					sb.append('}') ;
				} else {
					if( !(entry instanceof String) ) {
						sb.append(" : ["+ entry.getClass().getName() +"] - " + HoUtil.cutString(entry.toString(), 100, "... [has more]\r\n")) ;
					} else {
						sb.append(" : " + HoUtil.cutString(entry.toString(), 100, "... [has more]\r\n") );
					}
				}
				if( idx % 5 == 0 ) {
					sb.append("\r\n");
				}
			}
		}
		return sb.toString();
	}
}
