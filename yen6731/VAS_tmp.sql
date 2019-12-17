select * from contr_obligations_vas_vas_overview_join_all;


select * from base.manual_files_base_man_tertium_servicestatus_vw where bss_subscriber_id=1469162;

select * from analytics.abt_subscribed_product where subscriber_id=1469162;
select * from analytics.abt_subscribed_product_history where subscriber_id=1469162;

select * from analytics.abt_service where subscriber_id=1469162;
select * from analytics.abt_service_history where subscriber_id=1469162;

--dissapeared, why?
subscriber_id=121850;
subscriber_id=11744527;

select * from contr_obligations_vas_VAS_overview where number_of_subscribers_from_fokus = 2;

subscriber_id=7832668;

select trunc(sysdate) as Day from dual;
(trunc(sysdate) as Day from dual) as Day;

-- ***** USED SOURCES *******
select * from work.base_equation_work_subscriber;
select * from analytics.abt_service_history;
select * from base.manual_files_base_man_vas_soc;
select * from base.manual_files_base_man_tertium_servicestatus_vw;
-- ***** USED SOURCES

select Bss_subscriber_id,Product_name, active_state  from base.manual_files_base_man_tertium_servicestatus_vw;    
select bss_subscriber_id  from base.manual_files_base_man_tertium_servicestatus_vw where active_state=0; --13143215

Day. Day between Subscriber. Start_date and Subscriber. End_Date and;

select distinct
--*
trunc(now(), 'dd') as today,
--count ( distinct Service.subscriber_id),
--count (status.Bss_subscriber_id),
VAS_SOC.VAS_SOC_GROUP,
Service.SOC,
Service.SOC_Description,
Subscriber.Product_Subgroup,
status.Deal,
status.Status_date,
--case 
status.Active_state
--  when 0, 2, 4 then 'Y'
  --else 'N'
from analytics.abt_service_history as Service  
    join work.base_equation_work_subscriber as subscriber on
        subscriber.Subscriber_id = Service.Subscriber_id
       -- and trunc(now(),'dd') between effective_date and expiration_date
    -- and trunc(now(),'dd') between start_date and end_date
    join
        base.manual_files_base_man_vas_soc as vas_soc on
            vas_soc.vas_soc = service.soc 
    left outer join    
        base.manual_files_base_man_tertium_servicestatus_vw as status on
            status.Bss_subscriber_id = subscriber.Subscriber_id and
            status.Product_name = service.soc and
            status.creation_date <= trunc(now(),'dd')
           and RANK () OVER (PARTITION BY Bss_subscriber_id, Product_name ORDER BY creation_date desc) as rank
    ;
 Subscriber_id=10739380   count 2 
;
select * from base.manual_files_base_man_tertium_servicestatus_vw where bss_subscriber_id=10739380;
;

    not exists (select * from tertium. Servicestatus_vw as sx joined on
      sx. Bss_subscriber_id = subscriber. Subscriber_id and
      sx. Product_name = service. Soc and
      sx. creation_date <= day. day and
      sx. creation_date > status. creation_date)"
