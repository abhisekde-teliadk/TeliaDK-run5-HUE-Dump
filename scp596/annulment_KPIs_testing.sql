select count(*) from analytics.abt_annulment_kpi where annulment_date >= cast('2018-09-01' as timestamp) and 
annulment_date <= cast('2018-09-30' as timestamp) and soc = 'CHAMP01';

select * from analytics.abt_subscribed_product_history where soc = 'FLEXPA53';

select count(*) from (
select datediff(expiration_date, effective_date), * from base.import_fokus_base_service_agreement where soc = 'CHAMP01' and
 expiration_date >= cast('2018-09-01' as timestamp) and 
expiration_date <= cast('2018-09-30' as timestamp)
and datediff(expiration_date, effective_date) <= 30
and service_type = 'P')x;
--239 total rows - hodnoty pro CHAMP01
--86 pp zruseno ve stejny den jako zalozeno

--1228 radku pro CHAMP01

--some duplicates there
select customer_id, subscriber_no, count(*) from (

select datediff(expiration_date, effective_date), * from base.import_fokus_base_service_agreement where soc = 'FLEXPA53' and
 expiration_date >= cast('2018-09-01' as timestamp) and 
expiration_date <= cast('2018-09-30' as timestamp)
and datediff(expiration_date, effective_date) <= 30) x
group by customer_id, subscriber_no having count(*) > 1 
;


select count(*) from base.import_fokus_base_service_agreement where soc = 'CHAMP01' and
 expiration_date >= cast('2018-09-01' as timestamp) and 
expiration_date <= cast('2018-09-30' as timestamp)
and datediff(expiration_date, effective_date) + 1 <= 30;

select * from analytics.abt_subscribed_product_history
where
 expiration_date >= cast('2018-09-01' as timestamp) and 
expiration_date <= cast('2018-09-30' as timestamp)
and datediff(expiration_date, effective_date) + 1 <= 30
and soc = 'CHAMP01' and product_line = 'Mobile' and campaign = 'CHAMP01' 
and product_group = 'Postpaid BtC' and product_desc = 'ONE Fri/Fri'
order by ban, subscriber_no
;

--count per ban, subscriber_no
select ban, subscriber_no, count(*) from (
select * from analytics.abt_subscribed_product_history
where
 expiration_date >= cast('2018-09-01' as timestamp) and 
expiration_date <= cast('2018-09-30' as timestamp)
and datediff(expiration_date, effective_date) + 1 <= 30
and soc = 'CHAMP01' and product_line = 'Mobile' and campaign = 'CHAMP01' 
and product_group = 'Postpaid BtC' and product_desc = 'ONE Fri/Fri'
) x
group by
ban, subscriber_no
having count(*) > 1
;
-------------------------------------------------------------------------------------
--CHAMP01: report 63, DSS 96
--1228 in base service agreement
select * from base.import_fokus_base_service_agreement where soc = 'CHAMP01' and
 expiration_date >= cast('2018-09-01' as timestamp) and 
expiration_date <= cast('2018-09-30' as timestamp)
and datediff(expiration_date, effective_date) + 1 <= 30
and service_type in ('P', 'M', 'N');


--one step before join to subscriber: 64 vs 63 in report
select * from work.base_equation_kpis_work_subscribed_product_last
where
 expiration_date >= cast('2018-09-01' as timestamp) and 
expiration_date <= cast('2018-09-30' as timestamp)
and datediff(expiration_date, effective_date) + 1 <= 30
and soc = 'CHAMP01' and product_line = 'Mobile'/* and campaign = 'CHAMP01' */
and product_group = 'Postpaid BtC' and product_desc = 'ONE Fri/Fri'
order by ban, subscriber_no
;

--counts per campaign
select campaign, count(*) from work.base_equation_kpis_work_subscribed_product_last
where
 expiration_date >= cast('2018-09-01' as timestamp) and 
expiration_date <= cast('2018-09-30' as timestamp)
and datediff(expiration_date, effective_date) + 1 <= 30
and soc = 'CHAMP01' and product_line = 'Mobile'/* and campaign = 'CHAMP01' */
and product_group = 'Postpaid BtC' and product_desc = 'ONE Fri/Fri'
group by campaign;


