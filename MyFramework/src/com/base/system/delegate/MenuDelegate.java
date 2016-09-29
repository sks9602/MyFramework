package com.base.system.delegate;

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

public class MenuDelegate extends HoDelegate {

	/**
	 * 메뉴 Tree목록 조회
	 * @param actionFlag
	 * @param model
	 * @param parameter
	 * @param hoConfig
	 * @return
	 * @throws HoException
	 */
    public Object treelist(String actionFlag, HoModel model, HoParameter parameter, HoConfig hoConfig) throws HoException {

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

		HoList list = dao.select("Menu.selectMenuList", value);

		model.put( KEY_JSON_DATA , list);


    	return null;
    }

    /**
     * 세부 기능 목록 조회
     * @param actionFlag
     * @param model
     * @param parameter
     * @param hoConfig
     * @return
     * @throws HoException
     */
    public Object methodList(String actionFlag, HoModel model, HoParameter parameter, HoConfig hoConfig) throws HoException {

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

		HoMap  map = dao.selectOne("Menu.selectMethodListCnt", value);
		HoList list = dao.select("Menu.selectMethodList", value);

		model.put( KEY_JSON_CNT , map.getLong("CNT"));
		model.put( KEY_JSON_DATA , list);


    	return null;
    }

    /**
     * 메뉴 상세 정보
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

		HoMap menuInfo = dao.selectOne("Menu.selectMenuInfo", value);
		model.put( KEY_JSON_DATA , menuInfo );
	}

	/**
	 * 메뉴의 상세 정보를 저장
	 * @param actionFlag
	 * @param model
	 * @param parameter
	 * @param hoConfig
	 * @return
	 */
    public Object mergeInfo(String actionFlag, HoModel model, HoParameter parameter, HoConfig hoConfig) {

		HoDao dao = this.getHoDao();

		HoQueryParameterHandler hqph = new HoQueryParameterHandler(parameter, hoConfig);

		HoQueryParameterMap value = hqph.getForDetail();

		try {
			int result = dao.execute("Menu.mergeHoTSysMenu", value);

			logger.info("result : " + result  );

		} catch(Exception e) {
			return new HoException();
		} 
		
		return new HoMessage();
    }

	/**
	 * 메뉴의 세부기능 목록을 저장
	 * @param actionFlag
	 * @param model
	 * @param parameter
	 * @param hoConfig
	 * @return
	 */
    public Object mergeList(String actionFlag, HoModel model, HoParameter parameter, HoConfig hoConfig) {

		HoDao dao = this.getHoDao();

		HoQueryParameterHandler hqph = new HoQueryParameterHandler(parameter, hoConfig);

		HoQueryParameterMap [] values = hqph.toArrayBaseLength();

		List<HoDaoSqlResult> result = dao.batch("Menu.mergeHoTSysMenuMethod", values);
		
		logger.info("result : " + result  );
		return new HoMessage();
    }
    
    public Object init(String actionFlag, HoModel model, HoParameter parameter, HoConfig hoConfig) {

		HoDao dao = this.getHoDao();

		HoQueryParameterHandler hqph = new HoQueryParameterHandler(parameter, hoConfig);

		HoQueryParameterMap value = hqph.getForSearch();

		HoList list = dao.select("Sample.selectTableList", value);

		model.put("list", list);

    	return null;
    }

    public Object create(String actionFlag, HoModel model, HoParameter parameter, HoConfig hoConfig) {

		HoDao dao = this.getHoDao();

		HoQueryParameterHandler hqph = new HoQueryParameterHandler(parameter, hoConfig);

		HoQueryParameterMap value = hqph.getForSearch();

		HoList list = dao.select("Sample.selectTableList", value);

		model.put("list", list);


    	return null;
    }
    
    public Object download(String actionFlag, HoModel model, HoParameter parameter, HoConfig hoConfig) {

		HoDao dao = this.getHoDao();


    	return null;
    }
    
    
    
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

		HoMap menuInfo = dao.selectOne("Menu.selectMenuDevelopeInfo", value);
		model.put( KEY_JSON_DATA , menuInfo );
	}

	
    /**
     * 버튼 상태 조회
     * @param actionFlag
     * @param model
     * @param parameter
     * @param hoConfig
     * @throws HoException
     */
	public void validateButton(String actionFlag, HoModel model, HoParameter parameter, HoConfig hoConfig) throws HoException  {

		HoDao dao = this.getHoDao();
		HoQueryParameterHandler hqph = new HoQueryParameterHandler(parameter, hoConfig);
		HoQueryParameterMap value = hqph.getForDetail();

		HoMap menuInfo = dao.selectOne("Menu.selectButtonInfo", value);
		model.put( KEY_JSON_DATA , menuInfo );
	}
}
