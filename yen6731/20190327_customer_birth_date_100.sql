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
    where 
    birth_date > now()
    /*customer_id in (
    select customer_id from analytics.abt_customer_history where birth_date > now()
    )*/
    order by birth_date asc;

    
    
-- odecist 100 let!!!
select distinct customer_id, cpr_no, birth_date
from work.base_equation_sub_tbt_customer_history where customer_id = 100628628;



select customer_id from work.base_equation_sub_tbt_customer_history where birth_date > CAST('2007-12-31' as timestamp)

-- OK
--570130807


--NOK
--100628628