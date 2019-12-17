-- active customers on 2019-01-01
-- select count(*) as antal from (

select b.date_as_date,
       count(*) as antal

from (/* find kunder´der var aktive 2019-01-01 og deres evt. churn dato */
      select a.subscriber_id,
             a.start_date,
             a.end_date,
             a.status,
             case when b.churn_date is null then '9999-12-31'
                  else b.churn_date
             end as churn_date,
             datediff(nvl(b.churn_date,'9999-12-31'),'2019-01-01') as date_before_churn
      from   analytics.prod_abt_subscriber_history a
                left outer join 
            analytics.prod_abt_churn_kpi b
                on a.subscriber_id = b.subscriber_id
                and b.churn_date > '2019-01-01'

      where  1=1
      and    upper(a.status) in ('A','S')
      and    a.start_date < '2019-01-01'
      and    a.end_date >=  '2019-01-01'
      and    a.product_product_group = 'Postpaid BtC'
      and    a.product_brand = 'Telia'
     ) a,
     (/* find dato informationer i kalender tabellen */
      select date_as_date,
             datediff(date_as_date, '2019-01-01') as nr
      from   analytics.prod_abt_calendar 
      where  date_as_date >= '2019-01-01' 
      and    date_as_date <  '2019-05-31'
      --and    datediff(date_as_date, '2019-01-01') < 200
      ) b
where  nr < date_before_churn

group by 1
order by 1
;
-- 1862 

select *
from   analytics.prod_abt_churn_kpi
where  subscriber_id = 5991151
;

select status,
       *
from   analytics.prod_abt_subscriber_history
where  subscriber_id = 5991151
order  by start_date
;

select date_as_date,
       datediff(date_as_date, '2019-01-01') as nr
from   analytics.prod_abt_calendar 
where  date_as_date >= '2019-01-01' 
and    datediff(date_as_date, '2019-01-01') < 20
;


SET str = CAST(123 AS CHAR(5));
select *
from   analytics.prod_abt_subscriber_current
where  subscriber_no = $@subscriber_no}
;
