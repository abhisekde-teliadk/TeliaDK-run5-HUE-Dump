drop TABLE sandbox.ole_test
;

create table IF NOT EXISTS  sandbox.ole_test_444
(run_date timestamp,
 report_yyyymm int,
 extract_customer_id bigint,
 extract_subscriber_no string
 )
;

-- indsæt parametre
insert overwrite sandbox.ole_test 
(   run_date,
    report_yyyymm, 
     extract_customer_id, 
    extract_subscriber_no)
    
values(now(),
      201811,
      505740019,
      'GSM04540346801')
;

-- dan final styre tabel til udtræk
drop table if exists sandbox.ole_styre_tabel;
create table sandbox.ole_styre_tabel as
select *,
        last_day(cast (from_unixtime(unix_timestamp(cast (201811*100+01 as string) ,'yyyyMMdd'), 'yyyy-MM-dd') as timestamp)) as last_day_in_month
      
from sandbox.ole_test
;


select *
from sandbox.ole_styre_tabel
;


/* 
    Marianne udtræk 
*/
drop table if exists sandbox.ole_find_subscriber_info;
create table sandbox.ole_find_subscriber_info as
select a.*
from analytics.abt_stock_report a,
     sandbox.ole_styre_tabel b
where 1=1 
-- and   a.customer_id = b.extract_customer_id
-- and   a.subscriber_no = b.extract_subscriber_no
-- and   a.start_date <=  b.last_day_in_month 
-- and   a.end_date    >  b.last_day_in_month
and   a.month = cast(b.report_yyyymm as string)
;

select * from sandbox.ole_find_subscriber_info
where soc = '4YOU5'
;







drop table if exists sandbox.ole_find_product_info;
create table sandbox.ole_find_product_info as
select a.*
from   sandbox.ole_find_subscriber_info a,
--       analytics.abt_d_product b 
--where  a.product_id = b.product_id
;

select * from analytics.abt_d_product
where soc='DSLBTC3'

--where product_id = '495d2a2266698cf8575c6c497bb6d32'
;




/* 
    Krystian TEST 
*/
drop table if exists sandbox.ole_test_impala;
create table sandbox.ole_test_impala as
select a.*
from analytics.abt_stock_report a,
     sandbox.ole_styre_tabel b
where 1=1 
-- and   a.customer_id = b.extract_customer_id
-- and   a.subscriber_no = b.extract_subscriber_no
-- and   a.start_date <=  b.last_day_in_month 
-- and   a.end_date    >  b.last_day_in_month
and   a.month = cast(b.report_yyyymm as string)
;

select *
from   sandbox.ole_test_impala
;

drop table if exists sandbox.ole_adhoc_1127_trafik;
create table sandbox.ole_adhoc_1127_trafik as
select subscriber_no, max(call_date)
from base.import_fokus_base_detail_usage
where unit_measure_code = 'A'
group by subscriber_no
;