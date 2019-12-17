select count(*) from work.vasdata_work_rate_product_joined; -- 61.498.957

-- 
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
        ban as s_ban,
        subscriber_no as ser_subscriber_no,
        dealer_code,
        service_type,
        effective_date,
        expiration_date
    from base.import_fokus_base_service_agreement where service_type in ('R','O','S')),
subscriber as (
    select 
        Subscriber_id as s_subscriber_id,
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
subscribed_product as (
    select
        Subscriber_no as sp_subscriber_no,
        ban as sp_ban,
        Effective_date as sp_effective_date,
        expiration_date as sp_expiration_date
    from analytics.abt_subscribed_product
),
service_soc as (
    select
        soc as ss_soc
    from base.manual_files_base_service_soc
),
res as (
    select * from
        service_change join service on
            service.Soc = service_change.sc_soc and
            service.ser_subscriber_no = service_change.sc_subscriber_no and
            service.s_ban = service_change.sc_customer_id and
            --service.service_type in ('R','O','S') and
            --service_change.change_date between service.effective_date and service.expiration_date
            (service_change.change_date >= service.effective_date) and
            (service_change.change_date <= nvl(service.expiration_date,'99991231'))
        join subscriber on
            subscriber.customer_id = service.s_ban and
            subscriber.s_subscriber_no = service.ser_subscriber_no
        left outer join service_rate on
            service_rate.sr_change_date = service_change.change_date and
            service_rate.sr_soc = service_change.sc_soc
        left outer join /*analytics.abt_subscribed_product as*/ subscribed_product on
            subscribed_product.sp_subscriber_no = service_change.sc_subscriber_no and
            subscribed_product.sp_ban = service_change.sc_customer_id and
            service_change.change_date between subscribed_product.sp_effective_date and subscribed_product.sp_expiration_date    
        left outer join base.manual_files_base_man_tertium_servicestatus_vw as status on
            status.active_state = 0 and
            status.Bss_subscriber_id = /*service*/subscriber.s_subscriber_id and
            status.Product_name = service.Soc and
            status.creation_date between service.effective_date and service.expiration_date
        left outer join /*base.manual_files_base_service_soc as*/ service_soc on
            service_soc.ss_soc = service_change.sc_soc    
)
select count(*) from res;