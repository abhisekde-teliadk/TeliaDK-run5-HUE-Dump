SELECT cr.soc, cr.subscriber_no, cr.customer_id,cr.change_date, sc.vas_type
FROM work.vasdata_work_service_change_rate_joined as cr
inner join base.manual_files_base_service_soc as sc
on sc.soc = cr.soc
WHERE sc.vas_type = 'INSURANCE';

SELECT * FROM work.vasdata_work_service_change LIMIT 100;



SELECT * FROM work.vasdata_work_service_rate_sum LIMIT 100;


select sc.soc, sc.subscriber_no, sc.customer_id, sc.change_date, rs.rate_sum
from work.vasdata_work_service_change as sc
left outer join  work.vasdata_work_service_rate_sum as rs
on rs.change_date = sc.change_date
and rs.soc = sc.soc; 

SELECT * FROM work.vasdata_work_service LIMIT 100; 

SELECT * FROM base.manual_files_base_service_soc where vas_type = 'INSURANCE';