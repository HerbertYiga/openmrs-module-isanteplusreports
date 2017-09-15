package org.openmrs.module.isanteplusreports.healthqual;

import org.openmrs.module.isanteplusreports.IsantePlusReportsProperties;
import org.openmrs.module.isanteplusreports.healthqual.model.HealthQualIndicator;
import org.openmrs.module.isanteplusreports.healthqual.model.HealthQualIndicatorOption;
import org.openmrs.module.reporting.report.definition.ReportDefinition;
import org.openmrs.module.reporting.report.definition.service.ReportDefinitionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
public class HealthQualManager {
	
	private static final String[] adultIndicatorsUuid = {
			IsantePlusReportsProperties.HEALTH_QUAL_ADULT_1_INDICATOR_UUID,
			IsantePlusReportsProperties.HEALTH_QUAL_ADULT_2_INDICATOR_UUID,
			IsantePlusReportsProperties.HEALTH_QUAL_ADULT_3_INDICATOR_UUID,
			IsantePlusReportsProperties.HEALTH_QUAL_ADULT_4_INDICATOR_UUID,
			IsantePlusReportsProperties.HEALTH_QUAL_ADULT_8_INDICATOR_UUID,
			IsantePlusReportsProperties.HEALTH_QUAL_ADULT_9_INDICATOR_UUID,
			IsantePlusReportsProperties.HEALTH_QUAL_ADULT_10_INDICATOR_UUID,
			IsantePlusReportsProperties.HEALTH_QUAL_ADULT_11_INDICATOR_UUID,
			IsantePlusReportsProperties.HEALTH_QUAL_ADULT_12_INDICATOR_UUID,
			IsantePlusReportsProperties.HEALTH_QUAL_ADULT_13_INDICATOR_UUID,
			IsantePlusReportsProperties.HEALTH_QUAL_ADULT_14_INDICATOR_UUID,
			IsantePlusReportsProperties.HEALTH_QUAL_ADULT_15_INDICATOR_UUID,
			IsantePlusReportsProperties.HEALTH_QUAL_ADULT_16_INDICATOR_UUID
	};
	
	private static final String[] pediatricIndicatorsUuid = {
			IsantePlusReportsProperties.HEALTH_QUAL_PEDIATRIC_1_INDICATOR_UUID,
			IsantePlusReportsProperties.HEALTH_QUAL_PEDIATRIC_2_INDICATOR_UUID,
			IsantePlusReportsProperties.HEALTH_QUAL_PEDIATRIC_3_INDICATOR_UUID,
			IsantePlusReportsProperties.HEALTH_QUAL_PEDIATRIC_4_INDICATOR_UUID,
			IsantePlusReportsProperties.HEALTH_QUAL_PEDIATRIC_6_INDICATOR_UUID,
			IsantePlusReportsProperties.HEALTH_QUAL_PEDIATRIC_11_INDICATOR_UUID,
			IsantePlusReportsProperties.HEALTH_QUAL_PEDIATRIC_12_INDICATOR_UUID,
			IsantePlusReportsProperties.HEALTH_QUAL_PEDIATRIC_13_INDICATOR_UUID

	};
	
	private Map<String, HealthQualIndicatorOption> options = new HashMap<String, HealthQualIndicatorOption>();
	
	@Autowired
	private ReportDefinitionService reportDefinitionService;
	
	public HealthQualManager() {
		createIndicatorOptions();
	}
	
	public List<HealthQualIndicator> getAdultIndicators() {
		return uuidToReportDefinition(Arrays.asList(adultIndicatorsUuid));
	}
	
	public List<HealthQualIndicator> getPediatricIndicators() {
		return uuidToReportDefinition(Arrays.asList(pediatricIndicatorsUuid));
	}
	
	private List<HealthQualIndicator> uuidToReportDefinition(List<String> uuids) {
		List<HealthQualIndicator> indicators = new ArrayList<HealthQualIndicator>();
		for (String uuid : uuids) {
			ReportDefinition reportDefinition = reportDefinitionService.getDefinitionByUuid(uuid);
			HealthQualIndicatorOption option = options.get(uuid);
			if (reportDefinition != null) {
				indicators.add(new HealthQualIndicator(reportDefinition, option));
			}
		}
		return indicators;
	}
	
	private void createIndicatorOptions() {
		String[] periodMonthsValues = { "6", "12", "24", "48", "60" };
		HealthQualIndicatorOption period = new HealthQualIndicatorOption("periodMonths", "period", periodMonthsValues);

		// adult options
		options.put(IsantePlusReportsProperties.HEALTH_QUAL_ADULT_1_INDICATOR_UUID, period);
		// pediatric options
		options.put(IsantePlusReportsProperties.HEALTH_QUAL_PEDIATRIC_1_INDICATOR_UUID, period);
	}
}
