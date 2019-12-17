select -- count(*) c

    edi.invoice_number,
    edi.invoice_line,
    edi.tdc_circuit_id,
    cib.telia_circuit_id,
    cub.customer_number,
    cub.source_billing,
    nvl(tvk1.tvk, tvk2.tvk) as tvk,
    nvl(tvk1.tvk_telia_product, tvk2.tvk_telia_product ) as tvk_product


from 

    base.import_other_sources_base_edi_extract edi

left join
    analytics.abt_circuit_bridge cib on (edi.tdc_circuit_id = cib.foreign_circuit  )

left join
    analytics.abt_circuit_customer_bridge cub on (cub.telia_circuit_id = cib.telia_circuit_id)

left join 
    base.manual_files_base_tvk_segment seg on 
    (
    cub.segment = seg.product_group 
    AND 
    cub.source_billing = seg.system
    )

left join
    base.manual_files_base_tvk tvk1 on 
    (
    edi.action_code = tvk1.tvk_action_code
    and
    edi.tdc_product_code = tvk1.tvk_product_code
    and
    seg.tvk_segment = tvk1.tvk_telia_org
    and
    edi.tdc_circuit_id_tvk_technology = tvk1.tvk_technology
    )

left join
    base.manual_files_base_tvk tvk2 on 
    (
    edi.action_code = tvk2.tvk_action_code
    and
    edi.tdc_product_code = tvk2.tvk_product_code
    and
    tvk2.tvk = 'T'
    and
    tvk2.tvk_technology = "NULL"
    and
    tvk2.tvk_telia_org = "NULL"
    )


where 
    edi.account_name not like 'DLG%' 
    and action_code NOT IN ('000','777','888')

LIMIT 1000
;















select count(*)
from analytics.abt_circuit_one_time_fees
;

select invoice_number, invoice_line, count(*) c
from import_other_sources_base_edi_extract
where account_name not like 'DLG%' and action_code NOT IN ('000','777','888')
group by invoice_number, invoice_line
order by c, invoice_number, invoice_line desc
;


select 
tvk_action_code, tvk_product_code, tvk_technology, tvk_telia_org, count(*) c
from manual_files_base_tvk
where tvk ='T' 
group by tvk_action_code, tvk_product_code, tvk_technology, tvk_telia_org
order by c desc
;


select 
tvk_action_code, tvk_product_code, tvk_technology, tvk_telia_org, count(*) c
from manual_files_base_tvk
where tvk ='T' 
group by tvk_action_code, tvk_product_code, tvk_technology, tvk_telia_org
order by c desc
;


select 
tvk_action_code, tvk_product_code
from manual_files_base_tvk
where tvk_technology <> 'NULL' AND concat(tvk_action_code, cast(tvk_product_code as string))   -- tvk ='T' 
IN (
select 
concat(tvk_action_code, cast(tvk_product_code as string))
from manual_files_base_tvk
where tvk_technology = 'NULL'
)
;






SELECT  * FROM manual_files_base_tvk WHERE tvk_product_code = 8247800
;



SELECT count(*) FROM analytics.abt_circuit_one_time_fees
WHERE telia_circuit_id IS NOT NULL and customer_number IS NOT NULL
AND telia_circuit_id_count > 1
;








SELECT *
FROM analytics.abt_circuit_one_time_fees
WHERE tdc_circuit_id = '32104133'




;
SELECT *
from analytics.abt_circuit_customer_bridge
-- GROUP BY telia_circuit_id
WHERE telia_circuit_id = 'TB-368410'





SELECT telia_circuit_id, count(*) c
from analytics.abt_circuit_customer_bridge
GROUP BY telia_circuit_id
ORDER BY c DESC
;


SELECT *
from analytics.abt_circuit_customer_bridge
-- GROUP BY telia_circuit_id
WHERE telia_circuit_id = 'TB-368410'
--ORDER BY c DESC
;


SELECT count(*) from manual_files_base_rosetta where telia_circuitid IS NULL

;
SELECT count(*)
from import_other_sources_base_geneva_product
WHERE
;



SELECT 
-- count(*) -- count(distinct telia_circuit_id, tdc_circuit_id) 14917, NO telia ID 9641, No customer, yes telia - 14868,  Yes Customer 14392
count(distinct telia_circuit_id, tdc_circuit_id, customer_number)
FROM analytics.abt_circuit_one_time_fees
WHERE telia_circuit_id IS NOT NULL AND customer_number IS NOT NULL
;

SELECT *
FROM analytics.abt_circuit_one_time_fees
WHERE telia_circuit_id IS NOT NULL AND customer_number IS NOT NULL
;

-- OTF not found in circuit bridge
SELECT *
FROM analytics.abt_circuit_one_time_fees
-- WHERE telia_circuit_id='TB-368410'
-- WHERE telia_circuit_id IS  NULL
--AND customer_number IS NULL

;

