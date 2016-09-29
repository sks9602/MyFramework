package project.jun.was.security;

import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.Map;

import org.springframework.beans.factory.FactoryBean;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.web.util.RequestMatcher;

import project.jun.delegate.HoAuthorityRules;

public class HoReloadableRolesUrlFactoryBean implements FactoryBean<LinkedHashMap<RequestMatcher, Collection<ConfigAttribute>>>  {
	private LinkedHashMap<RequestMatcher, Collection<ConfigAttribute>> requestMap;

	protected HoAuthorityRules hoAuthorityRules = null;

	public HoReloadableRolesUrlFactoryBean() {
		requestMap = new LinkedHashMap<RequestMatcher, Collection<ConfigAttribute>>();
	}

	public void setHoAuthorityRules(HoAuthorityRules hoAuthorityRules) {
		this.hoAuthorityRules = hoAuthorityRules;
	}
	
    public void init() throws Exception {
    	requestMap = getRolesAndUrl(); 
    }
    
    public LinkedHashMap<RequestMatcher, Collection<ConfigAttribute>> getRolesAndUrl() {
    	/*
    	requestMap.clear();
		Collection<ConfigAttribute> config = new ArrayList<ConfigAttribute>();
		
		config.add(new SecurityConfig("IS_AUTHENTICATED_ANONYMOUSLY"));
		requestMap.put(new AntPathRequestMatcher("/system/login.do"), config);

		config.add(new SecurityConfig("IS_AUTHENTICATED_ANONYMOUSLY"));
		requestMap.put(new AntPathRequestMatcher("/example/example.do"), config);

		config.add(new SecurityConfig("IS_AUTHENTICATED_ANONYMOUSLY"));
		requestMap.put(new AntPathRequestMatcher("/static/**"), config);

		config = new ArrayList<ConfigAttribute>();
		config.add(new SecurityConfig("ROLE_USER"));
		requestMap.put(new AntPathRequestMatcher("/**"), config);

    	return requestMap;
		*/
    	
    	return this.hoAuthorityRules.getRolesAndUrl();
    }

	@Override
	public LinkedHashMap<RequestMatcher, Collection<ConfigAttribute>> getObject() throws Exception {
		if( this.requestMap == null ) {
			this.requestMap = getRolesAndUrl();
		}
		return this.requestMap;
	}

	@Override
	public Class<?> getObjectType() {
		return Map.class;
	}

	@Override
	public boolean isSingleton() {
		return true;
	}


}
