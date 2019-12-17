SELECT  strleft(s.internal_circuit_id,2) aa, count(*) 

FROM 

base.import_fokus_base_subscriber s
GROUP BY strleft(s.internal_circuit_id,2) 
LIMIT 100;

;

SELECT product_group, count(*)
FROM abt_subscriber_current
GROUP BY product_group
ORDER BY product_group ASC
LIMIT 100
;


SELECT strleft(telia_circuit_id,2) as code, techinfo_original_dataset, count(*) as cnt   FROM analytics.abt_circuit_bridge GROUP BY code, techinfo_original_dataset ORDER BY cnt DESC LIMIT 100;


SELECT strleft(foreign_circuit,2) as code, techinfo_original_dataset, count(*) as cnt   FROM analytics.abt_circuit_bridge GROUP BY code, techinfo_original_dataset ORDER BY cnt  DESC LIMIT 100;
