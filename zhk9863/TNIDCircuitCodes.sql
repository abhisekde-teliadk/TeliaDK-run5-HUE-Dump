SELECT strleft(provider_circuit_no,2) as code, techinfo_original_dataset, count(*) as cnt   FROM work.contr_obligations_tdc_work_techinfo_union GROUP BY code, techinfo_original_dataset ORDER BY cnt DESC LIMIT 100;

SELECT strleft( tnid_circuit_number,2) as code, count(*) as cnt FROM work.contr_obligations_tdc_work_techinfo_tnid_fo_joined GROUP BY code ORDER BY cnt DESC LIMIT 100;