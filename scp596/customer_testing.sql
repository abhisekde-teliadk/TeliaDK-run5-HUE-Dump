select robinson, count(*) from work.base_equation_work_customer_robinson group by robinson;

select adr_street_name, adr_house_letter, adr_house_no, adr_street_name_join, robinson
from work.base_equation_work_customer_robinson;

select robinson, count(*) from analytics.abt_customer_history group by robinson;

select * from analytics.abt_customer_history where customer_id = 622413201;

select * from base.import_fokus_base_ban_pym_mtd where ban = 622413201;

select ;

select * from work.base_equation_work_customer_hist where ban = 622413201;

select * from temp.base_equation_tmp_ban_pym_mtd_ranked where ban = 622413201;

select case when payment_method_id is not null then "Payment" else "NoPayment" end,
count(*) from analytics.abt_customer_history 
group by case when payment_method_id is not null then "Payment" else "NoPayment" end ;

/*
NoPayment	12898447
Payment	    16537530
*/

select count(*) from base.import_fokus_base_ban_pym_mtd where expiration_date is null;

select case when payment_method is not null then "Payment" else "NoPayment" end,
count(*) from work.base_equation_work_customer_hist 
group by case when payment_method is not null then "Payment" else "NoPayment" end ;

select start_date, ban, count(*) from work.base_equation_work_customer_hist  group by 
start_date, ban
having count(*) > 1;

select * from  work.base_equation_work_customer_hist where ban = 511850901;



select * from  work.base_equation_work_customer_deduplicated where ban = 915918007; --2 adresy

select * from  work.base_equation_work_customer_deduplicated where ban = 667848204; --3 adresy

select * from  work.base_equation_work_customer_deduplicated where ban = 970314605; --2 adresy

select * from work.base_equation_work_grouped_consents where customer_id = 458942018;

select * from  work.base_equation_work_customer_robinson where ban = 932487200;

select * from  work.base_equation_work_customer_hist where ban = 915918007;

select * from work.base_equation_work_address where customer_id = 915918007 and link_type = 'L';

select * from base.import_fokus_base_address_data where address_id in (210282928, 218645935);

select * from base.import_fokus_base_address_name_link where customer_id = 932487200 and link_type = 'L';




select start_date, ban, count(*) from work.base_equation_work_customer_deduplicated group by 
start_date, ban
having count(*) > 1;

select start_date, customer_id, count(*) from analytics.abt_customer_history group by 
start_date, customer_id
having count(*) > 1;

select * from analytics.abt_customer_history where customer_id = 658914700;

select * from work.base_equation_work_customer_deduplicated where customer_id = 637706805;

select * from base.manual_files_base_robinson where street like 'Kronborggade 9' and firstname = 'Line' and surname = 'Svendsen';

select * from base.manual_files_base_robinson where street like 'Bakkevej 28' and firstname = 'Martin' and surname = 'Hansen';

select * from work.base_equation_work_robinson_deduplicated where street like 'Bakkevej 28' and firstname = 'Martin' and surname = 'Hansen';

select count(*) from base.manual_files_base_robinson;

select count(*) from work.base_equation_work_robinson_deduplicated;
--1494446
--1489211


select count(*) from (

select surname, firstname, street, city, postcode, count(*) from
base.manual_files_base_robinson 
group by 
surname, firstname, street, city, postcode
having count(*) > 1) x; --5220


select * from base.manual_files_base_robinson ;

select surname, firstname, street, count(*) from base.manual_files_base_robinson
group by surname, firstname, street
having count(*) > 1;

select robinson, count(*) from work.base_equation_work_subscriber_rest_data group by robinson;
--122

select distinct gender from work.base_equation_work_subscriber_rest_data
;

select distinct gender from work.base_equation_work_subscriber_history_all;

select distinct gender from work.base_equation_work_customer_deduplicated
;

select distinct gender from work.base_equation_work_customer_robinson
;

select distinct gender from work.base_equation_work_customer_hist
;

select case when payment_method_id is not null then "Payment" else "NoPayment" end, count(*) 
from analytics.abt_customer_history 
group by case when payment_method_id is not null then "Payment" else "NoPayment" end;

select customer_id, start_date, count(*) from analytics.abt_customer_current
group by customer_id, start_date
having count(*) > 1;

select * from analytics.abt_customer_history where customer_id = 445503014;



select distinct gender from work.base_equation_work_address;

select * from work.crt_work_robinson_deduplicated where street like 'Bakkevej 28' and firstname = 'Martin' and surname = 'Hansen';

select surname, firstname, street, postcode, count(*) from 
work.crt_work_robinson_deduplicated
group by 
surname, firstname, street, postcode
having count(*) > 1;

select robinson_legal, count(*) from work.crt_customer
group by robinson_legal
;
--8173