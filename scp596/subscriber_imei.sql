select party_id, party_id_tp, count(*) from work.export_to_portrait_party_converted
group by party_id, party_id_tp having count(*) > 1


;

select primary_key, count(*) from work.export_to_portrait_party_converted
group by primary_key having count(*) > 1;

select * from work.export_to_portrait_party_converted where party_id = '14256841';

select * from work.export_to_portrait_party_converted where party_id = '920787017';

select * from work.crt_subscriber where fokus_subscriber_id = '14256841';

select * from work.crt_subscriber_product where subscriber_id = 14256841; 

select * from work.crt_subscriber_act_date where subscriber_id = 14256841; 

select * from work.crt_work_subscriber_min_act_date where subscriber_id = 14256841; 

select * from work.crt_work_optional_service_container_prev_end_joined 
where subscriber_no = 'GSM04526426286' and customer_id = 920787017;

select * from work.crt_work_tnid_techinfo_deduplicated where tnid_circuit_number = null;

select * from work.crt_customer1 where ban = 920787017;

select * from work.crt_customer where ban = 920787017;

select * from base.import_fokus_base_billing_account where ban = 920787017;

select * from work.crt_address_name where customer_id = 920787017 and link_type = 'L';

select * from base.import_fokus_base_address_data where address_id in (); 

select * from base.import_fokus_base_address_name_link where customer_id = 920787017 and link_type = 'L'
and  expiration_date > now() ;;

select * from base.import_fokus_base_address_name_link where address_id is null and expiration_date > now();

SELECT --distinct
*
FROM analytics.abt_subscriber_imei_history 
where imei='350146204834490'
and active_record_flag=true
--and end_date > now()
order by imei,
start_date,
end_date;



select customer_id, subscriber_no, effective_date, count(*)
from work.base_equation_other_work_physical_device_rank where equipment_no = '350146204834490'
group by customer_id, subscriber_no, effective_date
having count(*) > 1;

select subscriber_id, start_date, count(*) from analytics.abt_subscriber_imei_history
group by subscriber_id, start_date
having count(*) > 1;



select  subscriber_no, effective_date, count(*)
from work.base_equation_other_work_physical_device_rank where equipment_no = '350146204834490'
group by subscriber_no, effective_date
having count(*) > 1;

select  customer_id, subscriber_no, equipment_no, phd_seq_no, expiration_date, effective_date, equipment_level, device_type
from work.base_equation_other_work_physical_device_rank where equipment_no = '350146204834490';

select  customer_id, subscriber_no, equipment_no, phd_seq_no, expiration_date, effective_date, equipment_level, device_type
from work.base_equation_other_work_physical_device_rank where equipment_no = '350146204834490' 
and effective_date = to_date('2004-06-08 00:00:00');

select  customer_id, subscriber_no, equipment_no, phd_seq_no, expiration_date, effective_date
from work.base_equation_other_work_unique_imei_per_date where equipment_no = '350146204834490'
and effective_date = to_date('2004-06-08 00:00:00');;

select  customer_id, subscriber_no, equipment_no, phd_seq_no, expiration_date, effective_date
from work.base_equation_other_work_unique_imei_per_date where equipment_no = '350146204834490';

select * from work.base_equation_other_work_subscriber_imei where equipment_no = '350146204834490';

 /*                                   expiration          effective       subs_id
GSM04520820080	350146204834490	2005-12-07 20:49:59	2005-10-15 09:29:56	3264594	2005-12-07 20:49:59	20820080	35014620
GSM04520906512	350146204834490	2005-10-15 15:33:41	2004-06-08 00:00:00	3264583	2005-10-15 15:33:41
*/


select *from analytics.abt_subscriber_imei_history where imei = '350146204834490' order by start_date;

select * from analytics.abt_subscriber_imei where imei = '350146204834490';
--2005-11-23 10:33:06	9999-12-31 00:00:00	true	3307379	40286623	350146204834490	35014620
 
1
 
;

select imei, count(*) from analytics.abt_subscriber_imei /*where imei = '350146204834490' */
group by imei 
having count(*) > 1
;



SELECT  pd.subscriber_no, pd.equipment_no, pd.phd_seq_no, pd.effective_date, pd.expiration_date
FROM base.import_fokus_base_physical_device pd --work.base_equation_other_work_physical_device_rank pd 
where pd.equipment_no = '350146204834490'

order by effective_date, pd.subscriber_no;