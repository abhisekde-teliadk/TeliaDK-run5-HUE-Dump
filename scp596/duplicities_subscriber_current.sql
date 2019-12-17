select * from work.base_equation_work_subscriber_previous_product where product_id is not null;

select s_status_subscriber_id, start_date, end_date, s_customer_id, count(*) from work.base_equation_work_subscriber_previous_product where product_id is not null
group by s_status_subscriber_id, s_status_subscriber_id, start_date, end_date, s_customer_id
having count(*) > 1;
;

--8426958

select * from work.base_equation_work_subscriber_previous_product where product_id is not null and s_status_subscriber_id = 12227258;

select start_date, end_date, p_product_id, prev_product_id, p_effective_date, prev_effective_date 
from work.base_equation_work_subscriber_previous_product where prev_product_id is not null and s_status_subscriber_id = 12227258;

select * from work.base_equation_work_subscriber_history_deduplicated where s_status_subscriber_id = 12227258;

select * from work.base_equation_work_subscriber_history_deduplicated where s_status_subscriber_id = 8439527;

select * from analytics.abt_subscribed_product_history where subscriber_id = 12227258;

--1536 duplicated prev product_ids
select count(*) from (
select s_status_subscriber_id, start_date, end_date, s_customer_id, count(distinct prev_product_id) from 
work.base_equation_work_subscriber_previous_product where prev_product_id is not null
group by s_status_subscriber_id, s_status_subscriber_id, start_date, end_date, s_customer_id
having count(distinct prev_product_id) > 1)x;

select s_status_subscriber_id, start_date, end_date, s_customer_id, count(distinct prev_product_id) from 
work.base_equation_work_subscriber_previous_product where prev_product_id is not null
group by s_status_subscriber_id, s_status_subscriber_id, start_date, end_date, s_customer_id
having count(distinct prev_product_id) > 1;

select count(*) from work.base_equation_work_subscriber_previous_product where prev_product_id is not null; 
--8887 not null prev product
--68297750 does not have prev product
--jak casta je ta zmena produktu? Je tech 8887 radku relevantnich? - projit tu logiku s Danem D. 


select * from work.base_equation_work_subscriber_previous_product_max where s_status_subscriber_id = 631738;

select count(*) from work.base_equation_work_subscriber_previous_product_max;

select count(*) from work.base_equation_work_subscriber_previous_product_max;

select count(*) from work.base_equation_work_subscriber_history_deduplicated;

631738;

--duplicities in current subscriber 
select subscriber_id, count(*) from analytics.abt_subscriber_current group by subscriber_id having count(*) > 1;

select * from analytics.abt_subscriber_current where subscriber_id = 12739949; --8347682

select * from analytics.abt_subscriber_history where subscriber_id = 12739949; --8347682

select * from work.base_equation_work_subscriber_no_deduplicated where s_status_subscriber_id = 12739949; 

select start_date, s_status_subscriber_no, s_status_subscriber_id, subscriber_id_end_date, subscriber_no_end_date
from work.base_equation_work_subscriber_end_date where s_status_subscriber_id = 12739949; 

--68477605 pred behem count

select * from analytics.abt_subscriber_history where subscriber_id = 12739949;

select * from analytics.abt_subscribed_product_history where subscriber_id = 12739949;

select * from work.base_equation_work_subscriber_rest_data where s_status_subscriber_id = 324430;

select * from work.base_equation_work_subscriber_rest_deduplicated where s_status_subscriber_id = 3204186;

select a.*  from work.base_equation_work_subscriber_history_all a where s_status_subscriber_id = 324430;

select a.*  from work.base_equation_work_subscriber_history_deduplicated a where s_status_subscriber_id = 12739949;

select * from work.base_equation_work_subscriber_history_part where s_status_subscriber_id = 12739949;

select * from work.base_equation_work_subscriber_previous_product where s_status_subscriber_id = 6625200;

select * from work.base_equation_work_subscriber_history_all where s_status_subscriber_id = 6625200;

select * from work.base_equation_work_subscriber_rest_data where s_status_subscriber_id = 6625200;