-- OTF found in circuit, not found in customer bridge
SELECT * -- count(*) 
FROM analytics.abt_circuit_one_time_fees
-- WHERE telia_circuit_id IS NOT NULL
-- AND customer_number IS NULL

;

select customer_ref, account_num, cvr_number -- , count(*) c
from import_other_sources_base_geneva_product
-- group by customer_ref, cvr_number
order by customer_ref, account_num desc
;




SELECT * FROM manual_files_base_rosetta;


SELECT count(*) 
FROM import_other_sources_base_edi_extract WHERE action_code NOT IN ('000','777','888') AND account_name NOT LIKE 'DLG%'
;


SELECT distinct action_code, tdc_product_code 
FROM base.import_other_sources_base_edi_extract
WHERE 
action_code NOT IN ('000', '888', '777')
AND
concat(cast(action_code as string), cast(tdc_product_code as string))
NOT IN
(
SELECT  concat(cast(tvk_action_code as string), cast(tvk_product_code as string)) 
FROM manual_files_base_tvk
)

;



SELECT count(distinct tdc_circuit_id) 
FROM analytics.abt_circuit_data_quality
WHERE amount_billing IS NULL
;


SELECT action_code, technology,  should_be_found, round(sum(amount_billing)), round(sum(amount_edi))
FROM analytics.abt_circuit_data_quality
GROUP BY action_code, technology,  should_be_found
ORDER BY action_code, technology, should_be_found
;




SELECT distinct product_name --count(*) --account_name
FROM base.import_other_sources_base_edi_extract
WHERE action_code IS NULL
;

SELECT * --count(*) --account_name
FROM base.import_other_sources_base_edi_extract 
WHERE account_name IS NULL
;

SELECT count(*) --account_name
FROM base.import_other_sources_base_edi_extract edi
;


SELECT count(*) --account_name
FROM base.import_other_sources_base_edi_extract edi
LEFT JOIN 
analytics.abt_circuit_bridge cib
ON edi.tdc_circuit_id = cib.foreign_circuit
LEFT JOIN
analytics.tbt_circuit_customer_bridge cb
    ON edi.tdc_circuit_id = cb.foreign_circuit
LEFT JOIN
    manual_files_base_tvk_segment seg -- tady jsem pridal to mapovani na BTC/BTB segment
    ON cb.segment = seg.product_group
    AND cb.source_billing = seg.system
LEFT JOIN manual_files_base_tvk tvk
    ON (tvk.tvk_action_code = edi.action_code
    AND tvk.tvk_product_code = edi.tdc_product_code
    AND tvk.tvk_telia_org = seg.tvk_segment -- a tady se nam ty segmenty musi spojit
    AND tvk.tvk_technology = edi.tdc_circuit_id_tvk_technology
    )
    
WHERE edi.action_code <> '000' and edi.account_name NOT LIKE 'DLG%'

;

select distinct segment
from analytics.tbt_circuit_customer_bridge
;


-- Techinfo import to DataMall
SELECT *
FROM base.import_bpm_base_techinfodb_dsl -- and also DSL/FIBER/COAX and others
;

-- Steno extract for circuit bridge
-- 21.3.2019 count: 126468 rows
SELECT count(*)
FROM
base.manual_files_base_steno_extract
;

-- TNID extract for circuit bridge
-- 21.3.2019 count:68416
SELECT count(*)
FROM
base.import_other_sources_base_tnid_extract
;

-- Geneva Product view
-- 21.3.2019 count:46885
SELECT count(*)
FROM
base.import_other_sources_base_geneva_product
;

-- Geneva Event Source view
-- 21.3.2019 count:597498
SELECT count(*)
FROM
base.import_other_sources_base_geneva_event_source
;

-- Geneva - one way to join Product view and Event Source view
select 
es.event_source, es.START_DTM es_start, es.end_dtm es_end, prod.*

from (select customer_ref, segment, line_product_seq, product_seq, product_name, charge_start_date, charge_end_date, sum(amount)

        from base.import_other_sources_base_geneva_product

       group by customer_ref, segment, line_product_seq, product_seq, product_name, charge_start_date, charge_end_date) prod,

       base.import_other_sources_base_geneva_event_source  es

where prod.customer_ref = es.customer_ref

  and prod.line_product_seq = es.product_seq
  
  ORDER BY prod.charge_end_date ASC
;


-- Bruce billing data
-- 21.3.2019 count:439329
SELECT count(*)
FROM
base.manual_files_base_bruce
;

-- Rosetta billing data
-- 21.3.2019 count:5969
SELECT * --count(*)
FROM
base.manual_files_base_rosetta
;

-- Fokus telia_circuit_id is found in abt_subscriber_current
-- 21.3.2019 count:35257
SELECT count(*) 
FROM analytics.abt_subscriber_current
WHERE internal_circuit_id IS NOT NULL
;

-- Manual file mapping tvk for One Time Fees
SELECT *
FROM base.manual_files_base_tvk;

