package project.jun.dao.result.processor;

import java.util.Map;

import project.jun.dao.result.HoMap;

/**
 * Query결과를 사용자가 가공할 수 있도록 Column을 추가 가능한 Interface
 * @author Administrator
 *
 */
public abstract class HoRecordProcessor {
	private String column = null;
	private HoMap  record = null;
	
	public HoRecordProcessor (String column ) {
		this.column = column;
	}
	public String getColumn() {
		return this.column;
	}
	public void setRecord( HoMap record ) {
		this.record = record;
	}

	public void setRecord( Map<String, Object> record ) {
		this.record = new HoMap(record);
	}
	
	public abstract String getProcessResult();
	
	public abstract void processResult();

}
