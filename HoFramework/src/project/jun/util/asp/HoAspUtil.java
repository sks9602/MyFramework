package project.jun.util.asp;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import project.jun.dao.result.HoList;
import project.jun.dao.result.HoMap;
import project.jun.dao.result.transfigure.HoMapHasList;
import project.jun.dao.result.transfigure.HoSetHasMap;

public class HoAspUtil {

	/**
	 * ASP 가능 하도록 "Root Company"와"Asp Company"의 List를 Merge하여  HoList로 변환하다.
	 * 
	 * @param hoList
	 * @return
	 */
	public HoList getHoListAsp(HoList hoList) {
		return getHoListAsp(hoList, "0000", "0000",  "COMPANY_ID", "CD");
	}

	public HoList getHoListAsp(HoList hoList, String myCompany) {
		return getHoListAsp(hoList, "0000", myCompany,  "COMPANY_ID", "CD");
	}
	
	public HoList getHoListAsp(HoList hoList, String myCompany, String companyColumn) {
		return getHoListAsp(hoList, "0000", myCompany,  companyColumn, "CD");
	}	

	public HoList getHoListAsp(HoList hoList, String myCompany, String companyColumn, String codeColumn) {
		return getHoListAsp(hoList, "0000", myCompany,  companyColumn, codeColumn);
	}	

	/**
	 * ASP 가능 하도록 "Root Company"와"Asp Company"의 List를 Merge하여  HoList로 변환하다.
	 * ex) { COMPANY_CD : "0001", CODE : "1", "1 NM" } ,  { COMPANY_CD :  "0001", CODE : "2", "2 NM" } , { COMPANY_CD :  "0001", CODE : "3", "3 NM" } , { COMPANY_CD :  "1000", CODE : "2", "2_ASP NM" } 
	 *    --> { COMPANY_CD :  "0001", CODE : "1", "1NM" } ,  { COMPANY_CD :  "1000", CODE : "2", "2_ASP NM" } , { COMPANY_CD :  "0001", CODE : "3", "3NM" } 로 변경..
	 *     
	 *     HoList list = cache.getHoList("B20"); 
	 *     HoAspUtil  aspUtil = new HoAspUtil();
	 *     HoList aspHoList = aspUtil.getHoListAsp( list, "0001", "1000", "COMPANY_CD", "CODE");
	 *     
	 * @param hoList
	 * @param rootCompany : Root Company 명 EX) 예제에서는 "0001"
	 * @param myCompany : ASP Company 명 EX) 예제에서는 "1000"
	 * @param companyColumn : ASP 구분 코드 컬럼명.. EX) 예제에서는 "COMPANY_CD"
	 * @param codeColumn : 코드용 컬럼명 EX) 예제에서는 "CODE"
	 * @return
	 */
	public HoList getHoListAsp(HoList hoList, String rootCompany, String myCompany, String companyColumn, String codeColumn) {
		StringBuffer sb = new StringBuffer();
		
		if( hoList == null ) {
			return new HoList();
		}
		HoMapHasList mapList = hoList.toHoMapHasList(companyColumn);  // companyColumn  -> "COMPANY_CD"
 
		HoList rootHoList = mapList.getHoList(rootCompany);
		HoList compHoList = mapList.getHoList(myCompany);
		
		// Root Company와 ASP Company가 같을 경우 에는 "Root Company"에 해당 하는 정보 return
		if( rootCompany.equals(myCompany) || compHoList == null || compHoList.size() == 0 ) {
			return rootHoList;
		} 
		// Root Company와 ASP Company가 다를 경우
		else {
			HoSetHasMap myCompSet = null;
			if( compHoList != null && compHoList.size() > 0 ) {
				myCompSet = new HoSetHasMap(mapList.getHoList(myCompany), codeColumn); // codeColumn -> "CODE"
			}
			List list = new ArrayList();
		
			for( int i=0; rootHoList!=null && i<rootHoList.size(); i++) {
				sb.append(i>0 ? "," : "");
				sb.append("{");
				
				Map<String, Object> map = null;
				// ASP용 코드가 있을경우  ASP COMPANY의 코드 사용
				if( myCompSet!=null && myCompSet.containsKey( rootHoList.getString(i, codeColumn)) ) {
					list.add(((HoMap) myCompSet.getValue(rootHoList.getString(i, codeColumn))).getMap());
				} 
				// ASP 코드가 없을 경우 ROOT COMPANY의 코드 사용
				else {
					list.add(rootHoList.get(i));
				}
				
			}
			return new HoList(list);
		}
	}
	
	public String getComboOptionString(HoList hoList, String rootCompany, String myCompany, String companyColumn, String codeColumn) {
		StringBuffer sb = new StringBuffer();
		
		HoMapHasList mapList = hoList.toHoMapHasList(companyColumn);  // companyColumn  -> "COMPANY_CD"
 
		HoList rootHoList = mapList.getHoList(rootCompany);
		HoSetHasMap myCompSet = new HoSetHasMap(mapList.getHoList(myCompany), codeColumn); // codeColumn -> "CODE"

		/*
		ArrayList fList = new ArrayList();
		for( int i=0; rootHoList!=null && myCompSet!=null && i<rootHoList.size(); i++) {
			if( myCompSet.containsKey( rootHoList.getString(i, codeColumn)) ) {
				fList.add(myCompSet.getValue(rootHoList.getString(i, codeColumn)));
			} else {
				fList.add(rootHoList.get(i));
			}
		}
		 */
		
		for( int i=0; rootHoList!=null && myCompSet!=null && i<rootHoList.size(); i++) {
			sb.append(i>0 ? "," : "");
			sb.append("{");
			
			HoMap map = null;
			if( myCompSet.containsKey( rootHoList.getString(i, codeColumn)) ) {
				map = (HoMap) myCompSet.getValue(rootHoList.getString(i, codeColumn));
			} else {
				map = new HoMap(rootHoList.get(i));
			}
			
			for( int j=0; j<mapList.getMetaData().getColumnCount(); j++) {
				sb.append(j>0 ? "," : "");
				sb.append( mapList.getMetaData().getColumnName(j) + ": '" +  map.getString(mapList.getMetaData().getColumnName(j)) + "'");
			}
			
			sb.append("}");
		}
		
		System.out.println(">>>>>" + sb);
		
		return sb.toString();
	}
}
