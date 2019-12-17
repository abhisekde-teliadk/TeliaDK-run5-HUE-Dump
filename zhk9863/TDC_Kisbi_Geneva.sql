-- how many rows do we have in one time fees
SELECT *
FROM base.manual_files_base_rosetta
;

select count(distinct rc.tdc_circuit_id) te --, count(distinct rc.tdc_circuit_id) td,  count(*) 
from abt_circuit_recon rc
WHERE rc.bill_end_date between add_months(now(),-3) and now()
;




select count(distinct telia_circuit_id) from abt_circuit_recon_fail;

-- info about one time fees
SELECT tvk, count(*) c
FROM analytics.abt_circuit_one_time_fees
GROUP BY tvk
ORDER BY c DESC
;


-- info about one time fees
SELECT edi.action_code, edi.tdc_product_code, sum(edi.line_amount_incl_vat) amount
FROM import_other_sources_base_edi_extract edi,
(
SELECT action_code, tdc_product_code, count(*) c
FROM analytics.abt_circuit_one_time_fees otf
-- WHERE otf.tvk_product_code is null and otf.tdc_product_code is null
WHERE otf.tvk_id IS NULL
GROUP BY action_code, tdc_product_code

ORDER BY action_code, tdc_product_code
) t
WHERE t.action_code = edi.action_code and t.tdc_product_code = edi.tdc_product_code
GROUP BY edi.action_code, edi.tdc_product_code
ORDER BY amount desc
;

-- how many rows do we have in one time fees
SELECT * --count(*)
FROM analytics.abt_circuit_one_time_fees
WHERE tdc_product_code = 8211300 and action_code = '010'
;




-- how many rows should be in one time fees
SELECT count(*) c
FROM 
base.import_other_sources_base_edi_extract edi
WHERE edi.account_name NOT LIKE 'DLG%' AND edi.action_code <> '000'
;

-- info about recon fail
SELECT source, sum(nvl(amount,0)), count(*) c
FROM analytics.abt_circuit_recon_fail
GROUP BY source
ORDER BY c DESC
;




SELECT count(*)

FROM work.contr_obligations_tdc_tbt_circuit_recon
;

select * from
work.contr_obligations_tdc_work_circuit_billing
;


SELECT strleft(edi.tdc_circuit_id, 2), count(*) c
FROM 
base.import_other_sources_base_edi_extract edi
LEFT OUTER JOIN
analytics.abt_circuit_bridge br
ON 
edi.tdc_circuit_id = br.foreign_circuit
WHERE 
edi.account_name NOT LIKE 'DLG%'
AND br.foreign_circuit IS NULL
GROUP BY strleft(edi.tdc_circuit_id, 2)
ORDER BY c DESC
;






SELECT count(distinct foreign_circuit) c
FROM analytics.abt_circuit_bridge
WHERE
strleft(foreign_circuit, 2) IN ('B6', 'B7', 'B8', 'B9', 'C0', 'C1', 'C2', 'C3', 'FN', 'HK', 'IN', 'VB')
;


SELECT count(*) total, count(distinct tdc_circuit_id) dist
FROM base.import_other_sources_base_edi_extract
WHERE
strleft(tdc_circuit_id, 2) IN ('B6', 'B7', 'B8', 'B9', 'C0', 'C1', 'C2', 'C3', 'FN', 'HK', 'IN', 'VB')
-- AND account_name NOT LIKE 'DLG%'
;


SELECT count(*) total, count(distinct foreign_circuit) dist
FROM analytics.abt_circuit_recon
WHERE
strleft( foreign_circuit, 2) IN ('B6', 'B7', 'B8', 'B9', 'C0', 'C1', 'C2', 'C3', 'FN', 'HK', 'IN', 'VB')
-- AND account_name NOT LIKE 'DLG%'
;











SELECT source, count(*) c
FROM analytics.abt_circuit_bridge
GROUP BY source
ORDER BY c DESC
;



SELECT * FROM 

manual_files_base_rosetta
;

SELECT 
count(distinct tdc_circuit_id)
FROM work.contr_obligations_tdc_tbt_circuit_recon
WHERE amount IS NULL

;

