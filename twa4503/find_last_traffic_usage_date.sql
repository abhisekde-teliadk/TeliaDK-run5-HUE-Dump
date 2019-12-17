select --ban, 
       --cycle_run_year, 
       --cycle_run_month, 
       subscriber_no, max(call_date)
from base.import_fokus_base_fokus_detail_usage
where unit_measure_code = 'A'
group by subscriber_no
;

select 
count(*) as antal
from (
select ban, cycle_run_year, cycle_run_month, subscriber_no, max(call_date)
from base.import_fokus_base_detail_usage
where unit_measure_code = 'A'
group by ban,cycle_run_year,cycle_run_month,subscriber_no
) as x
;

-- 19.426.768 rows

select count(*)
from   sandbox.ole_find_last_traffic_usage_date
;