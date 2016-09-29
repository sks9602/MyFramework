package com.base.system.delegate;

import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.naming.NamingException;

import project.jun.config.HoConfig;
import project.jun.dao.HoDao;
import project.jun.dao.parameter.HoQueryParameterHandler;
import project.jun.dao.parameter.HoQueryParameterMap;
import project.jun.dao.result.HoList;
import project.jun.dao.result.HoMap;
import project.jun.dao.result.HoPageNavigator;
import project.jun.util.cache.HoCache;
import project.jun.util.cache.HoEhCache;
import project.jun.was.HoModel;
import project.jun.was.parameter.HoParameter;
import project.jun.was.parameter.HoParameterMap;
import project.jun.was.result.exception.HoException;
import project.jun.was.spring.HoController;

import org.springframework.security.access.annotation.Secured;

public class DataBaseDelegate extends ProjectDelegate {

	private HoDao getDaoImpl() {
		return super.getHoDao("DbDao");
	}

	public void init(String actionFlag, HoModel model, HoParameter parameter, HoConfig hoConfig) throws NamingException, SQLException, HoException {

		HoDao dao = this.getDaoImpl();

		HoQueryParameterHandler hqph = new HoQueryParameterHandler(parameter, hoConfig);

		HoQueryParameterMap value = hqph.getForSearch();

		HoList list = dao.select("DataBase.selectTableList", value);

		// parameter.getHoRequest().getHoSession().setObject("PAGE_ROW_CNT", "50");

		model.put("list", list);
	}

	public void list(String actionFlag, HoModel model, HoParameter parameter, HoConfig hoConfig) throws NamingException, SQLException, HoException  {

		HoDao dao = super.getHoDao("DbDao"); //"DbDao");
		HoQueryParameterHandler hqph = new HoQueryParameterHandler(parameter, hoConfig);

		HoQueryParameterMap value = hqph.getForSearch();

		HoMap listCnt = dao.selectOne("DataBase.selectTableListCnt", value);

		long pageNo     = hqph.getPageNo();
		long pageRowCnt = hqph.getPageRowCnt();


        long totCnt = listCnt.getLong("CNT");


        // 페이지 네비게이션
        HoPageNavigator nav = new HoPageNavigator(totCnt, pageRowCnt, pageNo, parameter, model.getString(HoController.HO_URI));

        // 페이지범위 설정!!
        long beginRowNum = nav.getBeginRowNum();
        long endRowNum   = nav.getEndRowNum();

        value.put("S_ROWNUM", beginRowNum);
        value.put("E_ROWNUM", endRowNum);


        HoList list = dao.select("DataBase.selectTableList", value);

		model.put("TOTAL_CNT", totCnt);
		model.put("JSON_DATAS", list);
	}

	public void makeTableInfo(String actionFlag, HoModel model, HoParameter parameter, HoConfig hoConfig) throws NamingException, SQLException, HoException, UnsupportedEncodingException {
		HoDao dao = super.getHoDao("DbDao"); //"DbDao");
		HoQueryParameterHandler hqph = new HoQueryParameterHandler(parameter, hoConfig);

		HoQueryParameterMap value = hqph.getForDetail();

		logger.info(parameter.getValues("table_name_es").length);
		if( parameter.getValues("table_name_es").length > 0 ) {
			int result = dao.execute("DataBase.deleteTableInfo", value);
			result = dao.execute("DataBase.insertTableInfo", value);
			result = dao.execute("DataBase.deleteColumnInfo", value);
			result = dao.execute("DataBase.insertColumnInfo", value);

	        HoCache cache = new HoEhCache(dao.getCache());
	        boolean [] c_result = cache.removeAll();
	        StringBuffer sb = new StringBuffer();
	        for( int i=0; c_result!=null && i<c_result.length ; i++) {
	        	sb.append(c_result[i] ? "O" : "X");
	        }
	        if( c_result != null ) {
	        	logger.info(" Cache Remove Result ["+c_result.length+"] : ["+ sb +"]");
	        }
		}
	}


