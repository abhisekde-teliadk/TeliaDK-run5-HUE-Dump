SELECT strleft(telia_circuit_id, 2), count( *) c 
FROM analytics.abt_circuit_bridge
GROUP BY strleft(telia_circuit_id, 2)
ORDER BY c DESC
-- WHERE telia_circuit_id = 'TS-000441'
;

SELECT * FROM analytics.abt_subscriber_current WHERE internal_circuit_id LIKE '%TS%' -- 'TS-000441'
LIMIT 100
;



-- how successfull are we in joining on telia_circuit_id
SELECT DISTINCT su.customer_id, su.subscriber_no, su.internal_circuit_id, ex.charge_telia_circuit, ex.bill_comment
-- SELECT count(*)
FROM 
work.analyst_sandbox_work_charge_extracted_synced ex
LEFT JOIN
analytics.abt_subscriber_current su
ON (su.subscriber_no = ex.subscriber_no AND cast(su.customer_id as STRING) = ex.ban)
-- WHERE su.subscriber_no IS NULL
LIMIT 100;


-- how successfull are we in joining on telia_circuit_id
-- SELECT su.customer_id, su.subscriber_no, su.internal_circuit_id, ex.charge_telia_circuit
SELECT count(*)
FROM 
work.analyst_sandbox_work_charge_extracted_synced ex
LEFT JOIN
analytics.abt_subscriber_current su
ON (su.internal_circuit_id = ex.charge_telia_circuit)
WHERE su.subscriber_no IS NULL
LIMIT 100;



-- REP 11 FOKUS DDATA
alter session set current_schema = DDATA; 
SELECT column_name, table_name, data_type
 FROM all_tab_cols
 WHERE column_name IN ('BILL_COMMENT')
 ORDER BY column_name;

-- 613 records 
SELECT count(*) FROM ddata.charge WHERE bill_comment LIKE '%TN-%';

-- with a partition
select * from ddata.charge partition(CHARGE_PR149) WHERE bill_comment LIKE '%TN-%'


-- we don't have bill_comment in Dataiku
SELECT count(*) FROM base.import_fokus_base_charge
WHERE bill_comment LIKE '%TN-%'
LIMIT 100;

-- TDC codes select
SELECT STRLEFT(br.foreign_circuit,3), count(*) c
FROM analytics.abt_circuit_bridge br
WHERE
br.foreign_circuit LIKE 'FN%'
OR
br.foreign_circuit LIKE 'HN%'

GROUP BY strleft(br.foreign_circuit,3)
ORDER BY c DESC
;


SELECT STRLEFT(br.foreign_circuit,3), count(*) c
FROM analytics.abt_circuit_bridge br
WHERE
br.foreign_circuit LIKE 'HN%'
GROUP BY strleft(br.foreign_circuit,3)
ORDER BY c DESC
;


SELECT strleft(br.foreign_circuit,2), count(*) c
FROM analytics.abt_circuit_bridge br
WHERE
instr(br.foreign_circuit, ',')=0
GROUP BY strleft(br.foreign_circuit,2)
ORDER BY c DESC
;

SELECT *
FROM analytics.abt_circuit_bridge br
WHERE
instr(br.foreign_circuit, ',')>0
;


-- SELECT distinct su.subscriber_no, su.internal_circuit_id, br.foreign_circuit, br.source
SELECT count(distinct su.subscriber_no, su.internal_circuit_id, br.foreign_circuit, br.source)
FROM 

analyst_sandbox_tdc_ll_sample ll,
analytics.abt_subscriber_current su,
analytics.abt_circuit_bridge br

WHERE
ll.line = su.subscriber_no
AND br.telia_circuit_id = su.internal_circuit_id
-- AND instr(br.foreign_circuit, ',')>0
AND su.internal_circuit_id IS NOT NULL
-- LIMIT 100;
;

-- 24402 rows
-- 3864
SELECT count(*) 
FROM 
work.analyst_sandbox_tdc_ll_sample ll
;

-- 24401 rows
-- 
SELECT count(DISTINCT ll.circuit_id) 
FROM 

work.analyst_sandbox_analyst_tdc_ll_copy ll
;

SELECT *
FROM 

work.analyst_sandbox_analyst_tdc_ll_copy ll
LIMIT 100
;