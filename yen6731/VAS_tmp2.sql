select 
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
from
  analytics.abt_service_history as Service
    join work.base_equation_work_subscriber as subscriber on
        subscriber.Subscriber_id = Service.Subscriber_id
        and now() between subscriber.start_date and subscriber.end_date
    join
        base.manual_files_base_man_vas_soc as vas_soc on
            vas_soc.vas_soc = service.soc
    left outer join    
        base.manual_files_base_man_tertium_servicestatus_vw as status on
            status.Bss_subscriber_id = subscriber.Subscriber_id and
            status.Product_name = service.soc and
            status.creation_date <= now()
    where now() between service.effective_date and Service.expiration_date ;
select Bss_subscriber_id,Product_name, active_state  from base.manual_files_base_man_tertium_servicestatus_vw;    
    select  bss_subscriber_id  from base.manual_files_base_man_tertium_servicestatus_vw where active_state=0; --13143215
    
    
    