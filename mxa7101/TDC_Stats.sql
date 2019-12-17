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


select source, count(foreign_circuit), count(telia_circuit_id)
from analytics.abt_circuit_bridge
group by source;
