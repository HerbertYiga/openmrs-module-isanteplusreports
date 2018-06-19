select cn.name as 'Nom du test', count(DISTINCT lab.patient_id) as Quantité 
FROM openmrs.concept_name cn, isanteplus.patient_laboratory lab
WHERE cn.concept_id=lab.test_id AND locale='fr'
GROUP BY cn.name;