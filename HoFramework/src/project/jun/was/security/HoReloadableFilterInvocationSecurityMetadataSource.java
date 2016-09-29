package project.jun.was.security;

import java.util.Collection;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.web.FilterInvocation;
import org.springframework.security.web.access.intercept.FilterInvocationSecurityMetadataSource;
import org.springframework.security.web.util.RequestMatcher;

import project.jun.delegate.HoAuthorityRules;

public class HoReloadableFilterInvocationSecurityMetadataSource implements FilterInvocationSecurityMetadataSource {

	protected  Logger          logger     = Logger.getLogger(HoReloadableFilterInvocationSecurityMetadataSource.class);

	// org.springframework.security.config.method.ProtectPointcutPostProcessor a = null;
	
	private final LinkedHashMap<RequestMatcher, Collection<ConfigAttribute>> requestMap;

	protected HoAuthorityRules hoAuthorityRules;
	
	public HoReloadableFilterInvocationSecurityMetadataSource(LinkedHashMap<RequestMatcher, Collection<ConfigAttribute>> requestMap) {
		
		this.requestMap = requestMap;
		
	}
	
	public void setHoAuthorityRules(HoAuthorityRules hoAuthorityRules) {
		this.hoAuthorityRules = hoAuthorityRules;
	}
	
	public void reload() throws Exception {
		this.requestMap.clear();
		
		this.requestMap.putAll( hoAuthorityRules.getRolesAndUrl() );
		
		logger.warn("Security??  HoReloadableFilterInvocationSecurityMetadataSource.reload()");
	}
	

	public Collection<ConfigAttribute> getAllConfigAttributes() {
		Set<ConfigAttribute> allAttributes = new HashSet<ConfigAttribute>();

		for (Map.Entry<RequestMatcher, Collection<ConfigAttribute>> entry : this.requestMap.entrySet()) {
			allAttributes.addAll(entry.getValue());
		}

		return allAttributes;
	}

	public Collection<ConfigAttribute> getAttributes(Object object) {
		HttpServletRequest request = ((FilterInvocation) object).getRequest();
		
		Collection<ConfigAttribute> result = null;
		
		for (Map.Entry<RequestMatcher, Collection<ConfigAttribute>> entry : this.requestMap.entrySet()) {
			if (((RequestMatcher) entry.getKey()).matches(request)) {
				result = entry.getValue();
				break;
				//return ((Collection) entry.getValue());
			}
		}
		return result;
	}

	@Override
	public boolean supports(Class<?> clazz) {
		return FilterInvocation.class.isAssignableFrom(clazz);
	}

}
