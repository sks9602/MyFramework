package project.jun.was.spring;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileUploadException;
import org.apache.log4j.Logger;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.mvc.Controller;

import project.jun.util.HoUtil;
import project.jun.util.HoValidator;
import project.jun.was.HoModel;
import project.jun.was.servlet.HoServlet;
import project.jun.config.HoConfig;
import project.jun.delegate.HoDelegate;
import project.jun.was.parameter.HoCosFileParameter;
import project.jun.was.parameter.HoCommonFileParameter;
import project.jun.was.parameter.HoNormalParameter;
import project.jun.was.parameter.HoParameter;
import project.jun.was.result.message.HoMessage;
import project.jun.exception.HoException;

public abstract class HoController implements Controller {

	protected  Logger          logger     = Logger.getLogger(this.getClass());

	public static final String HO_CONFIG         = "HO_CONTROLLER.HO_CONFIG";
	public static final String HO_PARAMETER      = "HO_CONTROLLER.HO_PARAMETER";
	public static final String HO_SUCCESS        = "HO_CONTROLLER.HO_SUCCESS";
	public static final String HO_INCLUDE_JSP    = "HO_CONTROLLER.HO_INCLUDE_JSP";
	public static final String HO_CUD_RESULT     = "HO_CONTROLLER.HO_CUD_RESULT";
	public static final String HO_URI            = "HO_CONTROLLER.HO_URI";

	protected HoConfig hoConfig = null;

	protected View documentView;

	private String forwardPage;
	private String includePage;
	private String exceptionPage;
	private String messagePage;
	private String defaultPageInfo;


	protected HoDelegate hoDelegate = null;

	protected HoParameter processParameter( HoServlet   hoServlet, HoConfig hoConfig)  throws FileUploadException, IOException {
		HttpServletRequest request = hoServlet.getRequest();

		String contentType = request.getContentType();

        if( !"POST".equalsIgnoreCase(request.getMethod()) ) {
        	return new HoNormalParameter( hoServlet, getHoConfig() );
        } else {
        	if( HoUtil.replaceNull(contentType).startsWith("multipart/form-data")) {
        		
        		if( !HoUtil.replaceNull(getHoConfig().getUploadType()).equals("cos")) {
	            	return new HoCommonFileParameter( hoServlet, getHoConfig() );
        		} else {
        			return new HoCosFileParameter( hoServlet, getHoConfig() );
        		}
        	} else
	        	return new HoNormalParameter( hoServlet, getHoConfig() );
        }
	}


	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HoServlet   hoServlet = new HoServlet( request, response, this.getHoConfig() );

		HoParameter parameter = processParameter(hoServlet, this.getHoConfig());

		ModelAndView mav = new ModelAndView();

		HoModel model = new HoModel(mav.getModelMap());

		mav.addObject(HO_CONFIG   , this.getHoConfig());
		mav.addObject(HO_PARAMETER, parameter);
		mav.addObject(HO_URI      , requestUri(hoServlet));

		String actionFlag = parameter.get("p_action_flag");

		Object delegateResult = null;

		try {
			this.printActionFlag(actionFlag);

			this.setForwardPage( null );
			this.setIncludePage( null );

			this.hoDelegate.setHoServlet(hoServlet);
			// 실제 B/L 이전 실행..
			beforeExecute( actionFlag, model, parameter, hoServlet );

			delegateResult = execute( actionFlag, model, parameter, hoServlet);
			
			// 실제 B/L 이후 실행
			afterExecute( actionFlag, model, parameter, hoServlet  );


		} catch(Exception e) {
			getLogger().error(e);

			if( !this.getHoConfig().isProductMode() ) {
				e.printStackTrace();
			}
			try {
				exceptionExecute(actionFlag, model, parameter, hoServlet);
			} catch(Exception ee) {
            	if( !this.getHoConfig().isProductMode() && !((e instanceof java.net.SocketException) && e.getMessage().equals("Broken pipe"))) {
            		ee.printStackTrace();
            	}
        	}

			// Exception 발생시 forward
			return getExceptionForward( actionFlag, mav, e);

		} finally {
			try {
				finallyExecute( actionFlag,  model, parameter, hoServlet  );
			} catch(Exception e) {
            	if( !this.getHoConfig().isProductMode()) {
            		e.printStackTrace();
            	}
        	}

		}

		