--subscriber
select * from analytics.abt_subscriber_current 
where datediff(churn_date_id, coalesce(sales_date, act_date_id)) + 1 <= 30
and  churn_date_id >= cast('2018-09-01' as timestamp) 
and churn_date_id <= cast('2018-09-30' as timestamp)
;

--manual join: 58
select a.subscriber_id, a.start_date, a.end_date, a.churn_date_id, b.effective_date, b.expiration_date from (
select * from analytics.abt_subscriber_current
where datediff(churn_date_id, coalesce(sales_date, act_date_id)) + 1 <= 30
) a
left outer join 
(
select * from work.base_equation_kpis_work_subscribed_product_last
--where
-- expiration_date >= cast('2018-09-01' as timestamp) and 
--expiration_date <= cast('2018-09-30' as timestamp)
--and datediff(expiration_date, effective_date) + 1 <= 30
--and soc = 'CHAMP01' and product_line = 'Mobile'/* and campaign = 'CHAMP01' */
--and product_group = 'Postpaid BtC' and product_desc = 'ONE Fri/Fri'
)b
on a.subscriber_no = b.subscriber_no and
a.customer_id = b.ban
where
a.churn_date_id >= cast('2018-09-01' as timestamp) 
and a.churn_date_id <= cast('2018-09-30' as timestamp)
and soc = 'CHAMP01'
;

--pokud se effective a expiration po trunc nerovnaji, tak k expiration pridat 1 sec takze mist o23 59 59 bude 00 00 00

--churn excluding annulments: 754
select count(*) /* a.subscriber_id, a.start_date, a.end_date, a.churn_date_id, b.effective_date, b.expiration_date */ from (
select * from analytics.abt_subscriber_current
where datediff(churn_date_id, coalesce(sales_date, act_date_id)) + 1 > 30
) a
left outer join 
(
select * from work.base_equation_kpis_work_subscribed_product_last
--where
-- expiration_date >= cast('2018-09-01' as timestamp) and 
--expiration_date <= cast('2018-09-30' as timestamp)
--and datediff(expiration_date, effective_date) + 1 <= 30
--and soc = 'CHAMP01' and product_line = 'Mobile'/* and campaign = 'CHAMP01' */
--and product_group = 'Postpaid BtC' and product_desc = 'ONE Fri/Fri'
)b
on a.subscriber_no = b.subscriber_no and
a.customer_id = b.ban
where
a.churn_date_id >= cast('2018-09-01' as timestamp) 
and a.churn_date_id <= cast('2018-09-30' as timestamp)
and soc = 'CHAMP01'
;

--after join: 95
select * from work.base_equation_kpis_work_annulment_kpi_product
where
 churn_date_id >= cast('2018-09-01' as timestamp) and 
churn_date_id <= cast('2018-09-30' as timestamp) and

--and datediff(expiration_date, effective_date) + 1 <= 30
 soc = 'CHAMP01';

--abt product history: 383
select * from analytics.abt_subscribed_product_history
where
 expiration_date >= cast('2018-09-01' as timestamp) and 
expiration_date <= cast('2018-09-30' as timestamp)
and datediff(expiration_date, effective_date) + 1 <= 30
and soc = 'CHAMP01' and product_line = 'Mobile' and campaign = 'CHAMP01' 
and product_group = 'Postpaid BtC' and product_desc = 'ONE Fri/Fri'
order by ban, subscriber_no
;

--base agreement: 1242
select datediff(expiration_date, effective_date), * from base.import_fokus_base_service_agreement where soc = 'CHAMP01' and
 expiration_date >= cast('2018-09-01' as timestamp) and 
expiration_date <= cast('2018-09-30' as timestamp)
and datediff(expiration_date, effective_date) <= 30
and service_type = 'P';




--------------------------------------------------------------------------------------
--CHAMPEB: Report 96, DSS 174
--one step before join to subscriber: 74 with campaign filter
select * from work.base_equation_kpis_work_subscribed_product_last
where
 expiration_date >= cast('2018-09-01' as timestamp) and 
expiration_date <= cast('2018-09-30' as timestamp)
and datediff(expiration_date, effective_date) + 1 <= 30
and soc = 'CHAMPEB' and product_line = 'Mobile' /* and campaign = 'CHAMPEB' */
and product_group = 'Postpaid BtC' and product_desc = 'ONE+ Fri/Fri'
order by ban, subscriber_no
;
--count per campaign
select campaign, count(*) from work.base_equation_kpis_work_subscribed_product_last
where
 expiration_date >= cast('2018-09-01' as timestamp) and 
