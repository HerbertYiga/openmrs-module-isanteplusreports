SELECT
	COUNT(
		DISTINCT CASE WHEN (
			p.gender = 'F'
			AND p.patient_id
            AND pp.rx_or_prophy = 163768
            AND pp.drug_id = 105281
            AND (pp.visit_date BETWEEN :startDate AND :endDate)
		) THEN p.patient_id else null END
	) AS 'femaleNumerator',
    COUNT(
		DISTINCT CASE WHEN (
			p.gender = 'M'
            AND p.patient_id
            AND pp.rx_or_prophy = 163768
            AND pp.drug_id = 105281
            AND (pp.visit_date BETWEEN :startDate AND :endDate)
		) THEN p.patient_id else null END
	) AS 'maleNumerator',
	COUNT(
		DISTINCT CASE WHEN (
			p.gender = 'F'
		) THEN p.patient_id else null END
	) AS 'femaleDenominator',
    COUNT(
		DISTINCT CASE WHEN (
			p.gender = 'M'
		) THEN p.patient_id else null END
	) AS 'maleDenominator'
FROM
	isanteplus.patient p
	LEFT JOIN isanteplus.patient_prescription pp
	ON p.patient_id = pp.patient_id
WHERE
	p.vih_status = 1
	AND p.patient_id IN (
		SELECT pv.patient_id
		FROM isanteplus.patient_visit pv
		WHERE
			DATE(pv.visit_date) BETWEEN :startDate AND :endDate
			OR DATE(pp.visit_date) BETWEEN :startDate AND :endDate
	)
    AND p.patient_id IN (
		SELECT poa.patient_id
        FROM isanteplus.patient_on_arv poa
	)
	AND p.patient_id NOT IN (
		SELECT discon.patient_id
        FROM isanteplus.discontinuation_reason discon
        WHERE discon.reason IN (159,1667,159492)
	) AND TIMESTAMPDIFF(YEAR, p.birthdate, :endDate) > 14; -- adult