SELECT * -- count(*)
FROM 
analytics.abt_circuit_bridge
WHERE telia_circuit_id IS NULL
;




SELECT * FROM work.contr_obligations_tdc_tbt_circuit_recon
WHERE telia_circuit_id IN ( 'TN-146159','TN-145600', 'TN-145602' )
;

SELECT count()
analytics.abt_
;

-- 3 844 325 after circuit bridge
-- 3 910 194 after customer bridge
SELECT 
count(*)
FROM
base.import_other_sources_base_edi_extract edi
LEFT JOIN
analytics.abt_circuit_bridge cb
ON edi.tdc_circuit_id = cb.foreign_circuit
LEFT JOIN
analytics.work_circuit_customer_bridge ccb ON cb.telia_circuit_id = ccb.telia_circuit_id
LEFT JOIN
work.contr_obligations_tdc_work_circuit_billing cb
;

SELECT * FROM base.import_other_sources_base_geneva_product LIMIT 100;

-- how many unique circuit ids from TDC EDI are not found in the bridge
-- 145201 March 14, 2019
SELECT count(distinct edi.tdc_circuit_id)
FROM 
base.import_other_sources_base_edi_extract edi
WHERE edi.tdc_circuit_id NOT IN
    (
    SELECT DISTINCT foreign_circuit FROM analytics.abt_circuit_bridge   
    )
;



SELECT *
FROM 
base.import_other_sources_base_edi_extract 
WHERE tdc_circuit_id IS NOT NULL AND account_name NOT LIKE 'DLG%'

LIMIT 100

;


SELECT * FROM analytics.abt_circuit_bridge WHERE foreign_circuit LIKE '32104133';-- HN202290


SELECT product_name, technology, count(*) 
FROM base.import_other_sources_base_geneva_product 
GROUP BY product_name, technology
ORDER BY product_name, technology
LIMIT 100;


SELECT 
count(distinct tdc_circuit_id) -- 12079 in Product
-- count(distinct tdc_circuit_id) -- 13792 in Event Source
-- tdc_circuit_id, line_amount_excl_vat 
FROM
base.import_other_sources_base_edi_extract edi, 
 base.import_other_sources_base_geneva_event_source gen
WHERE edi.tdc_circuit_id = gen.event_source
;


SELECT *
FROM
 base.import_other_sources_base_geneva_event_source 
 ;

SELECT *
FROM
 base.import_other_sources_base_geneva_product
 WHERE customer_ref = 2562284;

SELECT DISTINCT event_source
FROM
 base.import_other_sources_base_geneva_event_source 
WHERE event_source NOT IN 
(
 SELECT event_source FROM base.import_other_sources_base_geneva_product
)
;








SELECT 
count(*) count_total,
count(tdc_circuit_id IS NOT NULL) count_not_null_circuit,
count(distinct tdc_circuit_id) count_distinct_circuit
-- tdc_circuit_id, line_amount_excl_vat 
FROM 
base.import_other_sources_base_edi_extract 
LIMIT 100;


SELECT 
count(distinct tdc_circuit_id) -- 12079 in Product
count(distinct tdc_circuit_id) -- 13792 in Event Source
-- tdc_circuit_id, line_amount_excl_vat 
FROM
base.import_other_sources_base_edi_extract edi, 
 base.import_other_sources_base_geneva_event_source gen
WHERE edi.tdc_circuit_id = gen.event_source
;


SELECT * from base.import_other_sources_base_geneva_product;


select 
es.event_source, es.START_DTM es_start, es.end_dtm es_end, prod.*

from (select customer_ref, segment, line_product_seq, product_seq, product_name, charge_start_date, charge_end_date, sum(amount)

        from base.import_other_sources_base_geneva_product

       group by customer_ref, segment, line_product_seq, product_seq, product_name, charge_start_date, charge_end_date) prod,

       base.import_other_sources_base_geneva_event_source  es

where prod.customer_ref = es.customer_ref

  and prod.line_product_seq = es.product_seq
  --and es.event_source = 'TN-117905'
  
  ORDER BY prod.charge_end_date ASC
;




select 
es.event_source, es.START_DTM es_start, es.end_dtm es_end, prod.*

