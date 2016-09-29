package project.jun.was.parameter.agent;

import javax.servlet.http.HttpServletRequest;

/**
 * User Agent를 이용하여 접속 brower를 판단.
 * @author Administrator
 *
 */
public class HoUserAgent {

	private HttpServletRequest request = null;
	private String      userAgent          = null;
	
	public HoUserAgent(HttpServletRequest request) {
		if( this.request == null ) {
			this.request = request;
			
			this.userAgent = this.request.getHeader("User-Agent").toLowerCase();
		}
	}
	
	/**
	 *  클라이언트의 IP 조회 (PROXY SERVER 또는 LOAD BALANCER 를 거친 경우에도 조회 가능)
	 * @return
	 */
	public String getClientIp() {
		// PROXY SERVER
		String ip = this.request.getHeader("Proxy-Client-IP");		

		if( ip == null || ip.length() == 0 || ip.toLowerCase().equals("unknown")){
			// 웹로직
			ip = request.getHeader("WL-Proxy-Client-IP");
		} else {
			return ip;
		}

		if( ip == null || ip.length() == 0 || ip.toLowerCase().equals("unknown")){
			// LOAD BALANCER(L4) 
			ip = this.request.getHeader("HTTP_X_FORWARDED_FOR");
		} else {
			return ip;
		}			
	
		if( ip == null || ip.length() == 0 || ip.toLowerCase().equals("unknown")){
			// LOAD BALANCER(L4) 
			ip = this.request.getHeader("X-Forwarded-For");
		} else {
			return ip;
		}			

		if( ip == null || ip.length() == 0 || ip.toLowerCase().equals("unknown")){
			// REMOTE_ADDR
			ip = this.request.getHeader("REMOTE_ADDR");
		} else {
			return ip;
		}
		
		if( ip == null || ip.length() == 0 || ip.toLowerCase().equals("unknown")){
			// RemoteAddr
			ip = this.request.getRemoteAddr();
		} 
		
		return ip;
	}
	
	public String getAgentName() {
		return this.request.getHeader("User-Agent");
	}
	public boolean isAndroid() {
		return this.userAgent.indexOf("android")>=0;
	}
	public boolean isIphone() {
		return this.userAgent.indexOf("iphone")>=0;	
	}
	public boolean isWindowsCE() {
		return this.userAgent.indexOf("windows ce")>=0;	
	}
	public boolean isMobile() {
		String [] mobileos = {"iphone", "ipad", "android", "blackberry", "windows ce", "nokia", "webos", "opera mini", "Sonyericsson", "opera mobi", "iemobile"};
		
		if( this.userAgent == null || "".equals(this.userAgent)) {
			return false;
		} else {
			for( int i=0 ; i<mobileos.length; i++) {
				if( this.userAgent.indexOf(mobileos[i])>-1) {
					return true;
				}
			}
		}
		return false;
	}
	public boolean isPc() {
		return !isMobile();
	}
	
	/**
	 * 서비스 가능한 OS여부 (PC, iphone, ipad, android )
	 * @return
	 */
	public boolean isSupportable() {
		String [] mobileos = {"iphone", "ipad", "android", "opera mini", "opera mobi", "iemobile"};
		if( this.userAgent == null || "".equals(this.userAgent)) {
			return true;
		} else {
			for( int i=0 ; i<mobileos.length; i++) {
				if( this.userAgent.indexOf(mobileos[i])>-1) {
					return true;
				}
			}
		}
		return false;
	}
	
	/**
	 * Ajax로 호출 여부.
	 * @return
	 */
	public boolean isAjaxCall() {
		String      xRequest = this.request.getHeader("X-Requested-With");
		
		return xRequest==null ? false : xRequest.equals("XMLHttpRequest");
	}

}
