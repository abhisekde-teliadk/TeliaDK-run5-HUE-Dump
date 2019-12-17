SELECT  count(*) FROM 
base.import_fokus_base_service_agreement sa 
WHERE 
sa.soc = 'BASIS5';


;
SELECT sa.soc, count(*) FROM 

base.import_fokus_base_service_agreement sa 
WHERE 
sa.soc LIKE 'BASIS5'
AND sa.effective_date < cast('2019-01-01' as TIMESTAMP)
AND sa.expiration_date >= cast('2019-01-01' as TIMESTAMP)
GROUP BY sa.soc
LIMIT 100;