select * from work.base_equation_work_subscriber_history_all where s_status_subscriber_id = 6625200;

--ban hierarchy: 2008-12-15
select * from base.import_fokus_base_ban_hierarchy_tree where ban = 947684205;

SELECT * FROM base.import_fokus_base_charge WHERE inv_seq_no = 247845474;

SELECT * FROM analytics.abt_billing WHERE invoice_no = 247845474 LIMIT 100;

select distinct bill_seq_no from base.import_fokus_base_bill where root_ban = 590959904 and ban =  590959904;

select distinct actv_bill_seq_no from base.import_fokus_base_charge where root_ban = 590959904 and ban =  590959904;

select distinct bill_seq_no, invoice_seq_no from base.import_fokus_base_bill where root_ban = 590959904 and ban =  590959904;

--imei
select * from work.base_equation_work_physical_device_imei where subscriber_no = 'GSM04523710689' 
and customer_id = 738494004; 

select * from work.base_equation_work_subscriber_history_all where s_status_subscriber_no = 'GSM04523710689' 
and s_customer_id = 738494004; 

select * from work.base_equation_work_subscriber_rest_data where s_status_subscriber_no = 'GSM04523710689' 
and s_customer_id = 738494004; 

select * from work.base_equation_work_subscriber_rest_deduplicated where s_status_subscriber_no = 'GSM04523710689' 
and s_customer_id = 738494004; 

select * from base.import_fokus_base_billing_account where ban = 329968507;

--csm future reqeust: ok
select * from base.import_fokus_base_csm_future_request where cfr_ban = 852511005 and cfr_subscriber_no = 'GSM04526442251';

--csam activity: ok
select * from base.import_fokus_base_csm_status_activity where csa_activity_code = 'CAN' and csa_activity_rsn_code = 'PONO';

--activity reason ok
select * from base.manual_files_base_man_activity_reason where reason_code = 'CAN - PONO';

--consent ok
select * from work.base_equation_work_grouped_consents where customer_id = 324430;

select * from base.import_fokus_base_np_number_info where subscriber_id = 6625200 and port_number = '27131070' and
effective_date <= cast('2012-09-11 23:59:58' as timestamp) and expiration_date >= cast('2012-09-11 23:59:58' as timestamp)
and port_ind = 'E'
; --2007-07-06 23:59:58

select * from work.base_equation_work_subscriber_history_all h 
left outer join
base.import_fokus_base_np_number_info n
on 
h.s_status_subscriber_id = n.subscriber_id and
substring(h.s_status_subscriber_no,7,8) = n.port_number and
start_date >= cast(n.effective_date as timestamp) and
start_date <= cast(n.expiration_date as timestamp) and
n.port_ind = 'E'
where h.s_status_subscriber_id = 324430;

select * from base.import_fokus_base_np_trx_detail where int_order_id in (10562564) 
and trx_code = '1' and trx_source = 'EXT'; 

select firstname, surname, street from base.manual_files_base_robinson group by firstname, surname, street
having count(*) > 1;

select * from base.manual_files_base_robinson where firstname = 'Jørgen' and surname = 'Schneider' and street = 'Smedeland';

------------------------------------------------------------------------------------------------------------------------------------------
select subscriber_no, customer_id, equipment_no, phd_seq_no, effective_date, expiration_date 
from work.base_equation_work_physical_device_imei where subscriber_no = 'GSM04521634217' and customer_id = 882489206;

select subscriber_no, customer_id, count(*) from work.base_equation_work_physical_device_sim 
group by subscriber_no, customer_id
having count(*) > 1
;


select * from work.base_equation_work_physical_device_sim where subscriber_no = 'GSM04528493971' and  customer_id = 882489206;

select * from work.base_equation_work_subscriber_history_all where s_status_subscriber_no = 'GSM04521634217' and  s_customer_id = 882489206;

------------------------------------------------------------------------------------------------------------------------------------------

select count(*) from base.import_fokus_base_subscriber;

