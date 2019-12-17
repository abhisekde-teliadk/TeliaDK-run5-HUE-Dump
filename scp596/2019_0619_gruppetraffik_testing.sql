select 
*  
from work.base_equation_kpis_tbt_churn_kpi where subscriber_no = 'GSM04529138208' and customer_id = 418214219;

select count(*) from work.base_equation_kpis_fat_work_churn_annulment_device_unique;

select nrm_population, * from work.crt_subscriber where fokus_subscriber_id = '16099754';

select * from work.export_to_portrait_party_converted where party_id = '16099754';

select * from work.export_to_portrait_subscriber_prepared where party_id = '16099754';

select population, * from work.crt_subscriber_product where subscriber_id = 16099754;

select * from work.crt_subscriber_act_date where subscriber_id = 16099754;

select * from work.crt_work_subscriber_min_act_date where subscriber_id = 16099754;

select * from work.crt_customer1 where ban = 860169705;

select * from base.import_fokus_base_billing_account where ban = 860169705;

select * from work.crt_address_name where customer_id = 860169705 and link_type = 'L';

select customer_id, link_type, count(*) from work.crt_address_name where  link_type = 'L' group by customer_id, link_type
having count(*) > 1
;

select * from base.import_fokus_base_insurance_subscriptions where ban = 676704901 and subscriber_no = 'GSM04561743575';

select * from work.crt_work_normalization_distinct where population = 'Mit Tele Postpaid BtB';

select * from work.crt_work_subscriber_sa_window where ban = 676704901 and subscriber_no = 'GSM04561743575';

select * from work.crt_work_subscriber_email_last_change where customer_id = 676704901 and subscriber_no = 'GSM04561743575';

select customer_id, subscriber_no, count(*) from work.crt_work_subscriber_email_last_change 
group by customer_id, subscriber_no
having count(*) > 1;

select * from work.crt_work_subscriber_email where customer_id = 676704901 and subscriber_no = 'GSM04561743575';

select * from work.crt_work_subscriber_email_windows where customer_id = 676704901 and subscriber_no = 'GSM04561743575';

select * from work.crt_work_subscriber_email_last_change where customer_id = 676704901 and subscriber_no = 'GSM04561743575';



5138196;

select fokus_subscriber_id, count(*) from work.crt_subscriber group by fokus_subscriber_id having count(*) > 1;



select 
distinct 
fokus_subscriber_id, 
access_installation_address, 
access_installation_zipcode, 
access_installation_city 
from 
work.crt_subscriber  
where 
fokus_subscriber_id in ( 
'16300634', 
'16299530', 
'16298456', 
'16297033', 
'16297779', 
'16296811' 
) 

; 

select 

* 

from  

work.crt_work_tnid_techinfo_deduplicated 

where 

tnid_circuit_number = 'TB-402062'; 

select tnid_circuit_number, count(*) from  
work.crt_work_tnid_techinfo_deduplicated group by tnid_circuit_number having count(*) > 1; 

select * from work.crt_subscriber where fokus_subscriber_id = '16296811';

select * from work.crt_subscriber where fokus_subscriber_id = '16296811';

select * from work.crt_subscriber_act_date where subscriber_id = 16296811;

select * from work.crt_work_subscriber_min_act_date where subscriber_id = 16296811;

select * from base.import_fokus_base_address_name_link where customer_id = 860169705 and link_type = 'L';

select * from base.import_fokus_base_name_data where name_id in (268365328, 268365327);

select * from work.crt_address_name where customer_id = 860169705 and link_type = 'L' ;

select fokus_subscriber_id, count(*)  from work.crt_subscriber_insurance group by 
fokus_subscriber_id
having count(*) > 1;

select fokus_subscriber_id, count(*)  from work.crt_subscriber group by 
fokus_subscriber_id
having count(*) > 1;

select ban, count(*) from work.crt_customer group by ban having count(*) > 1;

select cycle_run_month, cycle_run_year, call_month, bill_month1, bill_month2, * from analytics.abt_gruppetrafik where 
;

select sum(at_call_dur_sec) from base.import_fokus_base_fokus_detail_usage where ban = 425252012 and call_date between
to_timestamp('01/04/2019', 'dd/MM/yyyy') and to_timestamp('30/04/2019', 'dd/MM/yyyy') and call_type = 'D'
and unit_measure_code = 'M'
--1 141 796
;


-- ********************** baseline = record cnt and duration sum in detail usage for one big ban **********************
select count(*) from work.gruppetrafik_work_detail_usage_by_day where 
ban = 425252012 and call_date between
to_timestamp('01/04/2019', 'dd/MM/yyyy') and to_timestamp('30/04/2019', 'dd/MM/yyyy') and call_type = 'D'
and unit_measure_code = 'M';
-- sum voice: 1141796
--record cnt: 23173

select * from work.gruppetrafik_work_detail_usage_by_day where 
ban = 425252012 and call_date between
to_timestamp('01/04/2019', 'dd/MM/yyyy') and to_timestamp('30/04/2019', 'dd/MM/yyyy') and call_type = 'D'
and unit_measure_code = 'M';

select distinct at_soc, at_feature_code from work.gruppetrafik_work_detail_usage_by_day where 
ban = 425252012 and call_date between
to_timestamp('01/04/2019', 'dd/MM/yyyy') and to_timestamp('30/04/2019', 'dd/MM/yyyy') and call_type = 'D'
and unit_measure_code = 'M'
--and subscriber_no = 'GSM04552358040' and
--call_date = to_timestamp('17/04/2019', 'dd/MM/yyyy')
;


