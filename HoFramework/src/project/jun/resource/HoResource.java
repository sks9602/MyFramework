package project.jun.resource;

public class HoResource {

	private String resource;
	private String code;

	public HoResource(String code) {
		this.code = code;
		this.resource = null;
	}

	public HoResource(String code, String resource) {
		this.code     = code;
		this.resource = resource;
	}

	/**
	 * @return
	 * @uml.property  name="code"
	 */
	public String getCode() {
		return code;
	}

	/**
	 * @param code
	 * @uml.property  name="code"
	 */
	public void setCode(String code) {
		this.code = code;
	}

	/**
	 * @return
	 * @uml.property  name="resource"
	 */
	public String getResource() {
		return resource;
	}

	/**
	 * @param resource
	 * @uml.property  name="resource"
	 */
	public void setResource(String resource) {
		this.resource = resource;
	}
}
