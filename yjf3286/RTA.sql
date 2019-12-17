select count(*) from analytics.abt_stock_report;
--13435
select * from analytics.abt_stock_report limit 2;
create table temp.abt_stock_report_backup stored as parquet as select * from analytics.abt_stock_report;


select * from analytics.abt_stock_report where month = '201810' and product_id = 'de52378fa359972108e62e50d253d8f3'
union all
select * from temp.abt_stock_report_backup where month = '201810' and product_id = 'de52378fa359972108e62e50d253d8f3';


select count(*) from analytics.abt_usage_mobile;
create table temp.abt_usage_mobile_backup stored as parquet as select * from analytics.abt_usage_mobile;


select count(*) from analytics.abt_usage_mobile;
select count(*) from temp.abt_usage_mobile_backup;


select reporting_month, product_line, count(*) from analytics.abt_usage_mobile group by reporting_month, product_line 
union all
select reporting_month, product_line, count(*) from temp.abt_usage_mobile_backup group by reporting_month, product_line order by 1,2;


select * from temp.abt_usage_mobile_backup where product_line = 'Data'
union all
select * from analytics.abt_usage_mobile where product_line = 'Data' order by call_description;



select trunc(current_timestamp(),'MM');

select trunc(now(), 'year');

select nvl('a','false');

select add_months(trunc(now(),'mm'),-2);

select count(*) from analytics.abt_subscriptions_per_region;
select * from analytics.abt_subscriptions_per_region;

create table temp.abt_subscriptions_per_region_backup as select * from analytics.abt_subscriptions_per_region;

select * from analytics.abt_subscriptions_per_region
union all
select * from temp.abt_subscriptions_per_region_backup ;

create table temp.abt_subscriptions_per_region_for_last_3_months_bckp as select * from analytics.abt_subscriptions_per_region_for_last_3_months;


select * from analytics.abt_subscriptions_per_region_for_last_3_months;
--201904	EEA	364302
--201904	Non-EEA	61098








SELECT  event_month, product_line, count(*)
FROM `work`.`base_equation_other_tbt_traffic`
group by event_month, product_line
order by 1,2;


select end_of_month, trunc(end_of_month,'yyyyMM') from work.reporting_to_authorities_work_month limit 10;


create table temp.abt_international_roaming stored as parquet as select * from analytics.abt_international_roaming;
--Inserted 2680 row(s)

select count(*) from analytics.abt_international_roaming;
select count(*) from temp.abt_international_roaming;

select * from temp.abt_international_roaming where reporting_month = '201901' and brand = 'Call Me' and country = 'Czech Republic'
union all
select * from analytics.abt_international_roaming where reporting_month = '201901' and brand = 'Call Me' and country = 'Czech Republic';

select now(), to_timestamp(to_date(now()),'yyyy-MM-dd');

select * from temp.reporting_to_authorities_tmp_month_prepared;