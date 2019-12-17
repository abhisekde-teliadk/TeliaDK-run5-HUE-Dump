-- duplicates in telia_circuit_id
SELECT steno_telia_circuit_id, count(*) CNT FROM work.analyst_sandbox_steno_prepared GROUP BY steno_telia_circuit_id ORDER BY CNT DESC LIMIT 100;

-- duplicates in foreing id
SELECT steno_foreign_circuit_id, count(*) CNT FROM work.analyst_sandbox_steno_prepared GROUP BY steno_foreign_circuit_id ORDER BY CNT DESC LIMIT 100;

-- duplicates in order id
SELECT steno_order_id, count(*) CNT FROM work.analyst_sandbox_steno_prepared GROUP BY steno_order_id ORDER BY CNT DESC LIMIT 100;

-- how many times order is circuit name
SELECT (steno_telia_circuit_id = steno_order_id) as EQ, count(*) CNT FROM work.analyst_sandbox_steno_prepared GROUP BY EQ ORDER BY CNT DESC LIMIT 100;
