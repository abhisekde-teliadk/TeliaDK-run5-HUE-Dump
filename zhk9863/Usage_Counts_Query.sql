select call_date, cycle_code, count(*) 
from base.import_fokus_base_detail_usage 
where cycle_code = 33
group by call_date, cycle_code 
order by 1;