select * from analytics.abt_subscriber_current where subscriber_id = 8347682; 

select * from analytics.abt_subscriber_current where subscriber_id = 7682361;

select * from analytics.abt_subscriber_current where subscriber_id = 324430;

select * from analytics.abt_subscriber_current where subscriber_id =9536147;

select * from work.base_equation_work_subscriber_rest_data where s_status_subscriber_id = 324430;

select a.*  from work.base_equation_work_subscriber_history_all a where s_status_subscriber_id = 324430;

select a.*  from work.base_equation_work_subscriber_history_all a where s_status_subscriber_id = 9536147;

--csm future reqeust: ok
select * from base.import_fokus_base_csm_future_request where cfr_ban = 852511005 and cfr_subscriber_no = 'GSM04526442251';

--csam activity: ok
select * from base.import_fokus_base_csm_status_activity where csa_activity_code = 'CAN' and csa_activity_rsn_code = 'PONO';

--activity reason ok
select * from base.manual_files_base_man_activity_reason where reason_code = 'CAN - PONO';

--consent ok
select * from work.base_equation_work_grouped_consents where customer_id = 324430;

select * from base.import_fokus_base_np_number_info where subscriber_id = 8347682  and port_number = '26419903' and
effective_date <= cast('2010-04-23 23:59:58' as timestamp) and expiration_date >= cast('2010-04-23 23:59:58' as timestamp)
and port_ind = 'E'
; --2007-07-06 23:59:58

select * from base.import_fokus_base_np_number_info where subscriber_id = 7682361  and port_number = '26448420' and
effective_date <= cast('2011-12-16 23:59:58' as timestamp) and expiration_date >= cast('2011-12-16 23:59:58' as timestamp)
and port_ind = 'E';

select * from work.base_equation_work_subscriber_history_all h 
left outer join
base.import_fokus_base_np_number_info n
on 
h.s_status_subscriber_id = n.subscriber_id and
substring(h.s_status_subscriber_no,7,8) = n.port_number and
start_date >= cast(n.effective_date as timestamp) and
start_date <= cast(n.expiration_date as timestamp) and
n.port_ind = 'E'
where h.s_status_subscriber_id = 324430;

select s_status_subscriber_id, s_status_subscriber_no, s_customer_id, start_date, end_date, port_number, np_number_effective_date
from work.base_equation_work_subscriber_rest_data where s_status_subscriber_id = 324430;

select s_status_subscriber_id, s_status_subscriber_no, s_customer_id, start_date, end_date, rank
from work.base_equation_work_subscriber_rest_deduplicated where s_status_subscriber_id = 324430;

select * from base.import_fokus_base_np_trx_detail where int_order_id in (5237308, 6992385, 7007633) 
and trx_code = '1' and trx_source = 'EXT'; 

select firstname, surname, street from base.manual_files_base_robinson group by firstname, surname, street
having count(*) > 1;

select * from base.manual_files_base_robinson where firstname = 'Jørgen' and surname = 'Schneider' and street = 'Smedeland';

------------------------------------------------------------------------------------------------------------------------------------------
--combination of subscriber_no and customer_id should be unique
select subscriber_no, customer_id, fokus_status, count(*) from analytics.abt_subscriber_current
where fokus_status != 'C' /*and subscriber_no = 'GSM04520656249'*/
group by subscriber_no, customer_id, fokus_status 
having count(*) > 1;

/*
--GSM04551871151	 640213013
dva akti

*/
select * from analytics.abt_subscriber_current where subscriber_no = 'GSM04551871151' and customer_id = 640213013;

select * from analytics.abt_subscriber_history where subscriber_no = 'GSM04551871151' and customer_id = 640213013;

select * from work.base_equation_work_subscriber_rest_data
where s_status_subscriber_no = 'GSM04526332284' and s_customer_id = 966679706;

--before join to change entity
select subscriber_id, status_subscriber_no, customer_id, effective_date, status_expiration_join, 
sys_creation_date, sub_status
from work.base_equation_work_subscriber_per_status where status_subscriber_no = 'GSM04551871151' and customer_id = 640213013;

