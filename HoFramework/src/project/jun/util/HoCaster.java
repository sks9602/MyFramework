package project.jun.util;

public class HoCaster {

	/**
	 * String을 int값으로 반환
	 * @param value
	 * @return
	 */
	public static int toInt(String value) {
		return toInt( value, 0);
	}

	/**
	 * type변환 오류일경우 defaultValue값 반환.
	 * @param value
	 * @param defaultValue
	 * @return
	 */
	public static int toInt(String value, boolean igoreException) {
		return toInt( value, 0, igoreException);
	}
	

	/**
	 * type변환 오류일경우 defaultValue값 반환.
	 * @param value
	 * @param defaultValue
	 * @return
	 */
	public static int toInt(String value, int defaultValue) {
		return toInt( value, defaultValue, true);
	}
	
	/**
	 * type변환 오류일경우 defaultValue값 반환.
	 * @param value
	 * @param defaultValue
	 * @return
	 */
	public static int toInt(String value, int defaultValue, boolean igoreException) {
		int rVal = 0;
		try {
			rVal = Integer.parseInt(value);
		} catch(Exception e) {
			if( igoreException ) {
				rVal = defaultValue;
			} else {
				throw e;
			}
		}
		
		return rVal;
	}
	
	
	/**
	 * String을 int값으로 반환
	 * @param value
	 * @return
	 */
	public static long toLong(String value) {
		return toLong( value, 0L);
	}

	/**
	 * type변환 오류일경우 defaultValue값 반환.
	 * @param value
	 * @param defaultValue
	 * @return
	 */
	public static long toLong(String value, boolean igoreException) {
		return toLong( value, 0L, igoreException);
	}
	
	/**
	 * type변환 오류일경우 defaultValue값 반환.
	 * @param value
	 * @param defaultValue
	 * @return
	 */
	public static long toLong(String value, int defaultValue) {
		return toLong( value, Long.valueOf(defaultValue), true);
	}	

	/**
	 * type변환 오류일경우 defaultValue값 반환.
	 * @param value
	 * @param defaultValue
	 * @return
	 */
	public static long toLong(String value, long defaultValue) {
		return toLong( value, defaultValue, true);
	}
	
	/**
	 * type변환 오류일경우 defaultValue값 반환.
	 * @param value
	 * @param defaultValue
	 * @return
	 */
	public static long toLong(String value, long defaultValue, boolean igoreException) {
		long rVal = 0;
		try {
			rVal = Integer.parseInt(value);
		} catch(Exception e) {
			if( igoreException ) {
				rVal = defaultValue;
			} else {
				throw e;
			}
		}
		
		return rVal;
	}
	/**
	 * String을 double값으로 반환
	 * @param value
	 * @return
	 */
	public static double toDouble(String value) {
		return toDouble( value, 0.0);
	}

	/**
	 * type변환 오류일경우 defaultValue값 반환.
	 * @param value
	 * @param defaultValue
	 * @return
	 */
	public static double toDouble(String value, boolean igoreException) {
		return toDouble( value, 0.0, igoreException);
	}
	

	/**
	 * type변환 오류일경우 defaultValue값 반환.
	 * @param value
	 * @param defaultValue
	 * @return
	 */
	public static double toDouble(String value, int defaultValue) {
		return toDouble( value, Double.valueOf(defaultValue), true);
	}

	
	/**
	 * type변환 오류일경우 defaultValue값 반환.
	 * @param value
	 * @param defaultValue
	 * @return
	 */
	public static double toDouble(String value, float defaultValue) {
		return toDouble( value, Double.valueOf(defaultValue), true);
	}

	
	/**
	 * type변환 오류일경우 defaultValue값 반환.
	 * @param value
	 * @param defaultValue
	 * @return
	 */
	public static double toDouble(String value, double defaultValue) {
		return toDouble( value, defaultValue, true);
	}
	
	/**
	 * type변환 오류일경우 defaultValue값 반환.
	 * @param value
	 * @param defaultValue
	 * @return
	 */
	public static double toDouble(String value, double defaultValue, boolean igoreException) {
		double rVal = 0;
		try {
			rVal = Double.parseDouble(value);
		} catch(Exception e) {
			if( igoreException ) {
				rVal = defaultValue;
			} else {
				throw e;
			}
		}
		
		return rVal;
	}
}
