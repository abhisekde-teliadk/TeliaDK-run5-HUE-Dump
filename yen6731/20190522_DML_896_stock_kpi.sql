select sum(subs_qty) from analytics.abt_stock_kpi where stock_date='2019-05-06 00:00:00';
select sum(subs_qty) from analytics.abt_stock_kpi where stock_date='2019-05-06 00:00:00'; -- 1.513.353
select sum(customer_qty) from analytics.abt_stock_kpi where stock_date='2019-05-06 00:00:00'; -- 1.011.687

select sum(cast(dwh_closing_stock as bigint)) from sandbox.abt_stock_stock_diff_uat_joined; --1.502.176
select sum(cast(fokus_closing_stock as bigint)) from sandbox.abt_stock_stock_diff_uat_joined; --1.501.791


select stock_date, count(*) from sandbox.abt_stock_stock_diff_uat_joined group by stock_date;
select count(*) from sandbox.abt_stock_stock_from_fokus where soc='CHAMP01A'; -- 33855


select * from sandbox.abt_stock_stock_diff_uat_joined where fokus_soc='4EF'; -- 8665 => NOK
select * from sandbox.abt_stock_stock_diff_uat_joined where fokus_soc='NBME02D'; -- 4047 => NOK

select * from sandbox.abt_stock_stock_diff_uat_joined where fokus_soc='CHAMP01A'; -- 33367 => 

select * from sandbox.abt_stock_stock_diff_uat_joined where fokus_soc='CORFRI'; -- 5548 => OK
select distinct * from sandbox.abt_stock_stock_diff_uat2_joined where priceplan='CORFRI50G'; -- 5548 => OK

select sum(subs_qty) from analytics.abt_stock_kpi where stock_date='2019-05-06 00:00:00' and soc='CORFRI50G'; -- 23562 => NOK

select * from sandbox.abt_stock_stock_diff_uat_joined where fokus_soc='CORFRI'; -- 23095 vs 12633 => NOK
select sum(subs_qty) from analytics.abt_stock_kpi where stock_date='2019-05-06 00:00:00' and soc='CORFRI'; -- 23095 vs 12633 => NOK

select sum(subs_qty) from analytics.abt_stock_kpi where stock_date='2019-05-06 00:00:00' and soc='4EF'; -- 8735 => NOK
select sum(subs_qty) from analytics.abt_stock_kpi where stock_date='2019-05-06 00:00:00' and soc='NP_4EP'; -- 33 => NOK
select sum(subs_qty) from analytics.abt_stock_kpi where stock_date='2019-05-06 00:00:00' and soc='CHAMP01A'; -- 34807 => NOK

select sum(subs_qty) from work.base_equation_kpis_tbt_stock_kpi where stock_date='2019-05-06 00:00:00' and soc='4EF'; -- 8735, 5706 => NOK

select product_id from work.base_equation_product_tbt_product where soc='4EF';

select sum(subs_qty) from work.base_equation_kpis_tbt_stock_kpi where stock_date='2019-05-06 00:00:00'; -- 8735, 5706 => NOK
select * from work.base_equation_kpis_tbt_stock_kpi where stock_date='2019-05-06 00:00:00' and product_id='99cecd6bc15a1db37eb44da7297fb0c9' and active_traffic='Y'; -- 8735, 5706 => NOK
select /*sum(subs_qty)*/* from work.base_equation_kpis_tbt_stock_kpi
--where stock_date='2019-05-06 00:00:00' and product_id='de52378fa359972108e62e50d253d8f3' and active_traffic='Y'; -- 7818 => -1000 with active traffic=N
where stock_date='2019-05-06 00:00:00' and product_id='99cecd6bc15a1db37eb44da7297fb0c9'; -- 8475 => -260 with active traffic=N

select count(*) from work.base_equation_kpis_work_subscribed_product_day
where date_as_date='2019-05-06 00:00:00' and product_id='99cecd6bc15a1db37eb44da7297fb0c9';

select count(*) from work.base_equation_product_work_subscribed_product_id
where '2019-05-06 00:00:00' between effective_date and expiration_date and product_id='99cecd6bc15a1db37eb44da7297fb0c9';

select * from work.base_equation_product_tbt_product
where product_id='99cecd6bc15a1db37eb44da7297fb0c9';

