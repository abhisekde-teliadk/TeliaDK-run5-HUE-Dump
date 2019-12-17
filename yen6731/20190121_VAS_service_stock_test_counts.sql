set APPX_COUNT_DISTINCT=true;

select count(*) from analytics.abt_service_stock; -- 1203

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
    distinct month,
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
),
result as (
select res_join.month, res_join.product_group, res_join.soc
from res_join left  join res_count on
res_join.month=res_count.month and
res_join.product_group = res_count.product_group and
res_join.soc = res_count.soc
left  join res_per on
res_join.month=res_per.month and
res_join.product_group = res_per.product_group
group by res_join.month, res_join.product_group, res_join.soc
)
select count(*) from result r
--where r.month=201811 and r.soc='ALLBIZA'
--group by month, product_group, soc
;


 select  * from work.vasdata_work_service_stock_join where service_soc='ALLBIZA' and month=201812;
 select  * from analytics.abt_service_stock where soc='ALLBIZA' and reporting_month=201812;
 
select * from work.vasdata_work_service_stock_join where service_soc='ALLBIZA' and month=201812 and sub_product_group is not null;
select * from work.vasdata_work_service_stock_join where service_soc='ALLBIZA' and month=201812;
  
-- 1.
select * from vasdata_work_service_stock_count_group where service_soc='ALLBIZA' and month=201812;
-- 2.
select * from vasdata_work_service_stock_joined_groups where service_soc='ALLBIZA' and month=201812;


/*from res_count left outer join res_per on
res_count.month=res_per.month and
res_count.product_group = res_per.product_group;
*/
/*qualify
  rownum() over (partition
    reporting_month.Month
    subscriber.Product_group
    service.Soc) = 1;*/