set APPX_COUNT_DISTINCT=true;

select * from analytics.abt_service_stock;

-- 1203 is count
with reporting_month as (
    select
        Month,
        end_of_month
    from work.vasdata_work_reporting_month),
subscriber as (
    select
        Product_group,
        fokus_status,
        subscriber_no as sub_subscriber_no,
        customer_id as sub_customer_id,
        start_date as sub_start_date,
        end_date as sub_end_date,
        subscriber_id as sub_subscriber_id
    from  analytics.abt_subscriber_history
    where fokus_status not in ('C')),
service as (
    select
        soc,
        subscriber_no,
        customer_id,
        start_date,
        end_date,
        subscriber_id as ser_subscriber_id
    from analytics.abt_service_history),
res_join as (
select
    month,
    product_group,
    soc,
    ser_subscriber_id,
    sub_customer_id,
    sub_subscriber_id
from reporting_month join subscriber on
     reporting_month.end_of_month between subscriber.sub_Start_date and subscriber.sub_End_date
     left outer join Service on
    service.subscriber_no = subscriber.sub_subscriber_no and
    service.customer_id = subscriber.sub_customer_id and
    reporting_month.end_of_month between service.Start_date and service.End_date
),
res_count as (
select
    month,
    product_group,
    soc,
    ndv(ser_subscriber_id) as Count_of_Subscribers,
    ndv(sub_customer_id) as Count_of_customers
from res_join
group by month, product_group,soc
),
res_per as (
select
    month,
    product_group,
    ndv(sub_subscriber_id) as work_per_active_subscribers,
    ndv(sub_customer_id) as work_per_active_customers
from res_join
group by month, product_group
)
select --count(*)
distinct
'testsql' as src,
res_join.month,
res_join.product_group,
res_join.soc,
Count_of_Subscribers,
(Count_of_Subscribers/work_per_active_subscribers) as Percentage_of_Active_Subscribers,
Count_of_customers,
(Count_of_customers/work_per_active_customers) as Percentage_of_Active_Customers
from res_join left outer join res_count on
res_join.month=res_count.month and
res_join.product_group = res_count.product_group and
res_join.soc = res_count.soc
left outer join res_per on
res_join.month=res_per.month and
res_join.product_group = res_per.product_group
where res_join.soc='EU2GBTB'-- and res_count.month=201811
UNION ALL
select 'abt' as src, * from analytics.abt_service_stock as abt where abt.soc='EU2GBTB'; --and abt.month=201811
order by month asc limit 100;

/*qualify
  rownum() over (partition
    reporting_month.Month
    subscriber.Product_group
    service.Soc) = 1;*/