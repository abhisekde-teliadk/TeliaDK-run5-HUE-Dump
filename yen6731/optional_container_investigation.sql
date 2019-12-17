-- service_agreement original
select * from base_equation_work_service_agreement_subscr_joined where subscriber_no='GSM04531524510';
-- service_agreement with condition
select * from base_equation_work_service_agreement_subscr_joined where subscriber_no='GSM04531524510'
and service_type in ('O') and  substr(SOC,1,2) in ('OS');

/*select * from base.import_fokus_samples_base_service_agreement_sample3 where subscriber_no='GSM04550385656'
and service_type in ('O') and  substr(SOC,1,2) in ('OS') and subscriber_id=15974230 order by subscriber_id desc;*/

-- OSC_change entity
;
select * from base_equation_work_OSC_change where subscriber_no='GSM04520481480';

-- 2.
select * from base_equation_work_optional_service_container_prepared where subscriber_no='GSM04520481480';

-- Last receipe - impala receipe doing hard coded SQL
select count(*) from base_equation_work_optional_service_container;
select * from base_equation_work_optional_service_container where subscriber_no='GSM04520481480';



select
 cp.*,
 nvl(cnt.cnt,0) as service_active,
 2*nvl(cnt.cnt,0) as used_points
  from base_equation_work_optional_service_container_prepared cp
  left outer join
  (
   select
   sx.ban,
   sx.subscriber_no,
   osc.soc,
   osc.change_date,
   count(*) as cnt
   from       
     base_equation_work_osc_change osc left outer join
     base_equation_work_service_agreement_subscr_joined sx on
       substr(sx.soc,1,3) = osc.soc and
	   sx.ban = osc.customer_id and 
	   sx.subscriber_no = osc.subscriber_no and
       --sx.service_type in ('O') and
       substr(sx.SOC,3,2) NOT in ( 
         'CA', 'CB', 'CC', 'CD',
         'B1', 'B2', 'B3', 'B4') and
     osc.change_date between sx.effective_date and sx.expiration_date
   group by
     sx.ban,
     sx.subscriber_no,
     osc.soc,
     osc.change_date
   ) as cnt
   on
     cp.ban = cnt.ban and
     cp.subscriber_no = cnt.subscriber_no and
     substr(cp.soc,1,3) = cnt.soc and
     trunc(cp.oscc_change_date,'dd')=trunc(cnt.change_date,'dd')
     where cp.subscriber_no='GSM04524620478';

select subscriber_no, soc, effective_date, service_type, expiration_date from base_equation_work_service_agreement_subscr_joined where subscriber_no='GSM04524620478' and substr(soc,1,3)='OSB' order by effective_date desc;

select * from base_equation_work_service_agreement_subscr_joined where 

GSM04524620478




-- count(*) entity
select * from base_equation_work_optional_service_container_grouped where subscriber_no='GSM04531524510';


-- OSC_change entity SQL
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
  from base_equation_work_service_agreement_sample3_prepared as container
  where
    service_type in ('O') and
    substr(SOC,1,3) in ('OSB', 'OSC')
  union 
  select  
  subscriber_no,
  customer_id,
  substr(soc, 1 , 3) as soc,
  date_add(expiration_date,1) as change_date
  --expiration_date as change_date
  from base_equation_work_service_agreement_sample3_prepared as container
  where
    service_type in ('O') and
    substr(SOC,1,3) in ('OSB', 'OSC')    
  ) x
where
  trunc(change_date,'dd') <= trunc(now(),'dd')
) y where subscriber_no='GSM04531524510';

select count(*) from base_equation_work_optional_service_container_tmp union 
select count(*) from base_equation_work_service_agreement_subscr_joined union
select count(*) from base_equation_work_optional_service_container_grouped;
select count(*) from base_equation_work_service_agreement_subscr_joined;
select count(*) from base_equation_work_service_agreement_subscr_joined
where
service_type in ('O') and
  substr(soc,1,2) in ('OS') and
  substr(soc,3,2) in (
    'CA', 'CB', 'CC', 'CD',
    'B1', 'B2', 'B3', 'B4')and
now() < expiration_date;