		// 다운로드 일 경우.
		if(actionFlag.toLowerCase().indexOf("download")!=-1 ) {
			
			if( delegateResult instanceof ModelAndView ) {
				mav =  (ModelAndView) delegateResult;
			} 
			if( mav.getViewName().equals("excelDownloadView")) {
				return new ModelAndView("excelDownloadView", model.getAllMap());
			} else {
				return mav;
			}
        } else {
        	// 정상적인 실행 완료시 forward
        	return getForward(actionFlag, mav, delegateResult, hoServlet);
        }
	}

	/**
	 * Exception이 발생했을 경우 forward될 페이지를 구한다.
	 * @param actionFlag
	 * @param mav
	 * @param e
	 * @return
	 * @throws UnsupportedEncodingException
	 */
    public ModelAndView getExceptionForward(String actionFlag, ModelAndView mav, Exception e) {
		mav.addObject(HO_SUCCESS, new Boolean(false));

		HoException he = null;

    	if( e instanceof HoException ) {
    		he = (HoException) e;
    	} else if( e instanceof java.sql.SQLException ) {
    		he = new HoException("ERR-CO-0004", e);
    	} else if( e instanceof AccessDeniedException ) {
    		he = new HoException("ERR-CO-ACCESS-DENIED", e);
    	} else {
    		he = new HoException(e);
    	}
		// 결과를 등록
		mav.addObject(HO_CUD_RESULT, he);

		HoParameter param = (HoParameter) mav.getModelMap().get(HO_PARAMETER);

		String messagePage = "";
		boolean useMessageParam = false;
		try {
			if( !param.get("message").equals("") && this.getHoConfig().getOutlineMap().containsKey(param.get("message").toUpperCase())) {
				messagePage = param.get("message").toUpperCase();
			}
		} catch (Exception e1) {
			if(!this.getHoConfig().isProductMode()) {
				e.printStackTrace();
			}
		}

		if( HoUtil.replaceNull(this.getExceptionPage()).equals("") && !messagePage.equals("")) {
			useMessageParam = true;
			this.setExceptionPage((String) this.getHoConfig().getOutlineMap().get(messagePage) );
		}

		if( he.getCode().equals("ERR-CO-ACCESS-DENIED")) {
			mav.setViewName("/system/login.do?p_action_flag=denied");
		} else {
			mav.setViewName(this.getExceptionPage());
		}

		getLogger().info("message-page   : ["+ this.getExceptionPage() +"] "+ (useMessageParam ? "(Use parameter(message) : "+messagePage+")" : "" ) +" - " + mav.getViewName());


    	return mav;
    }

    /**
     * 성공적으로 B/L이 실행될 경우 forward될 페이지를 구한다.
     * @param actionFlag
     * @param mav
     * @param cudResult
     * @return
     */
	public ModelAndView getForward(String actionFlag,ModelAndView mav, Object result, HoServlet   hoServlet ) {

		getLogger().info("uri            : " + requestUri(hoServlet));

		// Message를 나타낼 수 있는 형태의 결과값인지 확인(String, String[], HoMessage)
    	if( isActionForMessage(actionFlag,  mav, result) ) {
    		return getMessageForward(actionFlag, mav, result);
    	} else {

			HoParameter param = (HoParameter) mav.getModelMap().get(HO_PARAMETER);
			boolean outlineUseParam = false;

			// forward페이지 정보가 없을경우.
			if( HoUtil.replaceNull(this.getForwardPage()).equals("")) {
    			try {

    				String outlinePage = "";

    				if( !HoValidator.isEmpty(param.get("outline")) && this.getHoConfig().getOutlineMap().containsKey(param.get("outline").toUpperCase())) {
    					outlinePage = param.get("outline").toUpperCase();
    				}

    				// 파라미터에 outline이 있으면.. outline파라미터를 이용해서 설정..
					if( !outlinePage.equals("")) {
						outlineUseParam = true;
						this.setForwardPage((String) this.getHoConfig().getOutlineMap().get(outlinePage) );
					}
				} catch (Exception e) {
					if(!this.getHoConfig().isProductMode()) {
						e.printStackTrace();
					}
				}
    		}

			if( HoValidator.isEmpty(this.getForwardPage())) {
    			// forward될 페이지없음.
    			return getExceptionForward(actionFlag, mav, new HoException("ERR-CO-0009"));
			}

			mav.setViewName(this.getForwardPage());

			try {
		    	getLogger().info("forward-page   : ["+ this.getForwardPage() +"] "+ (outlineUseParam ? "(Use parameter(outline) : "+param.get("outline")+")" : "" ) +" - " + mav.getViewName());
			} catch(Exception e) {

			}

    		if( HoValidator.isNotEmpty(this.getIncludePage())) {
				ModelAndView includeView = new ModelAndView(this.getIncludePage());

    			mav.addObject(HO_INCLUDE_JSP, includeView.getViewName());

		    	getLogger().info("included-page   : ["+ this.getIncludePage() +"] - " + includeView.getViewName());
		    	// wreq.setIncludeJsp(includeView.getViewName());
    		} else {
				// 파라미터에 include가 있고,  DefaultPageInfo가 있으면.. include파라미터를 이용해서 설정..
				if( HoUtil.replaceNull(this.getDefaultPageInfo()).indexOf("#p_action_flag#")!=-1) {
					ModelAndView includeView = new ModelAndView(this.getDefaultPageInfo().replaceAll("#p_action_flag#", actionFlag));

	    			mav.addObject(HO_INCLUDE_JSP, includeView.getViewName());

			    	getLogger().info("included-page   : ["+ this.getIncludePage() +"] (Use parameter("+ getHoConfig().getActionFlag()+") :"+actionFlag+" ) - " + includeView.getViewName());

				} else {
					getLogger().warn("included-page   : undefined!!! ");
				}
    		}
	    	return mav;
    	}

	}

	/**
	 * CUD가 성공했을 경우 forward될 페이지를 구한다.
	 * @param actionFlag
	 * @param mav
	 * @param result
	 * @return
	 */
	private ModelAndView getMessageForward(String actionFlag, ModelAndView mav, Object result) {

		mav.setViewName(this.getMessagePage());

		HoMessage hm = null;
		if( result instanceof HoMessage ) {
			hm = (HoMessage)result;
		} else if( result instanceof String ) {
			hm = new HoMessage((String) result);
		} else if( result instanceof String [] ) {
			hm = new HoMessage(((String[]) result)[0], ((String[]) result).length > 0 ? ((String[]) result)[1] : "" );
		}

		HoParameter param = (HoParameter) mav.getModelMap().get(HO_PARAMETER);

		String messagePage = "";
		boolean useMessageParam = false;
		
		try {
			if( !param.get("message").equals("") && this.getHoConfig().getOutlineMap().containsKey(param.get("message").toUpperCase())) {
				messagePage = param.get("message").toUpperCase();
			}
		} catch (Exception e) {
			if(!this.getHoConfig().isProductMode()) {
				e.printStackTrace();
			}
		}

		if( HoUtil.replaceNull(this.getMessagePage()).equals("") && !messagePage.equals("")) {
			useMessageParam = true;
			this.setMessagePage((String) this.getHoConfig().getOutlineMap().get(messagePage) );
		}

		// 결과를 등록
		mav.addObject(HO_CUD_RESULT, hm);

    	getLogger().info("message-page   : ["+ this.getMessagePage() +"] "+ (useMessageParam ? "(Use parameter(message) : "+messagePage+")" : "" ) +" - " + mav.getViewName());


		return mav;
	}

	/**
	 * Message를 나타낼 수 있는 형태의 결과값인지 확인
	 * @param actionFlag
	 * @param mav
	 * @param result
	 * @return
	 */
	private boolean isActionForMessage(String actionFlag, ModelAndView mav, Object result) {
		boolean isForMessage = false;
		if( result != null ) {
			logger.info(" result : "  + result.getClass().getName());
		}
		
		if( result instanceof HoException ) {
			mav.addObject(HO_SUCCESS, new Boolean(false));
			isForMessage = true;
		} else {
			if( result instanceof HoMessage ) {
				isForMessage = true;
			} else if( result instanceof String ) {
				isForMessage = true;
			} else if( result instanceof String [] ) {
				isForMessage = true;
			}
			
			if( isForMessage ) {
				mav.addObject(HO_SUCCESS, new Boolean(true));
			}
		}
		
		return isForMessage;

	}

	/**
	 * request uri구한다.
	 * @param hoRequest
	 * @return
	 */
	public String requestUri(HoServlet   hoServlet) {
		org.springframework.web.util.UrlPathHelper urlPathHelper = new org.springframework.web.util.UrlPathHelper();
		return urlPathHelper.getOriginatingRequestUri(hoServlet.getRequest());

	}

	/**
     * 실제 biz logic실행전 실행될 method
     * @param actionFlag
     * @throws Exception
     */
    public void beforeExecute( String actionFlag, HoModel model, HoParameter parameter, HoServlet   hoServlet) throws Exception { }


    /**
     * 실제 biz logic 실행될 method
     * @param actionFlag
     * @throws Exception
     * 
     * @return 
     * 	case1 : ModelAndView - 파일 다운로드 또는 Excel 다운로드시
     * 	case2 : HoMessage,String, String[],HoException / HoException,SQLException  - 처리결과 메시지 출력 화면 이동
     * 	case3 : null 화면 View(jsp) 표시
     */
    public abstract Object execute( String actionFlag, HoModel model, HoParameter parameter, HoServlet   hoServlet) throws Exception;

    /**
     * 실제 biz logic실행후 실행될 method
     * @param actionFlag
     * @throws Exception
     */
    public void afterExecute( String actionFlag, HoModel model, HoParameter parameter, HoServlet   hoServlet) throws Exception { }


    /**
     * exception발생시 실행될 method
     * @param actionFlag
     * @throws Exception
     */
    public void exceptionExecute( String actionFlag, HoModel model, HoParameter parameter, HoServlet   hoServlet) throws Exception { }

    /**
     * 항상 실행될 method
     * @param actionFlag
     * @throws Exception
     */
    public void finallyExecute( String actionFlag, HoModel model, HoParameter parameter, HoServlet   hoServlet) throws Exception { }

    protected void setLogger(Class<?> className) {
		this.logger = Logger.getLogger(className);
	}

    protected Logger getLogger() {
		return this.logger == null ? Logger.getLogger(this.getClass()) : this.logger;
	}

	private void printActionFlag(String actionFlag) {
        getLogger().info(" actionFlag : " + actionFlag );
	}

	public HoConfig getHoConfig() {
		return hoConfig;
	}


	public void setHoConfig(HoConfig hoConfig) {
		this.hoConfig = hoConfig;
	}

	/**
	 * 기본적으로 사용될 jsp경로정보를 get
	 * @return
	 * @uml.property  name="defaultPageInfo"
	 */
	public String getDefaultPageInfo() {
		return HoUtil.replaceNull(defaultPageInfo);
	}

	/**
	 * 기본적으로 사용될 jsp경로정보를 set.
	 * @return
	 * @uml.property  name="defaultPageInfo"
	 */
	public void setDefaultPageInfo(String defaultPageInfo) {
		this.defaultPageInfo = defaultPageInfo;
	}

	/**
	 * CUD성공시 FORWARD될 페이지정보를 set
	 * @param  page
	 */
	public void setMessagePage(String page) {
		this.messagePage = page;
	}

	/**
	 * CUD성공시 FORWARD될 페이지정보를 get
	 * @param  page
	 */
	public String getMessagePage() {
		return this.messagePage;
	}

	/**
	 * CUD실패시 FORWARD될 페이지정보를 set
	 * @param  page
	 */
	public void setExceptionPage(String page) {
		this.exceptionPage = page;
	}

	/**
	 * CUD실패시 FORWARD될 페이지정보를 get
	 * @param  page
	 */
	public String getExceptionPage() {
		return this.exceptionPage;
	}

	/**
	 * include될 페이지정보를 set <b>include만으로는 페이지를 호출 할 수 없기때문에 반드시 forwardPage가 설정되어야함.</b>
	 * @param  page
	 */
	public void setIncludePage(String page) {
		this.includePage = page;
	}

	/**
	 * include될 페이지정보를 get <b>include만으로는 페이지를 호출 할 수 없기때문에 반드시 forwardPage가 설정되어야함.</b>
	 * @param  page
	 */
	public String getIncludePage() {
		return this.includePage;
	}

	/**
	 * forward될 페이지정보를 set
	 * @param  page
	 */
	public void setForwardPage(String page) {
		this.forwardPage = page;

	}

	/**
	 * forward될 페이지정보를 get
	 * @param  page
	 */
	public String getForwardPage() {
		return this.forwardPage;
	}

	/**
	 * @param hoDelegate
	 */
	public void setHoDelegate(HoDelegate hoDelegate) {
		this.hoDelegate = hoDelegate;
	}

	/**
	 * @return
	 */
	public HoDelegate getHoDelegate() {
		return hoDelegate;
	}


}
