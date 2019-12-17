select * from import_fokus_samples_base_subscriber_sample  where subscriber_no='GSM04550385656'
and service_type in ('O') and  substr(SOC,1,2) in ('OS');


    SELECT distinct
        sa.ban,
        subs.customer_id,
        sa.subscriber_no as sa_subs_no,
        subs.subscriber_no as subs_sub_no,
        sa.soc,
        sa.soc_effective_date,
        sa.effective_date,
        sa.service_type,
        sa.expiration_date,
        sa.dealer_code,
        subs.subscriber_id
      FROM base.import_fokus_samples_base_service_agreement_sample3 sa
      
      INNER JOIN work.import_fokus_samples_base_subscriber_sample2 subs
        ON (sa.subscriber_no = subs.subscriber_no)
          AND (sa.ban = subs.customer_id)
          where subs.subscriber_no='GSM04550385656'
          and service_type in ('O') and  substr(SOC,1,2) in ('OS');
          
 SELECT 
        sa.ban,
        sa.subscriber_no as sa_subs_no,
        sa.soc,
        sa.soc_effective_date,
        sa.effective_date,
        sa.service_type,
        sa.expiration_date,
        sa.dealer_code
      FROM base.import_fokus_samples_base_service_agreement_sample3 sa
      where subscriber_no='GSM04550385656'
          and service_type in ('O') and  substr(SOC,1,2) in ('OS');
          
select * /*subscriber_no, customer_id*/ from work.import_fokus_samples_base_subscriber_sample2 subs
          where subs.subscriber_no='GSM04550385656';          
          
          select * from base_equation_work_service_agreement_sample3_prepared;
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
select subscriber_no, customer_id, soc, change_date, lag(change_date,1) over (partition by subscriber_no, customer_id /*, soc*/ order by change_date desc) next_change_date
from (
select distinct subscriber_no, customer_id, soc, 
--coalesce(change_date,to_timestamp('99991231','yyyyMMdd')) as change_date
--date_add(trunc(coalesce(change_date,to_timestamp('99991231','yyyyMMdd')),'dd') , 0.99999) as change_date
seconds_add(date_add(trunc(change_date,'dd'),1),-2) as change_date

--trunc(change_date,'dd') as change_date
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
    and subscriber_no='GSM04531524510'
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
    and subscriber_no='GSM04531524510'
  ) x
where
  trunc(change_date,'dd') <= trunc(now(),'dd')
) y
 where subscriber_no='GSM04531524510';