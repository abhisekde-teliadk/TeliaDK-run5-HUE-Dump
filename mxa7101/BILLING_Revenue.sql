SELECT sub.subscriber_id, sub.subscriber_no, sub.customer_id, bill.bill_period_start_date, 
bill.bill_period_end_date, SUM(bill.amount_incl_vat_after_discount) AS amount_incl_vat_after_discount_sum, 
SUM(bill.amount_ex_vat_after_discount) AS amount_ex_vat_after_discount_sum,
bill.invoice_no, bill.bill_date, bill.bill_due_date
FROM analytics.abt_subscriber_current sub
LEFT JOIN analytics.abt_billing bill
ON sub.subscriber_no = bill.subscriber_no
AND sub.customer_id = bill.customer_id
GROUP BY sub.subscriber_id, sub.subscriber_no, sub.customer_id, bill.bill_period_start_date, 
bill.bill_period_end_date, bill.amount_incl_vat_after_discount, bill.amount_ex_vat_after_discount,
bill.invoice_no, bill.bill_date, bill.bill_due_date
LIMIT 100;


SELECT customer_id, subscriber_no, bill_date, bill_due_date, 
bill_period_start_date, bill_period_end_date, 
SUM(amount_incl_vat_after_discount) amount_incl_vat_after_discount_sum
FROM analytics.abt_billing
where customer_id = 533662219
and subscriber_no = 'GSM04528598082'
GROUP BY  customer_id, subscriber_no, bill_date, bill_due_date, 
bill_period_start_date, bill_period_end_date
LIMIT 100;

select bill_period_start_date, bill_period_end_date, datediff(bill_period_end_date,bill_period_start_date) as bill_period_days
from analytics.abt_billing
group by bill_period_start_date, bill_period_end_date, bill_period_days
;


select count(*)
from analytics.abt_subscriber_current
where end_date < now()
;