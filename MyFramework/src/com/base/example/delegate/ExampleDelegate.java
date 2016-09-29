package com.base.example.delegate;

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

public class ExampleDelegate extends HoDelegate {

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

		logger.info(value);
		
		HoMap  map = dao.selectOne("Sample.selectTableListCnt", value);
		HoList list = dao.select("Sample.selectTableList", value);

		model.put( KEY_JSON_CNT , map.getLong("CNT"));
		model.put( KEY_JSON_DATA , list);


    	return null;
    }

	public void detail(String actionFlag, HoModel model, HoParameter parameter, HoConfig hoConfig) throws HoException  {

		HoDao dao = this.getHoDao();
		HoQueryParameterHandler hqph = new HoQueryParameterHandler(parameter, hoConfig);
		HoQueryParameterMap value = hqph.getForDetail();

		HoMap ColumnList = dao.selectOne("Sample.selectTableInfo", value);
		//HoList ConstraintsList = dao.select("DataBase.selectConstraintsList", value);
		model.put( KEY_JSON_CNT , 1);
		model.put( KEY_JSON_DATA , ColumnList );
		HoList AnimalList = dao.select("Sample.selectAnimalList", value);

		model.put( KEY_JSON_DATA+"ANIMAL" , AnimalList );

		//model.put("ds_ConstraintsList", ConstraintsList );
	}

    public Object insert(String actionFlag, HoModel model, HoParameter parameter, HoConfig hoConfig) {

		HoDao dao = this.getHoDao();

		HoQueryParameterHandler hqph = new HoQueryParameterHandler(parameter, hoConfig);

		HoQueryParameterMap value = hqph.getForSearch();

		HoList list = dao.select("Sample.selectTableList", value);

		model.put("list", list);


    	return null;
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

}