select * from work.gruppetrafik_work_subscriber_segment where subscriber_no = 'GSM04552358040'
and customer_id = 425252012;

select soc, effective_date, expiration_date, *  from base.import_fokus_base_soc where soc = 'MOBFL100';

select * from base.import_fokus_base_roaming_operator where roaming_operator_cd is null;

select effective_date, expiration_date, soc, feature_code, toll_rs_code from 
base.import_fokus_base_uc_rated_feature where soc = 'MOBFL100' and feature_code = 'MVOI';

select effective_date, expiration_date, soc, feature_code, toll_rs_code from 
work.gruppetrafik_work_dist_uc_rated_feature where soc = 'MOBFL100' and feature_code = 'MVOI';

select effective_date, expiration_date, * from base.import_fokus_base_uc_rated_feature where soc = 'DEFSOC' 
and feature_code = 'MTOVM' and effective_date >= to_timestamp('01/01/2019', 'dd/MM/yyyy');


select count(*) from work.gruppetrafik_work_usage_date_joins where 
ban = 425252012 and call_date between
to_timestamp('01/04/2019', 'dd/MM/yyyy') and to_timestamp('30/04/2019', 'dd/MM/yyyy') and call_type = 'D'
and unit_measure_code = 'M';
-- sum voice 1141796
-- record cnt: 23173


select sum(at_call_dur_sec_sum) from work.gruppetrafik_work_usage_date_zones where 
ban = 425252012 and call_date between
to_timestamp('01/04/2019', 'dd/MM/yyyy') and to_timestamp('30/04/2019', 'dd/MM/yyyy') and call_type = 'D'
and unit_measure_code = 'M';
-- sum voice 1141796
-- record cnt: 23173


select count(*) from work.gruppetrafik_work_gruppe_traffic_month where 
ban = 425252012 and call_month = to_timestamp('01/04/2019', 'dd/MM/yyyy') and call_type = 'D'
and unit_measure_code = 'M';
-- sum voice 1141796

select sum(at_call_dur_sec_sum) from work.gruppetrafik_work_gruppe_traffic_details where 
ban = 425252012 and call_month = to_timestamp('01/04/2019', 'dd/MM/yyyy') and call_type = 'D'
and unit_measure_code = 'M';
--1141796


select sum(at_call_dur_sec) from analytics.abt_gruppetrafik
where call_month = 201904 and ban = 425252012 and call_type = 'D' and unit_measure_code = 'M';
--1141796

--data are 0 if it is voice call - OK

select distinct collected_data_mb from analytics.abt_gruppetrafik
where call_month = 201904 and ban = 425252012 and call_type = 'D' and unit_measure_code = 'M';


--data traffic verification
select * from analytics.abt_gruppetrafik
where call_month = 201904 and ban = 425252012 and call_type = 'D' and unit_measure_code = 'A';
--2832750975579
--2832750975579


select sum(at_call_dur_sec) from base.import_fokus_base_fokus_detail_usage where ban = 425252012 and call_date between
to_timestamp('01/04/2019', 'dd/MM/yyyy') and to_timestamp('30/04/2019', 'dd/MM/yyyy') and call_type = 'D'
and unit_measure_code = 'A';


select unit_measure_code, count(*) from analytics.abt_gruppetrafik
where call_month = 201904 and ban = 425252012
group by unit_measure_code; 

--if it is roaming  then Roaming country is filled - OK
select * from analytics.abt_gruppetrafik
where call_month = 201904 and ban = 425252012 and call_type = 'R' and roaming_country is null;

--if it is call to roamer then called country is filled - OK
select * from analytics.abt_gruppetrafik
where call_month = 201904 and ban = 425252012 and call_type = 'L' and called_country_name is null;

select * from analytics.abt_gruppetrafik
where call_month = 201904 and ban = 425252012 and call_type = 'L' and called_country_name is null;


-----test of null/not null columns
select * from analytics.abt_gruppetrafik
where call_month = 201904 and ban = 425252012 and cvr_no is not null;

select  * from analytics.abt_gruppetrafik where cvr_no is not null;

select * from analytics.abt_gruppetrafik
where call_month = 201904 and ban = 425252012 and called_country_name is not null;

select * from work.base_equation_other_work_country where name like 'Germany Mobile Networks';

select * from analytics.abt_customer_current;

select * from base.import_fokus_base_foreign_country where country_name like 'Belgium Mobile Netw%';

select customer_id, count(subscriber_no) from analytics.abt_subscriber_current 
group by customer_id having count(*) > 100 order by 2 desc;


select * from work.crt_work_subscriber_min_act_date where subscriber_id = 16404588;

select count(*) from work.crt_work_subscriber_min_act_date; --8806285

select * from work.crt_subscriber_act_date where subscriber_id = 6482423;



select * from analytics.abt_subscriber_current where subscriber_id = 16404588;

select * from work.crt_work_subscriber_stacked where subscriber_id = 16404588;;


set request_pool = big;
select  

-- indicate in which dataset the subscribers are missing 

case when a.subscriber_id is null then 'NOT in CRT FILES' 

when b.subscriber_id is null then 'NOT in subscriber' 

end as join_type, 

* 

from  

-- get CRT subscribers 

analytics.abt_crt_subscriber a 

-- join base equation subscribers on subscriber_id 

right outer join ( 

select * 

from analytics.abt_subscriber_current 

where is_active=1 

) b on a.subscriber_id = b.subscriber_id 

where  

-- filter not joined subscribers 
(
a.subscriber_id is null 

or b.subscriber_id is null ) 

; 

select count(*) from work.crt_subscriber;