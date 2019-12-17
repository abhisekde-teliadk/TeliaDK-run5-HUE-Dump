select count(*) from work.vasdata_work_service_change_agreement_joined; -- 120.209.360
select count(*) from work.vasdata_work_rate_product_joined; -- 61.498.957

-- 120.209.356
with service_change as (
select 
    soc as sc_soc,
    subscriber_no as sc_subscriber_no,
    customer_id as sc_customer_id,
    change_date,
    trunc(change_date, 'DD') as start_date,
    trunc(lead(change_date, 1) over (
      partition by
        soc,
        Subscriber_no,
        Customer_id
      order by
        change_date asc), 'DD') - interval 1 second
        as end_date
from  work.vasdata_work_service_change),
service as (
    select
        soc,
        ban,
        subscriber_no,
        dealer_code,
        service_type,
        effective_date,
        expiration_date
    from base.import_fokus_base_service_agreement where service_type in ('R','O','S')),
subscriber as (
    select 
        Subscriber_id,
        customer_id,
        subscriber_no as s_subscriber_no
    from base.import_fokus_base_subscriber),
service_rate as (
select
  vcy.change_date as sr_change_date, 
  pp_rc_rate.soc as sr_soc, 
  sum (pp_rc_rate.rate) as rate
  from
    work.vasdata_work_service_change as vcy join
    base.import_fokus_base_pp_rc_rate as pp_rc_rate on
      pp_rc_rate.soc = vcy.Soc and
      --pp_rc_rate.Feature_code <> 'PNETRM' and
      vcy.change_date between
        pp_rc_rate.Effective_date and
        coalesce(pp_rc_rate.Expiration_date, '9991231')
     where pp_rc_rate.Feature_code <> 'PNETRM'
    group by vcy.change_date,pp_rc_rate.soc
),
res as (
    select * from
        service_change join service on
            service.Soc = service_change.sc_soc and
            service.Subscriber_no = service_change.sc_subscriber_no and
            service.ban = service_change.sc_customer_id and
            --service.service_type in ('R','O','S') and
            --service_change.change_date between service.effective_date and service.expiration_date
            (service_change.change_date >= service.effective_date) and
            (service_change.change_date <= nvl(service.expiration_date,'99991231'))
        join subscriber on
            subscriber.customer_id = service.ban and
            subscriber.s_subscriber_no = service.subscriber_no
        left outer join service_rate on
            service_rate.sr_change_date = service_change.change_date and
            service_rate.sr_soc = service_change.sc_soc
        left outer join analytics.abt_subscribed_product as subscribed_product on
            subscribed_product.Subscriber_no = service_change.Subscriber_no and
            subscribed_product.ban = service_change.Customer_id and
            service_change.change_date between subscribed_product.Effective_date and subscribed_product.expiration_date    
        left outer join base.manual_files_base_man_tertium_servicestatus_vw as status on
            status.active_state = 0 and
            status.Bss_subscriber_id = /*service*/subscriber.subscriber_id and
            status.Product_name = service.Soc and
            status.creation_date between service.effective_date and service.expiration_date
        left outer join base.manual_files_base_service_soc as service_soc on
            service_soc.soc = service_change.Soc    
)
select count(*) from res;







;
-- 120.208.702
select count(*) from (
select
service.SOC,
trunc(service_change.change_date, 'DD') as start_date,
trunc(lead(service_change.change_date, 1) over (
  partition by
    service_change.Soc,
    service_change.Subscriber_no,
    service_change.Customer_id
  order by
    service_change.change_date asc), 'DD') - interval 1 second
    as end_date,
service.Ban as customer_id,
service.SUBSCRIBER_NO,
subscriber.Subscriber_id,
service.Dealer_code,
subscribed_product.Product_id,
case service_soc.vas_type
    when 'INSURANCE'
    then  service_rate.rate
    else (service_rate.rate * 1.25)
    end as price,
case status.Active_state when 0 then 'Y' else 'N' end as activation_status,
status.Creation_date as activation_date
from
  work.vasdata_work_service_change as service_change join
  base.import_fokus_base_service_agreement as service on
    service.Soc = service_change.Soc and
    service.Subscriber_no = service_change.Subscriber_no and
    service.ban = service_change.customer_id and
    service.service_type in ('R','O','S') and
    service_change.change_date between
      service.effective_date and service.expiration_date
  join
  base.import_fokus_base_subscriber as subscriber on
    subscriber.customer_id = service.ban and
    subscriber.subscriber_no = service.subscriber_no
  left outer join
  (select
  vcy.change_date, 
  pp_rc_rate.soc, 
  sum (pp_rc_rate.rate) as rate
  from
    work.vasdata_work_service_change as vcy join
    base.import_fokus_base_pp_rc_rate as pp_rc_rate on
      pp_rc_rate.Soc = vcy.Soc and
      --pp_rc_rate.Feature_code <> 'PNETRM' and
      vcy.change_date between
        pp_rc_rate.Effective_date and
        coalesce(pp_rc_rate.Expiration_date, '9991231')
     where pp_rc_rate.Feature_code <> 'PNETRM'
    group by vcy.change_date,pp_rc_rate.soc    
  ) as service_rate on
    service_rate.change_date = service_change.change_date and
    service_rate.soc = service_change.soc
left outer join
  analytics.abt_subscribed_product as subscribed_product on
    subscribed_product.Subscriber_no = service_change.Subscriber_no and
    subscribed_product.ban = service_change.Customer_id and
    service_change.change_date between
      subscribed_product.Effective_date and
      subscribed_product.expiration_date
 )x; 
  left outer join
  base.manual_files_base_man_tertium_servicestatus_vw as status on
    status.active_state = 0 and
    status.Bss_subscriber_id = /*service*/subscriber.subscriber_id and
    status.Product_name = service.Soc and
    status.creation_date between 
      service.effective_date and
      nvl(service.expiration_date,'99991231')
  left outer join
  base.manual_files_base_service_soc as service_soc on
    service_soc.soc = service_change.Soc
--where service.service_type in ('R','O','S')
--where status.active_state = 0
--and status.active_state = 0
)x;
*/