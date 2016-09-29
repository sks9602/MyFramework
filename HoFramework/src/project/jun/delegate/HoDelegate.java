package project.jun.delegate;

import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;

import project.jun.config.HoConfig;
import project.jun.config.HoConfigDao;
import project.jun.dao.HoDao;
import project.jun.was.HoModel;
import project.jun.was.parameter.HoParameterMap;
import project.jun.was.result.message.HoMessage;
import project.jun.was.servlet.HoServlet;

public class HoDelegate {
	protected  Logger          logger     = Logger.getLogger(HoDelegate.class);

	private   Map<String, Object>         daoMap        = new HashMap<String, Object>();
	private   HoConfigDao                 hoConfigDao   = null;
	private   HoServlet                   hoServlet  = null;
	
	final public static String KEY_JSON_CNT = "HoDelegate.KEY_JSON_DATA_CNT";
	final public static String KEY_JSON_DATA = "HoDelegate.KEY_JSON_DATA";

	/**
	 * 프로젝트에 기본으로 사용되는 db정보를 조회한다.
	 * @return
	 */
	public HoDao getHoDao() {
		return this.getHoDao(this.hoConfigDao.getDefaultDaoName());
	}

	/**
	 * daoName에 해당하는 db정보를 조회한다.
	 * @param daoName
	 * @return
	 */
	public HoDao getHoDao(String daoName) {
		HoDao dao = (HoDao)  this.daoMap.get(daoName);

		return dao;
	}

	/**
	 * 모든 dao정보를 조회한다.
	 * @return
	 */
	public Map<String, Object> getHoDaoMap() {
		return this.daoMap;
	}

	/**
	 * dao정보를 입력한다.
	 * @param daoMap
	 */
	public void setHoDaoMap(Map<String, Object> daoMap) {
		if( this.daoMap == null ) {
			this.daoMap = new HashMap<String, Object>();
		}

		this.daoMap.putAll(daoMap);
	}

	public HoConfigDao getHoConfigDao() {
		return hoConfigDao;
	}

	public void setHoConfigDao(HoConfigDao hoConfigDao) {
		this.hoConfigDao = hoConfigDao;
	}

	protected void setLogger(Class<?> className) {
		this.logger = Logger.getLogger(className);
	}

    protected Logger getLogger() {
		return this.logger == null ? Logger.getLogger(this.getClass()) : this.logger;
	}

    
    public void setHoServlet(HoServlet hoServlet) {
    	this.hoServlet = hoServlet;
    }

    protected HoServlet getHoServlet() {
    	return this.hoServlet;
    }
    public Object execute(HoModel model, HoParameterMap hoParameterMap, HoConfig hoConfig) {
		return new HoMessage();
    	//return new String();
    	//return new String[2];
    }

    public Object select(HoModel model, HoParameterMap hoParameterMap, HoConfig hoConfig) {
    	return null;
    }
       
}
