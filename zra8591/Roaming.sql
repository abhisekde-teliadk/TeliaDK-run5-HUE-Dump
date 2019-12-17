select distinct nrtype from analytics.abt_gruppetrafik;

drop table if exists sandbox.roaming_split_data;
create table sandbox.roaming_split_data as 
select 
    roaming_country
    ,nrtype
    ,collected_voice_min
    ,event_count as antal
    ,collected_data_mb
    ,call_month
    ,substring(cast(call_month as string),1,4) as year
    ,at_soc
    ,soc_description
    ,price_plan_code
    ,bp_category_desc
from analytics.abt_gruppetrafik
-- where at_soc='CORUSA5G'

where 
(bp_category_desc ='Foretaget i udlandet'
or bp_category_desc='Internet/data i udlandet'
or bp_category_desc='Foretaget i udlandet (MMS)'
or bp_category_desc='Opkald i udlandet'
or bp_category_desc='Opkald modtaget i udlandet')
and substring(cast(call_month as string),1,4) ='2019'

;



select * from analytics.abt_subscriber_history
where lower(customer_identify) like "grundfos%";

SELECT distinct  roaming_country, country_name FROM sandbox.roaming_cost_roaming_split_priser
where roaming_country is null or country_name is null;



