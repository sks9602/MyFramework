package project.jun.util;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

/**
 * ExtJS에서 유용하게 사용 할수 있는 기능들을 포함한 Class
 * @author Administrator
 *
 */
public class HoUtilExtjs {

	/**
	 * Combobox에서 multiSelect가능할 경우 String 값을 Array로 변환 해서 반환
	 * ex) 'aaa,bbb' -> ['aaaa','bbb'] 
	 * ex) 'ccc' -> "" (빈값) 
	 * @param value
	 * @return
	 */
	public static String toValueArray(String value) {
		if( HoValidator.isEmpty(value)) {
			return "''";
		} 
		
		StringBuilder sb = new StringBuilder();
		
		if( value.indexOf(",") != -1 ) {
			String [] values = value.split(",");
			sb.append("[");
			for( int i=0; i<values.length ; i++ ) {
				sb.append((i>0 ? "," : "") + "'" +values[i].trim()+"'");
			}
			sb.append("]");
		} else {
			sb.append("'");
			sb.append(value);
			sb.append("'");
		}
		
		return sb.toString();
	}

	/**
	 * Multi Slider에서  String 값을 Array로 변환 해서 반환
	 *   value가 있으면 value가 우선 하고, value가 없을 경우 min 또는 max값을 return
	 * ex) ('1,100', null, null) -> ['1','100'] // value우선
	 * ex) ('1,50', 0, 100 ) -> ['1','50'] // value가 우선
	 * ex) ('', null, null) -> ['0','100']  // value가 null이기 때문에  default min / max return (default min : 0, default max : 100)
	 * ex) ('1', 10, 50) -> ['10','50'] // value가 ','로 구분되지 않아 min / max로 return
	 * @param value
	 * @return
	 */
	public static String toValueArray(String value, String min, String max) {
		String defMin = "0";
		String defMax = "100";
		
		if( HoValidator.isEmpty(value) || value.indexOf(",") < 0 ) {
			return "["+HoUtil.replaceNull(min, defMin)+","+ HoUtil.replaceNull(max, defMax) +"]";
		} 
		
		StringBuilder sb = new StringBuilder();
		
		String [] scopes = new String[] {min, max};
		
		if( value.indexOf(",") != -1 ) {
			String [] values = value.split(",");
			sb.append("[");
			// min과 max이기 때문에 2번 이상 실행 되면 안됨..
			for( int i=0; i<Math.min(values.length, scopes.length) ; i++ ) {
				sb.append((i>0 ? "," : "") + HoUtil.replaceNull(values[i].trim(), scopes[i]) );
			}
			sb.append("]");
		}
		
		return sb.toString();
	}
	
	/**
	 * RadioGroup에서  입력값과 코드가 같을 경우 checked되도록 
	 * @param value
	 * @param codeValue
	 * @return
	 */
	public static String getCheckedRadio(String value, String codeValue) {
		
		if( HoUtil.replaceNull(value).equals(HoUtil.replaceNull(codeValue))) {
			return " checked : true ";
		} else {
			return "";
		}
	}
	
	
	/**
	 * CheckboxGroup에서  입력값과 코드가 같을 경우 checked되도록 
	 * @param value  선택할  코드 값(들) "AAA,BBB"
	 * @param codeValue  코드값 "AAA"
	 * @return
	 */
	public static String getCheckedCheckbox(String value, String codeValue) {
		if( HoValidator.isEmpty(value) || HoValidator.isEmpty(codeValue) ) {
			return "";
		}
		
		String [] values = value.split(",");
		
		Set<String> set = new HashSet<String>(Arrays.asList(values));

		if( set.contains(codeValue)) {
			return " checked : true ";
		} else {
			return "";
		}
	}
	
