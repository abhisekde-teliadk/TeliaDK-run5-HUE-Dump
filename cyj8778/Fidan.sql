select subscriber_id,from_priceplan
from analytics.prod_abt_migration_kpi
where from_priceplan in ('CM6T12GB','CMJHEU09')
and to_priceplan = 'CMJLHEU08'
and migration_date = '2019-03-10' ; 

select subscriber_id,from_priceplan, to_priceplan, migration_date
from analytics.prod_abt_migration_kpi
where from_product_group in 
from analytics.prod_abt_migration_kpi
;

drop table if exists sandbox.Fidan_Migrations;
drop table if exists sandbox.Fidan_total_migration_ND;

create table sandbox.Fidan_total_migration_ND as
select distinct * from analytics.prod_abt_migration_kpi;

CREATE table sandbox.Fidan_Migrations as 
Select  
                customer_id
            ,   subscriber_id
            ,   subscriber_no
            ,   migration_date
            ,   YEAR(migration_date)    as  year_migration
            ,   MONTH(migration_date)   as  month_migration
            ,   DAY(migration_date)     as  day_migration
            ,   migration_type
            
            ,   from_prim_acc_type
            ,   from_product_group
            ,   from_product_subgroup
            ,   from_product_description
            ,   from_product_price
            
            ,   to_prim_acc_type
            ,   to_product_group
            ,   to_product_subgroup
            ,   to_product_description
            ,   to_product_price
            
            ,   product_change
            ,   product_group_change
            ,   prim_acc_type_change
    
FROM    sandbox.Fidan_total_migration_ND 
    
WHERE       YEAR(migration_date) = 2019;

select count(subscriber_ID) from sandbox.Fidan_total_migration_ND where subscriber_ID = 1453529 and month(migration_date)=9;

select distinct * from sandbox.Fidan_Migrations;


drop table if exists sandbox.Fidan_CustomerSize;
CREATE table sandbox.Fidan_CustomerSize as
Select 
        count(subscriber_id),
        start_Date,
        end_date,
        customer_id
        
        
from analytics.abt_subscriber_history
where product_prim_acc_type="VOICE"
and year(end_date) >= 2019
and product_product_group = "Postpaid SOHO"
group by start_date, end_date, customer_id;

select 

CREATE table sandbox.Fidan_CustomerSize as
Select 

        count(subscriber_id),
        customer_id,
        End_Date
        

from abt_subscriber_history
where product_prim_acc_type ="VOICE"
group by start_Date;

select
 distinct(product_prim_acc_type) 
from analytics.abt_subscriber_current
;
Select 

        start_Date,
        End_Date
        

from abt_subscriber_history;


select 
subscriber_id,
from_priceplacurrent
n,
to_priceplan,
from_product_group,
to_product_group,
month(migration_date) as month_migration

from analytics.prod_abt_migration_kpi
where from_product_group in ('Call Me Postpaid BtC')


select 
subscriber_id,
from_priceplan,
to_priceplan,
from_product_group,
to_product_group,
month(migration_date) as month_migration

from analytics.prod_abt_migration_kpi
where from_product_group in ('Call Me Postpaid BtC')
and to_product_group in ('Call Me Postpaid BtC')


and month_migration in ('3','4');

select distinct roaming_country,roaming_zone from analytics.prod_abt_gruppetrafik
where roaming_zone is not null and roaming_zone like "%Zone 1+2%"
; 

select distinct roaming_zone from analytics.prod_abt_gruppetrafik
where roaming_zone is not null ;


select status, * 
from  analytics.abt_subscriber_history

where customer_ID=884125212;



select*
from subscriber_history 
;
select distinct customer_id, end_date, year(end_date), month(end_date),product_product_group
from analytics.prod_abt_subscriber_history
where customer_id in (

483605218,
576025217,
436415210,
602254211,
631505211,
884125212,
989905211,
655774214,
993605211,	
573225216,
564774214,
685705212

) and product_prim_acc_type = "VOICE" 
order by month(end_date) desc
; 

  
select distinct customer_id, last_business_name, end_date, reason_desc, year(end_date), month(end_date)
from analytics.abt_subscriber_history
where customer_id in (
483605218,
576025217,
436415210,
602254211,
631505211,
884125212,
989905211,
655774214,
993605211,	
573225216,
564774214,
685705212
)
order by month(end_date)
; 
 
select * from sandbox.anders_kt_abt_cvr_stockreport
where month =201909;select *, b.customer_id from sandbox.anders_kt_abt_cvr_stockreport a
left join analytics.abt_subscriber_history b
on a.customer_identify=b.customer_identify
where month =201909 and a.prim_acc_type='VOICE'; 

select month, a.customer_identify, brand, product_line, count(b.customer_id)
from sandbox.anders_kt_abt_cvr_stockreport a
left join analytics.abt_subscriber_history b
on a.customer_identify=b.customer_identify
where month =201909 and a.prim_acc_type='VOICE'
group by month, a.customer_identify, brand, a.product_line;

drop table if exists sandbox.Fidan_SohoKundeforhold;
CREATE table sandbox.Fidan_SohoKundeforhold as
  
select b.end_of_month
       ,a.customer_id
       ,count(a.subscriber_id) as qty 
    
FROM   analytics.abt_subscriber_history a,
       (select distinct end_of_month from analytics.abt_calendar  where year(date_as_date)=2019) b
where  a.start_date <= end_of_month
and    a.end_date > end_of_month
and a.product_prim_acc_type='VOICE'
and a.product_product_group in("Postpaid SOHO","Postpaid BtB")



group by 1,2 
 
order by qty desc,a.customer_id 
 
