select * from temp.base_equation_tmp_soc_free_columns where soc = 'CM2020EUB' and service_type = 'P';

select * from temp.base_equation_tmp_soc_free_columns where free_sms_max = 'MSMS';

select * from temp.base_equation_tmp_soc_free_columns where feature_code like 'PN%' and feature_code != 'PNETRM';


select * from work.base_equation_work_soc_history_rates where change_soc like 'NBME%V'; -- 'SIMBT%';

select * from base.import_fokus_base_soc where soc like 'NBME%V' or soc like 'CHAMP%EB';

select * from work.base_equation_work_soc_agg_columns where length(pxeu_feature_code) = 0;

select soc, start_date, count(*) from work.base_equation_work_soc_deduplicated group by soc, start_date having count(*) > 1;

select soc, start_date, end_date from work.base_equation_work_soc_end_date where soc = '1000SMSB';

select soc, start_date, count(*) from analytics.abt_soc group by soc, start_date having count(*) > 1;

--SOC: TELIAMOB2
select * from analytics.abt_soc where soc = 'TELIAMOB2';

--join between all tables and change entity
select * from work.base_equation_work_soc_history where change_soc = 'TELIAMOB2';

--pn columns and all others are created
select * from work.base_equation_work_soc_history_rates where change_soc = 'TELIAMOB2';

select * from work.base_equation_work_soc_history_rates where change_soc = 'TELIAMOB2' and length(pn_feature_code) > 0;

--temp columns calculated
select ;

--all max  values are in place
select * from work.base_equation_work_soc_agg_columns where soc = 'TELIAMOB2' order by start_date desc;

--uz ve focusu pro dany change date existuje featura PXEA20
select * from base.import_fokus_base_rated_feature where soc = 'TELIAMOB2' and effective_date >= to_date('2018-11-30');
 

---------------------------------------------------------------------------------------------------------------------------

--SOC: 4WF
select * from analytics.abt_soc where soc = '4WF';

--join between all tables and change entity
select * from work.base_equation_work_soc_history where change_soc = 'TELIAMOB2';

--pn columns and all others are created
select * from work.base_equation_work_soc_history_rates where change_soc = 'TELIAMOB2';

select * from work.base_equation_work_soc_history_rates where change_soc = 'TELIAMOB2' and length(pn_feature_code) > 0;

--temp columns calculated
select ;

--all max  values are in place
select * from work.base_equation_work_soc_agg_columns where soc = 'TELIAMOB2' order by start_date desc;

--uz ve focusu pro dany change date existuje featura PXEA20
select * from base.import_fokus_base_rated_feature where soc = 'TELIAMOB2' and effective_date >= to_date('2018-11-30');

-----------------------------

--SOC: 4YOU3
select * from analytics.abt_soc where soc = '4YOU3';

--join between all tables and change entity
select * from work.base_equation_work_soc_history where change_soc = '4YOU3' order by start_date desc;

--pn columns and all others are created
select * from work.base_equation_work_soc_history_rates where change_soc = '4WF' order by start_date desc;

select * from work.base_equation_work_soc_history_rates where change_soc = 'TELIAMOB2' and length(pn_feature_code) > 0;

select * from work.base_equation_work_soc_change where change_soc = '4YOU3';

--temp columns calculated
select ;

--all max  values are in place
select * from work.base_equation_work_soc_agg_columns where soc = 'TELIAMOB2' order by start_date desc;

--uz ve focusu pro dany change date existuje featura PXEU
select * from base.import_fokus_base_rated_feature where soc = '4YOU3' and effective_date >= to_date('2018-11-29');

-----------------------

select product_id, count(*) from analytics.abt_product group by product_id having count(*) > 1;


--XPRESS
select * from analytics.abt_product where product_id = '85ffbdff01354757132c27e65d3ba7ab';

select product_id, count(*) from analytics.abt_d_product group by product_id having count(*) > 1;

select * from analytics.abt_d_product where product_id = '85ffbdff01354757132c27e65d3ba7ab';

select * from base.manual_files_base_d_product where soc = 'XPRESS';

select * from analytics.abt_soc where soc = 'XPRESS';

select * from work.base_equation_work_product_soc where soc_soc = 'XPRESS';

select * from work.base_equation_work_product_soc where f_product_lt = 'Xpress 2.0';

select f_soc, f_campaign, f_service_soc, soc_soc, f_product_lt, start_date, rank  
from work.base_equation_work_product_deduplicated where soc_soc = 'XPRESS';

select * from work.base_equation_work_product_deduplicated where 
soc_soc = 'XPRESS' and f_campaign is null and f_service_soc is null;

--select * from analytics.abt_d_product where product_desc like press Step%';

select product_id, soc, campaign, service_soc, product_desc, product_code from base.manual_files_base_d_product where soc = 'XPRESS';

--radky, kde existuje jen zaznam v soc entite, ale neni ve filu d_product
select * from analytics.abt_product where product_id = 'd41d8cd98f00b204e9800998ecf8427e';

--XPRESS bez kampane
select * from analytics.abt_product where product_id = '9e4e45d33df094b5c5e351ce50402ad6';

--dva uplne stejne radky
select * from analytics.abt_product where product_id = '29125b1ac508bd2faf9baed77f3d8eef';
;

select soc, campaign, service_soc from base.manual_files_base_d_product where soc = 'CM15T25GB';

select * from base.import_fokus_base_service_agreement where expiration_date is null;

select to_date('9999-12-31');

select floor((33780.0 + 1024) / 1024);

select to_timestamp('2019-01-01', 'yyyy-MM-dd'), now(),datediff(now(), to_timestamp('2018-12-01', 'yyyy-MM-dd')), 
add_months(now(), -3);

;

select * from work.crt_work_additional_soc_groupped where ban=494377807 and subscriber_no='GSM04526107181';

select * from work.crt_work_additional_soc_group  where ban=494377807 and subscriber_no='GSM04526107181';

select subscriber_no, ban from work.crt_work_additional_soc_group group by subscriber_no, ban having count(*) > 1;

select * from work.crt_work_additional_soc  where ban=494377807 and subscriber_no='GSM04526107181';

select subscriber_no, ban, count(*) from work.crt_subscriber_product group by subscriber_no, ban having count(*) > 1;;