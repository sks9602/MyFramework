package project.jun.delegate.validator;

import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.log4j.Logger;

import project.jun.config.HoConfig;
import project.jun.dao.HoDao;
import project.jun.dao.parameter.HoQueryParameterHandler;
import project.jun.dao.parameter.HoQueryParameterMap;
import project.jun.dao.result.HoMap;
import project.jun.dao.result.transfigure.HoMapHasList;
import project.jun.dao.result.transfigure.HoSetHasMap;
import project.jun.delegate.HoDelegate;
import project.jun.util.HoArrayList;
import project.jun.util.HoHashMap;
import project.jun.util.HoValidator;
import project.jun.was.HoModel;
import project.jun.was.parameter.HoParameter;
import project.jun.was.parameter.HoParameterMap;

public abstract  class HoDelegateValidator {

	private HoDao hoDao = null;
	protected  Logger          logger     = Logger.getLogger(HoDelegateValidator.class);

	public HoDelegateValidator(HoDao hoDao) {
		this.hoDao = hoDao;
	}

	public HoDao getHoDao() {
		return this.hoDao;
	}

	public void setHoDao(HoDao hoDao) {
		this.hoDao = hoDao;
	}

	public HoSetHasMap columnSet(HoQueryParameterMap value) {
		return columnSet(value, "COLUMN_NAME");
	}


	protected HoSetHasMap columnSet(HoQueryParameterMap value, String columnName) {
		return new HoSetHasMap(getHoDao().select("DBTable.selectColumnList", value), columnName);
	}

	/**
	 * validation 확인.
	 * @param actionFlag
	 * @param model
	 * @param parameter
	 * @param hoConfig
	 * @return
	 */
	public abstract HoViolationMap validate(String actionFlag, HoModel model, HoParameter parameter, HoConfig hoConfig) ;
	
	/**
	 * 파라미터정보를 DataBase 정보를 기준으로 validation확인
	 * @param owner
	 * @param tableName
	 * @param actionFlag
	 * @param model
	 * @param parameter
	 * @param hoConfig
	 * @return
	 */
	public HoViolationMap parameterValidate(String owner, String tableName, String actionFlag, HoModel model, HoParameter parameter, HoConfig hoConfig) {

		HoQueryParameterHandler hqph = new HoQueryParameterHandler(parameter, hoConfig);

		HoQueryParameterMap value = hqph.getForSearch();

		HoViolationMap hoViolationMap = new HoViolationMap();

		value.put("OWNER"     , owner);
		value.put("TABLE_NAME", tableName);

		HoSetHasMap columnSet = columnSet(value);

		Set<String>      paramSet  = value.keySet();
		Iterator<String> it        = paramSet.iterator();
		String           paramName = null;
		HoMap            hoMap     = null;
		String           dataType  = null;
		String           dataLength= null;

		while( it.hasNext() ) {
			paramName = it.next();

			paramName = paramName.replaceAll("_ES", "");

			hoMap = columnSet.getHoMap(paramName);
			if( hoMap != null ) {

				dataType = hoMap.getString("DATA_TYPE");
				dataLength = hoMap.getString("DATA_LENGTH");

				if( "NUMBER".equals(dataType) ) {
					hoViolationMap.putAll(number(dataLength, paramName, actionFlag, model, parameter.getHoParameterMap(), hoConfig, value));
				} else if (dataType.indexOf("CHAR") >= 0 ) {
					hoViolationMap.putAll(varchar(dataLength, paramName, actionFlag, model, parameter.getHoParameterMap(), hoConfig, value));
				}

			}
		}

		logger.warn( hoViolationMap.toString() );

		return hoViolationMap;
	}

	protected HoViolationMap varchar(String dataLength, String paramName, String actionFlag, HoModel model, HoParameterMap hoParameterMap, HoConfig hoConfig, HoQueryParameterMap value) {
		HoViolationMap hoViolationMap = new HoViolationMap();
		String           paramValue= null;
		String        [] paramValues= null;

		int dataPartLength = Integer.parseInt(dataLength);

		Object obj = hoParameterMap.get(paramName);


		if( obj instanceof String [] ) {
			paramValues = (String [])obj;
			for( int i=0; i<paramValues.length; i++) {
				if( !HoValidator.isEmpty(paramValues[i]) ) {
					if( !HoValidator.maxDBLength(paramValues[i], dataPartLength)) {
						hoViolationMap.setValue(paramName, i,  "입력값이 너무 큽니다.["+dataLength+"]");
					}
				}
			}
		} else if( obj instanceof String ){
			paramValue = (String)obj;
			if( !HoValidator.isEmpty(paramValue) ) {
				if( !HoValidator.maxDBLength(paramValue, dataPartLength)) {
					hoViolationMap.setValue(paramName,  "입력값이 너무 큽니다.["+dataLength+"]");
				}
			}
		}
		return hoViolationMap;
	}

	protected HoViolationMap number(String dataLength, String paramName, String actionFlag, HoModel model, HoParameterMap hoParameterMap, HoConfig hoConfig, HoQueryParameterMap value) {
		HoViolationMap hoViolationMap = new HoViolationMap();
		String intPartValue = "";
		String           paramValue= null;
		String        [] paramValues= null;

		// 정수부분의 길이..
		int intPartLength = 0;
		String [] dataPartLength = dataLength.split("\\.");

		if( dataPartLength.length > 0 && !"".equals(dataPartLength[0]) ) {
			if(dataPartLength.length > 1 && !"".equals(dataPartLength[1])) {
				intPartLength = Integer.parseInt(dataPartLength[0]) - Integer.parseInt(dataPartLength[1]);
			} else {
				intPartLength = Integer.parseInt(dataPartLength[0]);
			}
		}

		Object obj = hoParameterMap.get(paramName);

		if( obj instanceof String [] ) {
			paramValues = (String [])obj;
			for( int i=0; i<paramValues.length; i++) {
				if( !HoValidator.isEmpty(paramValues[i]) ) {
					if( !HoValidator.isNumber(paramValues[i]) ) {
						hoViolationMap.setValue(paramName, i,  "숫자를 입력하세요.");
					} else {
						intPartValue = paramValues[i].replaceAll(",", "").split("\\.")[0];
						if( intPartValue.length() > intPartLength ) {
							hoViolationMap.setValue(paramName, i,  "입력값이 너무 큽니다.["+intPartLength+"]");
						}
					}
				}
			}
		} else if( obj instanceof String ){
			paramValue = (String)obj;
			if( !HoValidator.isEmpty(paramValue) ) {
				if( !HoValidator.isNumber(paramValue) ) {
					hoViolationMap.setValue(paramName, "숫자를 입력하세요.");
				}else {
					intPartValue = paramValue.replaceAll(",", "").split("\\.")[0];
					if( intPartValue.length() > intPartLength ) {
						hoViolationMap.setValue(paramName, "입력값이 너무 큽니다.["+intPartLength+"]");
					}
				}
			}
		}
		return hoViolationMap;
	}
}
