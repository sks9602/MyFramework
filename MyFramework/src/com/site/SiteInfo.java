package com.site;

import java.util.ArrayList;
import java.util.List;

public class SiteInfo {

	List serverList = new ArrayList();
	String excelFileName = null;


	public void setServerList(List serverList) {

		this.serverList = serverList;
	}


	public List getServerList() {
		return this.serverList;
	}

	public void setExcelFileName(String excelFileName) {
		this.excelFileName = excelFileName;
	}

	public String getExcelFileName() {
		return this.excelFileName;
	}

}
