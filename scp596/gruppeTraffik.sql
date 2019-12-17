select call_month, subscriber_no, ban, start_date, end_date 
from work.gruppetrafik_work_gruppe_traffic where subscriber_no = 'GSM04521799506' and ban = 340875608 and call_month = to_timestamp('2017-11-01', 'yyyy-MM-dd');

select call_month, subscriber_no, ban
from base.gruppetrafik_work_detail_usage_groupped where subscriber_no = 'GSM04521799506' and ban = 340875608 and call_month = to_timestamp('2017-11-01', 'yyyy-MM-dd');

select *
from base.gruppetrafik_work_detail_usage_groupped where subscriber_no = 'GSM04521799506' and ban = 340875608 and call_month = to_timestamp('2017-11-01', 'yyyy-MM-dd')
order by at_soc, price_plan_code, call_type, at_feature_code
;

select *
from work.gruppetrafik_work_gruppe_traffic where subscriber_no = 'GSM04521799506' and ban = 340875608 and call_month = to_timestamp('2017-11-01', 'yyyy-MM-dd')
order by at_soc, price_plan_code, call_type, at_feature_code
;

select ban, root_ban, cycle_run_year, cycle_run_month, at_feature_code, subscriber_no, ri_carrier, country_code, call_type, price_plan_code, at_soc, unit_measure_code, call_month, count(*)
from work.gruppetrafik_work_gruppe_traffic
group by ban, root_ban, cycle_run_year, cycle_run_month, at_feature_code, subscriber_no, ri_carrier, country_code, call_type, price_plan_code, at_soc, unit_measure_code, call_month
having count(*) > 1;

select * from work.gruppetrafik_work_gruppe_traffic where ban = 444485601 and cycle_run_year = 2019 and at_feature_code = 'MGPRNO' and subscriber_no = 'GSM04528301567' and ri_carrier =  24202
and call_type = 'R' and price_plan_code = 'NBMA11' and call_month = to_timestamp('2019-01-01', 'yyyy-MM-dd');

select * from work.gruppetrafik_work_detail_usage_group where ban = 444485601 and cycle_run_year = 2019 and at_feature_code = 'MGPRNO' and subscriber_no = 'GSM04528301567' and ri_carrier =  24202
and call_type = 'R' and price_plan_code = 'NBMA11' and call_month = to_timestamp('2019-01-01', 'yyyy-MM-dd');

select * from work.gruppetrafik_work_feature_bill_charge where feature_code = 'MGPRNO';

select * from work.gruppetrafik_work_feature_bill_category_prep where feature_category = 'MGIR';

select distinct at_soc from work.gruppetrafik_work_max_sub where soc_description is null;

select * from work.gruppetrafik_work_max_sub where at_soc = 'NBMA01' and soc_description is null and cycle_run_year = 2018 and cycle_run_month = 12;

select count(*) from work.gruppetrafik_work_gruppe_traffic where soc_description is null;

select * from  work.gruppetrafik_work_gruppe_traffic where at_soc = 'NBMA01' and soc_description is null and cycle_run_year = 2018 and cycle_run_month = 12;

select * from work.base_equation_product_tbt_soc where soc in ('NBMA01', 'SIMBUS1', 'RLHEUAP01');

select * from work.base_equation_product_tbt_soc where soc = 'NBMA01';

select case when to_timestamp('2018-12-01', 'yyyy-MM-dd') >= to_timestamp('2018-11-01', 'yyyy-MM-dd') then 'ma byt' else 'nema' end;


select subscriber_id,
customer_id,
subscriber_no,
tree_level,
customer_tree_level
from analytics.prod_abt_subscriber_current
where tree_level <> customer_tree_level;

select a.call_month, a.at_soc, b.soc, b.soc_description, b.start_date, b.end_date, start_month, end_month from 
(select * from  work.gruppetrafik_work_gruppe_traffic where at_soc = 'NBMA01' and soc_description is null and cycle_run_year = 2018 and cycle_run_month = 12) a
left join
(select soc, soc_description, start_date, end_date, trunc(start_date, 'month') start_month, trunc(end_date, 'month') end_month from work.base_equation_product_tbt_soc where soc = 'NBMA01') b
on 
a.at_soc = b.soc and
a.call_month >= b.start_month and a.call_month <= b.end_month
;

select soc, soc_description, start_date, end_date, trunc(start_date, 'month') start_month, trunc(end_date, 'month') end_month from work.base_equation_product_tbt_soc where soc = 'NBMA01';


select call_month, at_soc, start_date_month, end_date_month from  work.gruppetrafik_work_gruppe_traffic where at_soc = 'NBMA01' 
and soc_description is null and cycle_run_year = 2018 and cycle_run_month = 11;

select call_month, at_soc, start_date_month, end_date_month from  work.gruppetrafik_work_gruppe_traffic_soc where at_soc = 'NBMA01' 
and soc_description is null and cycle_run_year = 2018 and cycle_run_month = 11;

select count(*) from work.gruppetrafik_work_gruppe_traffic_soc where soc_description is null;

select count(*) from work.gruppetrafik_work_gruppe_traffic_month where unit_measure_code is null;

select count(*) from work.gruppetrafik_work_usage_date_joins where unit_measure_code is null;

select count(*) from work.gruppetrafik_work_gruppe_traffic where/* unit_measure_code is null and*/ call_month = to_timestamp('2019-01-01', 'yyyy-MM-dd');

select count(*) from analytics.abt_gruppetrafik where at_call_dur_sec is not null;

select * from work.gruppetrafik_work_detail_usage_by_day where total_chrg_sum is null;

select count(*) from base.import_fokus_base_detail_usage where total_chrg is not null;
--8776200257

select * from analytics.prod_abt_churn_kpi where subscriber_no = 'GSM04560725090';

select * from work.base_equation_product_work_subscribed_product_id where subscriber_no = 'GSM04560725090' and ban = 698122116 and subscriber_id = 14887653;;

select * from work.base_equation_product_tbt_subscribed_product_history where subscriber_no = 'GSM04560725090' and ban = 698122116 and subscriber_id = 14887653;;


select * from work.base_equation_kpis_tbt_churn_kpi where subscriber_no = 'GSM04560725090' and customer_id = 698122116 and subscriber_id = 14887653;;;

select * from work.base_equation_product_tbt_product where product_id = 'b18d2442b423d6445c5f435fe3a52598';

select * from work.base_equation_kpis_work_subscribed_product_rank where subscriber_no = 'GSM04560725090' and ban = 698122116; 

select * from work.base_equation_kpis_work_subscribed_product_w_date_last where subscriber_no = 'GSM04560725090' and ban = 698122116 and subscriber_id = 14887653;;;

select * from work.base_equation_sub_tbt_subscriber_history where subscriber_no = 'GSM04560725090' and customer_id = 698122116;