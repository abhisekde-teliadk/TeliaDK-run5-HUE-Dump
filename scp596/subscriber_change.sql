select subscriber_no, equipment_no, count(*) from base.import_fokus_base_physical_device where equipment_level = 0
group by subscriber_no, equipment_no 
having count(*) > 1
;

select * from base.import_fokus_base_physical_device where equipment_level = 0
and subscriber_no = 'GSM04528721353' and equipment_no = '356563003046197';

select * from base.import_fokus_base_physical_device where equipment_level = 0
and subscriber_no = 'GSM04528721353' and equipment_no = '356563003046197';

select * from work.base_equation_work_physical_device_primary_imei
where subscriber_no = 'GSM04528721353' and equipment_no = '356563003046197';

select * from work.base_equation_work_physical_device_imei
where subscriber_no = 'GSM04528721353' and equipment_no = '356563003046197';

select * from work.base_equation_work_primary_devices where subscriber_no = 'GSM04528721353';

select device_type, equipment_level, count(*) from work.base_equation_work_primary_devices
group by device_type, equipment_level;

select count(*) from work.base_equation_work_primary_devices; 

select count(*) from base.import_fokus_base_physical_device where 
--subscriber_no = 'GSM04528721353'
 (
(device_type = 'E' 
and equipment_level = 1 )

OR 

(
device_type = 'H'
and equipment_level = 0
)


) -- 16206670
; 

select * from work.base_equation_work_subscriber_history_all where 
s_status_subscriber_no = 'GSM04528721353'
;

select subscriber_no, customer_id, effective_date, expiration_date
from base.import_fokus_base_subscriber_history where subscriber_no = 'GSM04552385699';

select subscriber_id, subscriber_no, customer_id, effective_date, expiration_date, sys_creation_date
from work.base_equation_work_subscriber_history
where subscriber_no = 'GSM04552385699';

select subscriber_id, status_subscriber_no, customer_id, effective_date, status_expiration_join, 
sys_creation_date, sub_status
from work.base_equation_work_subscriber_per_status
where status_subscriber_no = 'GSM04552385699';

select * from work.base_equation_work_subscriber_change where change_subscriber_id = 9667838;

select s_status_subscriber_id, s_status_subscriber_no, s_customer_id, start_date, end_date
from work.base_equation_work_subscriber_history_part
where s_status_subscriber_no = 'GSM04552385699';
;

select *
from work.base_equation_work_subscriber_history_part
where s_status_subscriber_no = 'GSM04552385699';

--change entity and subscriber entity
select ch.change_date, ch.next_change_date, 
s.subscriber_id, status_subscriber_no, customer_id, status_effective_join, status_expiration_join, sys_creation_date
from 
work.base_equation_work_subscriber_change ch
left outer join
work.base_equation_work_subscriber_per_status s
on 
ch.change_subscriber_id = s.subscriber_id and
ch.change_date >= s.status_effective_join and
ch.change_date <= s.status_expiration_join
where
s.status_subscriber_no = 'GSM04552385699';

--change entity and subscriber entity + product entity
select ch.change_date, ch.next_change_date, 
s.subscriber_id, status_subscriber_no, customer_id, status_effective_join, status_expiration_join, sys_creation_date
from 
work.base_equation_work_subscriber_change ch
left outer join
work.base_equation_work_subscriber_per_status s
on 
ch.change_subscriber_id = s.subscriber_id and
ch.change_date >= s.status_effective_join and
ch.change_date <= s.status_expiration_join
left outer join analytics.abt_subscribed_product_history p
on
ch.change_subscriber_id = p.subscriber_id and
ch.change_date >= p.effective_date and
ch.change_date <= p.expiration_date
where
s.status_subscriber_no = 'GSM04552385699'
order by change_date, customer_id;




select subscriber_id, status_subscriber_no, customer_id, effective_date, ff_expiration_date, sys_creation_date, sub_status
from work.base_equation_work_subscriber_per_status;