from (select customer_ref, line_product_seq, product_seq, product_name , segment, event_source prod_event_source, sum(amount)

        from base.import_other_sources_base_geneva_product

       group by customer_ref, line_product_seq, product_seq, product_name, segment,  prod_event_source) prod,

       base.import_other_sources_base_geneva_event_source  es

where prod.customer_ref = es.customer_ref

  and prod.line_product_seq = es.product_seq
  
;



SELECT 
*

FROM base.manual_files_base_td_business_tdv_dwh_tdc_prodct_view
where charge_end_date  BETWEEN add_months(now(), -6) AND add_months(now(),-2) --OR charge_end_date IS NULL
LIMIT 100;





-- 34420 rows in Geneva for charge_end_date within last three months till next 3000
-- 54019 total
SELECT 
 count(*) 

FROM base.manual_files_base_td_business_tdv_dwh_tdc_prodct_view
where charge_end_date  BETWEEN add_months(now(), -6) AND add_months(now(),-2) --OR charge_end_date IS NULL
LIMIT 100;

-- distinct event_source 555 551, NULL end date 536 376, non null end date 484 462
-- 
SELECT 
count(distinct event_source) 
FROM 
base.manual_files_base_kisbi_geneva_tdv_dwh_es
WHERE end_dtm IS NOT NULL

LIMIT 100;



SELECT * FROM base.manual_files_base_kisbi_geneva_tdv_dwh_es LIMIT 100;


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
        'to be calculated' segment, -- vezmem z mf_tvk_segment a pres product_group ziskame BTB a BTC
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






-- SELECT count(DISTINCT tdc_circuitid) FROM work.analyst_sandbox_omi_rosetta; -- 5228
SELECT * FROM work.analyst_sandbox_omi_bruce_rosetta LIMIT 100; -- 230844

set request_pool=big;

SELECT * FROM 
analytics.abt_traffic tr
LIMIT 100
;

SELECT count(*) FROM 
analytics.abt_subscriber_current su,
analytics.abt_traffic tr
WHERE 
    su.internal_circuit_id IS NOT NULL
    AND
    tr.subscriber_internal_circuit_id IS NOT NULL
    AND 
    su.subscriber_id = tr.subscriber_subscriber_id
    
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
        'to be calculated' segment,  -- vezmem z mf_tvk_segment ziskame BTB a BTC z product group
        'to be calculated' product, -- vezmeme product group z abt_subscriber_current (customer_id, subscriber_no)
        fokus.billing_bill_period_start_date bill_start_date, 
        fokus.billing_bill_period_end_date  last_bill_date

FROM work.contr_obligations_tdc_work_circuit_billing fokus
-- todo specify Fokus Bill comment
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










SELECT * FROM work.analyst_sandbox_omi_kisbi_geneva_event_source
LIMIT 100;

SELECT  * FROM base.sandbox_brstak_base_tdc_prodct_view
LIMIT 100
;

-- how many event sources do we have without prd view
SELECT count(*) FROM work.analyst_sandbox_omi_kisbi_geneva_event_source
WHERE customer_ref NOT IN (SELECT customer_ref FROM base.sandbox_brstak_base_tdc_prodct_view);

-- how many prd do we have without 
SELECT * FROM base.sandbox_brstak_base_tdc_prodct_view
WHERE customer_ref NOT IN (SELECT customer_ref FROM work.analyst_sandbox_omi_kisbi_geneva_event_source );



SELECT 

-- event_type_name, count(*) 
-- count(*)
*


FROM 

base.sandbox_brstak_base_tdc_prodct_view
-- LEFT JOIN
-- work.analyst_sandbox_omi_kisbi_geneva_event_source
-- GROUP  BY event_type_name
-- WHERE event_source <> event_source_label
--ORDER BY end_dtm DESC
LIMIT 100
;












select edi.account_name, count(*) counts 
from base.import_other_sources_base_edi_extract edi
group by edi.account_name
order by counts desc

;


-- 
SELECT count(*) FROM 
    analytics.abt_circuit_bridge cb, 
    work.analyst_sandbox_omi_bruce_rosetta br
WHERE cb.foreign_circuit = br.tdc_circuitid
;

