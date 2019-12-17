select call_direction_id, count(*) 
from work.base_equation_work_traffic_partitioned where product_desc = '4EVERYTHING Premium u/b Spotify+HBO+RLH'
group by call_direction_id 
having count(*) > 1
;

select call_direction_id, count(*) 
from work.base_equation_work_traffic_partitioned /*where product_desc = '4EVERYTHING Premium u/b Spotify+HBO+RLH'*/
group by call_direction_id 
--having count(*) > 1
;

/*
call_direction_id
1,3 miliardy ma hodnotu 1
290000 ma 2
27 mil ma 4
57000 ma null
*/

select  ft.traffic_type_id ,u.* from base.import_fokus_base_detail_usage u left join base.manual_files_base_man_feature_translation ft
on u.at_feature_code = ft.at_feature_code 
where ft.traffic_type_id = 2 and subscriber_no = 'GSM04561697957' and trunc(call_date, 'MM') = cast('2018-01-01' as timestamp);

select sum(at_call_dur_sec)  from base.import_fokus_base_detail_usage u left join base.manual_files_base_man_feature_translation ft
on u.at_feature_code = ft.at_feature_code 
where ft.traffic_type_id = 2 and subscriber_no = 'GSM04561697957' and trunc(call_date, 'MM') = cast('2018-01-01' as timestamp);


where trafic_type_id = 2;

select * from base.manual_files_base_man_feature_translation where traffic_type_id = 2;

--sms count per subscriber per month
select *
from work.base_equation_work_traffic_partitioned where subscriber_no = 'GSM04561697957' and traffic_type_id = '2'
and event_month = '201801'
;

select sum(volume)
from work.base_equation_work_traffic_partitioned where subscriber_no = 'GSM04561697957' and traffic_type_id = '2' 
and event_month = '201801'
;

--source
select sum(at_call_dur_sec)  from base.import_fokus_base_detail_usage u left join base.manual_files_base_man_feature_translation ft
on u.at_feature_code = ft.at_feature_code  where ft.traffic_type_id = 2 and subscriber_no = 'GSM04561697957'; 


where ft.traffic_type_id = 2 and subscriber_no = 'GSM04561697957';

select * from work.base_equation_work_detail_usage_groupped
where subscriber_no = 'GSM04561697957' and
;

select sum(at_call_dur_sec_sum) from work.base_equation_work_traffic_agg where subscriber_no = 'GSM04561697957' 
and traffic_type_id = 2;
--22223

select sum(volume) from analytics.abt_traffic where subscriber_no = 'GSM04561697957' 
and traffic_type_id = 2;

select * from work.base_equation_work_traffic_agg where roaming_country_id is not null;