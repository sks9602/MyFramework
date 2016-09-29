package project.jun.util.cache;import java.util.List;import org.apache.log4j.Logger;import project.jun.dao.result.HoList;import project.jun.dao.result.HoMap;import net.sf.ehcache.Cache;import net.sf.ehcache.Element;public class HoEhCache implements HoCache {	Cache cache;	protected static Logger          logger     = Logger.getLogger(HoEhCache.class);	public HoEhCache(Cache cache) {		this.cache = cache;	}	public void setName(String name) {		if( name!=null && this.cache!=null && !this.cache.getName().equals(name) ) {			this.cache.setName(name);		}	}	public List keyList() {		return this.cache.getKeys();	}	public Object getElement(Object key) {		return this.cache.get(key);	}	public Object get(Object key) {		Element element =  this.cache.get(key);		if( element!= null ) {			return element.getObjectValue();		} else {			return null;		}	}	public HoList getHoList(Object key) {		Element element =  this.cache.get(key);		if( element!= null ) {			return (HoList) element.getObjectValue();		} else {			return null;		}	}	public HoMap getHoMap(Object key) {		Element element =  this.cache.get(key);		if( element!= null ) {			return (HoMap) element.getObjectValue();		} else {			return null;		}	}	public void put(Object key, Object entry) {		Element element = new Element(key, entry);		this.cache.put(element);	}	public void flush() {		this.cache.flush();	}	public boolean remove(Object key) {		Element element =  this.cache.get(key);		if( element != null ) {			return this.cache.remove(key);		} else {			return true;		}	}	public boolean [] removeAll() {		List keyList = this.keyList();		boolean [] results = new boolean[keyList.size()];		Object key = null;		for( int i=0 ; i<keyList.size(); i++ ) {			key = keyList.get(i);			results[i] = this.cache.remove(key);			if( !results[i] ) {				logger.warn("Cache key ["+ key + "] not removed!!");			} else {				logger.info("Cache key ["+ key + "] Removed!!");			}		}		return results;	}	public Object getCacheManager() {		return this.cache.getCacheManager();	}}