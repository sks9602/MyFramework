package com.base.system.delegate;

import project.jun.config.HoConfig;
import project.jun.dao.HoDao;
import project.jun.dao.parameter.HoQueryParameterHandler;
import project.jun.dao.parameter.HoQueryParameterMap;
import project.jun.dao.result.HoList;
import project.jun.dao.result.HoMap;
import project.jun.delegate.HoDelegate;
import project.jun.was.HoModel;
import project.jun.was.parameter.HoParameter;
import project.jun.was.result.exception.HoException;
import project.jun.was.result.message.HoMessage;

public class CodeDelegate extends HoDelegate {

    /**
     * 공통코드 목록 전체 조회.
     * @param actionFlag
     * @param model
     * @param parameter
     * @param hoConfig
     * @return
     * @throws HoException
     */
    public Object list(String actionFlag, HoModel model, HoParameter parameter, HoConfig hoConfig) throws HoException {

		HoDao dao = this.getHoDao();

		HoQueryParameterHandler hqph = new HoQueryParameterHandler(parameter, hoConfig);

		HoQueryParameterMap value = hqph.getForSearch();

		HoMap  map = dao.selectOne("Code.selectCodeListAllCnt", value);
		HoList list = dao.select("Code.selectCodeListAll", value);

		model.put( KEY_JSON_CNT , map.getLong("CNT"));
		model.put( KEY_JSON_DATA , list);


    	return null;
    }

    
    /**
     * 공통코드 목록 그룹코드별 조회.
     * @param actionFlag
     * @param model
     * @param parameter
     * @param hoConfig
     * @return
     * @throws HoException
     */
    public Object listGroup(String actionFlag, HoModel model, HoParameter parameter, HoConfig hoConfig) throws HoException {

		HoDao dao = this.getHoDao();

		HoQueryParameterHandler hqph = new HoQueryParameterHandler(parameter, hoConfig);

		HoQueryParameterMap value = hqph.getForSearch();

		HoMap  map = dao.selectOne("Code.selectCodeListAllGroupCnt", value);
		HoList list = dao.select("Code.selectCodeListAllGroup", value);

		model.put( KEY_JSON_CNT , map.getLong("CNT"));
		model.put( KEY_JSON_DATA , list);


    	return null;
    }

	/**
	 * ??? 를 저장
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

}
