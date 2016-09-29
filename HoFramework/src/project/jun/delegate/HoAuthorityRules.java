package project.jun.delegate;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.metadata.result.MetaData;
import org.apache.log4j.Logger;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.access.SecurityConfig;
import org.springframework.security.authentication.encoding.PasswordEncoder;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.web.util.AntPathRequestMatcher;
import org.springframework.security.web.util.RequestMatcher;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import project.jun.user.UserInfo;

import project.jun.config.HoConfig;
import project.jun.config.HoConfigDao;
import project.jun.dao.HoDao;
import project.jun.dao.parameter.HoQueryParameterMap;
import project.jun.dao.result.HoList;
import project.jun.dao.result.HoMap;
import project.jun.was.HoSession;

public class HoAuthorityRules  implements UserDetailsService {
	protected  Logger          logger     = Logger.getLogger(HoAuthorityRules.class);

	private   Map<String, Object>         daoMap        = new HashMap<String, Object>();
	private   HoConfigDao                 hoConfigDao   = null;
	private   HoConfig                    hoConfig      = null;
	private   String queryUserInfo;
	private   String queryDataAuth;
	
	public void setQueryUserInfo(String queryUserInfo) {
		this.queryUserInfo = queryUserInfo;
	}

	public void setQueryDataAuth(String queryDataAuth) {
		this.queryDataAuth = queryDataAuth;
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

	public void setHoConfig(HoConfig hoConfig ) {
		this.hoConfig = hoConfig; 
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
    
	@Override
	public UserDetails loadUserByUsername(String id) throws UsernameNotFoundException {

		HttpServletRequest request =  ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();

		logger.info(request.getParameter("company_cd"));
		logger.info(request.getParameter("j_username"));
		logger.info(request.getParameter("j_password"));

		UserInfo userInfo = null;

		try {
			
			HoDao dao = getHoDao();

			HoQueryParameterMap value = new HoQueryParameterMap();
			value.add("COMPANY_CD", "0001");
			value.add("MEMBER_NO", id);

			HoMap  user = dao.selectOne(this.queryUserInfo , value, true); //"Login.selectUserInfo"
			HoList auth = dao.select(this.queryDataAuth, value); //"Login.selectDataAuth"

			PasswordEncoder encoder = new ShaPasswordEncoder(256);
			String hashed = encoder.encodePassword(user.getString("USER_ID"), null);
			
			userInfo = new UserInfo();
			
			userInfo.setUserId(user.getString("USER_ID"));
			userInfo.setUsername(user.getString("NAME"));
			userInfo.setPassword(encoder.encodePassword(user.getString("USER_ID"), null));
			userInfo.setAccountNonExpired(true);
			userInfo.setAccountNonLocked(true);
			userInfo.setCredentialsNonExpired(true);
			userInfo.setEnabled(true);

			Collection<SimpleGrantedAuthority> authList = new ArrayList<SimpleGrantedAuthority>();
			for( int i=0 ; i<auth.size(); i++ ) {
				authList.add(new SimpleGrantedAuthority(auth.getString(i, "ROLE")));
			}

			userInfo.setAuthorities(authList);

			logger.info("Password : " + user.getString("USER_ID") + " => " + hashed);

			HoSession hoSession = new HoSession( request.getSession(), this.hoConfig );
			
			MetaData metaData = user.getMetaData();
			
			for( int i=0 ; i<metaData.getColumnCount() ; i++ ) {
				hoSession.setObject(metaData.getColumnName(i), user.getString(metaData.getColumnName(i)));
			}
			
		} catch (Exception e) {
			throw new UsernameNotFoundException(id + "Not Founded..");
		}

		return userInfo;
	}

	
	/**
	 * URL기반 권한 조회 
	 * TODO DB연결 필요..
	 * @return
	 */
    public LinkedHashMap<RequestMatcher, Collection<ConfigAttribute>> getRolesAndUrl() {
    	LinkedHashMap<RequestMatcher, Collection<ConfigAttribute>> requestMap = new LinkedHashMap<RequestMatcher, Collection<ConfigAttribute>>();
    	
		Collection<ConfigAttribute> config = new ArrayList<ConfigAttribute>();
		config.add(new SecurityConfig("IS_AUTHENTICATED_ANONYMOUSLY"));
		
		requestMap.put(new AntPathRequestMatcher("/system/login.do"), config);
		requestMap.put(new AntPathRequestMatcher("/example/example.do"), config);
		requestMap.put(new AntPathRequestMatcher("/static/**"), config);

		config = new ArrayList<ConfigAttribute>();
		config.add(new SecurityConfig("ROLE_USER"));
		
		requestMap.put(new AntPathRequestMatcher("/**"), config);
		
		logger.warn("Security?? HoAuthorityRules.getRolesAndUrl");
    	return requestMap;
    }

	/**
	 * Class.method 기반 권한 조회 (미완...)
	 * TODO DB연결 필요..
	 * @return
	 */
    public LinkedHashMap<String, List<ConfigAttribute>> getRolesAndMethod() {
    	LinkedHashMap<String, List<ConfigAttribute>> methodMap = new LinkedHashMap<String, List<ConfigAttribute>>();

    	List<ConfigAttribute> rolesList = new ArrayList<ConfigAttribute>();
    	
    	rolesList.add(new SecurityConfig("ROLE_USER"));
    	rolesList.add(new SecurityConfig("ROLE_ADMIN1"));
    	rolesList.add(new SecurityConfig("ROLE_ADMIN2"));
    	rolesList.add(new SecurityConfig("ROLE_ADMIN3"));
    	    	
    	methodMap.put("com.base.system.delegate.DataBaseDelegate.join", rolesList );
		logger.warn("Security?? HoAuthorityRules.getRolesAndMethod");
    	
    	return methodMap;
    }
   
}
