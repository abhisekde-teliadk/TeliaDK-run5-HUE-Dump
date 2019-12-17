-- 56
select count(distinct customer_account_type_id)
from analytics.abt_subscriber_current
;

select customer_account_type_id, count (*) c 
from analytics.abt_subscriber_current 
group by customer_account_type_id
order by c
limit 100;

-- 3
select count(distinct product_brand)
from analytics.abt_subscriber_current
;

-- 15
select count(distinct product_product_group)
from analytics.abt_subscriber_current
;


select product_product_group, count (*) c 
from analytics.abt_subscriber_current 
group by product_product_group
order by c
limit 100;


SELECT subscriber_no, customer_id,  count(distinct imsi) c
FROM base.import_fokus_base_physical_device
WHERE device_type = 'E'
GROUP BY subscriber_no, customer_id
order by c desc
;

SELECT *
FROM base.import_fokus_base_physical_device
where subscriber_no = 'GSM04520960066'
and customer_id = 945294908
;

-- exp date = 2019-05-15 11:22:55
SELECT *
FROM base.import_fokus_base_physical_device
where imsi = 238201009224695--238201010743722--238201007712342
;

select imsi_device, imsi_sub
from temp.sandbox_brstak_temp_subscriber_all_imsi_test--analytics.abt_subscriber_current
where customer_id = 945294908 --844336909
and subscriber_no = 'GSM04520960066' --'GSM04553535566'
;

-- 2019-05-03 00:00:00	9999-12-31 23:59:59
select *
from analytics.abt_subscriber_current
where customer_id = 945294908 --844336909
and subscriber_no = 'GSM04520960066' --'GSM04553535566'
;

SELECT subscriber_no, customer_id,  count(distinct imsi) c
FROM temp.sandbox_brstak_temp_calendar_sub_imsi_test
GROUP BY subscriber_no, customer_id
order by c desc
;

SELECT subscriber_no, customer_id, imsi_sub, count(imsi_device) c
FROM temp.sandbox_brstak_temp_subscriber_all_imsi_test
group by subscriber_no, customer_id, imsi_sub
order by c desc
;

SELECT subscriber_no, customer_id, imsi_sub, imsi_device, equipment_level
FROM temp.sandbox_brstak_temp_subscriber_all_imsi_test
where subscriber_no = 'GSM04528914267'
and customer_id = 813732211
;


SELECT start_date, subscriber_no, customer_id, product_soc, count(*) c
FROM temp.sandbox_brstak_temp_subscriber_all_imsi_test
GROUP BY start_date, subscriber_no, customer_id, product_soc
order by c desc
;

SELECT distinct start_date, subscriber_no, customer_id, product_soc
FROM temp.sandbox_brstak_temp_subscriber_all_imsi_test
;

SELECT x.start_date, x.subscriber_no, x.customer_id, x.product_soc, count(*) c
from (SELECT distinct start_date, subscriber_no, customer_id, product_soc
FROM temp.sandbox_brstak_temp_subscriber_all_imsi_test) x
group by x.start_date, x.subscriber_no, x.customer_id, x.product_soc
order by c desc
;
