package project.jun.was.listener;

import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.context.ApplicationEvent;
import org.springframework.context.ApplicationListener;

import project.jun.config.HoConfigDao;
import project.jun.dao.HoDao;
import project.jun.delegate.HoDelegate;

public class StartUpApplicationListener implements ApplicationListener {
	protected  Logger          logger     = Logger.getLogger(HoDelegate.class);

	private   Map<String, Object>         daoMap        = new HashMap<String, Object>();
	private   HoConfigDao                 hoConfigDao   = null;

	@Override
	public void onApplicationEvent(ApplicationEvent applicationevent) {
		logger.info( " DAO : " + this.hoConfigDao.getDefaultDaoName()  + ":" + getHoDao() );
	}
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
}
