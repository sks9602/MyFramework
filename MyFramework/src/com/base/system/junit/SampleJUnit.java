package com.base.system.junit;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.ui.ModelMap;

import project.jun.config.HoConfig;
import project.jun.dao.result.HoList;
import project.jun.was.HoModel;
import project.jun.was.parameter.HoJUnitParameter;
import project.jun.was.parameter.HoParameter;
import project.jun.was.parameter.HoParameterMap;

import com.base.system.delegate.SampleDelegate;

import junit.framework.TestCase;

/**
 * The class <code>SampleJUnit</code> contains tests for the class {@link
 * <code>TestCase</code>}
 *
 * @pattern JUnit Test Case
 *
 * @generatedBy CodePro at 13. 7. 10 �}Q 3:02
 *
 * @author sks
 *
 * @version $Revision$
 */
public class SampleJUnit extends TestCase {

	SampleDelegate delegate = null;
	ApplicationContext context = null;

	/**
	 * Construct new test instance
	 *
	 * @param name the test name
	 */
	public SampleJUnit(String name) {
		super(name);
	}

	/**
	 * Perform pre-test initialization
	 *
	 * @throws Exception
	 *
	 * @see TestCase#setUp()
	 */
	protected void setUp() throws Exception {
		super.setUp();



		String applicationContexts[] = {
				"project/config/applicationContext.xml",
				"project/config/applicationContext-aop.xml",
				"project/config/applicationContext-cache.xml",
				"project/config/applicationContext-dao.xml",
				"project/config/applicationContext-db.xml",
				"project/config/applicationContext-tx.xml",
				"project/config/applicationContextDelegate.xml",
				"project/config/applicationContextDelegate-sample.xml"

		};

		context = new ClassPathXmlApplicationContext(applicationContexts);

		delegate = (SampleDelegate) context.getBean("SampleDelegate");

	}


	public void testSelect() {
		String actionFlag = "list";

		HoModel model = new HoModel(new ModelMap());
		HoParameterMap hoParameterMap = new HoParameterMap();
		HoConfig hoConfig = null;

		hoParameterMap.put("p_action_flag", "list");
		hoParameterMap.put("DIA_SQ", "adfsdfasd");
		hoParameterMap.put("use_yn", new String[]{"afds", "1", "aflsdjf"});
		hoParameterMap.put("COURSE_SQ", "1343556");
		hoParameterMap.put("EDU_YEAR", "1343556");

		HoJUnitParameter parameter = new HoJUnitParameter();
		parameter.setHoParameterMap(hoParameterMap);
		
		hoConfig = (HoConfig) context.getBean("config");

		Object result = delegate.list(actionFlag, model, parameter, hoConfig);
	}



	/**
	 * Perform post-test clean up
	 *
	 * @throws Exception
	 *
	 * @see TestCase#tearDown()
	 */
	protected void tearDown() throws Exception {
		super.tearDown();
		// Add additional tear down code here
	}
}

