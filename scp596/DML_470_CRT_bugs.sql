select * from analytics.abt_service_history;

set request_pool=big;
select soc, subscriber_no, customer_id, start_date, count(*) from analytics.abt_service_history group by
soc, subscriber_no, customer_id, start_date
having count(*) > 1;

select reporting_month, product_group, soc, count(*) from analytics.abt_service_stock
group by reporting_month, product_group, soc
having count(*) > 1
;

select * from analytics.abt_service_stock;

select * from work.vasdata_work_service_stock_join 
where service_soc = '3G' and sub_product_group = 'Postpaid BtC' and month = 201811;

select count(distinct sub_subscriber_id) from work.vasdata_work_service_stock_join 
where service_soc = '3G' and sub_product_group = 'Postpaid BtC' and month = 201811; --18

select count(distinct sub_customer_id) from work.vasdata_work_service_stock_join 
where service_soc = '3G' and sub_product_group = 'Postpaid BtC' and month = 201811;--18


select count(distinct sub_subscriber_id) from work.vasdata_work_service_stock_join 
where sub_product_group = 'Postpaid BtC' and month = 201811; --554121

--percentage
select count(distinct sub_customer_id) from work.vasdata_work_service_stock_join 
where sub_product_group = 'Postpaid BtC' and month = 201811;--335763

select * from work.vasdata_work_service_stock_join 
where sub_product_group = 'Postpaid BtC' and month = 201811;--335763

select * from work.vasdata_work_service_stock_percentage_group where month =  201811
and sub_product_group = 'Postpaid BtC';

select * from work.vasdata_work_service_stock_count_group where month =  201811
and sub_product_group = 'Postpaid BtC' and service_soc = '3G';

select count(*) from analytics.abt_customer_current;

select * from work.crt_subscriber where prol_change_date_id != prol_change_date_id;


select soc, subscriber_no, customer_id, start_date, count(*) from analytics.abt_service_history_fat group by
soc, subscriber_no, customer_id, start_date
having count(*) > 1;

set request_pool=big;
select soc, subscriber_no, customer_id, start_date, count(*) from analytics.abt_service_history group by
soc, subscriber_no, customer_id, start_date
having count(*) > 1;

select * from analytics.abt_subscribed_product_history order by ban, subscriber_no, effective_date desc;


select * from analytics.abt_subscribed_product_history where ban = 100107645 and subscriber_no = 'GSM04528891888';

select * from work.crt_work_subscribed_product where ban = 100107645 and subscriber_no = 'GSM04528891888';
