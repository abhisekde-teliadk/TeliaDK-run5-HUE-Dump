select distinct --* 
migration_date, from_priceplan, to_priceplan, from_product_subgroup,to_product_subgroup, from_product_description,to_product_description, customer_id, subscriber_id, subscriber_no
from analytics.abt_migration_kpi
where subscriber_no='GSM04520111036'
order by migration_date desc;

select * from work.base_equation_kpis_work_subscribed_product_change;

--two cases examples
select * from sandbox.sandbox_stoszek_abt_migration_ref where subscriber_no='GSM04528408979';-- reported by Krystian
select * from sandbox.sandbox_stoszek_abt_migration_ref where subscriber_no='GSM04520111036'; 

select * from sandbox.sandbox_stoszek_abt_migration_ref where customer_id in (851037119,979932217); -- for subscriber_no='GSM04520192324'
select * from sandbox.sandbox_stoszek_abt_migration_ref where customer_id in (641282900); -- 4SURE->ONE+

select  distinct --* 
migration_date, from_priceplan, to_priceplan, from_product_subgroup,to_product_subgroup, from_product_description,to_product_description, customer_id, subscriber_id, subscriber_no
from analytics.abt_migration_kpi
where subscriber_no='GSM04520192324'
--customer_id=979932217
and migration_date > trunc(now() + interval -1 years,'year')
order by migration_date desc;

select count(*) from analytics.abt_migration_kpi; -- 43.604.108
select count(*) from (select distinct * from analytics.abt_migration_kpi) as t; -- 41.697.684

select count(*) from analytics.abt_migration_kpi where migration_date > trunc(now() + interval -1 years,'year'); -- 3.716.415

select count(*) from sandbox.sandbox_stoszek_abt_migration_ref where customer_id_abt is not null;

select migration_date, subscriber_no, subscriber_id, customer_id, from_product_subgroup, to_product_subgroup
from sandbox.sandbox_stoszek_abt_migration_ref where subscriber_no='GSM04520192324';

-- on 19.1.2019 customer_id=851037119 migrated form 4SURE to SMART15. BUT correctly, there should be customer_id=979932217 
select distinct migration_date, subscriber_no, subscriber_id, customer_id, from_product_subgroup, to_product_subgroup
from analytics.prod_abt_migration_kpi where subscriber_no='GSM04520192324'
order by migration_date desc;

--only customer_id=851037119 is present in subscribed_product_change entity
select distinct * from work.base_equation_kpis_work_subscribed_product_change where subscriber_no='GSM04520192324'
order by effective_date desc;

select  * from work.base_equation_product_tbt_subscribed_product_history where subscriber_no='GSM04528408979'
order by effective_date desc;

select  status,* from work.base_equation_sub_tbt_subscriber_history where subscriber_no='GSM04528408979'
order by start_date desc;


select distinct orig.subscriber_no, orig.customer_id, orig.subscriber_id, orig.migration_date, orig.from_product_subgroup, orig.to_product_subgroup, abt.from_product_subgroup, abt.to_product_subgroup
from sandbox.sandbox_stoszek_abt_migration_ref orig
left join analytics.abt_migration_kpi abt
on
orig.subscriber_no = abt.subscriber_no
and orig.subscriber_id = abt.subscriber_id
and orig.customer_id = abt.customer_id
and orig.from_product_subgroup = abt.from_product_subgroup
and orig.to_product_subgroup = abt.to_product_subgroup
where 
--abt.customer_id is null;
orig.subscriber_no='GSM04520111036';


-- join migartion_kpi with product to get product_soubgroup
select m.migration_date,m.ban,m.subscriber_no, m.subscriber_id, m.from_soc,m.from_campaign, fp.product_subgroup as from_product_subgroup, tp.product_subgroup as to_product_subgroup
from work.base_equation_kpis_tbt_migration_kpi m
left join work.base_equation_product_tbt_product fp
on from_product_id=fp.product_id
left join work.base_equation_product_tbt_product tp
on to_product_id=tp.product_id
where ban in (851037119,979932217)
--and ban=641282900
and migration_date > trunc(now() + interval -1 years,'year')
order by migration_date desc;


 select * from work.base_equation_product_tbt_subscribed_product_history where ban in (851037119,979932217) order by effective_date desc;
 
 select 'DEV' as src, count(*) from analytics.abt_migration_kpi
 UNION
 select 'PROD' as src, count(*) from analytics.prod_abt_migration_kpi;
 
 select count(*) from work.base_equation_kpis_tbt_migration_kpi;