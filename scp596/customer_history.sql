select * from analytics.abt_customer_history where customer_id = 100122601;

select customer_id, count(*) from  analytics.abt_customer_history where end_date > now() group by customer_id having 
count(*) > 1;

select count(*) from (
select customer_id, count(*) from  analytics.abt_customer_history where end_date > now() group by customer_id having 
count(*) > 1)x;

select * from work.base_equation_work_customer where customer_id =  424201218;

select * from base.import_fokus_base_ban_pym_mtd where ban = 424201218;

select * from raw.import_fokus_raw_ban_pym_mtd where ban = '424201218';



select * from work.base_equation_work_customer where customer_id =  986301216;


select * from base.import_fokus_base_ban_pym_mtd where ban = 986301216;


select * from work.base_equation_work_traffic_partitioned where product_line = 'Mobile'  and traffic_type_id = 1;

select * from analytics.abt_customer_history where customer_id = 536308018;


select * from work.base_equation_work_customer_change where customer_id = 536308018;

select concat(cast(date_part('hour',next_change_date) as string),':',cast(date_part('minute',next_change_date) as string),':', 
cast(date_part('second',next_change_date)as string))
from work.base_equation_work_customer_change where customer_id = 536308018;

select distinct concat(cast(date_part('hour',next_change_date) as string),':',cast(date_part('minute',next_change_date) as string),':', 
cast(date_part('second',next_change_date)as string))
from work.base_equation_work_customer_change;

--all change dates
select * from temp.base_equation_tmp_customer_change_all where customer_id = 100683539; --18 count



select * from temp.base_equation_tmp_address_expiration where customer_id = 100683539 and link_type = 'L';

select * from temp.base_equation_tmp_ban_pym_expiration where customer_id = 100683539;

select * from temp.base_equation_tmp_ban_hierarchy_tree_expiration where customer_id = 100683539;

select * from temp.base_equation_tmp_ban_hierarchy_tree_effective where customer_id = 100683539;

select * from base.import_fokus_base_ban_hierarchy_tree where ban = 100683539;

--next change date
select * from work.base_equation_work_customer_change where customer_id = 100683539;

--change entity joined with data
select * from work.base_equation_work_customer_history where customer_id = 100683539;

--change entity joined with data new way
select start_date, end_date, adr_effective_date, adr_expiration_date, hier_effective_date, hier_expiration_date,
pym_effective_date, pym_expiration_date, adr_city, tree_level, payment_method
from work.base_equation_work_customer_hist where customer_id = 100683539;

select * from analytics.abt_customer_history where customer_id = 536308018;

select * from analytics.abt_customer_history where customer_id = 100683539;

select * from base.import_fokus_base_ban_pym_mtd where ban = 424201218;

select ban, count(*) from base.import_fokus_base_ban_pym_mtd where expiration_date = cast('4700-12-31 00:00:00' as timestamp)
group by ban having count(*) > 1;
;

select count(*) from (
select ban, count(*) from base.import_fokus_base_ban_pym_mtd where expiration_date = cast('4700-12-31 00:00:00' as timestamp)
group by ban having count(*) > 1)x; --1625


select * from base.import_fokus_base_ban_pym_mtd where ban = 838341212;
 
select * from base.import_fokus_base_ban_pym_mtd where ban = 505741215;

select * from base.import_fokus_base_ban_pym_mtd where ban = 458540119 and expiration_date = cast('4700-12-31 00:00:00' as timestamp);


--next change date generation
select customer_id, change_date, lag(change_date,1) over (partition by customer_id order by change_date desc) as next_change_date
from (
SELECT
distinct
customer_id, nvl(trunc(change_date,'DD'), to_date('9999-12-30')) + interval 1 day - interval 2 SECONDS as change_date 
FROM temp.base_equation_tmp_customer_change_all
where customer_id = 536308018)x;

--change entity joined with data
select * from work.base_equation_work_customer_history where customer_id = 536308018;

--final entity

select * from analytics.abt_customer_history where customer_id = 536308018;

select customer_id, start_date, end_date, next_start_date, 
case when end_date = cast('9999-12-31' as timestamp) then 1 else
datediff(next_start_date, end_date) 
end
from (

select customer_id, start_date, end_date, lag(start_date,1) over (partition by customer_id order by start_date desc) next_start_date
from analytics.abt_customer_history where customer_id = 536308018)x;

select count(*) from temp.base_equation_tmp_customer_change_all; 
--56110950
--32320489

select customer_id, start_date, end_date, next_start_date, 
datediff(next_start_date, end_date) as "difference"
from (
select customer_id, start_date, end_date, lag(start_date,1) over (partition by customer_id order by start_date desc) next_start_date
from analytics.abt_customer_history where end_date != cast('9999-12-31' as timestamp) )x
where datediff(next_start_date, end_date) != 1; --and customer_id in (100683539,347232506);
 
 select * from analytics.abt_customer_history where customer_id = 100683539;
 
  select * from analytics.abt_customer_history where customer_id = 347232506;
  
  select * from analytics.abt_customer_history where customer_id = 536308018;
  
  select ban, effective_date, expiration_date, tree_level from base.import_fokus_base_ban_hierarchy_tree where ban = 347232506;
  
  select * from base.import_fokus_base_ban_hierarchy_tree where ban = 100683539;