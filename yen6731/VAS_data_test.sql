
-- data without tertium
select 
trunc(now(), 'dd') as today,
--count ( distinct Service.subscriber_id),
--count (status.Bss_subscriber_id),
VAS_SOC.VAS_SOC_GROUP,
Service.SOC,
Service.SOC_Description,
Subscriber.Product_Subgroup
--status.Deal,
--status.Status_date

from 
analytics.abt_service_history as Service  
    join work.base_equation_work_subscriber as subscriber on
        subscriber.Subscriber_id = Service.Subscriber_id
        and trunc(now(),'dd') between effective_date and expiration_date
        and trunc(now(),'dd') between start_date and end_date
    join
        base.manual_files_base_man_vas_soc as vas_soc on
            vas_soc.vas_soc = service.soc     
   /* join base.manual_files_base_man_tertium_servicestatus_vw status on
        Bss_subscriber_id = subscriber.Subscriber_id and
        Product_name = service.soc*/
where service.subscriber_id=10739380;

-- data with joined tertium
select 
trunc(now(), 'dd') as today,
--count ( distinct Service.subscriber_id),
--count (status.Bss_subscriber_id),
VAS_SOC.VAS_SOC_GROUP,
Service.SOC,
Service.SOC_Description,
Subscriber.Product_Subgroup,
status.Deal,
status.Status_date

from 
analytics.abt_service as Service  
    join work.base_equation_work_subscriber as subscriber on
        subscriber.Subscriber_id = Service.Subscriber_id
        and trunc(now(),'dd') between start_date and end_date
    join
        base.manual_files_base_man_vas_soc as vas_soc on
            vas_soc.vas_soc = service.soc     
    left outer join base.manual_files_base_man_tertium_servicestatus_vw status on
        Bss_subscriber_id = subscriber.Subscriber_id and
        Product_name = service.soc
where service.subscriber_id=10739380
and status.creation_date<=now()
;

select * from contr_obligations_vas_vas_overview where subscriber_id=10739380;

-- joined all except subscriber
select * from base.manual_files_base_man_tertium_servicestatus_vw where bss_subscriber_id=10739380 and product_name in(
select soc from analytics.abt_service service
join base.manual_files_base_man_vas_soc as vas_soc on
    vas_soc.vas_soc = service.soc where subscriber_id=10739380
)
;
select product_name, count(*) from base.manual_files_base_man_tertium_servicestatus_vw group by product_name having count(*)>1 order by product_name asc;

select count(*) from (
select bss_subscriber_id, product_name, rank() over (partition by bss_subscriber_id, product_name order by creation_date desc) as rnk from base.manual_files_base_man_tertium_servicestatus_vw
) x where rnk=1;

select 

trunc(now(), 'dd') as today,
--count ( distinct Service.subscriber_id),
--count (status.Bss_subscriber_id),
--VAS_SOC.VAS_SOC_GROUP,
Service.SOC,
Service.SOC_Description,
Subscriber.Product_Subgroup
--status.Deal,
--status.Status_date
from 
analytics.abt_service as Service  
    join work.base_equation_work_subscriber as subscriber on
        subscriber.Subscriber_id = Service.Subscriber_id
   -- and trunc(now(),'dd') between start_date and end_date
    
where subscriber.subscriber_id=10739380;

select * from work.contr_obligations_vas_work_vas_soc_joined_windows where bss_subscriber_id=10739380;
select * from work.contr_obligations_vas_vas_overview_all where bss_subscriber_id=10739380;

-- TERTIUM
select * from base.manual_files_base_man_tertium_servicestatus_vw where bss_subscriber_id=10739380;


select * from analytics.abt_service_history
join base.manual_files_base_man_vas_soc
on soc=vas_soc
where subscriber_id=14332318;

select count(*) from contr_obligations_vas_work_service_history_soc_join;  -- 3.326.998
select * from contr_obligations_vas_work_service_history_soc_join where subscriber_id=14332318 order by soc asc;

