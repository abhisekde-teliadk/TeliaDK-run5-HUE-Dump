select ban, subscriber_no, count(*) from base_equation_work_service_agreement_subscr_joined where
service_type in ('O') and  substr(SOC,1,2) in ('OS') and substr(SOC,3,2) in ('CA', 'CB', 'CC', 'CD','B1', 'B2', 'B3', 'B4')
and now() < expiration_date
group by ban, subscriber_no
having count(*)>1
;

select ban, subscriber_no,count(*) 
from base_equation_work_active_service as sx 
where
  now() < sx.optional_expiration_date
group by ban, subscriber_no--and
 -- substring(sx.optional_soc, 1, 3) = substring(was.optional_soc, 1, 3) and
 -- sx.optional_soc <> was.optional_soc

/*
*****
Vysledny data set
*****
*/
select distinct * from base_equation_work_optional_container where subscriber_id=15447684
--and now()<end_date
;

-- subscriber_id=15447684 => subscriber_no='GSM04551464605' and ban=945579118
select * from base_equation_work_optional_service_container_tmp where subscriber_no='GSM04531524510' /*and ban=945579118*/
and service_type in ('O') and  substr(SOC,1,2) in ('OS') and substr(SOC,3,2) in ('CA', 'CB', 'CC', 'CD','B1', 'B2', 'B3', 'B4')
and now() < expiration_date
;

select * from base_equation_work_osc_change where subscriber_no='GSM04531524510';

select * from base_equation_work_service_agreement_subscr_joined where subscriber_no='GSM04531524510' /*and ban=945579118*/
and service_type in ('O') and  substr(SOC,1,2) in ('OS');


select  * from base_equation_work_service_agreement_subscr_joined where 
subscriber_id=15267776
--subscriber_no='GSM04551464605' and ban=945579118
and service_type in ('O') and  substr(SOC,1,2) in ('OS') and substr(SOC,3,2) in ('CA', 'CB', 'CC', 'CD','B1', 'B2', 'B3', 'B4')
and now() < expiration_date;
--and substr(soc, 1, 3) = substr(soc, 1, 3)
--and sx. soc <> service agreement. soc    ;
;

select subscriber_no, customer_id, soc, change_date, lag(change_date,1) over (partition by subscriber_no, customer_id /*, soc*/ order by change_date desc) next_change_date
from (
select distinct subscriber_no, customer_id, soc, 
coalesce(change_date,to_timestamp('99991231','yyyyMMdd')) as change_date 
from ( 
  select
  subscriber_no,
  customer_id,
  substr(soc, 1, 3) as soc,
  effective_date as change_date
  from base.import_fokus_samples_base_service_agreement_sample3 as container
  where
    service_type in ('O') and
    substr(SOC,1,3) in ('OSB', 'OSC')
  union 
  select  
  subscriber_no,
  customer_id,
  substr(soc, 1 , 3) as soc,
  --date_add(expiration_date,1) as change_date
  expiration_date as change_date
  from base.import_fokus_samples_base_service_agreement_sample3 as container
  where
    service_type in ('O') and
    substr(SOC,1,3) in ('OSB', 'OSC')    
  ) x
where
  trunc(change_date,'dd') <= trunc(now(),'dd')
) y where subscriber_no='GSM04531524510';

select * from base_equation_work_optional_service_container_grouped where subscriber_no='GSM04531524510';
--select * from base_equation_work_service_change where  subscriber_no='GSM04522115781';
--select * from base_equation_work_service_agreement_soc_prepared where  subscriber_no='GSM04522115781' and soc='GP4GBS2';
;

select
  subscriber_no,
  customer_id,
  substr(soc, 1, 3) as soc,
  effective_date as change_date
  from base.import_fokus_samples_base_service_agreement_sample3 as container
  where
    service_type in ('O') and
    substr(SOC,1,3) in ('OSB', 'OSC')
    and subscriber_no='GSM04531524510'
  union 
  select  
  subscriber_no,
  customer_id,
  substr(soc, 1 , 3) as soc,
  --date_add(expiration_date,1) as change_date
  expiration_date as change_date
  from base.import_fokus_samples_base_service_agreement_sample3 as container
  where
    service_type in ('O') and
    substr(SOC,1,3) in ('OSB', 'OSC')
    and subscriber_no='GSM04531524510';
select  
  subscriber_no,
  customer_id,
  substr(soc, 1 , 3) as soc,
  date_add(expiration_date,-10) as change_date
  --expiration_date as change_date
  from base.import_fokus_samples_base_service_agreement_sample3 as container
  where
    service_type in ('O') and
    substr(SOC,1,3) in ('OSB', 'OSC')
    and subscriber_no='GSM04531524510'