package org.openmrs.module.isanteplusreports.model;

import java.util.Map;

public class HealthQualIndicator {
	
	private String uuid;
	
	private Map<String, Object> option;
	
	public String getUuid() {
		return uuid;
	}
	
	public void setUuid(String uuid) {
		this.uuid = uuid;
	}
	
	public Map<String, Object> getOption() {
		return option;
	}
	
	public void setOption(Map<String, Object> option) {
		this.option = option;
	}
}