--BASE_EQUATION_PRODUCT
create table temp.import_fokus_base_inclus_by_period stored as parquet as 
select * from base.import_fokus_base_inclus_by_period;

create table temp.import_fokus_base_soc stored as parquet as 
select * from base.import_fokus_base_soc;

create table temp.import_fokus_base_rated_feature stored as parquet as 
select * from base.import_fokus_base_rated_feature;

create table temp.manual_files_base_man_soc_groups stored as parquet as 
select * from base.manual_files_base_man_soc_groups;

create table temp.import_fokus_base_pp_uc_rate stored as parquet as 
select * from base.import_fokus_base_pp_uc_rate;

create table temp.import_fokus_base_pp_rc_rate stored as parquet as 
select * from base.import_fokus_base_pp_rc_rate;

create table temp.manual_files_base_service_soc stored as parquet as 
select * from base.manual_files_base_service_soc;

create table temp.import_fokus_base_campaign stored as parquet as 
select * from base.import_fokus_base_campaign;

create table temp.manual_files_base_d_product stored as parquet as 
select * from base.manual_files_base_d_product;

create table temp.import_fokus_base_service_agreement stored as parquet as 
select * from base.import_fokus_base_service_agreement;
--Inserted 92 879 522 row(s)

create table temp.import_fokus_base_subscriber stored as parquet as 
select * from base.import_fokus_base_subscriber;
--Inserted 8789079 row(s)

create table temp.import_fokus_base_subscriber_history stored as parquet as 
select * from base.import_fokus_base_subscriber_history;

-- BASE_EQUATION_KPIS
create table temp.base_equation_product_work_subscribed_product_filter_dup stored as parquet as 
select * from work.base_equation_product_work_subscribed_product_filter_dup;

create table temp.base_equation_product_tbt_product stored as parquet as 
select * from work.base_equation_product_tbt_product;

create table temp.base_equation_sub_work_subscriber_churn_dt stored as parquet as 
select * from work.base_equation_sub_work_subscriber_churn_dt;

create table temp.base_equation_sub_tbt_subscriber_history stored as parquet as 
select * from work.base_equation_sub_tbt_subscriber_history;

create table temp.manual_files_base_man_d_calendar stored as parquet as 
select * from base.manual_files_base_man_d_calendar;

create table temp.base_equation_product_work_subscribed_product_id stored as parquet as 
select * from work.base_equation_product_work_subscribed_product_id;

create table temp.base_equation_product_tbt_subscribed_product_history stored as parquet as 
select * from work.base_equation_product_tbt_subscribed_product_history;

create table temp.base_equation_other_tbt_traffic stored as parquet as
select distinct subscriber_no, customer_id, event_date from work.base_equation_other_tbt_traffic where event_date > '2018-01-01';

create table temp.base_equation_order_abt_orders stored as parquet as 
select * from analytics.abt_orders;


      
drop table temp.tf;
create table temp.tf ( i int , subs string, dt timestamp );
insert into temp.tf select 1, 'A', now();
insert into temp.tf select 2, 'A', now();
insert into temp.tf select 3, 'A', now();
insert into temp.tf select 4, 'B', now();
insert into temp.tf select 5, 'B', now();


create table temp.base_equation_other_tbt_traffic2 stored as parquet as
select distinct subscriber_no, ban as customer_id, call_date as event_date from base.import_fokus_base_fokus_detail_usage where call_date > '2018-01-01';
--162 494 520

select count(*) from temp.base_equation_other_tbt_traffic;
--534 639 567

select maxd_change, count(*) from (
    select a.customer_id, a.subscriber_no, case when b.maxd > a.maxd then 1 else 0 end maxd_change  from
    ( select customer_id, subscriber_no, max(event_date) maxd, min(event_date) mind from temp.base_equation_other_tbt_traffic group by customer_id, subscriber_no ) a 
     join
    ( select customer_id, subscriber_no, max(event_date) maxd, min(event_date) mind from temp.base_equation_other_tbt_traffic2 group by customer_id, subscriber_no )  b 
     on a.customer_id = b.customer_id and a.subscriber_no = b.subscriber_no
) t group by maxd_change;

create table temp.base_equation_other_tbt_traffic2_diff stored as parquet as
select a.* from temp.base_equation_other_tbt_traffic2 a
left join temp.base_equation_other_tbt_traffic b on a.customer_id = b.customer_id and a.subscriber_no = b.subscriber_no
where b.customer_id is null;

compute stats temp.base_equation_other_tbt_traffic2;
compute stats temp.base_equation_other_tbt_traffic;

drop table   temp.base_equation_other_tbt_traffic2_diff ;


select *,
LAG(`dt`, 1) OVER (PARTITION BY `subs` ORDER BY `dt` DESC) AS `event_date_lag`,
CEIL((UNIX_TIMESTAMP(`dt`) - UNIX_TIMESTAMP(LAG(`dt`, 1) OVER (PARTITION BY `subs` ORDER BY `dt` DESC))))
from temp.tf;

