SELECT call_direction_id, count(*) FROM work.base_equation_work_traffic_partitioned 
WHERE 
event_month = '201802'
AND
roaming_country_id = 53
GROUP BY call_direction_id
LIMIT 100; 

SELECT * FROM work.base_equation_work_traffic_partitioned LIMIT 100;