select * from contr_obligations_vas_work_service_history_soc_join
join base.manual_files_base_man_d_calendar
on date_as_date between effective_date and expiration_date
and date_as_date <= now()
where --date_as_date => '2018-01-01'
 subscriber_id=14332318;



select min(date_as_date) as min_date, max(date_as_date) as max_date from contr_obligations_vas_work_service_history_daily_join;
select * from contr_obligations_vas_work_service_history_daily_join where subscriber_id=14332318 order by date_as_date asc;

select count(*) from contr_obligations_vas_work_service_history_daily_join; -- 145.453.949

select date_as_date as date1, subscriber_id, bss_subscriber_id, vas_soc_group,soc,soc_description, deal,status_date,activated, effective_date, expiration_date, product_name from contr_obligations_vas_work_vas_overview_prepared where subscriber_id=14061514;

select distinct product_name from contr_obligations_vas_work_vas_overview_prepared where subscriber_id=3542972;
select * from base.manual_files_base_man_tertium_servicestatus_vw where bss_subscriber_id=14061514 order by creation_date desc;
select bss_subscriber_id, count(*) from base.manual_files_base_man_tertium_servicestatus_vw group by bss_subscriber_id having count(*) > 1;

select * from contr_obligations_vas_work_vas_overview_prepared where bss_subscriber_id=14332318;

SELECT 
    *,
    COUNT(subscriber_id) OVER (date_as_date) AS subscriber_id_count,
    COUNT(bss_subscriber_id) OVER (date_as_date) AS bss_subscriber_id_count
  FROM work.contr_obligations_vas_work_vas_overview_prepared;
  
  
select * FROM work.contr_obligations_vas_work_vas_overview_prepared where vas_soc in ('TSCBTC3',
'OSCTSEC',
'TSCBTC',
'OSBTSEC',
'TSCBTB3') and date_as_date=to_date('2018-01-01 00:00:00');--subscriber_id=13446645
select * from base.manual_files_base_man_tertium_servicestatus_vw where bss_subscriber_id=13446645;


select count(*) FROM work.contr_obligations_vas_work_vas_overview_prepared
    where vas_soc in (
        select vas_soc from base.manual_files_base_man_vas_soc where vas_soc_group='Office365')
    and date_as_date=to_date('2018-01-04 00:00:00')
    and bss_subscriber_id is not null;--subscriber_id=14805487

select * from base.manual_files_base_man_tertium_servicestatus_vw where bss_subscriber_id=15622239;

select vas_soc from base.manual_files_base_man_vas_soc where vas_soc_group='Office365';

select * from contr_obligations_vas_work_vas_overview_grouped_by_subscriber_id where subscriber_id_count!=bss_subscriber_id_count and bss_subscriber_id_count=2 and date_as_date=to_date('2018-03-13 00:00:00');
select * from contr_obligations_vas_work_vas_overview_grouped_by_subscriber_id_prepared where number_of_subscribers_from_fokus!=number_of_subscribers_from_tertium and number_of_subscribers_from_tertium=2 and "date"=to_date('2018-03-13 00:00:00');

select * FROM work.contr_obligations_vas_work_vas_overview_prepared where soc='OSCRLH' and date_as_date=to_date('2018-03-13 00:00:00');

select * from contr_obligations_vas_work_service_history_daily_join sh
join work.base_equation_work_subscriber sub
on sub.subscriber_id=sh.subscriber_id;

where date_as_date=to_date('2018-03-13 00:00:00') and soc='OSCRLH';

select * from analytics.abt_vas_overview_daily where date_as_date=to_date('2018-08-23') and vas_soc_group='ESP' order by status_date_trunc desc;

select distinct deal from analytics.abt_vas_overview_daily;
select * from contr_obligations_vas_work_vas_overview_daily where subscriber_id_count<>bss_subscriber_id_count;

