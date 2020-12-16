/* 25 Nombre de patients ARV conseillés en PF*/
SELECT fp.patient_id
FROM isanteplus.patient p, isanteplus.patient_on_arv pa, isanteplus.family_planning fp 
     WHERE p.patient_id = pa.patient_id  
     AND pa.patient_id = fp.patient_id
     AND DATE(fp.encounter_date) BETWEEN :startDate AND :endDate
     AND p.voided = 0
     AND fp.voided = 0;