--afte joint with change
select * from work.base_equation_work_subscriber_history_part 
where s_status_subscriber_no = 'GSM04551871151' and s_customer_id = 640213013;

select

change_date, next_change_date, subscriber_id, status_subscriber_no, customer_id, status_effective_join, status_expiration_join, 
sys_creation_date, sub_status
from work.base_equation_work_subscriber_per_status a 
right join 
work.base_equation_work_subscriber_change b 
on
a.subscriber_id = b.change_subscriber_id and
a.status_effective_join <= b.change_date and
a.status_expiration_join >= b.change_date
where a.status_subscriber_no = 'GSM04551871151' and a.customer_id = 640213013;

;2015-02-23 00:35:57 <= 2015-01-23 23:59:58;

select case when cast('2015-02-23 00:35:57' as timestamp) <= cast('2015-01-23 23:59:58' as timestamp) then 'ano' else 'ne' end;

select * from work.base_equation_work_subscriber_change where change_subscriber_id = 14397297;

select * from work.base_equation_work_subscriber_change where change_subscriber_id = 13574935;

select * from temp.base_equation_tmp_subscriber_status where subscriber_id = 13574935;

--source union
select subscriber_id, subscriber_no, customer_id, sub_status, sub_status_date, ctn_seq_no, * from (
    select subscriber_id, subscriber_no, customer_id, effective_date, null expiration_date, sub_status, sub_status_date, ctn_seq_no from base.import_fokus_base_subscriber 
    union
    select subscriber_id, subscriber_no, customer_id, effective_date, expiration_date, sub_status, sub_status_date, ctn_seq_no from base.import_fokus_base_subscriber_history 
    ) x 
    where subscriber_id in (14397297,13574935);
    
select * from     base.import_fokus_base_subscriber_history where subscriber_id in (13574935);
    
select * from     base.import_fokus_base_subscriber where subscriber_id in (13574935);


--change entities
select * from work.base_equation_work_subscriber_change where change_subscriber_id = 11780620;

select * from work.base_equation_work_subscriber_change where change_subscriber_id = 12181897;

--source for join with change entity
select subscriber_id, status_subscriber_no, customer_id, effective_date, status_expiration_join, 
sys_creation_date, sub_status, rank
from work.base_equation_work_subscriber_per_status where status_subscriber_no = 'GSM04551871151' and customer_id = 640213013;

select subscriber_id, status_subscriber_no, customer_id, effective_date, status_expiration_join, 
sys_creation_date, sub_status, rank
from work.base_equation_work_subscriber_per_status where subscriber_id = 13574935; 

--after joined change entity    
select * from work.base_equation_work_subscriber_history_part 
where s_status_subscriber_no = 'GSM04551871151' and s_customer_id = 640213013;    

select s_status_subscriber_id, eff * from work.base_equation_work_subscriber_history_part 
where s_status_subscriber_id in (14397297,13574935
); 

--before second join for history
select * from work.base_equation_work_subscriber_previous_product_max 
where s_status_subscriber_no = 'GSM04520656249' and s_customer_id = 625511902;   

--after second join with history tables
select * from work.base_equation_work_subscriber_history_all 
where s_status_subscriber_no = 'GSM04520656249' and s_customer_id = 625511902; 

--all data together
select * from work.base_equation_work_subscriber_rest_data 
where s_status_subscriber_no = 'GSM04520656249' and s_customer_id = 625511902; 


--csm future reqeust: ok
select * from base.import_fokus_base_csm_future_request where cfr_ban = 852511005 and cfr_subscriber_no = 'GSM04526442251';

--csam activity: ok
select * from base.import_fokus_base_csm_status_activity where csa_activity_code = 'CCN' and csa_activity_rsn_code = 'NP';

--activity reason ok
select * from base.manual_files_base_man_activity_reason where reason_code = 'CCN - NP';

--consent ok
select * from work.base_equation_work_grouped_consents where customer_id = 625511902;

