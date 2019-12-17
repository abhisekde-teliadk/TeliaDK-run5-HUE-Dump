create table sandbox.ole_3_md_trafik as 
select ban, 
       subscriber_no,
       year(call_date) as YYYY,
       round(sum(case when month(call_date) = 1 then at_call_dur_sec end)/1024/1024/1014) as MM_01_GB_round,
       round(sum(case when month(call_date) = 2 then at_call_dur_sec end)/1024/1024/1014) as MM_02_GB_round,
       round(sum(case when month(call_date) = 3 then at_call_dur_sec end)/1024/1024/1014) as MM_03_GB_round,
       round(sum(case when month(call_date) = 4 then at_call_dur_sec end)/1024/1024/1014) as MM_04_GB_round
      
from base.import_fokus_base_detail_usage
where unit_measure_code = 'A'
--and   subscriber_no = 'GSM04540346801
and   year(call_date)  = 2019
group by 1,2,3
;
-- Inserted 1.225.978 row(s)

select count(*)
from   sandbox.ole_3_md_trafik
;


select *
from   sandbox.ole_3_md_trafik
;