-- Manual file mapping segments to BTC/BTB
SELECT *
FROM base.manual_files_base_tvk_segment;

-- Manual file circuit technology codes and comments
SELECT *
FROM base.manual_files_base_circuit_technology;




----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------

-- run this first:
set request_pool=big;

-- EDI total 3 830 724, distinc 234 399
-- non DLG 1019991	116481
SELECT '350 EDI TOTAL' filter,
count(*) count_total,
count(distinct tdc_circuit_id) count_distinct_circuit
FROM 
base.import_other_sources_base_edi_extract 

UNION
SELECT 
'340 EDI without DLG' filter,
count(*) count_total,
count(distinct tdc_circuit_id) count_distinct_circuit
FROM 
base.import_other_sources_base_edi_extract 
WHERE account_name NOT LIKE 'DLG%'


UNION
SELECT 
'330 EDI NULL tdc_circuit_id' filter,
count(*) count_total,
count(distinct tdc_circuit_id) count_distinct_circuit
FROM 
base.import_other_sources_base_edi_extract 
WHERE tdc_circuit_id IS NULL

UNION
SELECT 
'320 EDI, no DLG, NULL action_code' filter,
count(*) count_total,
count(distinct tdc_circuit_id) count_distinct_circuit
FROM 
base.import_other_sources_base_edi_extract 
WHERE action_code IS NULL AND account_name NOT LIKE 'DLG%'

UNION
SELECT 
'310 EDI, no DLG, action_code 000' filter,
count(*) count_total,
count(distinct tdc_circuit_id) count_distinct_circuit
FROM 
base.import_other_sources_base_edi_extract 
WHERE action_code = '000' AND account_name NOT LIKE 'DLG%'

UNION
SELECT 
'300 EDI, no DLG, action_code <> 000' filter,
count(*) count_total,
count(distinct tdc_circuit_id) count_distinct_circuit
FROM 
base.import_other_sources_base_edi_extract 
WHERE action_code <> '000' and action_code IS NOT NULL AND account_name NOT LIKE 'DLG%'


UNION
SELECT 
'220 EDI non DLG, Not found in Bridge' filter,
count(*) count_total,
count(distinct edi.tdc_circuit_id) count_distinct_circuit
FROM 
base.import_other_sources_base_edi_extract edi
LEFT OUTER JOIN
analytics.abt_circuit_bridge br
ON 
edi.tdc_circuit_id = br.foreign_circuit
WHERE 
edi.account_name NOT LIKE 'DLG%'
AND br.foreign_circuit IS NULL

UNION
SELECT 
'210 Circuit Bridge Foreign Circuits' filter,
count(*) count_total,
count(distinct foreign_circuit) count_distinct_circuit
FROM 
analytics.abt_circuit_bridge

UNION
SELECT 
'200 Circuit Bridge Telia Circuits' filter,
count(*) count_total,
count(distinct telia_circuit_id) count_distinct_circuit
FROM 
analytics.abt_circuit_bridge

UNION
SELECT 
'110 Recon Telia Circuits' filter,
count(*) count_total,
count(distinct telia_circuit_id) count_distinct_circuit
FROM work.contr_obligations_tdc_tbt_circuit_recon


UNION
SELECT 
'100 Recon Customers' filter,
count(*) count_total,
count(distinct customer_number) count_distinct_circuit
FROM work.contr_obligations_tdc_tbt_circuit_recon


UNION
SELECT 
'120 Recon Telia NULL amount' filter,
count(*) count_total,
count(distinct telia_circuit_id) count_distinct_circuit
FROM work.contr_obligations_tdc_tbt_circuit_recon
WHERE amount IS NULL


UNION
SELECT 
'130 Recon TDC circuit with NULL amount' filter,
count(*) count_total,
count(distinct foreign_circuit) count_distinct_circuit
FROM work.contr_obligations_tdc_tbt_circuit_recon
WHERE amount IS NULL 

UNION
SELECT 
'410 One Time Fees, no DLG, tdc_circuit_id ' filter,
count(*) count_total,
count(distinct tdc_circuit_id) count_distinct_circuit
FROM 
analytics.abt_circuit_one_time_fees
WHERE account_name NOT LIKE 'DLG%'

UNION
SELECT 
'420 One Time Fees, no DLG, telia_circuit_id ' filter,
count(*) count_total,
count(distinct telia_circuit_id) count_distinct_circuit
FROM 
analytics.abt_circuit_one_time_fees
WHERE account_name NOT LIKE 'DLG%'

UNION
SELECT 
'430 One Time Fees, no DLG, TDC circuit, where tvk is null ' filter,
count(*) count_total,
count(distinct tdc_circuit_id) count_distinct_circuit
FROM 
analytics.abt_circuit_one_time_fees
WHERE account_name NOT LIKE 'DLG%' and tvk_id IS NULL



ORDER BY filter ASC

LIMIT 100;
