package project.jun.log;

import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import org.apache.log4j.DailyRollingFileAppender;
import org.apache.log4j.MDC;
import org.apache.log4j.spi.LoggingEvent;

/**
 * @author  sks
 */
public class HoFileAppender extends DailyRollingFileAppender {
	/**
	 * @uml.property  name="mdcName"
	 */
	private String mdcName;

	private Map map = new HashMap();

	@Override
	public synchronized void doAppend(LoggingEvent event) {
		Object key = MDC.get(getMdcName());
		if (key == null) {
			super.doAppend(event);
			return;
		}
		String serviceName = key.toString();
		if (serviceName != null && serviceName.length() > 0 && !map.containsKey(serviceName)) {
			try {
				String s_fileName = fileName.substring(0, fileName.lastIndexOf('.'));
				String s_extName = fileName.substring(fileName.lastIndexOf('.'));

				DailyRollingFileAppender dailyRollingFileAppender = new DailyRollingFileAppender(layout, s_fileName + "_" + serviceName + s_extName, getDatePattern());
				map.put(serviceName, dailyRollingFileAppender);
			} catch (IOException e) {
			}
		}
		DailyRollingFileAppender ap = (DailyRollingFileAppender) map.get(serviceName);
		if (ap != null)
			ap.doAppend(event);
		else
			super.append(event);
	}

	@Override
	public synchronized void close() {
		for (Iterator iter = map.values().iterator(); iter.hasNext();) {
			DailyRollingFileAppender appender = (DailyRollingFileAppender) iter.next();
			appender.close();
		}
		super.close();
	}

	/**
	 * @param mdcName
	 * @uml.property  name="mdcName"
	 */
	public void setMdcName(String mdcName) {
		this.mdcName = mdcName;
	}

	/**
	 * @return
	 * @uml.property  name="mdcName"
	 */
	public String getMdcName() {
		return mdcName;
	}
}
