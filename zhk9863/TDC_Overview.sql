SELECT * -- count(*), count(DISTINCT product.event_source)
FROM 
base.manual_files_base_td_business_tdv_dwh_tdc_prodct_view product 
ORDER BY product.customer_ref

LIMIT 100;

SELECT count(*) --, count(DISTINCT es.event_source)
base.manual_files_base_kisbi_geneva_tdv_dwh_es es

LIMIT 100;


SELECT * -- count(distinct es.customer_ref)
FROM 
base.manual_files_base_kisbi_geneva_tdv_dwh_es es
WHERE es.customer_ref NOT IN
            (
            SELECT distinct customer_ref
            FROM
            base.manual_files_base_td_business_tdv_dwh_tdc_prodct_view product 
            )

LIMIT 100;






-- circuit stats --
SELECT DISTINCT abt_circuit_bridge.source, 
tel_crct_type_count.telia_circuit_type_count,
frgn_type.foreign_circuit_type_count,
tel_crct_id.telia_circuit_count,
frgn_crct_count.foreign_circuit_count

FROM analytics.abt_circuit_bridge

LEFT JOIN(
-- telia circuit id types count --
select source, count(distinct telia_circuit_id) telia_circuit_type_count
from work.contr_obligations_tdc_work_circuit_bridge_circuit_types crct_types
group by source) tel_crct_type_count

ON abt_circuit_bridge.source = tel_crct_type_count.source

LEFT JOIN(
-- foreign circuit id types count --
select source, count(distinct foreign_circuit) foreign_circuit_type_count
from work.contr_obligations_tdc_work_circuit_bridge_circuit_types 
group by source) frgn_type

ON abt_circuit_bridge.source = frgn_type.source

LEFT JOIN (
-- telia circuit ids count --
select source, count(distinct telia_circuit_id) telia_circuit_count
from analytics.abt_circuit_bridge
group by source) tel_crct_id

ON abt_circuit_bridge.source = tel_crct_id.source

LEFT JOIN (
-- foreign circuit ids count -- 
select source, count(distinct foreign_circuit) foreign_circuit_count
from analytics.abt_circuit_bridge
group by source) frgn_crct_count

ON abt_circuit_bridge.source = frgn_crct_count.source;

-- billing lines --
select source_billing, count(*) billing_lines_count
from analytics.abt_billing_lines
group by source_billing
order by count(*) desc;









-- 324 663 ES have data in Product view
-- 272 057 ES do not have customer_ref in Product
SELECT * 
FROM
base.manual_files_base_kisbi_geneva_tdv_dwh_es es
WHERE 
es.customer_ref  IN (
    SELECT customer_ref FROM
    base.manual_files_base_td_business_tdv_dwh_tdc_prodct_view 
    ) 
;

SELECT count(*) 
FROM
base.manual_files_base_td_business_tdv_dwh_tdc_prodct_view 
;

SELECT 
es.event_source, count(distinct es.customer_ref) c
FROM
-- base.manual_files_base_td_business_tdv_dwh_tdc_prodct_view geneva
base.manual_files_base_kisbi_geneva_tdv_dwh_es es
GROUP BY
es.event_source
ORDER BY c DESC
;


SELECT 
*
FROM
base.manual_files_base_td_business_tdv_dwh_tdc_prodct_view geneva
WHERE 
geneva.customer_ref = 2060463	and geneva.product_seq = 5444 --	61489  -- and geneva.product_seq = 4

;

SELECT 
*
FROM
base.manual_files_base_kisbi_geneva_tdv_dwh_es es
ORDER BY es.event_source
LIMIT 100
;

SELECT 
*
FROM
base.manual_files_base_td_business_tdv_dwh_tdc_prodct_view geneva
ORDER BY geneva.customer_ref
LIMIT 100
;



SELECT 
geneva.customer_ref, count(distinct geneva.segment) c
FROM
base.manual_files_base_td_business_tdv_dwh_tdc_prodct_view geneva
GROUP BY
geneva.customer_ref
ORDER BY c DESC
;

SELECT 
count(*)
/*
        'Geneva-ES' source_billing,
        geneva.amount,
        es.customer_ref customer_number, 
        es.event_source foreign_circuit, 
        es.event_source telia_circuit_id, 
        geneva.segment, 
        geneva.technology product,
        geneva.charge_start_date bill_start_date, 
        geneva.charge_end_date  last_bill_date
*/
FROM 

base.manual_files_base_kisbi_geneva_tdv_dwh_es es
LEFT OUTER JOIN
base.manual_files_base_td_business_tdv_dwh_tdc_prodct_view geneva

ON
(es.customer_ref = geneva.customer_ref)
;


-- how many mappings do we have from which source
SELECT source, count(*) c
FROM
analytics.abt_circuit_bridge
GROUP BY source
ORDER BY c DESC
;

-- distinct telia_circuit_ids in billing lines
SELECT 'FOKUS' source_billing, count(distinct telia_circuit_id) count_tids,count(*) count_lines
FROM
work.contr_obligations_tdc_work_circuit_billing
UNION
SELECT 'GENEVA-ES' source_billing, count(distinct event_source) count_tids,count(*) count_lines
FROM
base.manual_files_base_kisbi_geneva_tdv_dwh_es
UNION
SELECT 'GENEVA' source_billing, count(distinct event_source) count_tids,count(*) count_lines
FROM
base.manual_files_base_td_business_tdv_dwh_tdc_prodct_view
UNION
SELECT 'BRUCE' source_billing, count(distinct telia_circuitid) count_tids,count(*) count_lines
FROM
base.manual_files_base_bruce
UNION
SELECT 'ROSETTA' source_billing, count(distinct telia_circuitid) count_tids,count(*) count_lines
FROM
base.manual_files_base_rosetta
;

-- how many mappings are defined by which systems
SELECT source, count(*) c 
FROM
analytics.abt_circuit_bridge
GROUP BY source
;