select distinct call_description from analytics.abt_usage_mobile_part;

select * from temp.base_equation_tmp_subscriber_history where expiration_date is null;



select * from base.import_fokus_base_subscriber where expiration_date is null;



select * from base.import_fokus_base_subscriber_history where expiration_date is null;





select * from base.import_fokus_base_service_agreement where customer_id = 515292019 and subscriber_no = 'GSM04560245743';



select * from temp.base_equation_tmp_address_change_effective  where link_type = 'U' and change_date is null;;

select * from temp.base_equation_tmp_address_expiration  where link_type = 'U' and change_date is null;;


---------------------------------

select * from temp.base_equation_tmp_subscriber_history_effective where change_date is null;

select * from temp.base_equation_tmp_subscriber_history_expiration where change_date is null;

select * from temp.base_equation_tmp_service_agreement_effective where change_date is null; --1

select * from temp.base_equation_tmp_service_agreement_expiration where change_date is null; --1

select * from temp.base_equation_tmp_physical_device_effective where change_date is null;

select * from temp.base_equation_tmp_physical_device_expiration where change_date is null;

select count(*) from work.base_equation_work_address_change where link_type = 'U' and change_date is null;

select * from temp.base_equation_tmp_subscriber_change_all where change_date is null;


select * from work.base_equation_work_subscriber_change where customer_id = 100104492 and subscriber_no = 'GSM04528455555' ;

select * from work.base_equation_work_customer_change;


select sub_status, count(*) from work.base_equation_work_current_subscriber group by sub_status;

select subscriber_id, count(*) from work.base_equation_work_subscriber_act_date group by subscriber_id having count(*) >1 ;