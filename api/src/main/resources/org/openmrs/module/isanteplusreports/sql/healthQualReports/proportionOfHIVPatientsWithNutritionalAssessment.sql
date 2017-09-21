SELECT
	COUNT(
		DISTINCT CASE WHEN (
			p.gender = 'F' and
			p.patient_id IN ( -- BMI is filled
				SELECT pv.patient_id FROM isanteplus.patient_visit pv
				WHERE pv.patient_bmi IS NOT NULL
				AND pv.visit_date BETWEEN :startDate AND :endDate
			)
		) THEN p.patient_id else null END
	) AS 'femaleNumerator',
    COUNT(
		DISTINCT CASE WHEN (
			p.gender = 'M' AND
			p.patient_id IN ( -- BMI is filled
				SELECT pv.patient_id FROM isanteplus.patient_visit pv
				WHERE pv.patient_bmi IS NOT NULL
				AND pv.visit_date BETWEEN :startDate AND :endDate
			)
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
WHERE
  p.vih_status = 1 -- HIV+
  AND p.patient_id IN (
    SELECT pv.patient_id
    FROM isanteplus.patient_visit pv
    WHERE
      pv.visit_date BETWEEN :startDate AND :endDate
  )
  AND p.patient_id NOT IN ( -- Exclude deceased (159), discontinuations (1667), transfer (159492)
      SELECT discon.patient_id
      FROM isanteplus.discontinuation_reason discon
      WHERE discon.reason IN (159,1667,159492)
  ) AND TIMESTAMPDIFF(YEAR, p.birthdate, :endDate) > 14; -- adult