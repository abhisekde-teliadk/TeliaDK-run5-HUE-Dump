select distinct /*active_record_flag,*/ status, fokus_status, sub_status from analytics.abt_subscriber_history;

select distinct /*active_record_flag,*/ status, fokus_status from analytics.abt_subscriber_history;

select count(*) from work.base_equation_sub_tbt_subscriber_history; -- 71680454
select count(*) from analytics.prod_abt_subscriber_history; -- 71282000
select count(*) from analytics.abt_subscriber_history; -- 71680745

select count(*) from work.base_equation_sub_tbt_subscriber_history where is_active=true;  --  1506754
select count(*) from work.base_equation_sub_tbt_subscriber_history where is_active=false; -- 70173700

select subscriber_no, is_active, fokus_status, active_record_flag, start_date, end_date from work.base_equation_sub_tbt_subscriber_history where is_active=false and active_record_flag=true; -- 7255433

select distinct /*subscriber_no,*/ is_active, fokus_status, active_record_flag, /*start_date,*/ end_date
from work.base_equation_sub_tbt_subscriber_history
where is_active=true; -- 7255433


select count(*) from work.base_equation_sub_tbt_subscriber_current; -- 8762187
select count(*) from analytics.prod_abt_subscriber_current; -- 8738145
select count(*) from analytics.abt_subscriber_current; -- 8762187

select count(*) from work.base_equation_sub_tbt_subscriber_current where is_active=true;  -- 1506754
select count(*) from work.base_equation_sub_tbt_subscriber_current where is_active=false; -- 7255433

select subscriber_no, is_active, fokus_status, active_record_flag, start_date, end_date from work.base_equation_sub_tbt_subscriber_current where is_active=false and active_record_flag=true; -- 7255433

select distinct /*subscriber_no,*/ is_active, fokus_status, active_record_flag, /*start_date,*/ end_date
from work.base_equation_sub_tbt_subscriber_current
where is_active=false; -- 7255433

select distinct ban_status from work.base_equation_sub_tbt_customer_current;