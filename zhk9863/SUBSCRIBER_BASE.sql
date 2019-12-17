-- is always customer_id = customer_ban ? 
SELECT (customer_id = customer_ban) as cb, count(*) as cnt FROM base.import_fokus_base_subscriber GROUP BY cb  LIMIT 100;

-- is always internal_circuit_id = external_circuit_id ? 
SELECT (internal_circuit_id = external_circuit_id) as cb, count(*) as cnt 
FROM base.import_fokus_base_subscriber 
WHERE external_circuit_id IS NOT NULL
GROUP BY cb  LIMIT 100;

SELECT sub_status as cb, count(*) as cnt 
FROM base.import_fokus_base_subscriber 
GROUP BY cb  LIMIT 100;