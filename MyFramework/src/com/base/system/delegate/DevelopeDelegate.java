package com.base.system.delegate;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.naming.Name;

import org.apache.xmlbeans.impl.config.NameSet;

import com.base.system.delegate.validator.SampleValidator;

import project.jun.config.HoConfig;
import project.jun.dao.HoDao;
import project.jun.dao.parameter.HoQueryParameterHandler;
import project.jun.dao.parameter.HoQueryParameterMap;
import project.jun.dao.result.HoList;
import project.jun.dao.result.HoMap;
import project.jun.delegate.HoDelegate;
import project.jun.delegate.validator.HoViolationMap;
import project.jun.util.HoLogging;
import project.jun.util.HoSpringUtil;
import project.jun.was.HoModel;
import project.jun.was.parameter.HoParameter;
import project.jun.was.result.exception.HoException;
import project.jun.was.result.message.HoMessage;
import project.jun.was.spring.HoController;

public class DevelopeDelegate extends HoDelegate {

    /**
     * 메뉴 개발 진도 정보 조회 (TODO PMS로 이동)
     * @param actionFlag
     * @param model
     * @param parameter
     * @param hoConfig
     * @throws HoException
     */
	public void detailPms(String actionFlag, HoModel model, HoParameter parameter, HoConfig hoConfig) throws HoException  {

		HoDao dao = this.getHoDao();
		HoQueryParameterHandler hqph = new HoQueryParameterHandler(parameter, hoConfig);
		HoQueryParameterMap value = hqph.getForDetail();

		HoMap menuInfo = dao.selectOne("Develope.selectMenuDevelopeInfo", value);
		model.put( KEY_JSON_DATA , menuInfo );
	}

	/**
	 * Form에 저장된 저장이력 조회
	 * @param actionFlag
	 * @param model
	 * @param parameter
	 * @param hoConfig
	 * @throws HoException
	 */
	public void listFormHistory(String actionFlag, HoModel model, HoParameter parameter, HoConfig hoConfig) throws HoException  {

		HoDao dao = this.getHoDao();
		HoQueryParameterHandler hqph = new HoQueryParameterHandler(parameter, hoConfig);
		HoQueryParameterMap value = hqph.getForDetail();

		HoList list = dao.select("Develope.selectMenuFormHistList", value);

		model.put( KEY_JSON_CNT , list.size());
		model.put( KEY_JSON_DATA , list);
	}
	
	/**
	 * Form에 저장된 상세 정보 목록
	 * @param actionFlag
	 * @param model
	 * @param parameter
	 * @param hoConfig
	 * @throws HoException
	 */
	public void listFormDetail(String actionFlag, HoModel model, HoParameter parameter, HoConfig hoConfig) throws HoException  {

		HoDao dao = this.getHoDao();
		HoQueryParameterHandler hqph = new HoQueryParameterHandler(parameter, hoConfig);
		HoQueryParameterMap value = hqph.getForDetail();

		HoList list = dao.select("Develope.selectMenuFormHistDetailList", value);

		model.put( KEY_JSON_DATA , list);
	}

	/**
	 * Form에 저장된 상세 정보
	 * @param actionFlag
	 * @param model
	 * @param parameter
	 * @param hoConfig
	 * @throws HoException
	 */
	public void detailForm(String actionFlag, HoModel model, HoParameter parameter, HoConfig hoConfig) throws HoException  {

		HoDao dao = this.getHoDao();
		HoQueryParameterHandler hqph = new HoQueryParameterHandler(parameter, hoConfig);
		HoQueryParameterMap value = hqph.getForDetail();

		HoList list = dao.select("Develope.selectMenuFormHistDetailList", value);
		
		// LIST를 DETAIL로 만들때 "키"로 사용할 컬럼명
		model.put( "KEY_COL" , "ITEM_NM" );
		// LIST를 DETAIL로 만들때 "값"으로 사용할 컬럼명
		model.put( "VAL_COL" , "ITEM_VAL" );
		
		model.put( KEY_JSON_DATA , list );
	}
	