	public void detail(String actionFlag, HoModel model, HoParameter parameter, HoConfig hoConfig) throws NamingException, SQLException, HoException  {

		HoDao dao = this.getDaoImpl();
		HoQueryParameterHandler hqph = new HoQueryParameterHandler(parameter, hoConfig);
		HoQueryParameterMap value = hqph.getForDetail();

		parameter.infoParameter(true);
		parameter.infoParameterValue(true);

		HoList ColumnList = dao.select("DataBase.selectColumnList", value);
		//HoList ConstraintsList = dao.select("DataBase.selectConstraintsList", value);
		model.put("ds_ColumnList", ColumnList );
		//model.put("ds_ConstraintsList", ConstraintsList );
	}

	public void joinTable(String actionFlag, HoModel model, HoParameter parameter, HoConfig hoConfig) throws NamingException, SQLException, HoException  {

		HoDao dao = this.getDaoImpl();
		HoQueryParameterHandler hqph = new HoQueryParameterHandler(parameter, hoConfig);

		HoQueryParameterMap value = hqph.getForDetail();

        HoList ColumnList = dao.select("DataBase.selectColumnList", value);
        HoList ConstraintsList = dao.select("DataBase.selectConstraintsList", value);
        HoList TableAsList = dao.select("DataBase.selectJoinTableAlias", value);

        model.put("ds_ColumnList", ColumnList );
        model.put("ds_ConstraintsList", ConstraintsList );
        model.put("ds_TableAsList", TableAsList );

	}

	public void join(String actionFlag, HoModel model, HoParameter parameter, HoConfig hoConfig) throws NamingException, SQLException, HoException, UnsupportedEncodingException  {

		HoDao dao = this.getDaoImpl();

		HoQueryParameterHandler hqph = new HoQueryParameterHandler(parameter, hoConfig);

		HoQueryParameterMap value = hqph.getForDetail();

		// value.copy(hoParameterMap, hoConfig);

		String [] table_es = null;

		table_es = new String [parameter.getValues("LEFT_TABLE").length + parameter.getValues("RIGHT_TABLE").length];
		int j=0;
		for( int i=0 ; i< parameter.getValues("LEFT_TABLE").length ; i++ ) {
			table_es[j++] = parameter.getValues("LEFT_TABLE")[i];
		}
		for( int i=0 ; i< parameter.getValues("RIGHT_TABLE").length ; i++ ) {
			table_es[j++] = parameter.getValues("RIGHT_TABLE")[i];
		}

		value.put("SELECT_TABLE", table_es);

		ArrayList list = new ArrayList();
		HashMap   map = null;

		// value.put("JOIN_TABLE", list);


		for( int i=0 ; i< parameter.getValues("LEFT_TABLE").length ; i++ ) {
			map = new HashMap();
			map.put("TABLE_IDX", i);
			map.put("JOIN_LEFT_TABLE", parameter.getValues("LEFT_TABLE")[i]);
			map.put("JOIN_LEFT_TABLE_OUTER", parameter.getValues("LEFT_TABLE_OUTER")[i]);
			map.put("JOIN_OWNER", parameter.getValues("OWNER")[0]);
			map.put("JOIN_RIGHT_TABLE", parameter.getValues("RIGHT_TABLE")[i]);
			map.put("JOIN_RIGHT_TABLE_OUTER", parameter.getValues("RIGHT_TABLE_OUTER")[i]);

			list.add(map);
		}

		value.put("JOIN_TABLE", list);

		list = new ArrayList();

		for( int i=0 ; i< parameter.getValues("inline").length ; i++ ) {
			map = new HashMap();
			map.put("TABLE_IDX", i);
			map.put("INLINE_FROM", parameter.getValues("inline")[i]);
			map.put("INLINE_OWNER", parameter.getValues("OWNER")[0]);
			map.put("INLINE_SUB", parameter.getValues("inline_src")[i]);

			list.add(map);
		}
		value.put("INLINE_TABLE", list);

        HoList ColumnList = dao.select("DataBase.selectSelectClauseColumnList", value);
		logger.info( parameter.get("OWNER") );
		logger.info( parameter.get("INLINE_OWNER") );
		logger.info( value.get("JOIN_TABLE") );
        HoList JoinColumnList = dao.select("DataBase.selectJoinColumnList", value);
        HoList SubQueryColumnList = dao.select("DataBase.selectSubQueryColumnList", value);
        HoList JoinTable = dao.select("DataBase.selectJoinTable", value);



        model.put("ds_ColumnList", ColumnList );
        model.put("ds_JoinTable", JoinTable );
        model.put("ds_JoinColumnList", JoinColumnList );
        model.put("ds_SubQueryColumnList", SubQueryColumnList );
	}


}