expiration_date <= cast('2018-09-30' as timestamp)
and datediff(expiration_date, effective_date) + 1 <= 30
and soc = 'CHAMPEB' and product_line = 'Mobile' /*and campaign = 'CHAMPEB' */
and product_group = 'Postpaid BtC' and product_desc = 'ONE+ Fri/Fri'
group by campaign
;

--manual join: 109
select a.subscriber_id, a.start_date, a.end_date, a.churn_date_id, b.effective_date, b.expiration_date from (
select * from analytics.abt_subscriber_current
where datediff(churn_date_id, coalesce(sales_date, act_date_id)) + 1 <= 30
) a
left outer join 
(
select * from work.base_equation_kpis_work_subscribed_product_last
where
 expiration_date >= cast('2018-09-01' as timestamp) and 
expiration_date <= cast('2018-09-30' as timestamp)
--and datediff(expiration_date, effective_date) + 1 <= 30
--and soc = 'CHAMP01' and product_line = 'Mobile'/* and campaign = 'CHAMP01' */
--and product_group = 'Postpaid BtC' and product_desc = 'ONE Fri/Fri'
)b
on a.subscriber_no = b.subscriber_no and
a.customer_id = b.ban
where
a.churn_date_id >= cast('2018-09-01' as timestamp) 
and a.churn_date_id <= cast('2018-09-30' as timestamp)
and soc = 'CHAMPEB'
;

--after join: 170
select * from work.base_equation_kpis_work_annulment_kpi_product
where
 churn_date_id >= cast('2018-09-01' as timestamp) and 
churn_date_id <= cast('2018-09-30' as timestamp)
--and datediff(expiration_date, effective_date) + 1 <= 30
and soc = 'CHAMPEB';



--source for products: 113
select * from analytics.abt_subscribed_product_history
where
 expiration_date >= cast('2018-09-01' as timestamp) and 
expiration_date <= cast('2018-09-30' as timestamp)
and datediff(expiration_date, effective_date) + 1 <= 30
and soc = 'CHAMPEB' and product_line = 'Mobile' and campaign = 'CHAMPEB' 
and product_group = 'Postpaid BtC' and product_desc = 'ONE+ Fri/Fri'
order by ban, subscriber_no;

--base agreement: 847
select datediff(expiration_date, effective_date), * from base.import_fokus_base_service_agreement where soc = 'CHAMPEB' and
 expiration_date >= cast('2018-09-01' as timestamp) and 
expiration_date <= cast('2018-09-30' as timestamp)
and datediff(expiration_date, effective_date) <= 30
and service_type = 'P';



-----------------------------------------------------------------------
--FLEXPA53: Report 31, DSS: 75

--1 - malo
select * from work.base_equation_kpis_work_subscribed_product_last
where
 expiration_date >= cast('2018-09-01' as timestamp) and 
expiration_date <= cast('2018-09-30' as timestamp)
and datediff(expiration_date, effective_date) + 1 <= 30
and soc = 'FLEXPA53' and product_line = 'Mobile' and campaign = 'FLEXPA53' 
and product_group = 'Postpaid BtC' and product_desc = 'Telia Stay'
order by ban, subscriber_no
;

--manual join 
select a.subscriber_id, a.start_date, a.end_date, a.churn_date_id, b.effective_date, b.expiration_date,
soc, b.campaign, b.promotion from (
select * from analytics.abt_subscriber_current
where datediff(churn_date_id, coalesce(sales_date, act_date_id)) + 1 <= 30
) a
left outer join 
(
select * from work.base_equation_kpis_work_subscribed_product_last
where
 expiration_date >= cast('2018-09-01' as timestamp) and 
expiration_date <= cast('2018-09-30' as timestamp)
--and datediff(expiration_date, effective_date) + 1 <= 30
--and soc = 'CHAMP01' and product_line = 'Mobile'/* and campaign = 'CHAMP01' */
--and product_group = 'Postpaid BtC' and product_desc = 'ONE Fri/Fri'
)b
on a.subscriber_no = b.subscriber_no and
a.customer_id = b.ban
where
a.churn_date_id >= cast('2018-09-01' as timestamp) 
and a.churn_date_id <= cast('2018-09-30' as timestamp)
and soc = 'FLEXPA53';

