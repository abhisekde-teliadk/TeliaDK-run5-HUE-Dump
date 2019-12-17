select distinct customer_id, cpr_no, birth_date, cpr_no_status from work.base_equation_sub_work_customer_robinson where customer_id = 387400005;
select distinct customer_id, cpr_no, birth_date, cpr_no_status from work.base_equation_sub_work_customer_robinson where customer_id = 555120807;

select distinct customer_id, cpr_no, birth_date from work.base_equation_sub_work_customer_deduplicated where customer_id = 387400005;
select distinct customer_id, cpr_no, birth_date from work.base_equation_sub_work_customer_deduplicated where customer_id = 110094603;
--570130807

select distinct customer_id, cpr_no, birth_date from work.base_equation_sub_work_customer_deduplicated where birth_date > now();

-- FIXED, no birth_date in future
select distinct customer_id, cpr_no, birth_date from work.base_equation_sub_tbt_customer_history where birth_date > now();
select distinct customer_id, cpr_no, birth_date from work.base_equation_sub_tbt_customer_current where birth_date > now();

--ABT
select distinct customer_id, cpr_no, birth_date from analytics.abt_customer_history where birth_date > now();
select distinct customer_id, cpr_no, birth_date from analytics.abt_customer_current where birth_date > now();

-- NOT FIXED, no birth_date in last months/years
select distinct customer_id, cpr_no, birth_date from work.base_equation_sub_tbt_customer_history order by birth_date desc nulls last;
select distinct customer_id, cpr_no, birth_date from work.base_equation_sub_tbt_customer_current order by birth_date desc nulls last;

select distinct customer_id, cpr_no, birth_date from analytics.abt_customer_history order by birth_date desc nulls last;
select distinct customer_id, cpr_no, birth_date from analytics.abt_customer_current order by birth_date desc nulls last;

select distinct customer_id, cpr_no, birth_date, birth_date_from_cpr_no
from work.base_equation_sub_work_customer_deduplicated where birth_date_from_cpr_no is null;

---ROBINSON

select adr_secondary_ln, adr_primary_ln, adr_city, adr_zip, adr_house_no, adr_street_name,adr_door_no, count(*) as cnt
from work.base_equation_sub_work_address
group by adr_secondary_ln, adr_primary_ln, adr_city, adr_zip, adr_house_no, adr_door_no,adr_street_name
order by cnt desc;

SELECT *
FROM 
base.manual_files_base_robinson
where lower(street) like 'kanalgaden 3';

select robinson,
start_date,
end_date,
first_name,
last_business_name,
*
from analytics.abt_customer_current 
where lower(adr_primary_ln) like 'kanalgaden 3'
order by start_date
;

describe work.base_equation_sub_work_address;

select distinct adr_city from work.base_equation_sub_work_address where adr_zip='6650';