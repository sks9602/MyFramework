package project.jun.dao;

public class HoDaoSqlResult {
	private int index = 0;
	private String userId = "";
	private String sqlId = "";
	private boolean success = false;
	private Exception exception = null;
	
	/**
	 * 
	 * @param userId
	 * @param sqlId
	 * @param index
	 * @param success
	 * @param exception
	 */
	public HoDaoSqlResult(String userId, String sqlId, int index, boolean success, Exception exception ) {
		this.userId = userId;
		this.sqlId = sqlId;
		this.index = index;
		this.success = success;
		this.exception = exception;
	}
	
	/**
	 * 
	 * @return
	 */
	public String getUserId() {
		return userId;
	}

	/**
	 * 
	 * @return
	 */
	public String getSqlId() {
		return sqlId;
	}

	/**
	 * 
	 * @return
	 */
	public int getIndex() {
		return this.index;
	}

	/**
	 * 
	 * @return
	 */
	public boolean isSuccess() {
		return this.success;
	}

	/**
	 * 
	 * @return
	 */
	public Exception getException() {
		return this.exception;
	}
	
	/**
	 * 
	 */
	public String toString() {
		StringBuffer sb = new StringBuffer();
		
		sb.append(this.index);
		sb.append(",");
		sb.append(this.success);
		if( !this.success ) {
			sb.append(" [");
			sb.append(this.exception);
			sb.append("]");
		}
		
		return sb.toString();
	}

}
