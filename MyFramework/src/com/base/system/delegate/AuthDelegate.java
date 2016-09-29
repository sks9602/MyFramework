package com.base.system.delegate;

import java.util.ArrayList;
import java.util.List;

import com.base.system.delegate.validator.SampleValidator;

import project.jun.config.HoConfig;
import project.jun.dao.HoDao;
import project.jun.dao.HoDaoSqlResult;
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

public class AuthDelegate extends HoDelegate {

	/**
	 * 권한별 메뉴 정보를 Tree로 조회
	 * @param actionFlag
	 * @param model
	 * @param parameter
	 * @param hoConfig
	 * @return
	 * @throws HoException
	 */
    public Object authMenuTreeList(String actionFlag, HoModel model, HoParameter parameter, HoConfig hoConfig) throws HoException {

		HoDao dao = this.getHoDao();

		HoQueryParameterHandler hqph = new HoQueryParameterHandler(parameter, hoConfig);

		HoQueryParameterMap value = hqph.getForSearch();

		// 파라미터 유효성 검사 - 시작..
		SampleValidator sv = new SampleValidator(dao);
		parameter.infoParameter(true);
		parameter.infoParameterValue(true);

		HoViolationMap hoViolationMap = sv.validate(actionFlag, model, parameter, hoConfig);

		logger.warn( HoLogging.toString(hoViolationMap.getViolationParameterNames()) );
		// 파라미터 유효성 검사 - 끝..

		HoList list = dao.select("Auth.selectMenuList", value);

		model.put( KEY_JSON_DATA , list);


    	return null;
    }

    /**
     * 권한 목록 조회
     * @param actionFlag
     * @param model
     * @param parameter
     * @param hoConfig
     * @return
     * @throws HoException
     */
    public Object authList(String actionFlag, HoModel model, HoParameter parameter, HoConfig hoConfig) throws HoException {

		HoDao dao = this.getHoDao();

		HoQueryParameterHandler hqph = new HoQueryParameterHandler(parameter, hoConfig);

		HoQueryParameterMap value = hqph.getForSearch();

		HoMap  map = dao.selectOne("Auth.selectAuthListCnt", value);
		HoList list = dao.select("Auth.selectAuthList", value);

		model.put( KEY_JSON_CNT , map.getLong("CNT"));
		model.put( KEY_JSON_DATA , list);


    	return null;
    }

    
    /**
     * 권한별 권한부여자를  조회
     * @param actionFlag
     * @param model
     * @param parameter
     * @param hoConfig
     * @return
     * @throws HoException
     */
    public Object authMemberList(String actionFlag, HoModel model, HoParameter parameter, HoConfig hoConfig) throws HoException {

		HoDao dao = this.getHoDao();

		HoQueryParameterHandler hqph = new HoQueryParameterHandler(parameter, hoConfig);

		HoQueryParameterMap value = hqph.getForSearch();

		HoMap  map = dao.selectOne("Auth.selectAuthMemberListCnt", value);
		HoList list = dao.select("Auth.selectAuthMemberList", value);

		model.put( KEY_JSON_CNT , map.getLong("CNT"));
		model.put( KEY_JSON_DATA , list);


    	return null;
    }
    
    /**
     * 권한 정보를  조회
     * @param actionFlag
     * @param model
     * @param parameter
     * @param hoConfig
     * @throws HoException
     */
	public void detail(String actionFlag, HoModel model, HoParameter parameter, HoConfig hoConfig) throws HoException  {

		HoDao dao = this.getHoDao();
		HoQueryParameterHandler hqph = new HoQueryParameterHandler(parameter, hoConfig);
		HoQueryParameterMap value = hqph.getForDetail();

		HoMap menuInfo = dao.selectOne("Auth.selectAuthInfo", value);
		model.put( KEY_JSON_DATA , menuInfo );
	}

