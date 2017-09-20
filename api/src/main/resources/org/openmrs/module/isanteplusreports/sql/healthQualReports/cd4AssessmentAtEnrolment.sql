SELECT
    COUNT(
        DISTINCT CASE WHEN (
            p.gender = 'F'
            AND pl.test_id IN ('730', '5497') 	-- CD4 test (in % || in count unit)
            AND pl.date_test_done IS NOT NULL 	-- make sure that the test is not NULL test
            AND pl.test_result IS NOT NULL		-- make sure that the test is not NULL test
            AND TIMESTAMPDIFF(DAY, pv.visit_date, pl.date_test_done) <= 60
        ) THEN p.patient_id ELSE null END
    ) AS 'femaleNumerator',
    COUNT(
        DISTINCT CASE WHEN (
            p.gender = 'M'
			AND pl.test_id IN ('730', '5497') 	-- CD4 test (in % || in count unit)
            AND pl.date_test_done IS NOT NULL 	-- make sure that the test is not NULL test
            AND pl.test_result IS NOT NULL		-- make sure that the test is not NULL test
            AND TIMESTAMPDIFF(DAY, pv.visit_date, pl.date_test_done) <= 60
        ) THEN p.patient_id ELSE null END
    ) AS 'maleNumerator',
    COUNT(
        DISTINCT CASE WHEN (
            p.gender = 'F'
        ) THEN p.patient_id ELSE null END
    ) AS 'femaleDenominator',
    COUNT(
        DISTINCT CASE WHEN (
            p.gender = 'M'
        ) THEN p.patient_id ELSE null END
	) AS 'maleDenominator'
FROM isanteplus.patient p
	INNER JOIN isanteplus.patient_visit pv ON p.patient_id = pv.patient_id
    LEFT JOIN isanteplus.patient_laboratory pl ON p.patient_id = pl.patient_id -- join by patient_id, so that we can look for the first HIV visit (numerator)
WHERE p.vih_status = '1' -- HIV+ patient
	AND pv.encounter_type IN ('1', '9') -- adult or pediatric first HIV visit
    AND pv.visit_date BETWEEN :startDate AND :endDate -- the date of first visit
	AND p.patient_id NOT IN (
		SELECT discon.patient_id
        FROM isanteplus.discontinuation_reason discon
        WHERE discon.reason IN ('159', '1667', '159492') -- not deceased, discontinued and transferred
	)
