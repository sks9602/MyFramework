package project.jun.exception;

import java.util.ArrayList;

import project.jun.resource.HoResource;

public class HoException  extends Exception {
	/**
	 *
	 */
	private static final long serialVersionUID = -7506612931405400257L;

	/**
	 * @uml.property  name="errMessages"
	 */
	protected ArrayList errMessages;
	/**
	 * @uml.property  name="javascript"
	 */
	protected String javascript;
	protected String detailMessage;
	/**
	 * @uml.property  name="hr"
	 * @uml.associationEnd
	 */
	protected HoResource hr = null;

	protected final String EXCEPTION_CODE = "ERR-CO-00000";

	public HoException() {
		super( );
		this.hr = new HoResource(EXCEPTION_CODE);
		this.errMessages = new ArrayList();
		this.javascript = "";
	}

	public HoException(Exception e) {
		this( );
		setDetailErrMessage(e);
	}

	public HoException(String code) {
		super( );
		this.hr = new HoResource(code);
		this.errMessages = new ArrayList();
	}

	public HoException( String code, ArrayList errMessages )
	{
		this( code );
		this.errMessages.addAll(errMessages);
	}

	public HoException( String code, String javascript )
	{
		this( code );
		this.errMessages = new ArrayList();
		this.javascript = javascript;
	}

	public HoException( String code, Exception e )
	{
		this( code, "", "");
		setDetailErrMessage(e);
	}

	public HoException( String code, String errMessage, String javascript )
	{
		this( code);
		this.errMessages.add(errMessage);
		this.javascript = javascript;
	}

	public HoException( String code, ArrayList errMessages, String javascript )
	{
		this( code, errMessages );
		this.javascript = javascript;
	}

	public HoException( String code, String errMessage, String javascript, Exception e )
	{
		this( code, errMessage, javascript);
		setDetailErrMessage(e);
	}

	public HoException( String code, ArrayList errMessages, String javascript, Exception e )
	{
		this( code, errMessages , javascript);
		setDetailErrMessage(e);
	}

	public HoException(HoResource hr) {
		super( );
		this.hr = hr;
		this.errMessages = new ArrayList();
	}


	public HoException( HoResource hr, Exception e )
	{
		this.hr = hr;
		setDetailErrMessage(e);
	}


	public HoException( HoResource hr, ArrayList errMessages )
	{
		this( hr );
		this.errMessages.addAll(errMessages);
	}


	public HoException( HoResource hr, String javascript )
	{
		this( hr );
		this.javascript = javascript;
		this.errMessages = new ArrayList();
	}

	public HoException( HoResource hr, String errMessage, String javascript )
	{
		this( hr);
		this.errMessages = new ArrayList();
		this.errMessages.add(errMessage);
		this.javascript = javascript;
	}

	public HoException( HoResource hr, ArrayList errMessages, String javascript )
	{
		this( hr, errMessages );
		this.javascript = javascript;
	}

	public HoException( HoResource hr, String errMessage, String javascript, String detailMessage )
	{
		this( hr, errMessage, javascript);
		this.detailMessage = detailMessage;
	}

	public HoException( HoResource hr, ArrayList errMessages, String javascript, String detailMessage )
	{
		this( hr, errMessages , javascript);
		this.detailMessage = detailMessage;
	}

	public String getCode() {
		return this.hr.getCode();
	}

	public void setCode(String code) {
		if(this.hr==null) {
			this.hr = new HoResource(code);
		} else {
			this.hr.setCode(code);
		}
	}


	public String getDetailErrMessage() {
		return detailMessage;
	}

	public void setDetailErrMessage(String detailErrMessage) {
		this.detailMessage = detailErrMessage;
	}

	public void setDetailErrMessage(Exception e) {
		StringBuffer detail = new StringBuffer();
		for( int i=0 ; i< e.getStackTrace().length ; i++) {
			detail.append( e.getStackTrace()[i]);
		}
		this.detailMessage = detail.toString();
	}

	/**
	 * @return
	 * @uml.property  name="javascript"
	 */
	public String getJavascript() {
		return javascript;
	}

	/**
	 * @param javascript
	 * @uml.property  name="javascript"
	 */
	public void setJavascript(String javascript) {
		this.javascript = javascript;
	}

	/**
	 * @return
	 * @uml.property  name="errMessages"
	 */
	public ArrayList getErrMessages() {
		return errMessages;
	}

	/**
	 * @param errMessages
	 * @uml.property  name="errMessages"
	 */
	public void setErrMessages(ArrayList errMessages) {
		this.errMessages = errMessages;
	}

	public Object [] getErrMessage() {
		return errMessages.toArray();
	}

	public void addErrMessage(String errMessage) {
		if( this.errMessages == null ) {
			this.errMessages = new ArrayList();
		}

		this.errMessages.add(errMessage);
	}

	public String getResource() {
		return this.hr.getResource();
	}

	public void setResourceName(String resource) {
		if(this.hr!=null) {
			this.hr.setResource(resource);
		}
	}
}