	/**
	 * 권한 정보를 저장
	 * @param actionFlag
	 * @param model
	 * @param parameter
	 * @param hoConfig
	 * @return
	 */
    public Object mergeAuthInfo(String actionFlag, HoModel model, HoParameter parameter, HoConfig hoConfig) {

		HoDao dao = this.getHoDao();

		HoQueryParameterHandler hqph = new HoQueryParameterHandler(parameter, hoConfig);

		HoQueryParameterMap value = hqph.getForDetail();

		int result = dao.execute("Auth.mergeHoTSysAuth", value);

		logger.info("result : " + result  );

		if( result > 0 ) {
			return new HoMessage();
		} else {
			return new HoException();
		}
    }

    /**
     * 권한 정보를 삭제
     * @param actionFlag
     * @param model
     * @param parameter
     * @param hoConfig
     * @return
     */
    public Object deleteAuthInfo(String actionFlag, HoModel model, HoParameter parameter, HoConfig hoConfig) {

		HoDao dao = this.getHoDao();

		HoQueryParameterHandler hqph = new HoQueryParameterHandler(parameter, hoConfig);

		HoQueryParameterMap value = hqph.getForDetail();

		int result = dao.execute("Auth.deleteHoTSysAuth", value);
		dao.execute("Auth.deleteHoTSysAuthMenuByAuth", value);
		dao.execute("Auth.deleteHoTSysAuthMenuLevelByAuth", value);
		dao.execute("Auth.deleteHoTSysAuthMenuMethodByAuth", value);
		dao.execute("Auth.deleteHoTSysAuthMemberByAuth", value);

		logger.info("result : " + result  );

		if( result > 0 ) {
			return new HoMessage();
		} else {
			return new HoException();
		}
    }    
    
    
	/**
	 * 권한별 메뉴 권한을 저장
	 * @param actionFlag
	 * @param model
	 * @param parameter
	 * @param hoConfig
	 * @return
	 */
    public Object mergeAuthMenu(String actionFlag, HoModel model, HoParameter parameter, HoConfig hoConfig) {

		HoDao dao = this.getHoDao();

		HoQueryParameterHandler hqph = new HoQueryParameterHandler(parameter, hoConfig);

		HoQueryParameterMap [] values = hqph.toArrayBaseLength();

		
		ArrayList<HoQueryParameterMap> valuesDelAuthMenu = new ArrayList<HoQueryParameterMap>();
		ArrayList<HoQueryParameterMap> valuesInsAuthMenu = new ArrayList<HoQueryParameterMap>();
		ArrayList<HoQueryParameterMap> valuesDelAuthLevel = new ArrayList<HoQueryParameterMap>();
		ArrayList<HoQueryParameterMap> valuesInsAuthLevel = new ArrayList<HoQueryParameterMap>();
		ArrayList<HoQueryParameterMap> valuesDelAuthMethod = new ArrayList<HoQueryParameterMap>();
		ArrayList<HoQueryParameterMap> valuesInsAuthMethod = new ArrayList<HoQueryParameterMap>();
		
		for( int i=0; i< values.length ; i++ ) {
			
			// 메뉴 관련 기능일경우
			if( "MENU".equals(values[i].getString("TYPE"))) {
				
				// 메뉴 권한
				if( "Y".equals(values[i].getString("AUTH_YN"))) {
					valuesInsAuthMenu.add(values[i]);
				} else if( "N".equals(values[i].getString("AUTH_YN"))) {
					valuesDelAuthMenu.add(values[i]);
				} 
				
				// [조회] 버튼 권한 수정된 경우만..
				if( !values[i].getString("O_R_LEVEL").equals(values[i].getString("R_LEVEL"))) {
					// [조회] 버튼 권한
					if( "Y".equals(values[i].getString("R_LEVEL"))) {
						HoQueryParameterMap value1 = (HoQueryParameterMap) values[i].clone();
						value1.put("AUTH_LEVEL_CD", "SYS003001");
						valuesInsAuthLevel.add(value1);
						
					} else if( "N".equals(values[i].getString("R_LEVEL"))) {
						HoQueryParameterMap value1 = (HoQueryParameterMap) values[i].clone();
						value1.put("AUTH_LEVEL_CD", "SYS003001");
						valuesDelAuthLevel.add(value1);
					}
				}
				
				// [출력] 버튼 권한 수정된 경우만..
				if( !values[i].getString("O_P_LEVEL").equals(values[i].getString("P_LEVEL"))) {
					// [출력] 버튼 권한
					if( "Y".equals(values[i].getString("P_LEVEL"))) {
						HoQueryParameterMap value2 = (HoQueryParameterMap) values[i].clone();
						value2.put("AUTH_LEVEL_CD", "SYS003002");
						valuesInsAuthLevel.add(value2);
					} else if( "N".equals(values[i].getString("P_LEVEL"))) {
						HoQueryParameterMap value2 = (HoQueryParameterMap) values[i].clone();
						value2.put("AUTH_LEVEL_CD", "SYS003002");
						valuesDelAuthLevel.add(value2);
					}	
				}
				
				// [등록/수정] 버튼 권한 수정된 경우만..
				if( !values[i].getString("O_I_LEVEL").equals(values[i].getString("I_LEVEL"))) {
					// [등록/수정] 버튼 권한
					if( "Y".equals(values[i].getString("I_LEVEL"))) {
						HoQueryParameterMap value3 = (HoQueryParameterMap) values[i].clone();
						value3.put("AUTH_LEVEL_CD", "SYS003003");
						valuesInsAuthLevel.add(value3);
					} else if( "N".equals(values[i].getString("I_LEVEL"))) {
						HoQueryParameterMap value3 = (HoQueryParameterMap) values[i].clone();
						value3.put("AUTH_LEVEL_CD", "SYS003003");
						valuesDelAuthLevel.add(value3);
					}
				}
				
				// [삭제] 버튼 권한 수정된 경우만..
				if( !values[i].getString("O_D_LEVEL").equals(values[i].getString("D_LEVEL"))) {
					// [삭제] 버튼 권한
					if( "Y".equals(values[i].getString("D_LEVEL"))) {
						HoQueryParameterMap value4 = (HoQueryParameterMap) values[i].clone();
						value4.put("AUTH_LEVEL_CD", "SYS003004");
						valuesInsAuthLevel.add(value4);
					} else if( "N".equals(values[i].getString("D_LEVEL"))) {
						HoQueryParameterMap value4 = (HoQueryParameterMap) values[i].clone();
						value4.put("AUTH_LEVEL_CD", "SYS003004");
						valuesDelAuthLevel.add(value4);
					}
				}
			} 
			// METHOD관련 기능일 경우
			else if( "METHOD".equals(values[i].getString("TYPE"))) {
				
				// 메소드 권한
				if( "Y".equals(values[i].getString("M_LEVEL"))) {
					valuesInsAuthMethod.add(values[i]);
				} else if( "N".equals(values[i].getString("M_LEVEL"))) {
					valuesDelAuthMethod.add(values[i]);
				}
				
			}
		}		
		
		// 권한별 사용 불가능 메뉴 삭제
		List<HoDaoSqlResult> result = dao.batch("Auth.deleteHoTSysAuthMenu", valuesDelAuthMenu);
		
		// 권한별 사용 가능 메뉴 등록
		result = dao.batch("Auth.insertHoTSysAuthMenu", valuesInsAuthMenu);
		
		// 권한별 메뉴의 사용 가능 버튼 등급 삭제
		result = dao.batch("Auth.deleteHoTSysAuthMenuLevel", valuesDelAuthLevel);
		
		// 권한별 메뉴의 사용 가능 버튼 등급 등록
		result = dao.batch("Auth.insertHoTSysAuthMenuLevel", valuesInsAuthLevel);

		// 권한별 메뉴의 사용 불 가능 기능 삭제
		result = dao.batch("Auth.deleteHoTSysAuthMenuMethod", valuesDelAuthMethod);
		
		// 권한별 메뉴의 사용 가능 기능 등록 
		result = dao.batch("Auth.insertHoTSysAuthMenuMethod", valuesInsAuthMethod);

		logger.info("result : " + result  );
		return new HoMessage();
    }
    

}
