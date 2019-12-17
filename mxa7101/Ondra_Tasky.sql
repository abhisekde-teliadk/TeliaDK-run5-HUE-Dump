SELECT strleft(br.foreign_circuit,2), count(*) c
FROM analytics.abt_circuit_bridge br
WHERE
instr(br.foreign_circuit, ',')=0
GROUP BY strleft(br.foreign_circuit,2)
ORDER BY c DESC;

SELECT *
FROM analytics.abt_circuit_bridge br
WHERE
instr(br.foreign_circuit, ',')>0;

select *
from base.import_other_sources_base_tnid_extract tn
where
instr(tn.foreign_circuit, ',')>0;



SELECT *
FROM base.import_other_sources_base_tnid_extract
WHERE instr(tnid_foreign_reference, ',') > 0 OR
instr(tnid_foreign_reference, '/') > 0;