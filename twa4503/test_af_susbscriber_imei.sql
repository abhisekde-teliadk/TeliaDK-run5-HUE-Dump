select count(*) as antal 
from sandbox.adhoc_1149_device_repair_adhoc_1149_cleaned_input;


select *
from sandbox.adhoc_1149_device_repair_adhoc_1149_cleaned_input limit 100
;


SELECT imei,count(*)
FROM analytics.abt_subscriber_imei_history 
group by 1
order by 2 desc
;

SELECT --distinct
*
FROM analytics.abt_subscriber_imei_history 
where imei='350146204834490'
--and   active_record_flag=true
--and end_date > now()
order by imei,
         subscriber_id,
         start_date,
         end_date
;
-- 59 distinct rows
-- 109 rows
-- 23 rows with active_record_flag=true ???
-- 23 rows with end_date > now ???
-- A IMEi can only ba active at one subscriber_id at the time


SELECT * FROM base.import_fokus_base_physical_device LIMIT 100;

select b.imei,
       b.start_date,
       count(*) as antal_imei 
from   sandbox.adhoc_1149_device_repair_adhoc_1149_cleaned_input a,
       base.import_fokus_base_physical_device b 
where  a.imei = b.imei
and    b.start_date <= a.Created_Date_to_COLT
and    b.end_date   >  a.Created_Date_to_COLT
group by 1,2
order  by 3 desc
;


select b.imei,
       b.start_date,
       count(*) as antal_imei 
from   analytics.abt_subscriber_imei_history b 
group by 1,2
order  by 3 desc
;