-- SELECT DISTINCT tdc_circuitid FROM work.analyst_sandbox_omi_bruce_rosetta

-- KISBI/GENEVA following numbers
SELECT * FROM 
work.analyst_sandbox_omi_kisbi_geneva_event_source 
LIMIT 100
;

-- 234 399 TDC circuit IDs in the bridge
SELECT count(distinct tdc_circuit_id)
FROM
base.import_other_sources_base_edi_extract
;

-- 143 372
SELECT count(distinct foreign_circuit), count(distinct telia_circuit_id)
FROM
analytics.abt_circuit_fokus_minimal
;

-- 133 404
SELECT count(distinct telia_circuit_id)
FROM
analytics.abt_circuit_bridge
;

SELECT telia_circuit_id, source, count(*) c
FROM
analytics.abt_circuit_bridge
WHERE source <> 'Steno'

GROUP BY telia_circuit_id, source
ORDER BY c DESC
;

SELECT * FROM analytics.abt_circuit_bridge cb
WHERE cb.telia_circuit_id = 'TN-133411';

SELECT * FROM base.manual_files_base_steno_extract s
WHERE s.order_id LIKE '%TN-133411%'
;

-- 143 373
SELECT count(distinct foreign_circuit)
FROM
analytics.abt_circuit_bridge
;



SELECT count(distinct tdc_circuit_id)
FROM
analytics.abt_tdc_not_existing_billed
;

-- 157 554 circuits missing in total
-- 23 327 TDC CIRCUIT ID are in Bruce Rosetta without respect to any date
SELECT count(*)
FROM
(
    SELECT distinct tdc_circuit_id
    FROM
    analytics.abt_tdc_not_existing_billed
) neb

LEFT JOIN
(
    SELECT DISTINCT tdc_circuitid FROM work.analyst_sandbox_omi_rosetta
    UNION
    SELECT DISTINCT tdc_circuitid FROM work.analyst_sandbox_omi_bruce_rosetta
) bruce_rosetta ON neb.tdc_circuit_id=bruce_rosetta.tdc_circuitid

WHERE bruce_rosetta.tdc_circuitid IS NOT NULL;

SELECT count(DISTINCT tdc_circuitid) FROM work.analyst_sandbox_omi_rosetta; -- 5228
SELECT count(DISTINCT tdc_circuitid) FROM work.analyst_sandbox_omi_bruce_rosetta; -- 230844
    
SELECT count(DISTINCT event_source) FROM -- 157 554
(
    SELECT DISTINCT event_source FROM base.sandbox_brstak_base_tdc_prodct_view
    UNION
    SELECT DISTINCT event_source FROM work.analyst_sandbox_omi_kisbi_geneva_event_source
) t
;


-- how many unique rows from missing did we match with Kisbi/Geneva 131 264
-- 157 554 circuits missing in total
-- 13 864 TDC CIRCUIT ID are in Kisbi/Geneva without respect to any date
SELECT count(*)
FROM
(
SELECT distinct tdc_circuit_id
FROM
analytics.abt_tdc_not_existing_billed
) neb
;
LEFT JOIN
(
    SELECT DISTINCT event_source FROM base.sandbox_brstak_base_tdc_prodct_view
    UNION
    SELECT DISTINCT event_source FROM work.analyst_sandbox_omi_kisbi_geneva_event_source
) kisbi_geneva ON neb.tdc_circuit_id=kisbi_geneva.event_source

WHERE kisbi_geneva.event_source IS NOT NULL;

-- distinct event_source 559052
SELECT distinct event_source as foreign_circuit, event_source as telia_circuit_id, 'Geneva' source 
FROM
(
    SELECT DISTINCT event_source FROM base.sandbox_brstak_base_tdc_prodct_view
    UNION
    SELECT DISTINCT event_source FROM work.analyst_sandbox_omi_kisbi_geneva_event_source
) t
;

-- how many are not billed from Kisbi/Geneva event_source - 8627
SELECT count(*)
FROM analytics.abt_tdc_not_existing_billed neb 
    LEFT JOIN
    base.sandbox_brstak_base_tdc_prodct_view  kisbi_geneva
    ON neb.tdc_circuit_id = kisbi_geneva.event_source
    
