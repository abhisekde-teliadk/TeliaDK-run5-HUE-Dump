SELECT count(*) 
FROM base.import_other_sources_base_edi_extract edi
WHERE edi.action_code IS NULL;



SELECT DISTINCT cc.customer_id, cc.last_business_name , edi.foreign_circuit, cc.cvr_no  
FROM 
work.contr_obligations_tdc_work_circuit_minimal_with_edi edi , 
analytics.abt_customer_current cc
WHERE edi.customer_id = cc.customer_id AND cc.cvr_no IS NOT NULL
LIMIT 100;


SELECT count(DISTINCT fokus.internal_circuit_id)
FROM analytics.abt_subscriber_current fokus
WHERE fokus.internal_circuit_id IS NOT NULL
;

SELECT count(DISTINCT telia_circuit_id)
FROM analytics.abt_circuit_fokus_minimal fokus
WHERE fokus.telia_circuit_id IS NOT NULL
;

SELECT count(DISTINCT fokus.telia_circuit_id, cus.cvr_no) FROM 
analytics.abt_circuit_bridge bridge,
base.import_other_sources_base_edi_extract edi,
analytics.abt_circuit_fokus_minimal fokus,
analytics.abt_customer_current cus

WHERE
bridge.foreign_circuit = edi.tdc_circuit_id
AND fokus.telia_circuit_id = bridge.telia_circuit_id
AND fokus.customer_id = cus.customer_id

;


-- fokus based codes
SELECT  strleft(s.internal_circuit_id,2) aa, count(*) 

FROM 

base.import_fokus_base_subscriber s
GROUP BY strleft(s.internal_circuit_id,2) 
LIMIT 100;

;

-- from which years are our records
SELECT strleft(file_name, 4) fn, count(*) c
FROM 
base.import_other_sources_base_edi_extract 
GROUP BY fn
ORDER BY c desc
LIMIT 500
;



-- what are the records with tdc_circuit_id null
SELECT *
FROM 
base.import_other_sources_base_edi_extract 
WHERE tdc_circuit_id IS NULL
LIMIT 500
;

-- what are the records with action code null
SELECT *
FROM 
base.import_other_sources_base_edi_extract 
WHERE action_code IS NULL
LIMIT 100
;


-- how many rows do we have with action codes?
SELECT action_code, count(*) c
FROM 
base.import_other_sources_base_edi_extract 
GROUP BY action_code

LIMIT 100
;


-- what all is in one invoice
SELECT * 
FROM 
base.import_other_sources_base_edi_extract
WHERE
invoice_number = 2826520736181

;

-- how many invoice numbers
SELECT invoice_number, count(*) as cnt
FROM 
base.import_other_sources_base_edi_extract
GROUP BY invoice_number

ORDER BY cnt DESC
LIMIT 1000;



SELECT strleft(tdc_circuit_id, 1), count(*) c
FROM 
base.import_other_sources_base_edi_extract 
GROUP BY strleft(tdc_circuit_id, 1)
ORDER BY c DESC
LIMIT 100;



SELECT tdc_circuit_id, count(*) c
FROM 
base.import_other_sources_base_edi_extract 
GROUP BY tdc_circuit_id
ORDER BY c DESC
LIMIT 100;



SELECT product_name, count(*) 
FROM 
base.import_other_sources_base_edi_extract 
GROUP BY product_name
LIMIT 100;


-- 69.580 in one time fees
SELECT *
FROM 
base.import_other_sources_base_edi_extract 
WHERE action_code NOT IN ('0', '000')
LIMIT 100;


-- 69.580 in one time fees
SELECT count(*) 
FROM 
base.import_other_sources_base_edi_extract 
WHERE action_code NOT IN ( '0','000')
LIMIT 100;

-- 3.830.724 records
-- 420 tdc circuit NULL
SELECT count(*) 
FROM 
base.import_other_sources_base_edi_extract 
WHERE 
true 
-- and tdc_circuit_id IS NULL

LIMIT 100;

SELECT * 
FROM 
base.import_other_sources_base_edi_extract 
-- WHERE tdc_circuit_id IS NULL
LIMIT 100;