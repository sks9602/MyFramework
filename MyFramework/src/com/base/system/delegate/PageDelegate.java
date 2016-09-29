package com.base.system.delegate;

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
import project.jun.was.HoModel;
import project.jun.was.parameter.HoParameter;
import project.jun.was.result.exception.HoException;
import project.jun.was.result.message.HoMessage;

public class PageDelegate extends HoDelegate {



    /**
     * 샘플 - 세부 기능 목록 조회 
     * @param actionFlag
     * @param model
     * @param parameter
     * @param hoConfig
     * @return
     * @throws HoException
     */
    public Object listSample(String actionFlag, HoModel model, HoParameter parameter, HoConfig hoConfig) throws HoException {

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
     * 샘플 - 상세 정보 
     * @param actionFlag
     * @param model
     * @param parameter
     * @param hoConfig
     * @throws HoException
     */
	public void detailSample(String actionFlag, HoModel model, HoParameter parameter, HoConfig hoConfig) throws HoException  {

		HoDao dao = this.getHoDao();
		HoQueryParameterHandler hqph = new HoQueryParameterHandler(parameter, hoConfig);
		HoQueryParameterMap value = hqph.getForDetail();

		HoMap menuInfo = dao.selectOne("Menu.selectMenuInfo", value);
		model.put( KEY_JSON_DATA , menuInfo );
	}

	/**
	 * Grid 또는 TreeGrid의 fields에서 사용 하는 sql-id를 삭제함..(개발모드에서 상단의 grid상단의[x]버튼 클릭시)
	 * @param actionFlag
	 * @param model
	 * @param parameter
	 * @param hoConfig
	 * @return
	 */
    public Object deleteGridSqlId(String actionFlag, HoModel model, HoParameter parameter, HoConfig hoConfig) {

		HoDao dao = this.getHoDao();

		HoQueryParameterHandler hqph = new HoQueryParameterHandler(parameter, hoConfig);

		HoQueryParameterMap value = hqph.getForDetail();

		int result = dao.execute("Page.deleteGridFieldsSql", value);

		logger.debug("result : " + result  );

		return new HoMessage();
    }
}