select * from base.import_fokus_base_np_number_info where subscriber_id = 8347682  and port_number = '26419903' and
effective_date <= cast('2010-04-23 23:59:58' as timestamp) and expiration_date >= cast('2010-04-23 23:59:58' as timestamp)
and port_ind = 'E'
; --2007-07-06 23:59:58

select * from base.import_fokus_base_np_number_info where subscriber_id = 7682361  and port_number = '26448420' and
effective_date <= cast('2011-12-16 23:59:58' as timestamp) and expiration_date >= cast('2011-12-16 23:59:58' as timestamp)
and port_ind = 'E';

--sim
select * from work.base_equation_work_physical_device_sim where subscriber_no = 'GSM04520656249' and customer_id = 625511902
and effective_date <= cast('2012-12-04 23:59:58' as timestamp) and expiration_date >= cast('2012-12-04 23:59:58' as timestamp);

--imei
select * from work.base_equation_work_physical_device_sim where subscriber_no = 'GSM04520656249' and customer_id = 625511902
and effective_date <= cast('2012-12-04 23:59:58' as timestamp) and expiration_date >= cast('2012-12-04 23:59:58' as timestamp);

--ban hierarchy tree
select * from base.import_fokus_base_ban_hierarchy_tree where ban = 625511902 
and effective_date <= cast('2012-12-04 23:59:58' as timestamp) and expiration_date >= cast('2012-12-04 23:59:58' as timestamp);

--work address
select * from work.base_equation_work_address where  subscriber_no = 'GSM04520656249' and customer_id = 625511902
and adr_effective_date_join <= cast('2012-12-04 23:59:58' as timestamp) and 
adr_expiration_date_join >= cast('2012-12-04 23:59:58' as timestamp)
;

--padnou mi tam 2 adresy do daneho intevalu pravdepodobne proto, ze chnage entita je mix od dvou ruznych 
--kombinaci subscriber_no, customer_id
--co pridat distinct za ten join? proste kdyz tam takova duplicita bude, kdy ty radky jsou uplne stejne, tak to vezme jen jeden..
--pred zmenou je count: 68476085
--po pridani distinctu: 68450886

--change entita je vygenerovana pro jinou kombinaci subscriber_no a customer_id
--pri joinu se ale pouzije subscriber_id

-------------------------------------------------------------------------------------------------------------------
--same subscriber id for different subscriber_no, customer_id 

select * from analytics.abt_subscriber_current where subscriber_id =9536147;

--source union
select subscriber_id, subscriber_no, customer_id, * from (
    select subscriber_id, subscriber_no, customer_id, effective_date, null expiration_date, sys_creation_date, ctn_seq_no from base.import_fokus_base_subscriber 
    union
    select subscriber_id, subscriber_no, customer_id, effective_date, expiration_date, sys_creation_date, ctn_seq_no from base.import_fokus_base_subscriber_history 
    ) x 
    where subscriber_id in (9536147);
    
    select * from base.import_fokus_base_subscriber where subscriber_id = 9536147;
    
    select * from base.import_fokus_base_subscriber_history where subscriber_id = 9536147;
    
--after joined change entity    
select * from work.base_equation_work_subscriber_history_part 
where s_status_subscriber_id =9536147 ;    

--before join
select * from work.base_equation_work_subscriber_per_status 
where subscriber_id =9536147 ;  

--deduplication
select * from work.base_equation_work_subscriber_history_deduplicated 
where s_status_subscriber_id =9536147 ;  

--adding product
select * from work.base_equation_work_subscriber_previous_product 
where s_status_subscriber_id =9536147 ;  

--rest data added
select * from work.base_equation_work_subscriber_rest_data 
where s_status_subscriber_id =9536147 ;  

select * from analytics.abt_subscriber_history where fokus_status = 'C' and from_product_id is null;

select count(*) from analytics.abt_subscriber_history where fokus_status = 'C' and from_product_id is null and product_id is not null;

--17 mil radku s C prev_produkt_ma
--241 000 s C prev_produkt nema -> 1,4% nema vyplneno
--overeny case subscriber_id: 10449866 - nema zadny produkt

