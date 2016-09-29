package project.jun.config;

import java.util.Map;

import project.jun.util.HoUtil;

/**
 * @author  sks
 */
public class HoConfig extends HoConfigDisplayFormat {

	private String characterSetAjax;
	private String characterSet;
	private String characterSetFile;
	private String characterSetInput;
	private String dirFileUpload;
	private String dirFileUploadDev;
	private String uploadFolderType;
	private String renameFileNameType;
	private String dirTempFileUpload;
	private String dirWasHome;
	private String dirWebHome;
	private boolean productMode;
	private String actionFlag;
	private String uploadType;
	private String sessionNamePrefix = "SSN_";
	private boolean  debugParameterOrdered = false;
	private boolean  debugParameter;
	private boolean  debugParameterValue;
	private Map<String, String>      configMap;
	private Map<String, String>      outlineMap;
	private long    limit = 30L;
	private long    maxFileSize = 4096000L;    
	private Map<String, String>      dateFormatMapJS = null;
	private Map<String, String>      dateAltFormatMapJS = null;

	/**
	 * @return
	 */
	public String getCharacterSetAjax() {
		return characterSetAjax;
	}
	/**
	 * @param characterSetAjax
	 */
	public void setCharacterSetAjax(String characterSetAjax) {
		this.characterSetAjax = characterSetAjax;
	}
	/**
	 * @return
	 */
	public String getCharacterSet() {
		return characterSet;
	}
	/**
	 * @param characterSet
	 */
	public void setCharacterSet(String characterSet) {
		this.characterSet = characterSet;
	}
	/**
	 * @return
	 */
	public String getCharacterSetFile() {
		return characterSetFile;
	}
	/**
	 * @param characterSetFile
	 */
	public void setCharacterSetFile(String characterSetFile) {
		this.characterSetFile = characterSetFile;
	}
	/**
	 * @return
	 */
	public String getCharacterSetInput() {
		return characterSetInput;
	}
	/**
	 * @param characterSetInput
	 */
	public void setCharacterSetInput(String characterSetInput) {
		this.characterSetInput = characterSetInput;
	}
	/**
	 * @return
	 */
	public String getDirFileUpload() {
		return dirFileUpload;
	}
	/**
	 * @param dirFileUpload
	 */
	public void setDirFileUpload(String dirFileUpload) {
		this.dirFileUpload = dirFileUpload;
	}
	public String getDirFileUploadDev() {
		return dirFileUploadDev;
	}
	public void setDirFileUploadDev(String dirFileUploadDev) {
		this.dirFileUploadDev = dirFileUploadDev;
	}
	public String getUploadFolderType() {
		return HoUtil.replaceNull(uploadFolderType, "yyyyMMdd");
	}
	public void setUploadFolderType(String uploadFolderType) {
		this.uploadFolderType = uploadFolderType;
	}
	public String getRenameFileNameType() {
		return HoUtil.replaceNull(renameFileNameType, "random");
	}
	public void setRenameFileNameType(String renameFileNameType) {
		this.renameFileNameType = renameFileNameType;
	}
	/**
	 * @return
	 */
	public String getDirWasHome() {
		return dirWasHome;
	}
	public String getDirTempFileUpload() {
		return dirTempFileUpload;
	}
	public void setDirTempFileUpload(String dirTempFileUpload) {
		this.dirTempFileUpload = dirTempFileUpload;
	}
	/**
	 * @param dirWasHome
	 */
	public void setDirWasHome(String dirWasHome) {
		this.dirWasHome = dirWasHome;
	}
	/**
	 * @return
	 */
	public String getDirWebHome() {
		return dirWebHome;
	}
	/**
	 * @param dirWebHome
	 */
	public void setDirWebHome(String dirWebHome) {
		this.dirWebHome = dirWebHome;
	}
	/**
	 * @return
	 */
	public boolean isProductMode() {
		return productMode;
	}
	/**
	 * @param productMode
	 */
	public void setProductMode(boolean productMode) {
		this.productMode = productMode;
	}
	/**
	 * @return
	 */
	public String getActionFlag() {
		return actionFlag;
	}
	/**
	 * @param actionFlag
	 */
	public void setActionFlag(String actionFlag) {
		this.actionFlag = actionFlag;
	}
	/**
	 * @return
	 */
	public String getUploadType() {
		return uploadType;
	}
	/**
	 * @param uploadType
	 */
	public void setUploadType(String uploadType) {
		this.uploadType = uploadType;
	}

	/**
	 * @return
	 */
	public Map<String, String> getDateFormatMapJS() {
		return dateFormatMapJS;
	}

	public String getDateFormatMapJS(String key) {
		return dateFormatMapJS.get(key).toString();
	}

	/**
	 * @param dateFormatMapJS
	 */
	public void setDateFormatMapJS(Map<String, String> dateFormatMapJS) {
		this.dateFormatMapJS = dateFormatMapJS;
	}

	/**
	 * @return
	 */
	public Map<String, String> getDateAltFormatMapJS() {
		return dateAltFormatMapJS;
	}

	public String getDateAltFormatMapJS(String key) {
		return dateAltFormatMapJS.get(key).toString();
	}

	/**
	 * @param dateAltFormatMapJS
	 */
	public void setDateAltFormatMapJS(Map<String, String> dateAltFormatMapJS) {
		this.dateAltFormatMapJS = dateAltFormatMapJS;
	}
	/**
	 * @return
	 */
	public String getSessionNamePrefix() {
		return sessionNamePrefix;
	}
	/**
	 * @param sessionNamePrefix
	 */
	public void setSessionNamePrefix(String sessionNamePrefix) {
		this.sessionNamePrefix = sessionNamePrefix;
	}


	/**
	 * @return
	 */
	public boolean isDebugParameterOrdered() {
		return debugParameterOrdered;
	}
	/**
	 * @param debugParameterOrdered
	 */
	public void setDebugParameterOrdered(boolean debugParameterOrdered) {
		this.debugParameterOrdered = debugParameterOrdered;
	}

	/**
	 * @return
	 */
	public boolean isDebugParameter() {
		return debugParameter;
	}
	/**
	 * @param debugParameter
	 */
	public void setDebugParameter(boolean debugParameter) {
		this.debugParameter = debugParameter;
	}
	/**
	 * @return
	 */
	public boolean isDebugParameterValue() {
		return debugParameterValue;
	}
	/**
	 * @param debugParameterValue
	 */
	public void setDebugParameterValue(boolean debugParameterValue) {
		this.debugParameterValue = debugParameterValue;
	}
	/**
	 * @return
	 */
	public Map<String, String> getConfigMap() {
		return configMap;
	}
	/**
	 * @param configMap
	 */
	public void setConfigMap(Map<String, String> configMap) {
		this.configMap = configMap;
	}
	/**
	 * @return
	 */
	public Map<String, String> getOutlineMap() {
		return outlineMap;
	}
	/**
	 * @param outlineMap
	 */
	public void setOutlineMap(Map<String, String> outlineMap) {
		this.outlineMap = outlineMap;
	}
	/**
	 * Default paging size
	 * @return
	 */
	public long getLimit() {
		return limit;
	}
	
	/**
	 * Default paging size
	 * @param limit
	 */
	public void setLimit(long limit) {
		this.limit = limit;
	}
	/**
	 * 업로드 파일 Max 사이즈 
	 * @return
	 */
	public long getMaxFileSize() {
		return maxFileSize;
	}
	/**
	 * 업로드 파일 Max 사이즈
	 * @param maxFileSize
	 */
	public void setMaxFileSize(long maxFileSize) {
		this.maxFileSize = maxFileSize;
	}

}