-- customer bridge
SELECT DISTINCT br.foreign_circuit, customers.telia_circuit_id, br.source, customers.source_billing ,customers.customer_number
FROM
analytics.abt_circuit_bridge br
LEFT JOIN
(
SELECT 
        'Fokus' source_billing,
        cast(fokus.subscriber_customer_id as string) customer_number, 
        fokus.foreign_circuit foreign_circuit, 
        fokus.telia_circuit_id telia_circuit_id, 
        'to be calculated' segment, -- vezmem z mf_tvk_segment ziskame BTB a BTC
        'to be calculated' product -- vezmeme product group z abt_subscriber_current (customer_id, subscriber_no)

FROM work.contr_obligations_tdc_work_circuit_billing fokus
-- TODO: Ondrej - dosepcifikovat FOkus s Bill Comment
UNION

SELECT
        'Rosetta' source_billing,
        rosetta.cust_no customer_number, 
        rosetta.tdc_circuitid foreign_circuit, 
        rosetta.telia_circuitid telia_circuit_id, 
        rosetta.segment, 
        'rosetta product' product

FROM work.analyst_sandbox_omi_rosetta rosetta
UNION

SELECT
        'Bruce' source_billing,
        bruce.cust_no customer_number, 
        bruce.tdc_circuitid foreign_circuit, 
        bruce.telia_circuitid telia_circuit_id, 
        bruce.segment, 
        'bruce product' product

FROM work.analyst_sandbox_omi_bruce_rosetta bruce
UNION
SELECT  
        'Geneva' source_billing,
        geneva.customer_ref customer_number, 
        geneva.event_source foreign_circuit, 
        geneva.event_source telia_circuit_id, 
        geneva.segment, 
        geneva.technology product

FROM 

base.sandbox_brstak_base_tdc_prodct_view geneva



UNION
 
SELECT  'Geneva-ES' source_billing,
        es.customer_ref customer_number, 
        es.event_source foreign_circuit, 
        es.event_source telia_circuit_id, 
        geneva.segment, 
        geneva.technology product
FROM 

work.analyst_sandbox_omi_kisbi_geneva_event_source es,
base.sandbox_brstak_base_tdc_prodct_view geneva

WHERE
(es.customer_ref = geneva.customer_ref)

) customers
ON br.telia_circuit_id = customers.telia_circuit_id

WHERE 
    customers.telia_circuit_id IS NOT NULL
    AND
    br.telia_circuit_id IS NOT NULL

ORDER BY customers.foreign_circuit DESC
LIMIT 100
;

--- billing lines
SELECT source_billing, count(*) c
FROM
(
SELECT 
        'Fokus' source_billing,
        cast(fokus.billing_gross_amount_incl_vat as string) amount,
        cast(fokus.subscriber_customer_id as string) customer_number, 
        fokus.foreign_circuit foreign_circuit, 
        fokus.telia_circuit_id telia_circuit_id, 
        'to be calculated' segment, 
        'to be calculated' product,
        fokus.billing_bill_period_start_date bill_start_date, 
        fokus.billing_bill_period_end_date  last_bill_date

FROM work.contr_obligations_tdc_work_circuit_billing fokus

UNION

SELECT
        'Rosetta' source_billing,
        rosetta.payamt amount,
        rosetta.cust_no customer_number, 
        rosetta.tdc_circuitid foreign_circuit, 
        rosetta.telia_circuitid telia_circuit_id, 
        rosetta.segment, 
        'rosetta product' product,
        rosetta.product_start_date bill_start_date, 
        rosetta.last_invoice_date  last_bill_date

FROM work.analyst_sandbox_omi_rosetta rosetta
UNION

SELECT
        'Bruce' source_billing,
        bruce.payamt amount,
        bruce.cust_no customer_number, 
        bruce.tdc_circuitid foreign_circuit, 
        bruce.telia_circuitid telia_circuit_id, 
        bruce.segment, 
        'bruce product' product,
        bruce.product_start_date bill_start_date, 
        bruce.last_invoice_date  last_bill_date

FROM work.analyst_sandbox_omi_bruce_rosetta bruce
UNION
SELECT  
        'Geneva' source_billing,
        geneva.amount,
        geneva.customer_ref customer_number, 
        geneva.event_source foreign_circuit, 
        geneva.event_source telia_circuit_id, 
        geneva.segment, 
        geneva.technology product,
        geneva.charge_start_date bill_start_date, 
        geneva.charge_end_date  last_bill_date

FROM 

base.manual_files_base_kisbi_geneva_dwh_tdc_prodct_view geneva


UNION
 
SELECT  'Geneva-ES' source_billing,
        geneva.amount,
        es.customer_ref customer_number, 
        es.event_source foreign_circuit, 
        es.event_source telia_circuit_id, 
        geneva.segment, 
        geneva.technology product,
        geneva.charge_start_date bill_start_date, 
        geneva.charge_end_date  last_bill_date

FROM 

work.analyst_sandbox_omi_kisbi_geneva_event_source es,
base.manual_files_base_kisbi_geneva_dwh_tdc_prodct_view geneva

WHERE
(es.customer_ref = geneva.customer_ref)

) t

GROUP BY source_billing
ORDER BY c DESC
LIMIT 100
;









SELECT sum(amount)
FROM base.manual_files_base_td_business_tdv_dwh_tdc_prodct_view tdc
where tdc.customer_ref = 1004711;


SELECT source_billing, count(*) c
FROM analytics.abt_billing_lines
GROUP BY source_billing
ORDER BY c DESC
;

select count(*)
from analytics.abt_billing_lines
where source_billing = 'Geneva-ES';

select sum(amount)
from work.contr_obligations_tdc_work_geneva_view_es_joined;

