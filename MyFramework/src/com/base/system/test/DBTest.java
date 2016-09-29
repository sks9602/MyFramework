package com.base.system.test;

import java.sql.SQLException;

import javax.naming.NamingException;

import junit.framework.TestCase;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.ui.ModelMap;

import project.jun.config.HoConfig;
import project.jun.exception.HoException;
import project.jun.was.HoModel;
import project.jun.was.parameter.HoJUnitParameter;
import project.jun.was.parameter.HoParameter;
import project.jun.was.parameter.HoParameterMap;

import com.base.system.delegate.SampleDelegate;

public class DBTest {

	public static void main(String [] args) {
		SampleDelegate delegate = null;

		String actionFlag = "excel";
		HoModel model = new HoModel(new ModelMap());
		
		HoJUnitParameter parameter = new HoJUnitParameter();
		
		HoParameterMap hoParameterMap = new HoParameterMap();
		
		HoConfig hoConfig = null;

		hoParameterMap.put("p_action_flag", actionFlag);
		hoParameterMap.put("PRE_COURSE_SQ", "adfsdfasd");
		hoParameterMap.put("BASIS_COURSE_SQ", new String[]{"afds", "121", "aflsdjf"});
		hoParameterMap.put("COURSE_SQ", "1343556");
		hoParameterMap.put("EDU_YEAR", "1343556");

		parameter.setHoParameterMap(hoParameterMap);

		String applicationContexts[] = {
				"project/config/applicationContext.xml",
				"project/config/applicationContext-aop.xml",
				"project/config/applicationContext-cache.xml",
				"project/config/applicationContext-dao.xml",
				"project/config/junit-applicationContext-db.xml",
				"project/config/applicationContext-tx.xml",
				"project/config/applicationContextDelegate.xml",
				"project/config/applicationContextDelegate-sample.xml"

		};

		ApplicationContext context = new ClassPathXmlApplicationContext(applicationContexts);

		delegate = (SampleDelegate) context.getBean("SampleDelegate");

		hoConfig = (HoConfig) context.getBean("config");


		delegate.excel(actionFlag, model, parameter, hoConfig);
	}
}
