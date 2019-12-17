---ROBINSON

select adr_secondary_ln, adr_primary_ln, adr_city, adr_zip, adr_house_no, adr_street_name,adr_door_no, count(*) as cnt
from work.base_equation_sub_work_address
group by adr_secondary_ln, adr_primary_ln, adr_city, adr_zip, adr_house_no, adr_door_no,adr_street_name
order by cnt desc;

SELECT *
FROM 
base.manual_files_base_robinson
where lower(street) like 'dr sells vej 29';

select 
robinson,
start_date,
end_date,
first_name,
last_business_name,
*
from analytics.abt_customer_current
--from work.base_equation_sub_tbt_customer_current
where lower(adr_primary_ln) like 'dr sells vej 29';
--and customer_id=406644807;

select distinct * from work.base_equation_sub_work_address where lower(adr_primary_ln) like 'dr sells vej 29';
select distinct * from work.base_equation_sub_work_robinson_deduplicated where lower(street) like 'dr sells vej 29';
select count(*) from work.base_equation_sub_work_robinson_deduplicated; -- 1.539.747

--
select * from work.base_equation_sub_work_customer_deduplicated where lower(adr_primary_ln) like 'dr sells vej 29';


select distinct adr_city from work.base_equation_sub_work_address where adr_zip='6650';

select robinson,
start_date,
end_date,
first_name,
last_business_name,
*
from work.base_equation_sub_tbt_customer_current 
where lower(adr_primary_ln) like 'dr sells vej 29'
order by start_date
;

select count(*)
from work.base_equation_sub_tbt_customer_current 
where lower(adr_primary_ln) like 'dr sells vej 29'; --8

select count(*)
from work.base_equation_sub_tbt_customer_current; --3.735.030

select robinson,
start_date,
end_date,
first_name,
last_business_name,
*
from work.base_equation_sub_tbt_customer_history 
where --lower(adr_primary_ln) like 'dr sells vej 29'
robinson=0
order by start_date
;

-- FINALY
select robinson,
start_date,
end_date,
first_name,
last_business_name,
*
from analytics.abt_customer_current 
where lower(adr_primary_ln) like 'dr sells vej 29'
order by start_date
;

-- TESTING

--Need to find out address where is robinson flag set to 1 and check that there is somebody form that address in robinson file
select adr_primary_ln from work.base_equation_sub_tbt_customer_history where robinson=1;

select robinson,
start_date,
end_date,
first_name,
last_business_name,
adr_city,
adr_zip,
*
--from analytics.abt_customer_current 
from work.base_equation_sub_tbt_customer_current
where lower(adr_primary_ln) like lower('Annasvej 4')
order by robinson asc
;

select distinct
robinson,
first_name,
last_business_name
from analytics.abt_customer_current
--where lower(adr_primary_ln) like lower('Annasvej 4');
where lower(adr_primary_ln) like lower('Dr Sells Vej 29');


select distinct
robinson,
first_name,
last_business_name
from work.base_equation_sub_tbt_customer_history
--where lower(adr_primary_ln) like lower('Annasvej 4');
where lower(adr_primary_ln) like lower('Pedholtvej 7%');

select distinct
robinson,
first_name,
last_business_name,
adr_primary_ln
from work.base_equation_sub_tbt_customer_history
--where lower(adr_primary_ln) like lower('Annasvej 4');
where robinson=1;

select *
from work.base_equation_sub_work_robinson_deduplicated
where lower(street) like lower('Annasvej 4');
--where lower(street) like lower('Saltværksvej 47');

select *
from work.base_equation_sub_work_customer_hist
--where lower(adr_primary_ln) like lower('Annasvej 4');
where lower(adr_primary_ln) like lower('Saltværksvej 47, 1. tv.');

SELECT *--distinct surname, firstname, street, city
FROM 
base.manual_files_base_robinson
where street = 'Pedholtvej 7';
--where lower(street) like lower('Annasvej 4');


select adr_primary_ln from analytics.abt_customer_history  where robinson=0 
and lower(adr_primary_ln) in (select lower(street) FROM base.manual_files_base_robinson) ;


SELECT distinct concat(concat(adr_street_name, ' '),adr_house_no) AS adr_street_name_join FROM work.base_equation_sub_work_customer_hist where lower(adr_street_name) like lower('lundtoftevej');