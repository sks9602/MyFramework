package project.jun.config;

public class HoConfigDao {

	private String defaultDaoName;
	private boolean debugArugumentsOrdered = false;
	private boolean debugAruguments;
	private boolean debugArugumentsValue;

	/**
	 * @return
	 */
	public String getDefaultDaoName() {
		return defaultDaoName;
	}
	public void setDefaultDaoName(String defaultDaoName) {
		this.defaultDaoName = defaultDaoName;
	}
	public boolean isDebugArugumentsOrdered() {
		return debugArugumentsOrdered;
	}
	public void setDebugArugumentsOrdered(boolean debugArugumentsOrdered) {
		this.debugArugumentsOrdered = debugArugumentsOrdered;
	}
	public boolean isDebugAruguments() {
		return debugAruguments;
	}
	public void setDebugAruguments(boolean debugAruguments) {
		this.debugAruguments = debugAruguments;
	}
	public boolean isDebugArugumentsValue() {
		return debugArugumentsValue;
	}
	public void setDebugArugumentsValue(boolean debugArugumentsValue) {
		this.debugArugumentsValue = debugArugumentsValue;
	}

}
