package project.jun.was.view;import java.io.UnsupportedEncodingException;import java.util.Map;import javax.servlet.ServletContext;import javax.servlet.http.HttpServletRequest;import javax.servlet.http.HttpServletResponse;import org.apache.poi.hssf.usermodel.HSSFWorkbook;import org.springframework.web.context.WebApplicationContext;import org.springframework.web.context.support.WebApplicationContextUtils;import org.springframework.web.servlet.FrameworkServlet;import org.springframework.web.servlet.view.document.AbstractExcelView;import project.jun.util.HoExcelWriter;import project.jun.was.HoModel;import project.jun.was.HoSession;import project.jun.was.servlet.HoServlet;import project.jun.config.HoConfig;import project.jun.was.parameter.HoParameter;import project.jun.was.spring.HoController;public class HoExcelView extends AbstractExcelView {	private String excelFileName = null;	public static final String HO_EXCEL_DATA  = "project.jun.was.spring.HoExcelView.EXCEL_DATA";	/**	 * Excel 다운로드 필수구현 method	 */	protected void buildExcelDocument(Map<String,Object> map, HSSFWorkbook wb, HttpServletRequest request, HttpServletResponse response) throws Exception {    	HoServlet hoRequest = new HoServlet( request, response );    	HoParameter param = (HoParameter) map.get(HoController.HO_PARAMETER);    	HoExcelWriter hew = new HoExcelWriter();    	hew.setWorkbook(wb);    	ServletContext ctx =  hoRequest.getSession().getServletContext();		WebApplicationContext factory = null;		try {			String attr = FrameworkServlet.SERVLET_CONTEXT_PREFIX + "action";			factory = WebApplicationContextUtils.getWebApplicationContext(ctx, attr);		} catch (Exception e) {		}		/*				logger.info("1 :" + factory.getBean("config"));		logger.info("2 :" + ((HoConfig) factory.getBean("config")).getActionFlag());		logger.info("4 :" + param);		param.infoParameter(true);		logger.info("3 :" + param.get(((HoConfig) factory.getBean("config")).getActionFlag(), "p_action_flag"));		logger.info("6 :" + hew);		logger.info("7 :" + factory);		*/    	makeExcel(param.get(((HoConfig) factory.getBean("config")).getActionFlag(), "p_action_flag"), param, new HoModel(map), hoRequest,  hew, factory);	}	/**	 * 개발자가 실제로 구현해야하는  method	 * @param actionFlag	 * @param param	 * @param map	 * @param hew	 * @throws Exception	 */	public void makeExcel(String actionFlag, HoParameter param, HoModel model, HoServlet hoRequest, HoExcelWriter hew ,WebApplicationContext factory) throws Exception  {	}	/**	 * Excel다운로드시 헤더정보	 * @param header	 * @param value	 * @param res	 */	private void setDBCSHeader(String header,String value, HttpServletResponse res) {  		byte b[];  		try {     		b = value.getBytes(res.getCharacterEncoding());  		} catch (Exception ex) {     		b = value.getBytes();  		}  		char c[] = new char[b.length];  		for (int i=0;i<b.length;i++)  		{  		    c[i]=(char)(((char)b[i])&0xff);       	}  		res.setHeader(header,new String(c));  		res.setHeader("Content-Transfer-Encoding", "binary");	}	/**	 * Excel다운로드시 파일명 설정.	 * @param header	 * @param value	 * @param res	 */	protected void setExcelName(HoServlet hoRequest, String fileName) throws UnsupportedEncodingException {		/*		String strClient = hoRequest.getRequest().getHeader("User-Agent");		String sNewViewname = java.net.URLEncoder.encode(fileName, "utf-8"); //euc-kr		if (strClient.indexOf("MSIE 5.5") != -1) {			setDBCSHeader("Content-Disposition", "filename="+sNewViewname+".xls;", hoRequest.getResponse());		} else {			setDBCSHeader("Content-Disposition", "attachment;filename="+sNewViewname+".xls;", hoRequest.getResponse());		}		*/		String sNewViewname = new String(fileName.getBytes("euc-kr"), "8859_1");		this.setExcelFileName(sNewViewname);		hoRequest.getResponse().setHeader("Content-Disposition", "attachment; fileName=\"" + sNewViewname + "\";");		hoRequest.getResponse().setHeader("Content-Transfer-Encoding", "binary");	}		public void setExcelFileName( String excelFileName) {		this.excelFileName = excelFileName;	}		public String getExcelFileName() {		return this.excelFileName;	}}