--source for products: 3
select * from analytics.abt_subscribed_product_history
where
 expiration_date >= cast('2018-09-01' as timestamp) and 
expiration_date <= cast('2018-09-30' as timestamp)
and datediff(expiration_date, effective_date) + 1 <= 30
and soc = 'FLEXPA53' and product_line = 'Mobile' and campaign = 'FLEXPA53' 
and product_group = 'Postpaid BtC' and product_desc = 'Telia Stay'
order by ban, subscriber_no;

--base agreement: 239
select datediff(expiration_date, effective_date), * from base.import_fokus_base_service_agreement where soc = 'FLEXPA53' and
 expiration_date >= cast('2018-09-01' as timestamp) and 
expiration_date <= cast('2018-09-30' as timestamp)
and datediff(expiration_date, effective_date) <= 30
and service_type = 'P';

----------------------------------------------------------------------------------------------------------------

--CMMBBVIP2: manual join 
select a.subscriber_id, a.start_date, a.end_date, a.churn_date_id, b.effective_date, b.expiration_date,
soc, b.campaign, b.promotion from (
select * from analytics.abt_subscriber_current
where datediff(churn_date_id, coalesce(sales_date, act_date_id)) + 1 <= 30
) a
left outer join 
(
select * from work.base_equation_kpis_work_subscribed_product_last
where
 expiration_date >= cast('2018-09-01' as timestamp) and 
expiration_date <= cast('2018-09-30' as timestamp)
--and datediff(expiration_date, effective_date) + 1 <= 30
--and soc = 'CHAMP01' and product_line = 'Mobile'/* and campaign = 'CHAMP01' */
--and product_group = 'Postpaid BtC' and product_desc = 'ONE Fri/Fri'
)b
on a.subscriber_no = b.subscriber_no and
a.customer_id = b.ban
where
a.churn_date_id >= cast('2018-09-01' as timestamp) 
and a.churn_date_id <= cast('2018-09-30' as timestamp)
and soc = 'CMMBBVIP2';

-- P_MBB03 manual join 
select a.subscriber_id, a.start_date, a.end_date, a.churn_date_id, b.effective_date, b.expiration_date,
soc, b.campaign, b.promotion from (
select * from analytics.abt_subscriber_current
where datediff(churn_date_id, coalesce(sales_date, act_date_id)) + 1 <= 30
) a
left outer join 
(
select * from work.base_equation_kpis_work_subscribed_product_last
where
 expiration_date >= cast('2018-09-01' as timestamp) and 
expiration_date <= cast('2018-09-30' as timestamp)
--and datediff(expiration_date, effective_date) + 1 <= 30
--and soc = 'CHAMP01' and product_line = 'Mobile'/* and campaign = 'CHAMP01' */
--and product_group = 'Postpaid BtC' and product_desc = 'ONE Fri/Fri'
)b
on a.subscriber_no = b.subscriber_no and
a.customer_id = b.ban
where
a.churn_date_id >= cast('2018-09-01' as timestamp) 
and a.churn_date_id <= cast('2018-09-30' as timestamp)
and soc = 'P_MBB03';

select * from work.base_equation_work_address where customer_id = 636857906 and link_type = 'L';

select * from analytics.abt_customer_history where customer_id = 636857906;

select robinson, count(*) from work.base_equation_work_customer_robinson group by robinson;

select adr_street_name, adr_house_letter, adr_house_no, adr_street_name_join, robinson
from work.base_equation_work_customer_robinson;

select robinson, count(*) from analytics.abt_customer_history group by robinson;

select * from analytics.abt_customer_history where customer_id = 622413201;

select * from base.import_fokus_base_ban_pym_mtd where ban = 622413201;

select ;

select * from work.base_equation_work_customer_hist where ban = 622413201;

select * from temp.base_equation_tmp_ban_pym_mtd_ranked where ban = 622413201;

select case when payment_method_id is not null then "Payment" else "NoPayment" end,
count(*) from analytics.abt_customer_history 
group by case when payment_method_id is not null then "Payment" else "NoPayment" end 
