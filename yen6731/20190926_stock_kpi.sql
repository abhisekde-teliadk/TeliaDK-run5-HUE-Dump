select customer_id, subscriber_no, date_as_date, count(*) from work.base_equation_kpis_work_discount_sa_join
group by customer_id, subscriber_no, date_as_date
having count(*) > 1;

select * from work.base_equation_kpis_work_discount_sa_join where customer_id=524434602 and subscriber_no='GSM04561793464' and date_as_date=cast('2019-01-08 00:00:00' as timestamp);

select * from work.base_equation_kpis_work_discount_sa_unique where customer_id=524434602 and subscriber_no='GSM04561793464' and date_as_date=cast('2019-01-08 00:00:00' as timestamp);