--BASE_EQUATION_PRODUCT
create table temp.import_fokus_base_inclus_by_period1 stored as parquet as 
select * from base.import_fokus_base_inclus_by_period;

create table temp.import_fokus_base_soc1 stored as parquet as 
select * from base.import_fokus_base_soc;

create table temp.import_fokus_base_rated_feature1 stored as parquet as 
select * from base.import_fokus_base_rated_feature;

create table temp.manual_files_base_man_soc_groups1 stored as parquet as 
select * from base.manual_files_base_man_soc_groups;

create table temp.import_fokus_base_pp_uc_rate1 stored as parquet as 
select * from base.import_fokus_base_pp_uc_rate;

create table temp.import_fokus_base_pp_rc_rate1 stored as parquet as 
select * from base.import_fokus_base_pp_rc_rate;

create table temp.manual_files_base_service_soc1 stored as parquet as 
select * from base.manual_files_base_service_soc;

create table temp.import_fokus_base_campaign1 stored as parquet as 
select * from base.import_fokus_base_campaign;

create table temp.manual_files_base_d_product1 stored as parquet as 
select * from base.manual_files_base_d_product;

create table temp.import_fokus_base_service_agreement1 stored as parquet as 
select * from base.import_fokus_base_service_agreement;
--Inserted 92 879 522 row(s)
--Inserted 92 895 188 row(s)

create table temp.import_fokus_base_subscriber1 stored as parquet as 
select * from base.import_fokus_base_subscriber;
--Inserted 8789079 row(s)
--Inserted 8790505 row(s)

create table temp.import_fokus_base_subscriber_history1 stored as parquet as 
select * from base.import_fokus_base_subscriber_history;


-- BASE_EQUATION_KPIS
create table temp.base_equation_product_work_subscribed_product_filter_dup1 stored as parquet as 
select * from work.base_equation_product_work_subscribed_product_filter_dup;

create table temp.base_equation_product_tbt_product1 stored as parquet as 
select s* from work.base_equation_product_tbt_product;

-- todo
create table temp.base_equation_sub_work_subscriber_churn_dt1 stored as parquet as 
select * from work.base_equation_sub_work_subscriber_churn_dt;

-- todo
create table temp.base_equation_sub_tbt_subscriber_history1 stored as parquet as 
select * from work.base_equation_sub_tbt_subscriber_history;

create table temp.manual_files_base_man_d_calendar1 stored as parquet as 
select * from base.manual_files_base_man_d_calendar;

create table temp.base_equation_product_work_subscribed_product_id1 stored as parquet as 
select * from work.base_equation_product_work_subscribed_product_id;

create table temp.base_equation_product_tbt_subscribed_product_history1 stored as parquet as 
select * from work.base_equation_product_tbt_subscribed_product_history;

create table temp.base_equation_other_tbt_traffic1 stored as parquet as
select distinct subscriber_no, customer_id, event_date from work.base_equation_other_tbt_traffic where event_date > '2018-01-01';

-- todo
create table temp.base_equation_order_abt_orders stored as parquet as 
select * from analytics.abt_orders;


select 
count(*) from (
select  ban, subscriber_no, soc, effective_date from temp.base_equation_product_work_subscribed_product_id1  where sa_expiration_date >= '2018-01-01' ) t;
--3169580 --

-- I records
select count(*) from temp.base_equation_product_work_subscribed_product_id1 a 
left join temp.base_equation_product_work_subscribed_product_id b on a.ban = b.ban and a.subscriber_no = b.subscriber_no and a.soc = b.soc and a.effective_date = b.effective_date
where b.ban is null;
--30457

-- U records
select count(*) from temp.base_equation_product_work_subscribed_product_id1 a 
join temp.base_equation_product_work_subscribed_product_id b on a.ban = b.ban and a.subscriber_no = b.subscriber_no and a.soc = b.soc and a.effective_date = b.effective_date
where b.sa_expiration_date != a.sa_expiration_date;
--25188

    select count(*) from temp.base_equation_product_work_subscribed_product_id1 a 
    join temp.base_equation_product_work_subscribed_product_id b on a.ban = b.ban and a.subscriber_no = b.subscriber_no and a.soc = b.soc and a.effective_date = b.effective_date
    where b.sa_expiration_date < a.sa_expiration_date;
     -- rozsirenie intervalu 0 
    select count(*) from temp.base_equation_product_work_subscribed_product_id1 a 
    join temp.base_equation_product_work_subscribed_product_id b on a.ban = b.ban and a.subscriber_no = b.subscriber_no and a.soc = b.soc and a.effective_date = b.effective_date
    where b.sa_expiration_date > a.sa_expiration_date;
      -- zuzenie 25188


