SELECT * 
FROM 
base.import_fokus_base_service_agreement AS SA
WHERE SA.service_type IN ('R', 'O', 'S')
and trunc( SA.effective_date, 'dd') = to_date('2018-03-03')
and trunc( SA.expiration_date, 'dd') = to_date('2018-03-03');


SELECT count(sh.soc)
FROM analytics.abt_service_history AS sh
where trunc( sh.effective_date, 'dd') = to_date('2018-03-03')
and trunc( sh.expiration_date, 'dd') = to_date('2018-03-02')
group by sh.soc;