WHERE kisbi_geneva.customer_ref IS NOT NULL
;


-- how many are not billed from Kisbi/Geneva event_source - 133 874
SELECT count(*)
FROM analytics.abt_tdc_not_existing_billed neb 
    LEFT JOIN
    work.analyst_sandbox_omi_kisbi_geneva_event_source more_numbers
    ON neb.tdc_circuit_id = more_numbers.event_source
    
WHERE more_numbers.customer_ref IS NOT NULL
;



-- how many paired from Rosetta - 5425
SELECT count(*)
FROM analytics.abt_tdc_not_existing_billed neb
    LEFT JOIN
    work.analyst_sandbox_omi_rosetta rosetta
    ON neb.tdc_circuit_id = rosetta.tdc_circuitid
    
WHERE rosetta.telia_circuitid IS NOT NULL
;


-- how many paired from Bruce 161 818
SELECT count(*)
FROM analytics.abt_tdc_not_existing_billed neb
    LEFT JOIN
    work.analyst_sandbox_omi_bruce_rosetta bruce
    ON neb.tdc_circuit_id = bruce.tdc_circuitid
    
WHERE bruce.telia_circuitid IS NOT NULL
;



-- KISBI/GENEVA main table
-- Question for Steffen/Jeppe: end date for the main number
-- mapping of KISBI/GENEVA event sources to 
SELECT 
    DISTINCT
    neb.tdc_circuit_id,
    kisbi_main.customer_ref, 
    kisbi_main.account_num, 
    kisbi_main.credit_class, 
    kisbi_main.event_source kisbi_event_source, 
    more_numbers.event_source more_event_source,
    more_numbers.start_dtm,
    more_numbers.end_dtm

FROM base.sandbox_brstak_base_tdc_prodct_view kisbi_main
    LEFT JOIN
    work.analyst_sandbox_omi_kisbi_geneva_event_source more_numbers
    ON kisbi_main.customer_ref = more_numbers.customer_ref
    
    
    LEFT JOIN
    analytics.abt_tdc_not_existing_billed neb 
        ON neb.tdc_circuit_id = more_numbers.event_source

WHERE  neb.tdc_circuit_id IS NOT NULL

-- ORDER BY kisbi_main.account_num, kisbi_main.event_source


LIMIT 100
;


SELECT customer_ref, account_num, event_source, count(*) c
-- Kisbi Geneva
FROM base.sandbox_brstak_base_tdc_prodct_view 
GROUP BY customer_ref, account_num, event_source
ORDER BY c DESC

LIMIT 100;

-- 4 segments
SELECT segment, count(*)
FROM work.analyst_sandbox_omi_bruce_rosetta
GROUP BY segment
LIMIT 100;

-- 4 segments
SELECT segment, count(*)
FROM work.analyst_sandbox_omi_rosetta
GROUP BY segment
LIMIT 100;




SELECT strleft(telia_circuitid,2), count(*)
FROM work.analyst_sandbox_omi_bruce_rosetta
GROUP BY strleft(telia_circuitid,2)
LIMIT 100;

SELECT *
FROM work.analyst_sandbox_omi_bruce_rosetta
LIMIT 100;


SELECT * FROM work.analyst_sandbox_omi_kisbi_geneva_event_source LIMIT 100;


SELECT 
-- count(DISTINCT customer_ref, account_num, event_source)
DISTINCT customer_ref, account_num, event_source, geneva.product_name, edi.product_name  
FROM 
base.sandbox_brstak_base_tdc_prodct_view geneva,
base.import_other_sources_base_edi_extract edi
WHERE
geneva.event_source = edi.tdc_circuit_id
AND edi.action_code <> '000'
LIMIT 100;


-- one time fees mapping
SELECT 
-- count(DISTINCT customer_ref, account_num, event_source)
DISTINCT customer_ref, account_num, event_source  
FROM 
base.sandbox_brstak_base_tdc_prodct_view geneva;



SELECT * FROM base.sandbox_brstak_base_tdc_prodct_view
WHERE event_source LIKE '%CN%';


SELECT * FROM base.sandbox_brstak_base_tdc_prodct_view 
WHERE event_source = '59597982'

LIMIT 100;