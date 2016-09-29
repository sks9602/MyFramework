package project.jun.util;

import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

public class HoLogging {

	public static String toString(List list) {
		StringBuilder sb = new StringBuilder();

		Object obj = null;
		for( int i=0; i<list.size() ; i++) {
			obj = list.get(i);

			if( obj instanceof List) {
				sb.append(toString((List) obj));
			} else if( obj instanceof Map) {
				sb.append(toString((Map) obj));
			} else if( obj instanceof Set) {
				sb.append(toString((Set) obj));
			} else if( obj instanceof String []) {
				sb.append(toString((String []) obj));
			} else if( obj instanceof String) {
				sb.append(toString((String) obj));
			} else {
				sb.append(obj.toString());
			}
		}

		return sb.toString();
	}

	public static String toString(Map map) {
		StringBuilder sb = new StringBuilder();

		Set set = new TreeSet( map.keySet() );

		Iterator it = set.iterator();

		Object obj = null;
		Object entry = null;

		while( it.hasNext()) {
			obj = it.next();

			if( obj instanceof List) {
				sb.append(toString((List) obj));
			} else if( obj instanceof Map) {
				sb.append(toString((Map) obj));
			} else if( obj instanceof Set) {
				sb.append(toString((Set) obj));
			} else if( obj instanceof String []) {
				sb.append(toString((String []) obj));
			} else if( obj instanceof String) {
				sb.append(toString((String) obj));
			} else {
				sb.append(obj.toString());
			}

			entry = map.get(obj);
			if( entry instanceof List) {
				sb.append(toString((List) entry));
			} else if( entry instanceof Map) {
				sb.append(toString((Map) entry));
			} else if( entry instanceof Set) {
				sb.append(toString((Set) entry));
			} else if( entry instanceof String []) {
				sb.append(toString((String []) entry));
			} else if( entry instanceof String) {
				sb.append(toString((String) entry));
			} else {
				sb.append(entry.toString());
			}

		}

		return sb.toString();
	}

	public static String toString(Set _set) {
		StringBuilder sb = new StringBuilder();

		Set set = new TreeSet( _set );

		Iterator it = set.iterator();

		Object obj = null;

		while( it.hasNext()) {
			obj = it.next();

			if( obj instanceof List) {
				sb.append(toString((List) obj));
			} else if( obj instanceof Map) {
				sb.append(toString((Map) obj));
			} else if( obj instanceof Set) {
				sb.append(toString((Set) obj));
			} else if( obj instanceof String []) {
				sb.append(toString((String []) obj));
			} else if( obj instanceof String) {
				sb.append(toString((String) obj));
			} else {
				sb.append(obj.toString());
			}
		}


		return sb.toString();
	}


	public static String toString(String [] str) {
		StringBuilder sb = new StringBuilder();


		for( int i=0; i<str.length ; i++) {
			sb.append("[" + i + "] :" + str[i]);
		}
		sb.append("\r\n");

		return sb.toString();
	}

	public static String toString(String str) {
		StringBuilder sb = new StringBuilder();


		sb.append(str).append("\r\n");

		return sb.toString();
	}
}