	/**
	 * Form의 정보를 저장
	 * @param actionFlag
	 * @param model
	 * @param parameter
	 * @param hoConfig
	 * @return
	 */
    public Object insertFormHistory(String actionFlag, HoModel model, HoParameter parameter, HoConfig hoConfig) {

		HoDao dao = this.getHoDao();

		HoQueryParameterHandler hqph = new HoQueryParameterHandler(parameter, hoConfig);

		HoQueryParameterMap value = hqph.getForDetail();

		List<HoQueryParameterMap> list = new ArrayList<HoQueryParameterMap>();
		
		try {
			logger.info( value );
			int result = dao.execute("Develope.insertMenuFormHist", value);

			Map<String, Object> map = new HashMap<String, Object>();
			
			List<String> names = parameter.getNamesList();
			
			// Form등록을 위한 공통 파라미터
			Set<String> nameSet = new HashSet<String>();
			nameSet.add("COMPANY_ID");
			nameSet.add("SYSTEM_ID");
			nameSet.add("F_MENU_ID");
			nameSet.add("F_MEMBER_ID");
			nameSet.add("F_FORM_ID");
			nameSet.add("HISTORY_NM");
			
			
			Iterator<String> it = nameSet.iterator();
			String key = null;
			// 공통파라미터 map에 저장
			while( it.hasNext() ) {
				key = it.next();
				map.put(key, parameter.get(key));
			}
			map.put("HISTORY_SEQ", value.get("HISTORY_SEQ"));
			
			String [] colVals = null;
			StringBuilder colVal = null;
			// 파라미터의 수 만큼 loop
			for( int i=0; i<names.size() ; i++) {
				// 공통 파라미터가 아닌 경우에만 신규 ParameterMap생성
				if( !nameSet.contains( names.get(i) ) && !"P_ACTION_FLAG".equals(names.get(i))) { 
					HoQueryParameterMap paramMap = new HoQueryParameterMap();
					paramMap.putAll(map);
					paramMap.put("ITEM_NM", names.get(i));
					
					paramMap.put("SSN_MEMBER_NO", parameter.getHoParameterMap().get("SSN_MEMBER_NO") );
					// 파라미터의 값이 1개 일 경우
					if( parameter.isSingleValue(names.get(i))) {
						paramMap.put("IS_SINGLE_VAL", "Y");
						paramMap.put("ITEM_VAL" , parameter.get(names.get(i)));
					} 
					// 파라미터의 값이 여러개 일 경우.
					else {
						colVals = parameter.getValues(names.get(i));
						colVal = new StringBuilder();
						colVal.append("[");
						for( int j=0; j<colVals.length;j++) {
							if(j >0 ) {
								colVal.append(",");
							}
							colVal.append("#");
							colVal.append(colVals[j]);
							colVal.append("#");
						}
						colVal.append("]");
						
						paramMap.put("IS_SINGLE_VAL", "N");
						paramMap.put("ITEM_VAL" , colVal.toString() );

					}
					list.add(paramMap);
				}
			}
			dao.batch("Develope.insertMenuFormHistDetail", list);

		} catch(Exception e) {
			e.printStackTrace();
		} 
		
		return new HoMessage();
    }
    
    /**
     * Form이력을 삭제 처리
     * @param actionFlag
     * @param model
     * @param parameter
     * @param hoConfig
     */
    public void deleteFormHistory(String actionFlag, HoModel model, HoParameter parameter, HoConfig hoConfig) {
 
		HoDao dao = this.getHoDao();

		HoQueryParameterHandler hqph = new HoQueryParameterHandler(parameter, hoConfig);

		HoQueryParameterMap value = hqph.getForDetail();

		dao.execute("Develope.deleteMenuFormHist", value);
		dao.execute("Develope.deleteMenuFormHistDetail", value);
		
    }
    

}
