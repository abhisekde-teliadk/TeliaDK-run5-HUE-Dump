select * from (
select
'sql' as src,
cal.date_as_date as stock_date,
count(distinct subscriber.customer_id) as customer_qty,
sp.product_id,
count(subscriber.subscriber_id) as subscriber_qty,
subscriber.first_dealer_code,
subscriber.dealer_code
from
  base.manual_files_base_man_d_calendar cal
  join
  analytics.abt_Subscriber_current as subscriber
  join
  base_equation_work_subscribed_product_id as sp
  on
    sp.subscriber_id = subscriber.subscriber_id and
    cal.date_as_date between sp.effective_date and sp.expiration_date
where
  subscriber.status not in ('d') and
  subscriber.act_date_id is not null
  and sp.product_id='2d8421066170ee223f054efcf9dcf238'
  and cal.date_as_date="2018-09-30 00:00:00"
  --and subscriber.first_dealer_code='7329'
group by
cal.date_as_date, sp.product_id, subscriber.first_dealer_code, subscriber.dealer_code

UNION ALL

select 'abt' as src, * from analytics.abt_stock_kpi
where
product_id='2d8421066170ee223f054efcf9dcf238'
and stock_date="2018-09-30 00:00:00"
) res
order by res.customer_qty desc, dealer_code desc, first_dealer_code desc nulls last;

-- 5031
select sum(subs_qty) from analytics.abt_stock_kpi
where
product_id='2d8421066170ee223f054efcf9dcf238'
and stock_date="2018-09-30 00:00:00";

select distinct soc from base_equation_work_subscribed_product_id
where
--product_id='0033903b45ec2a16e9a02c2e555636ed' and
 soc='MOFL3000N';

-- product_id='2d8421066170ee223f054efcf9dcf238' => soc='SPMVALUE'
-- product_id='0033903b45ec2a16e9a02c2e555636ed' => soc='MOFL3000N'

select 
cal.date_as_date as stock_date,
subscriber.customer_id,
sp.product_id,
subscriber.subscriber_id,
subscriber.first_dealer_code,
subscriber.dealer_code
from
  base.manual_files_base_man_d_calendar cal
  join
  analytics.abt_Subscriber_current as subscriber
  join
  base_equation_work_subscribed_product_id as sp
  on
    sp.subscriber_id = subscriber.subscriber_id and
    cal.date_as_date between sp.effective_date and sp.expiration_date
where
  subscriber.status not in ('d') and
  subscriber.act_date_id is not null
  and sp.product_id='2d8421066170ee223f054efcf9dcf238'
  and cal.date_as_date='2018-09-30';
  
select * from analytics.abt_stock_kpi where  
  product_id='2d8421066170ee223f054efcf9dcf238'
  and stock_date='2018-09-30';
  -----------------------------------------------------------------------------------------------
  
  -- Test Case 02 - comparison against abt_ joins
SELECT 'Analytics.abt_joins', count(*) 
FROM
analytics.abt_subscribed_product sp,
analytics.abt_subscriber_current sc
WHERE
sp.subscriber_no = sc.subscriber_no
and sp.ban = sc.customer_id
AND sc.status NOT IN ('d') -- corresponds to not in d in status in BE.subscriber_current
AND sc.act_date_id is not null
AND sp.soc = 'MOFL3000N'
AND ('2018-09-30' BETWEEN sp.effective_date and sp.expiration_date )
GROUP BY sp.product_id, sp.soc
 
UNION

-- 5031 
SELECT 'BE_KPIs.abt_stock_kpi', sum(subs_qty) s  FROM analytics.abt_stock_kpi 
WHERE
product_id = '0033903b45ec2a16e9a02c2e555636ed'
AND
 stock_date = "2018-09-30 00:00:00"
;



-- 5031 vs 5204 in Telia report
SELECT 'BE_KPIs.abt_stock_kpi', sum(subs_qty) subscriber_qty  FROM analytics.abt_stock_kpi 
WHERE
product_id = '2d8421066170ee223f054efcf9dcf238'
AND
 stock_date = "2018-09-30 00:00:00"
 
UNION
 
select 'Spec_SQL', sum(subscriber_qty) from (
 select
cal.date_as_date as stock_date,
count(distinct subscriber.customer_id) as customer_qty,
sp.product_id,
count(subscriber.subscriber_id) as subscriber_qty,
subscriber.first_dealer_code,
subscriber.dealer_code
from
  base.manual_files_base_man_d_calendar cal
  join
  analytics.abt_Subscriber_current as subscriber
  join
  base_equation_work_subscribed_product_id as sp
  on
    sp.subscriber_id = subscriber.subscriber_id and
    cal.date_as_date between sp.effective_date and sp.expiration_date
where
  subscriber.status not in ('d') and
  subscriber.act_date_id is not null
  and sp.product_id='2d8421066170ee223f054efcf9dcf238'
  and cal.date_as_date="2018-09-30 00:00:00"
  --and subscriber.first_dealer_code='7329'
group by
cal.date_as_date, sp.product_id, subscriber.first_dealer_code, subscriber.dealer_code
) res