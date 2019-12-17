/* ***
Counts comparing - exactly same. OK
****/

select count(*) FROM work.vasdata_work_service_change; -- 215.576.940 ODL. new = 215.579.523

-- 215.576.940
select count(*) from (
select
distinct
x.SOC,
x.Subscriber_no,
x.Customer_id,
--nvl (trunc(change_date) +  1 day - 2 sec, 99991231)
trunc(change_date,'DD') + interval 1 day - interval 2 second as change_date
from (
  select
  SOC,
  Subscriber_no,
  Customer_id,
  Effective_date as change_date
  from base.import_fokus_base_service_agreement
  where service_type in ('R','O','S')
  union
  select
  SOC,
  Subscriber_no,
  Customer_id,
  expiration_date + interval 1 day as change_date
  from base.import_fokus_base_service_agreement
  where service_type in ('R','O','S')
  union
  select
  service_agreement.SOC,
  service_agreement.Subscriber_no,
  service_agreement.ban,
  subscribed_product.effective_date as change_date
  from 
    analytics.abt_subscribed_product subscribed_product join
    base.import_fokus_base_service_agreement service_agreement on
      service_agreement.service_type in ('R','O','S') and
      service_agreement.Subscriber_no = subscribed_product.Subscriber_no and
      service_agreement.ban = subscribed_product.ban and
      subscribed_product.effective_date between
        service_agreement.effective_date and
        service_agreement.expiration_date
  union
  select
  service_agreement.SOC,
  service_agreement.Subscriber_no,
  service_agreement.ban,
  subscribed_product.expiration_date + interval 1 day as change_date
  from 
    analytics.abt_subscribed_product subscribed_product join
    base.import_fokus_base_service_agreement service_agreement on
      service_agreement.service_type in ('R','O','S') and
      service_agreement.Subscriber_no = subscribed_product.Subscriber_no and
      service_agreement.ban = subscribed_product.ban and
      subscribed_product.expiration_date between
        service_agreement.effective_date and
        service_agreement.expiration_date
  union
  SELECT soc, subscriber_no, ban, effective_date as change_date
  FROM work.vasdata_work_service_type_ros_effective_date
  
  /*service_agreement.SOC,
  service_agreement.Subscriber_no,
  service_agreement.ban,
  pp_rc_rate.Effective_date as change_date
  from 
    base.import_fokus_base_pp_rc_rate joined on
    base.import_fokus_base_service_agreement joined on
      service_agreement.service_type in ('R','O','S') and
      service_agreement.SOC, = pp_rc_rate.SOC,
      pp_rc_rate.effective_date between
        service_agreement.effective_date and
        service_agreement.expiration_date*/
  union
  
  SELECT soc, subscriber_no, ban,  
             CASE 
                  WHEN expiration_date is null THEN CAST('9999-12-31' as timestamp) 
                  WHEN expiration_date = CAST('9999-12-31' as timestamp) THEN CAST(expiration_date as timestamp)
             ELSE
                  CAST(expiration_date as timestamp) + interval 1 day
             END as change_date
             FROM work.vasdata_work_service_type_ros_expiration_date
  
  /*service_agreement.SOC,
  service_agreement.Subscriber_no,
  service_agreement.ban,
  pp_rc_rate.Expiration_date + interval 1 day as change_date
  from 
    base.import_fokus_base_pp_rc_rate joined on
    base.import_fokus_base_service_agreement joined on
      service_agreement.service_type in ('R','O','S') and
      service_agreement.SOC, = pp_rc_rate.SOC,
      pp_rc_rate.expiration_date between
        service_agreement.effective_date and
        service_agreement.expiration_date*/
  ) x
 ) y; 
