package com.base.system.delegate.validator;


import project.jun.config.HoConfig;
import project.jun.dao.HoDao;
import project.jun.dao.parameter.HoQueryParameterMap;
import project.jun.delegate.validator.HoDelegateValidator;
import project.jun.delegate.validator.HoViolationMap;
import project.jun.util.HoHashMap;
import project.jun.was.HoModel;
import project.jun.was.parameter.HoParameter;

public class SampleInsertValidator extends SampleValidator {

	public SampleInsertValidator(HoDao hoDao) {
		super(hoDao);
	}

	public HoViolationMap validate(String actionFlag, HoModel model, HoParameter hoParameter, HoConfig hoConfig, HoQueryParameterMap value) {

		HoViolationMap hoViolationMap = super.validate(actionFlag, model, hoParameter, hoConfig);


		return hoViolationMap;
	}
}
