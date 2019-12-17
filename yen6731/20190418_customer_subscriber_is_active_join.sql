select *
--customer_id, count(*)
from (
select cust.customer_id, sub.subscriber_no, count(*) /*distinct cust.customer_id, sub.subscriber_no, sub.is_active*/ from work.base_equation_sub_tbt_customer_history cust
left join work.base_equation_sub_tbt_subscriber_history sub
on cust.customer_id = sub.customer_id
where is_active=true
group by cust.customer_id, sub.subscriber_no having count(*)=0) a
--group by customer_id
where customer_id=700872609 --999997703
order by count(*) desc;


select distinct cust.customer_id from work.base_equation_sub_tbt_customer_history cust
left join work.base_equation_sub_tbt_subscriber_history sub
on cust.customer_id = sub.customer_id
where
--now() between cust.start_date and cust.end_date
--and 
sub.is_active=true
--and sub.subscriber_no is null;
; --132.777

select cust.customer_id, sub.subscriber_no, count(*) /*distinct cust.customer_id, sub.subscriber_no, sub.is_active*/ from work.base_equation_sub_tbt_customer_history cust
left join work.base_equation_sub_tbt_subscriber_history sub
on cust.customer_id = sub.customer_id
where is_active=true
--and cust.customer_id=939048708
--and sub.subscriber_no='GSM04526881693'
group by cust.customer_id, sub.subscriber_no having count(*)<1;

select distinct cust.customer_id, sub.subscriber_no, sub.is_active from work.base_equation_sub_tbt_customer_history cust
left join work.base_equation_sub_tbt_subscriber_history sub
on cust.customer_id = sub.customer_id
where is_active=true
and cust.customer_id=554082214
and sub.subscriber_no='GSM04526881693';

select customer_id, subscriber_no, is_active, status, end_date from work.base_equation_sub_tbt_subscriber_history where customer_id=591853809; -- is-active will be true
select customer_id, subscriber_no, is_active, status, end_date from work.base_equation_sub_tbt_subscriber_history where customer_id=843260118; -- is-active will be false
select customer_id, subscriber_no, is_active, status, end_date from work.base_equation_sub_tbt_subscriber_history where customer_id=591853809; --???
select * from work.base_equation_sub_tbt_customer_history where customer_id=591853809;
select customer_id, subscriber_no, is_active, status, end_date from work.base_equation_sub_tbt_subscriber_history where customer_id=591853809;