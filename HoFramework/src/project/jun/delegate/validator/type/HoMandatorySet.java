package project.jun.delegate.validator.type;

import java.util.Iterator;
import java.util.Set;

import project.jun.config.HoConfig;
import project.jun.dao.parameter.HoQueryParameterMap;
import project.jun.delegate.validator.HoViolationMap;
import project.jun.was.HoModel;
import project.jun.was.parameter.HoParameterMap;

public class HoMandatorySet {

	public HoViolationMap valiate(Set<String> keySet, String actionFlag, HoModel model, HoParameterMap hoParameterMap, HoConfig hoConfig, HoQueryParameterMap value) {
		HoViolationMap hoViolationMap = new HoViolationMap();

		Iterator<String> iter = keySet.iterator();

		String key = null;

		while(iter.hasNext()) {
			key = iter.next();

			if( !hoParameterMap.containsKey(key) ) {
				hoViolationMap.setValue(key, key + "는 반드시 필요합니다.-null");
			} else {
				Object obj = hoParameterMap.get(key);

				if( obj instanceof String []) {
					if( ((String[])obj).length == 0 ) {
						hoViolationMap.setValue(key, key + "는 반드시 필요합니다.[]");
					}
				} else if( obj instanceof String) {
					if("".equals((String)obj)) {
						hoViolationMap.setValue(key, key + "는 반드시 필요합니다.");
					}
				}
			}
		}

		return hoViolationMap;

	}
}
