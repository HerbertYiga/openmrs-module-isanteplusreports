SELECT ps.patient_id
FROM isanteplus.patient_status_arv ps
    WHERE ps.id_status =1
    AND ps.date_started_status BETWEEN :startDate AND :endDate;