select * from work.base_equation_product_work_max_subscribed_product
where '2019-05-06 00:00:00' between effective_date and expiration_date and soc='NP_4EP';

select * from work.base_equation_product_work_subscribed_product
where '2019-05-06 00:00:00' between effective_date and expiration_date and soc='NP_4EP';

select count(*) from work.base_equation_product_work_service_agreement_subscr_joined
where '2019-05-06 00:00:00' between effective_date and expiration_date and soc='CORFRI';

select count(*) from (
SELECT DISTINCT ban, subscriber_no
  FROM (
    SELECT 
        ban AS ban,
        subscriber_no AS subscriber_no,
        soc AS soc,
        soc_seq_no AS soc_seq_no,
        campaign AS campaign,
        soc_effective_date AS soc_effective_date,
        effective_date AS effective_date,
        service_type AS service_type,
        expiration_date AS expiration_date,
        dealer_code AS dealer_code,
        subscriber_id AS subscriber_id,
        RANK() OVER (PARTITION BY ban, subscriber_no, soc_seq_no ORDER BY effective_date DESC, subscriber_id DESC) AS rank
      FROM work.base_equation_product_work_service_agreement_subscr_joined
    ) unfiltered_query
  WHERE
  '2019-05-06 00:00:00' between effective_date and expiration_date and soc='CORFRI'
  and rank=1) b
  ;

select count(*) from base.import_fokus_base_service_agreement where soc='CORFRI'
 and '2019-05-06 00:00:00' between effective_date and expiration_date
--group by subscriber_no having count(*)>1
 ; -- 12.963
 
 
select fokus_soc, fokus_closing_stock, subs_qty_sum, count, abs(cast(fokus_closing_stock as bigint) - subs_qty_sum) as diff
from sandbox.abt_stock_STOCK_DIFF_UAT_joined
--where soc='NP_4EP'
order by diff desc
nulls last
;

select fokus_soc, fokus_closing_stock, subs_qty_sum, count, (cast(fokus_closing_stock as bigint) - subs_qty_sum) as diff
from sandbox.abt_stock_STOCK_DIFF_UAT_joined
--where soc='NP_4EP'
order by diff desc
nulls last
;

select * from sandbox.abt_stock_stock_from_fokus where soc='NBME02D';

--GMXXL1
--CORFRI
--CORFRI5G
--CORFRI50G
--CORFRI20G


select * from (
select 'NOT IN' as src, /*ban, soc, expiration_issue_date*/ * from base.import_fokus_base_service_agreement
where soc='CORFRI'
 and '2019-05-06 00:00:00' between effective_date and expiration_date
 and subscriber_no not in(
select subscriber_no from sandbox.abt_stock_stock_from_fokus where soc='CORFRI')

UNION ALL

select 'IN' as src, /* ban, soc, expiration_issue_date*/ * from base.import_fokus_base_service_agreement
where soc='CORFRI'
 and '2019-05-06 00:00:00' between effective_date and expiration_date
 and subscriber_no in(
select subscriber_no from sandbox.abt_stock_stock_from_fokus where soc='CORFRI')
) a
order by src, ban asc
;

select * from sandbox.abt_stock_stock_from_fokus where soc='NP_4EP';

select distinct status,active_record_flag, subscriber_no from analytics.abt_subscriber_history where subscriber_no in (
select subscriber_no from base.import_fokus_base_service_agreement
where soc='CORFRI'
 and '2019-05-06 00:00:00' between effective_date and expiration_date
 and subscriber_no in(
select subscriber_no from sandbox.abt_stock_stock_from_fokus where soc='CORFRI'))
and status in ('A','S')-- and active_record_flag=false
order by status asc
;

select * from work.base_equation_kpis_tbt_stock_kpi
where stock_date='2019-05-06 00:00:00' and product_id='99cecd6bc15a1db37eb44da7297fb0c9'
;


select * from analytics.abt_subscriber_history where subscriber_no not in (
select subscriber_no from sandbox.abt_stock_stock_from_fokus where soc='CORFRI') and status in ('A','S');

select sum(subs_qty) from work.base_equation_kpis_tbt_stock_kpi where '2019-05-06'=stock_date and product_id='4ec29a0cd671e078af8396a82912fcbc';

select count(*) from analytics.abt_stock_kpi;
select count(*) from work.base_equation_kpis_tbt_stock_kpi;