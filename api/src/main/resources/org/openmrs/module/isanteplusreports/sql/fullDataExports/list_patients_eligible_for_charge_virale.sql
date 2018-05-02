select DISTINCT p.st_id as 'Code ST',
p.given_name as Prénom, p.family_name as Nom, p.telephone as Téléphone
FROM isanteplus.patient p, isanteplus.patient_on_arv parv
WHERE p.patient_id = parv.patient_id
AND (TIMESTAMPDIFF(MONTH,p.date_started_arv,DATE(now())) >= 6)
AND p.patient_id NOT IN(SELECT pl.patient_id FROM isanteplus.patient_laboratory pl
		WHERE pl.test_id = 856 AND pl.test_done=1 AND ((pl.test_result is not null) OR (pl.test_result <> '')))
AND p.patient_id NOT IN(SELECT dreason.patient_id FROM isanteplus.discontinuation_reason dreason WHERE dreason.reason IN(159,1667,159492))
AND p.patient_id NOT IN (SELECT ei.patient_id FROM isanteplus.exposed_infants ei);