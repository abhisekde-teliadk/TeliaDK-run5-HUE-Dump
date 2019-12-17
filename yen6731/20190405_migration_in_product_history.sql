select distinct migration_date, subscriber_no, subscriber_id, customer_id, from_product_subgroup, to_product_subgroup
from analytics.abt_migration_kpi where subscriber_no='GSM04520192324' --GSM04520111036
and migration_date > trunc(now() + interval -1 years,'year')
order by migration_date desc;

-- join migartion_kpi with product to get product_soubgroup
select m.*, fp.product_subgroup as from_product_subgroup, tp.product_subgroup as to_product_subgroup, fp.product_id
from work.base_equation_kpis_tbt_migration_kpi m
left join work.base_equation_product_tbt_product fp
on from_product_id=fp.product_id
left join work.base_equation_product_tbt_product tp
on to_product_id=tp.product_id
where subscriber_no='GSM04520192324'--GSM04520111036
--and ban=641282900
and migration_date > trunc(now() + interval -1 years,'year')
order by migration_date desc;


select * from work.base_equation_kpis_tbt_migration_kpi where ban in (851037119,979932217);
select * from work.base_equation_product_tbt_subscribed_product_history where ban in (851037119,979932217) order by effective_date desc;
select * from work.base_equation_product_tbt_subscribed_product_history where ban in (851037119) and subscriber_no='GSM04520192324';
select * from work.base_equation_product_tbt_subscribed_product_history where ban in (979932217) and subscriber_no='GSM04520192324';

select * from work.base_equation_kpis_work_subscribed_product_change where ban in (851037119);
select * from work.base_equation_kpis_work_subscribed_product_change where ban in (979932217);

select customer_id,status from work.base_equation_sub_tbt_subscriber_history where subscriber_no in ('GSM04520192324') order by start_date desc;
select * from work.base_equation_sub_tbt_subscriber_history where subscriber_no in ('GSM04520111036') order by start_date desc;

select * from base.import_fokus_base_service_agreement where subscriber_no='GSM04520192324' order by sys_creation_date desc; --ban=851037119;

select subscriber_no, active_record_flag, count(*) from work.base_equation_sub_tbt_subscriber_history
where active_record_flag=true --and subscriber_no='GSM04528405412'
group by subscriber_no, active_record_flag having count(*)>1 --where subscriber_no in ('GSM04520192324')