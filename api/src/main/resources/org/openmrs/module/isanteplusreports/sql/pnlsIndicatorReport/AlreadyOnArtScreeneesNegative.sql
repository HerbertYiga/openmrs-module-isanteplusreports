SELECT pa.patient_id
   FROM isanteplus.patient_on_art pa
	    WHERE pa.tb_screen =1
	    AND pa.date_started_arv < :startDate
		 AND pa.tb_status = "NEGATIVE" ;