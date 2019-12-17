select subscriber_no from base.import_fokus_base_service_agreement;
select * from base.manual_files_base_man_tertium_servicestatus_vw;

--subselect => counts same = OK
;
select count(*) from (
select
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
)x; -- 1.783.789

select count(*) from work.vasdata_work_service_rate_sum; -- 1.783.789

-- 120.210.018
select count(*) from work.vasdata_work_tertium_service_soc_joined;

-- 120.211.256 without qualify condition in the end
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
status.Creation_date as activation_date,
rank () over (
    partition by
      service.Soc,
      subscriber.Subscriber_id,
      service.effective_date
    order by
      status.Creation_date asc) as rnk,
lead(service_change.change_date, 1) over (
    partition by
      service_change.Soc,
      service_change.Subscriber_no,
      service_change.Customer_id
    order by
      service_change.change_date asc) as lead_change_date
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
)x
where lead_change_date is not null and rnk=1; -- 69.351.407 vs 68.589.606 in dataiku