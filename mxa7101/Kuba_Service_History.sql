set request_pool=big; 

SELECT t1.customer_id, t1.change_date, t1.ban, t1.subscriber_no
FROM work.vasdata_work_service_change_agreement_joined t1
LEFT JOIN
(
SELECT 
    work_service_change.customer_id AS customer_id,
    work_service_change.change_date AS change_date,
    base_service_agreement.ban AS ban,
    base_service_agreement.subscriber_no AS subscriber_no,
    base_service_agreement.soc AS soc,
    base_service_agreement.effective_date AS effective_date,
    base_service_agreement.expiration_date AS expiration_date,
    base_service_agreement.dealer_code AS dealer_code,
    work_subscriber_renamed.subscriber_id AS subscriber_i
  FROM work.vasdata_work_service_change as work_service_change
  INNER JOIN (
    SELECT *
      FROM base.import_fokus_base_service_agreement as base_service_agreement
      WHERE service_type in ('R', 'O', 'S')
    ) base_service_agreement
    ON (work_service_change.soc = base_service_agreement.soc)
      AND (work_service_change.subscriber_no = base_service_agreement.subscriber_no)
      AND (work_service_change.customer_id = base_service_agreement.ban)
      AND (work_service_change.change_date >= base_service_agreement.effective_date)
      AND (work_service_change.change_date <= base_service_agreement.expiration_date)
  INNER JOIN work.vasdata_work_subscriber_renamed as work_subscriber_renamed
    ON (base_service_agreement.ban = work_subscriber_renamed.customer_id_sub)
      AND (base_service_agreement.subscriber_no = work_subscriber_renamed.subscriber_no_sub)
      )t2 ON t2.customer_id = t1.customer_id
WHERE t2.customer_id IS NULL;

SELECT count(*) FROM work.vasdata_work_service_change_agreement_joined;

SELECT *
    /*work_service_change.customer_id AS customer_id,
    work_service_change.change_date AS change_date,
    base_service_agreement.ban AS ban,
    base_service_agreement.subscriber_no AS subscriber_no,
    base_service_agreement.soc AS soc,
    base_service_agreement.effective_date AS effective_date,
    base_service_agreement.expiration_date AS expiration_date,
    base_service_agreement.dealer_code AS dealer_code,
    work_subscriber_renamed.subscriber_id AS subscriber_i*/
  FROM work.vasdata_work_service_change as work_service_change
  INNER JOIN (
    SELECT *
      FROM base.import_fokus_base_service_agreement as base_service_agreement
      WHERE service_type in ('R', 'O', 'S')
    ) base_service_agreement
    ON (work_service_change.soc = base_service_agreement.soc)
      AND (work_service_change.subscriber_no = base_service_agreement.subscriber_no)
      AND (work_service_change.customer_id = base_service_agreement.ban)
      AND (work_service_change.change_date >= base_service_agreement.effective_date)
      AND (work_service_change.change_date <= base_service_agreement.expiration_date)
  INNER JOIN work.vasdata_work_subscriber_renamed as work_subscriber_renamed
    ON (base_service_agreement.ban = work_subscriber_renamed.customer_id_sub)
      AND (base_service_agreement.subscriber_no = work_subscriber_renamed.subscriber_no_sub);




-- 120.209.356
SELECT count(*)
FROM work.vasdata_work_service_change AS sc
JOIN (
    SELECT base.import_fokus_base_service_agreement.*
      FROM base.import_fokus_base_service_agreement
      WHERE service_type in ('R', 'O', 'S')
    ) as service
    
ON
   service.Soc = sc.Soc and
   service.Subscriber_no = sc.Subscriber_no and
   service.ban = sc.customer_id and
   sc.change_date between
     service.effective_date and service.expiration_date
JOIN work.vasdata_work_subscriber_renamed AS subscriber
ON subscriber.customer_id_sub = service.ban
AND subscriber.subscriber_no_sub = service.subscriber_no;


select count(*) from work.vasdata_work_rate_product_joined; -- 61.498.957


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
subscribed_product.Product_id/*,
case service_soc.vas_type
   when 'INSURANCE's
   then  service_rate.rate
   else (service_rate.rate * 1.25)
   end as price,
case status.Active_state when 0 then 'Y' else 'N' end as activation_status,
status.Creation_date as activation_date*/
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