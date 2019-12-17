--so we must anonymize, some of the values are 7, 16, 5. so we would be able to identify a person just by looking at the cusomer_account_type_id (edited) 
--unless you compute a segment of the values which have minimum values in the count of 1.000+ then it should be fine

select customer_account_type_id, count (*) 
from abt_subscriber_current 
group by customer_account_type_id 
limit 100;


-- exp date             effective date      effective date trunc
-- 9999-12-31 00:00:00 2017-03-23 10:10:46	2017-03-23 00:00:00
select * 
from base.import_fokus_base_physical_device
where subscriber_no = 'GSM04520111735'
and customer_id = 978252906
;


-- 2017-09-11 00:00:00	9999-12-31 23:59:59
select *
from analytics.abt_subscriber_current
where subscriber_no = 'GSM04520111735'
and customer_id = 978252906
;

select distinct customer_segment_subgroup
from analytics.abt_subscriber_current
;

select customer_segment_subgroup, count (*) 
from analytics.abt_subscriber_current
group by customer_segment_subgroup 
;