	/**
	 * Format에 따른 최소값을 조회
	 * ex) max("0", "5,2") --> "0.00"
	 * @param min
	 * @param scale
	 * @return
	 */
	public static String min(String min, String scale) {
		int up = 0;
		int dp = 0;

		StringBuilder sb = new StringBuilder();

		if( !HoValidator.isEmpty(min))  {
			
			if( HoUtil.replaceNull(scale).indexOf(",")>=0 ) {
				String [] dls = scale.split("\\,");
				try { up = Integer.parseInt(dls[0]); } catch(Exception e) { }
				try { dp = Integer.parseInt(dls[1]); } catch(Exception e) { }
				
				for( int i=1; i<up-dp; i++) {
					sb.append("#");
				}
				sb.append("0");
				if( dp> 0 ) {
					sb.append(".");
				}
				for( int i=0; i<dp; i++) {
					sb.append("0");
				}
			}
			
			return HoFormatter.toPointFormat(new Double(min), sb.toString());
		}
		if( HoValidator.isEmpty(scale))  {
			return "";
		}

		if( scale.indexOf(",")>=0 ) {
			String [] dls = scale.split("\\,");
			try { up = Integer.parseInt(dls[0]); } catch(Exception e) { }
			try { dp = Integer.parseInt(dls[1]); } catch(Exception e) { }
		} else {
			up = scale.length();
		}
		sb.append("-");
		for( int i=1; i<up-dp; i++) {
			sb.append("#");
		}
		sb.append("0");
		if( dp> 0 ) {
			sb.append(".");
		}
		
		for( int i=0; i<dp; i++) {
			sb.append("#");
		}
		return sb.toString();
	}
	
	/**
	 * Format에 따른 최대값을 조회
	 * ex) max("100", "5,2") --> "100.00"
	 * 
	 * @param max
	 * @param scale
	 * @return
	 */
	public static String max(String max, String scale) {
		int up = 0;
		int dp = 0;
		StringBuilder sb = new StringBuilder();

		if( !HoValidator.isEmpty(max))  {
			if( HoUtil.replaceNull(scale).indexOf(",")>=0 ) {
				String [] dls = scale.split("\\,");
				try { up = Integer.parseInt(dls[0]); } catch(Exception e) { }
				try { dp = Integer.parseInt(dls[1]); } catch(Exception e) { }
				
				for( int i=1; i<up-dp; i++) {
					sb.append("#");
				}
				sb.append("0");
				if( dp> 0 ) {
					sb.append(".");
				}
				for( int i=0; i<dp; i++) {
					sb.append("0");
				}
			}
			
			return HoFormatter.toPointFormat(new Double(max), sb.toString());
		}		
		if( HoValidator.isEmpty(scale))  {
			return "";
		}
		if( scale.indexOf(",")>=0 ) {
			String [] dls = scale.split("\\,");
			try { up = Integer.parseInt(dls[0]); } catch(Exception e) { }
			try { dp = Integer.parseInt(dls[1]); } catch(Exception e) { }
		} else {
			up = scale.length();
		}
		
		for( int i=1; i<up-dp; i++) {
			sb.append("#");
		}
		sb.append("0");
		
		if( dp> 0 ) {
			sb.append(".");
		}
		
		for( int i=0; i<dp; i++) {
			sb.append("9");
		}
		return sb.toString();
	}	
	
	/**
	 * 소수점 이하 자리수를 조회
	 * @param scale
	 * @return
	 */
	public static String getPrecision(String scale) {
		// 빈값일 경우 소숫점 3자리 임시..
		if( HoValidator.isEmpty(scale) ) {
			return "5";
		} else if( scale.indexOf(",")>=0 ) {
			String [] dls = scale.split("\\,");
			
			return dls[1];
		} 
		return "";
	}

	/**
	 * String을 배열로 변환하여 return
	 * ex) "5,2" => {"5", "2"}
	 * @param value
	 * @return
	 */
	public static  String [] toArrayValues(String value) {
		return toArrayValues(value, 2);
	}
	
	/**
	 * String을 배열로 변환하여 return
	 * ex) "5,2" => {"5", "2"}
	 * @param value
	 * @return
	 */
	public static  String [] toArrayValues(String value, int len) {
		String [] values = new String[len];
		
		if( HoValidator.isEmpty(value) ) {
			for(int i=0; i<len;i++) {
				values[i] = "";
			}
			
			return values;
		}
		
		String [] nVals = value.split("\\,");
	
		System.arraycopy(nVals, 0, values, 0, Math.min(nVals.length, len));
		
		return values;
	}
}
