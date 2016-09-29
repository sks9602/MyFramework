package com.base.system.delegate;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.base.system.delegate.validator.SampleValidator;

import project.jun.config.HoConfig;
import project.jun.dao.HoDao;
import project.jun.dao.HoDaoSqlResult;
import project.jun.dao.parameter.HoQueryParameterHandler;
import project.jun.dao.parameter.HoQueryParameterMap;
import project.jun.dao.result.HoList;
import project.jun.delegate.HoDelegate;
import project.jun.delegate.validator.HoViolationMap;
import project.jun.util.HoLogging;
import project.jun.util.HoValidator;
import project.jun.was.HoModel;
import project.jun.doc.excel.HoExcelReader;
import project.jun.doc.excel.impl.HoExcelHSSFReader;
import project.jun.doc.excel.impl.HoExcelXSSFReader;
import project.jun.was.parameter.HoParameter;

public class SampleDelegate extends HoDelegate {

    public Object list(String actionFlag, HoModel model, HoParameter parameter, HoConfig hoConfig) {

		HoDao dao = this.getHoDao();

		HoQueryParameterHandler hqph = new HoQueryParameterHandler(parameter, hoConfig);

		HoQueryParameterMap value = hqph.getForSearch();

		// 파라미터 유효성 검사 - 시작..
		SampleValidator sv = new SampleValidator(dao);

		HoViolationMap hoViolationMap = sv.validate(actionFlag, model, parameter, hoConfig);

		logger.warn( HoLogging.toString(hoViolationMap.getViolationParameterNames()) );
		// 파라미터 유효성 검사 - 끝..

		HoList list = dao.select("Sample.selectTableList", value);

		model.put("list", list);


    	return null;
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


    public Object excel(String actionFlag, HoModel model, HoParameter parameter, HoConfig hoConfig) {

 		HoDao dao = this.getHoDao("ProjectDaoBatch");

 		HoExcelReader reader = new HoExcelXSSFReader();


 		HoQueryParameterMap  value = null;
 		ArrayList<HoQueryParameterMap> list = new ArrayList<HoQueryParameterMap>();

 		try {
 			reader.setExelFile("s:/1.PROJECT/2013_다인/2013_08_베이비부머_진단/25.고객자료/베이비부머_기초자료/표준협회_베이비부머생애진단 결과(72개문항)_V4(0909).xlsx");
 			reader.setSheet(1);

 			logger.info( ">>>  " + reader.getLastRowNum() );

 			for( int i=1; i<reader.getLastRowNum() ; i++) {
 				for( int j=4; j<=75; j++ ) {
 					value = new HoQueryParameterMap();

 					if( "".equals(reader.getStringValue(i, 3))) {
 						break;
 					}

					value.put("COMPANY_CD", "0001");
					value.put("MEMBER_NO", reader.getStringValue(i, 3).replaceAll("\\-", ""));
					value.put("IND_SEQ", reader.getValue(0, j));
					value.put("ANS", reader.getValue(i, j));
					// logger.info( "INSERT INTO HR_ABL_ACTIND_MAP( COMPANY_CD, IND_SEQ, CAP_CD ) VALUES ( '0001', '"+reader.getValue(i, 1)+"', '"+capaMap.get(String.valueOf(j))+"');");

					logger.info( value );
					list.add(value);


 				}
 			}



 		} catch (FileNotFoundException e) {
 			e.printStackTrace();
 		} catch (IOException e) {
 			e.printStackTrace();
 		}


 		HoQueryParameterHandler hqph = new HoQueryParameterHandler(parameter, hoConfig);

 		// int [] result = dao.batch("Sample.insertHrAblActindMap", list);

 		List<HoDaoSqlResult> result = dao.batch("Sample.insertHrActindResult", list);

 		// HoList list = dao.select("Sample.selectTableList", value);

 		// model.put("list", list);


     	return null;
     }

    public Object excel2(String actionFlag, HoModel model, HoParameter parameter, HoConfig hoConfig) {

		HoDao dao = this.getHoDao("ProjectDaoBatch");

		HoExcelReader reader = new HoExcelXSSFReader();

		HashMap capaMap   = new HashMap();

		capaMap.put("4","RACE010101");
		capaMap.put("5","RACE010201");
		capaMap.put("6","RACE010202");
		capaMap.put("7","RACE010301");
		capaMap.put("8","RACE010401");
		capaMap.put("9","RACE010402");
		capaMap.put("10","RACE020101");
		capaMap.put("11","RACE020201");
		capaMap.put("12","RACE020301");
		capaMap.put("13","RACE020401");

		// HoQueryParameterMap [] values = new

		HoQueryParameterMap  value = null;
		ArrayList<HoQueryParameterMap> list = new ArrayList<HoQueryParameterMap>();

		try {
			reader.setExelFile("s:/1.PROJECT/2013_다인/2013_08_베이비부머_진단/25.고객자료/표준협회_베이비부머생애진단_평가지표.xlsx");

			for( int i=3; i<reader.getLastRowNum() ; i++) {
				for( int j=4; j<=13; j++ ) {
					if( HoValidator.isNotEmpty(reader.getStringValue(i, j))) {
						value = new HoQueryParameterMap();

						value.put("COMPANY_CD", "0001");
						value.put("IND_SEQ", reader.getValue(i, 1));
						value.put("CAP_CD", capaMap.get(String.valueOf(j)));
						// logger.info( "INSERT INTO HR_ABL_ACTIND_MAP( COMPANY_CD, IND_SEQ, CAP_CD ) VALUES ( '0001', '"+reader.getValue(i, 1)+"', '"+capaMap.get(String.valueOf(j))+"');");
						list.add(value);
					}

				}
			}


/*			for( int j=1; j<=100000; j++ ) {
				value = new HoQueryParameterMap();

				value.put("COMPANY_CD", "0001");
				value.put("IND_SEQ", j+"");
				value.put("CAP_CD", j+"");
				// logger.info( "INSERT INTO HR_ABL_ACTIND_MAP( COMPANY_CD, IND_SEQ, CAP_CD ) VALUES ( '0001', '"+reader.getValue(i, 1)+"', '"+capaMap.get(String.valueOf(j))+"');");
				list.add(value);
			}
*/

		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}


		HoQueryParameterHandler hqph = new HoQueryParameterHandler(parameter, hoConfig);

		List<HoDaoSqlResult> result = dao.batch("Sample.insertHrAblActindMap", list);

		// HoList list = dao.select("Sample.selectTableList", value);

		// model.put("list", list);


    	return null;
    }
}
