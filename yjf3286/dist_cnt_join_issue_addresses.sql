select count(*) from work.BASE_EQUATION_KPIS_FAT_work_all_kpis_fat_distinct_date; --12M
select count(*) from work.base_equation_sub_tbt_customer_history; --32M



select count(*), cust_cust_adr_door_no_join, cust_cust_adr_story_join, cust_cust_adr_house_letter_join, cust_cust_adr_country_join, cust_cust_adr_street_name_join, cust_cust_adr_direction_join, cust_cust_adr_pob_join, cust_cust_adr_house_no_join, cust_cust_adr_zip_join
from work.BASE_EQUATION_KPIS_FAT_work_all_kpis_fat_distinct_date group by 
cust_cust_adr_door_no_join, cust_cust_adr_story_join, cust_cust_adr_house_letter_join, cust_cust_adr_country_join, cust_cust_adr_street_name_join, cust_cust_adr_direction_join, cust_cust_adr_pob_join, cust_cust_adr_house_no_join, cust_cust_adr_zip_join
order by 1 desc;

show partitions analytics.prod_abt_traffic;

select 
 count(*),
 adr_city,
 adr_co_name,
 adr_country,
 adr_direction,
 adr_district,
 adr_door_no,
 adr_house_letter,
 adr_house_no,
 adr_pob,
 adr_story,
 adr_street_name,
 adr_zip
from work.base_equation_sub_tbt_customer_history
group by 
 adr_city,
 adr_co_name,
 adr_country,
 adr_direction,
 adr_district,
 adr_door_no,
 adr_house_letter,
 adr_house_no,
 adr_pob,
 adr_story,
 adr_street_name,
 adr_zip order by 1 desc;
 
 select count(*) from work.base_equation_sub_tbt_customer_history where adr_city is null;
 
 --3977047 -- adr_city is null
 --3977003 -- most frequent combination with adr_city == null
 
 
 