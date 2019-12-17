SELECT 
distinct
    base_address_name_link.customer_id AS customer_id,
    base_name_data.last_business_name AS last_business_name,
    base_name_data.first_name AS first_name,
    base_name_data.birth_date AS birth_date,
    base_name_data.identify AS identify
  FROM (
    SELECT base_address_name_link.*
      FROM base.import_fokus_base_address_name_link base_address_name_link
      WHERE link_type in ('U', 'L')
    ) base_address_name_link
  LEFT JOIN base.import_fokus_base_name_data base_name_data
    ON base_address_name_link.name_id = base_name_data.name_id
    --where base_name_data.birth_date > '1900-01-01 00:00:00'
    where customer_id = 110094603
    order by birth_date asc;

If cpr_no contains 10 digits  then

( test of cprnumber cpr_no )

       case when mod((cast(substr(cast(cpr_no as string),1,1) as int) *4 +

                    cast(substr(cast(cpr_no as string),2,1) as int) *3 +

                    cast(substr(cast(cpr_no as string),3,1) as int) *2 +

                    cast(substr(cast(cpr_no as string),4,1) as int) *7 +

                    cast(substr(cast(cpr_no as string),5,1) as int) *6 +

                    cast(substr(cast(cpr_no as string),6,1) as int) *5 +

                    cast(substr(cast(cpr_no as string),7,1) as int) *4 +

                    cast(substr(cast(cpr_no as string),8,1) as int) *3 +

                    cast(substr(cast(cpr_no as string),9,1) as int) *2 +

                    cast(substr(cast(cpr_no as string),10,1) as int) *1 ), 11) = 0 then 'OK' else 'ERROR'

       end as cpr_status
       
if(length(cpr_no) == 10 && not(isError(asDate(substring(cpr_no,0,6),'ddMMyy'))),
if(diff(asDate(substring(cpr_no,0,6),'ddMMyy'), asDate(now(), 'yyyy-MM-dd'), 'days') >= 1, inc(asDate(substring(cpr_no,0,6),'ddMMyy'),-100,'year'), asDate(substring(cpr_no,0,6),'ddMMyy'))
, if(not(isError(asDate(name_birth_date, 'dd-MM-yyyy'))),name_birth_date,null));

select distinct
case when length(cpr_no) = 10 then
    case when mod((cast(substr(cast(cpr_no as string),1,1) as int) *4 +
               cast(substr(cast(cpr_no as string),2,1) as int) *3 +
               cast(substr(cast(cpr_no as string),3,1) as int) *2 +
               cast(substr(cast(cpr_no as string),4,1) as int) *7 +
               cast(substr(cast(cpr_no as string),5,1) as int) *6 +
               cast(substr(cast(cpr_no as string),6,1) as int) *5 +
               cast(substr(cast(cpr_no as string),7,1) as int) *4 +
               cast(substr(cast(cpr_no as string),8,1) as int) *3 +
               cast(substr(cast(cpr_no as string),9,1) as int) *2 +
               cast(substr(cast(cpr_no as string),10,1) as int) *1 ), 11) = 0 then 'OK' else 'ERROR'
               end
else 'ERROR'               
end
as src,
customer_id, cpr_no, birth_date 
--from work.base_equation_sub_tbt_customer_history
from work.base_equation_sub_work_customer_deduplicated
where customer_id in(586761116,554925008, 496761115, 387400005)
order by customer_id;

select distinct customer_id, cpr_no, identify, cpr_no_status from work.base_equation_sub_work_customer_deduplicated where customer_id in(586761116,554925008, 496761115, 387400005);
select distinct customer_id, cpr_no, identify from work.base_equation_sub_work_customer_robinson where customer_id in(586761116,554925008, 496761115, 387400005);


SELECT

distinct

    base_address_name_link.customer_id AS customer_id,

    base_name_data.last_business_name AS last_business_name,

    base_name_data.first_name AS first_name,

    base_name_data.birth_date AS birth_date,

    base_name_data.identify AS identify

  FROM (

    SELECT base_address_name_link.*

      FROM base.import_fokus_base_address_name_link base_address_name_link

      WHERE link_type in ('U', 'L')

    ) base_address_name_link

  LEFT JOIN base.import_fokus_base_name_data base_name_data

    ON base_address_name_link.name_id = base_name_data.name_id

    where customer_id in (

    select customer_id from work.base_equation_sub_tbt_customer_history where birth_date > now()

    )

    order by customer_id, birth_date;

select * from work.base_equation_sub_tbt_customer_history where customer_id=538452707;

select substring('08021971',1,4) from work.base_equation_sub_tbt_customer_history where customer_id=538452707;