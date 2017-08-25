package org.openmrs.module.isanteplusreports.conventer;

import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.JavaType;
import org.openmrs.module.isanteplusreports.model.HealthQualIndicator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.List;

@Component
public class StringToHealthQualIndicatorListConverter implements Converter<String, List<HealthQualIndicator>> {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(StringToHealthQualIndicatorListConverter.class);
	
	@Override
	public List<HealthQualIndicator> convert(String json) {
		ObjectMapper mapper = new ObjectMapper();
		JavaType type = mapper.getTypeFactory().constructCollectionType(List.class, HealthQualIndicator.class);
		List<HealthQualIndicator> list = null;
		try {
			list = mapper.readValue(json, type);
		}
		catch (IOException ex) {
			LOGGER.error("Cannot convert json to List<HealthQualIndicator>>. Null was returned");
		}
		return list;
	}
}
