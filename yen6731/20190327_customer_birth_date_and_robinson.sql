select cpr_no, birth_date from analytics.abt_customer_current where customer_id=735305005;

-- removed blank (" ") from cpr_no
select 'orig' as src, cpr_no, birth_date from work.base_equation_sub_work_customer_deduplicated where customer_id = 387400005
UNION
select 'tbt' as src, cpr_no, birth_date from work.base_equation_sub_tbt_customer_history where customer_id = 387400005;

select customer_id, cpr_no, birth_date from work.base_equation_sub_tbt_customer_history where birth_date > now();
select customer_id, cpr_no, birth_date from work.base_equation_sub_tbt_customer_history where birth_date > '2019-03-01 00:00:00';

select distinct customer_id, cpr_no, birth_date from work.base_equation_sub_tbt_customer_history where cpr_no='1810330399';

select distinct customer_id, cpr_no, birth_date from work.base_equation_sub_tbt_customer_history
where substring(cpr_no,5,2)='19' and birth_date is not null
order by birth_date desc;

select 'tbt' as src, cpr_no, birth_date from work.base_equation_sub_tbt_customer_history where customer_id = 400064705;

-- select those customers that have birth date in future
select customer_id, cpr_no, count(*) from work.base_equation_sub_tbt_customer_history where birth_date > now() group by customer_id,cpr_no;

select customer_id, cpr_no, count(*) from analytics.abt_customer_history where birth_date > now() group by customer_id,cpr_no;

-- strange cpr_no
select distinct 'orig' as src, customer_id, cpr_no, birth_date from work.base_equation_sub_work_customer_deduplicated where customer_id = 554925008
UNION ALL
select distinct 'tbt' as src,  customer_id, cpr_no, birth_date from work.base_equation_sub_tbt_customer_history  where customer_id = 554925008;

-- null birth_date counts
select 'orig' as src, count(*)  from work.base_equation_sub_work_customer_deduplicated  where birth_date is null
UNION ALL
select 'tbt' as src, count(*)  from work.base_equation_sub_tbt_customer_history  where birth_date is null;



select * from base.import_fokus_base_name_data where name_id = ;
select * from base.import_fokus_base_address_name_link where customer_id = 554925008;


-- *** ROBINSON ***

SELECT * FROM base.manual_files_base_robinson where lower(street) like 'dr sells vej 29';


SELECT * FROM work.base_equation_sub_work_robinson_deduplicated where lower(street) like 'dr sells vej 29';

select distinct robinson,start_date,end_date,first_name,last_business_name, * from work.base_equation_sub_work_customer_deduplicated where lower(adr_primary_ln) like 'dr sells vej 29'
order by start_date;
select distinct robinson,start_date,end_date,first_name,last_business_name, * from work.base_equation_sub_work_customer_robinson where lower(adr_primary_ln) like 'dr sells vej 29'
order by start_date;

select * from analytics.abt_customer_current where robinson=1;

select 833852700