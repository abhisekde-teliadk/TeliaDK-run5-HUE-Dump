-- UAT af : 	Abt_customer_history, abt_customer_current - 8h

-- Test 1 - start_date
select a.customer_id,
       a.start_date,
       count(*) as antal
from   analytics.abt_customer_history a
group by 1,2
having count(*) > 1
;
-- 0 rows - OK

-- Test 1 - customer_id perioder
select a.customer_id,
       a.start_date
from   analytics.abt_customer_history a,
       analytics.abt_customer_history b
where  a.customer_id = b.customer_id
and    a.start_date between b.start_date and b.end_date
and    a.start_date <> b.start_date
order by 1,2
;
-- 0 rows : OK

select a.*
from   analytics.abt_customer_history a
where  customer_id = 100100296
order by a.customer_id,
         a.start_date 
;


select *
from analytics.abt_customer_history limit 1000
;

select ban_status,
       case when mod((cast(substr(cast(1212121211 as string),1,1) as int) *4 +
                    cast(substr(cast(1212121211 as string),2,1) as int) *3 +
                    cast(substr(cast(1212121211 as string),3,1) as int) *2 +
                    cast(substr(cast(1212121211 as string),4,1) as int) *7 +
                    cast(substr(cast(1212121211 as string),5,1) as int) *6 +
                    cast(substr(cast(1212121211 as string),6,1) as int) *5 +
                    cast(substr(cast(1212121211 as string),7,1) as int) *4 +
                    cast(substr(cast(1212121211 as string),8,1) as int) *3 +
                    cast(substr(cast(1212121211 as string),9,1) as int) *2 +
                    cast(substr(cast(1212121211 as string),10,1) as int) *1 ), 11) = 0 then 'OK' else 'ERROR' 
       end as cpr_status,
              count(*) as antal
from analytics.abt_customer_history
group by 1,2
order by 1,2
;
-- 5 rækker 
 
4, 3, 2, 7, 6, 5, 4, 3, 2 og 1
 


select customer_id, cpr_no, count(*) from analytics.abt_customer_current where birth_date > now() group by customer_id,cpr_no;
select cpr_no, birth_date from analytics.abt_customer_current where customer_id=496761115;
select customer_id, cpr_no, birth_date from analytics.abt_customer_history  where customer_id = 554925008;
SELECT 
    base_address_name_link.customer_id AS customer_id,
    base_name_data.last_business_name AS last_business_name,
    base_name_data.first_name AS first_name,
    base_name_data.birth_date AS birth_date,
    base_name_data.identify AS identify
  FROM (
    SELECT base_address_name_link.*
      FROM base.import_fokus_base_address_name_link base_address_name_link
      WHERE link_type in ('U', 'L')
    ) base_address_name_link
  LEFT JOIN base.import_fokus_base_name_data base_name_data
    ON base_address_name_link.name_id = base_name_data.name_id
    where customer_id = 554925008;
    
    
select  * from 
raw.import_fokus_raw_detail_usage 
where subscriber_no = 'GSM04528270897'
;


select * from analytics.abt_missing_soc_info; 

SELECT * FROM datascience.soc_groups_prepared 
where soc = 'FAVC144'
;
