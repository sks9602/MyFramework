package com.base.system.delegate.validator;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import project.jun.config.HoConfig;
import project.jun.dao.HoDao;
import project.jun.dao.parameter.HoQueryParameterMap;
import project.jun.dao.result.HoList;
import project.jun.dao.result.HoMap;
import project.jun.dao.result.transfigure.HoMapHasList;
import project.jun.dao.result.transfigure.HoSetHasMap;
import project.jun.delegate.validator.HoDelegateValidator;
import project.jun.delegate.validator.HoViolationMap;
import project.jun.util.HoArrayList;
import project.jun.util.HoHashMap;
import project.jun.util.HoValidator;
import project.jun.was.HoModel;
import project.jun.was.parameter.HoParameter;
import project.jun.was.parameter.HoParameterMap;

public class SampleValidator extends HoDelegateValidator {


	public SampleValidator(HoDao hoDao) {
		super(hoDao);
	}


	public HoViolationMap validate(String actionFlag, HoModel model, HoParameter parameter, HoConfig hoConfig) {

		HoViolationMap hoViolationMap = super.parameterValidate( "KSARACE", "COMPET_DIA_SQ", actionFlag,model, parameter, hoConfig);

		return hoViolationMap;
	}


}
