SELECT pl.patient_id            								            
FROM isanteplus.patient_status_arv ps ,isanteplus.patient_laboratory pl ,isanteplus.patient_on_art pat
    WHERE ps.patient_id = pl.patient_id
    AND pl.patient_id = pat.patient_id
	 AND ps.id_status IN (6,8)
	 AND pl.test_id IN (856,1305)
	 AND pat.breast_feeding = 1
    AND ps.date_started_status BETWEEN :startDate AND :endDate 
	 AND pat.viral_load_targeted = 1
	 AND pat.viral_load_targeted_result < 1000
	  AND TIMESTAMPDIFF(MONTH, pl.date_test_done ,:endDate) >= 12;