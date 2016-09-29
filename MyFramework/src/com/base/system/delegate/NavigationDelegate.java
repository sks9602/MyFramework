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
import project.jun.util.HoSpringUtil;
import project.jun.was.HoModel;
import project.jun.was.parameter.HoParameter;
import project.jun.was.result.exception.HoException;
import project.jun.was.result.message.HoMessage;
import project.jun.was.spring.HoController;

public class NavigationDelegate extends HoDelegate {

	/**
	 * 기능 목록 조회
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


}