select * from work.base_equation_work_subscriber_previous_product where s_status_subscriber_id = 13897800;

select * from analytics.abt_subscribed_product_history where subscriber_id = 13897800;

select * from base.import_fokus_base_subscriber where subscriber_id = 10449866;

select * from base.import_fokus_base_subscriber_history where subscriber_id = 10449866;

select subscriber_no, customer_id, count(*) from analytics.abt_subscriber_current group by subscriber_no, customer_id
having count(*) > 1;

select subscriber_id, count(*) from analytics.abt_subscriber_current group by subscriber_id
having count(*) > 1;

select * from analytics.abt_subscriber_current where subscriber_id = 13920190;



select * from work.base_equation_kpis_work_subscribed_product_last where subscriber_id = 13920190; 

select * from work.base_equation_kpis_work_annulment_kpi_product where subscriber_id = 13920190;

--2015-08-04 23:59:59 >= 2015-08-05 00:00:00

--2009-11-01 23:59:59 >= 2009-11-02 00:00:00

select expiration_date + interval 1 second, * from analytics.abt_subscribed_product_history where subscriber_id = 9013526; 

select * from analytics.abt_subscriber_current where subscriber_id = 15391456;

select * from analytics.abt_subscribed_product_history where subscriber_no = 'GSM04523953449' and ban = 923644116; 

select * from analytics.abt_subscribed_product_history where subscriber_id = 15391456; 

select * from work.base_equation_kpis_work_subscribed_product_last where subscriber_id = 15103756; 

select * from work.base_equation_kpis_work_subscribed_product_last where subscriber_id = 15103756; 

select * from work.base_equation_kpis_work_annulment_kpi_product where subscriber_id = 15103756;

select substring(subscriber_no, 1,3), count(*) from work.base_equation_kpis_work_annulment_kpi_product 
where product_id is null
group by  substring(subscriber_no, 1,3) ;

select * from work.base_equation_kpis_work_annulment_kpi_product 
where product_id is null and substring(subscriber_no, 1,3) = 'GSM';

select subscriber_no, customer_id from work.base_equation_kpis_work_annulment_kpi_product 
where product_id is null and substring(subscriber_no, 1,3) = 'GSM';

select count(*) from work.base_equation_kpis_work_annulment_kpi_product where product_id is not null;

select case when product_id is not null then 'productInfo' else 'noProduct' end, count(*) 
from work.base_equation_kpis_work_annulment_kpi_product
group by case when product_id is not null then 'productInfo' else 'noProduct' end;

select * from base.import_fokus_base_service_agreement where ban = 923644116 and subscriber_no = 'GSM04523953449' ;
--GSM04542371529	952017010

select * from work.base_equation_work_service_agreement_subscr_joined where ban =923644116 and subscriber_no = 'GSM04523953449';

select * from work.base_equation_work_subscribed_product where ban =923644116 and subscriber_no = 'GSM04523953449';

select * from work.base_equation_work_sub_product_filtered where ban =923644116 and subscriber_no = 'GSM04523953449';

select * from work.base_equation_work_sub_product_promotion_change where ban =923644116 and subscriber_no = 'GSM04523953449';

select * from work.base_equation_work_sub_product_change where ban =923644116 and subscriber_no = 'GSM04523953449';

select * from work.base_equation_work_sub_product_pp where ban =923644116 and subscriber_no = 'GSM04523953449';

select * from work.base_equation_work_sub_product_pp_change where ban =923644116 and subscriber_no = 'GSM04523953449';

select count(*) from analytics.abt_annulment_kpi where annulment_date >= cast('2018-09-01' as timestamp) and 
annulment_date <= cast('2018-09-30' as timestamp) and soc = 'FLEXPA53';

select * from analytics.abt_subscribed_product_history where soc = 'FLEXPA53';

select * from base.import_fokus_base_service_agreement where soc = 'FLEXPA53' and
 expiration_date >= cast('2018-09-01' as timestamp) and 
expiration_date <= cast('2018-09-30' as timestamp)
;
