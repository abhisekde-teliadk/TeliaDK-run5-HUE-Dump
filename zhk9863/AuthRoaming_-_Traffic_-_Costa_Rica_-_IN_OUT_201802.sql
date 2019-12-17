SELECT call_direction_id, count(*) FROM base_equation_work_traffic_partitioned 
WHERE 
event_month = '201802'
AND
roaming_country_id = 53
GROUP BY call_direction_id
LIMIT 100;


SELECT call_direction_id, count(*) FROM work.reporting_to_authorities_work_traffic_roaming_part
WHERE 
event_month = '201802'
AND
name = 'Costa Rica'
GROUP BY call_direction_id
LIMIT 100;