-- D records
select count(*) from temp.base_equation_product_work_subscribed_product_id a 
left join temp.base_equation_product_work_subscribed_product_id1 b on a.ban = b.ban and a.subscriber_no = b.subscriber_no and a.soc = b.soc and a.effective_date = b.effective_date
where b.ban is null;
--5892

select * from temp.base_equation_product_work_subscribed_product_id a 
left join temp.base_equation_product_work_subscribed_product_id1 b on a.ban = b.ban and a.subscriber_no = b.subscriber_no and a.soc = b.soc and a.effective_date = b.effective_date
where b.ban is null limit 10;


select * from temp.base_equation_product_work_subscribed_product_id where ban = 556153211 and subscriber_no = 'GSM04551911780' and soc = 'SPMVALUE';
select * from temp.base_equation_product_work_subscribed_product_id1 where ban = 556153211 and subscriber_no = 'GSM04551911780' and soc = 'SPMVALUE';
--556153211	GSM04551911780	SPMVALUE
--409193216	GSM04528894603	CMFRIEU12

create table temp.base_equation_other_tbt_traffic1diff stored as parquet as
select a.* from temp.base_equation_other_tbt_traffic1 a left join temp.base_equation_other_tbt_traffic b on a.customer_id = b.customer_id and a.subscriber_no = b.subscriber_no and a.event_date = b.event_date
where b.customer_id is null;


select count(*) from temp.base_equation_other_tbt_traffic1diff;
-- 4M

compute stats temp.base_equation_other_tbt_traffic1diff;
compute stats temp.base_equation_other_tbt_traffic;

select count(*) from
( select customer_id, subscriber_no, min( event_date ) mind from temp.base_equation_other_tbt_traffic1diff group by customer_id, subscriber_no ) a
 join ( select customer_id, subscriber_no, max( event_date ) maxd from temp.base_equation_other_tbt_traffic group by customer_id, subscriber_no ) b on a.customer_id = b.customer_id and a.subscriber_no = b.subscriber_no and a.mind < b.maxd;
-- prekryvy  962

create table temp.base_equation_other_tbt_traffic1diff_prekryv stored as parquet as 
select distinct a.customer_id, a.subscriber_no from
( select customer_id, subscriber_no, min( event_date ) mind from temp.base_equation_other_tbt_traffic1diff group by customer_id, subscriber_no ) a
 join ( select customer_id, subscriber_no, max( event_date ) maxd from temp.base_equation_other_tbt_traffic group by customer_id, subscriber_no ) b on a.customer_id = b.customer_id and a.subscriber_no = b.subscriber_no and a.mind < b.maxd;

select count(*) from
( select customer_id, subscriber_no, min( event_date ) mind from temp.base_equation_other_tbt_traffic1diff group by customer_id, subscriber_no ) a
 join ( select customer_id, subscriber_no, max( event_date ) maxd from temp.base_equation_other_tbt_traffic group by customer_id, subscriber_no ) b on a.customer_id = b.customer_id and a.subscriber_no = b.subscriber_no and a.mind > b.maxd;
-- inkrement 843260


select * from
( select customer_id, subscriber_no, min( event_date ) mind from temp.base_equation_other_tbt_traffic1diff group by customer_id, subscriber_no ) a
 join ( select customer_id, subscriber_no, max( event_date ) maxd from temp.base_equation_other_tbt_traffic group by customer_id, subscriber_no ) b on a.customer_id = b.customer_id and a.subscriber_no = b.subscriber_no and a.mind < b.maxd limit 100;

609441217 GSM04528924713
664140704 GSM04528355082 

select *,
LAG(`dt`, 1) OVER (PARTITION BY `subs` ORDER BY `dt` DESC) AS `event_date_lag`,
CEIL((UNIX_TIMESTAMP(`dt`) - UNIX_TIMESTAMP(LAG(`dt`, 1) OVER (PARTITION BY `subs` ORDER BY `dt` DESC))))
from temp.tf;

create table temp.base_equation_other_tbt_traffic1_change stored as parquet as
select 
 customer_id,
 subscriber_no,
 event_date,
 event_date_lag,
 datediff( event_date, event_date_lag ) lag_diff,
 date_add(event_date_lag,-90) lag_lower
from ( 
select 
a.*, 
LAG(a.event_date, 1) OVER (PARTITION BY a.customer_id, a.subscriber_no ORDER BY a.event_date DESC) AS `event_date_lag`
from temp.base_equation_other_tbt_traffic1 a 
join temp.base_equation_other_tbt_traffic1diff_prekryv b on a.customer_id = b.customer_id and a.subscriber_no = b.subscriber_no
) t;
--Inserted 373946 row(s)

select count(*) from temp.base_equation_other_tbt_traffic1_change a 
 join temp.base_equation_other_tbt_traffic b on a.customer_id = b.customer_id and a.subscriber_no = b.subscriber_no and a.event_date != b.event_date;
