select * from finance.abt_circuit_bridge where telia_circuit_id = 'TN-327041';
select *
from work.contr_obligations_tdc_work_steno_extract_dedup
where steno_foreign_circuit_id = 'HN150020'
;

select *
from work.contr_obligations_tdc_work_techinfo_tnid_steno_rank
where union_foreign_circuit = 'HN150020'
;

select *
from work.contr_obligations_tdc_work_techinfo_tnid_fo_joined
where foreign_circuit = 'HN150020'
;


select union_foreign_circuit
from work.contr_obligations_tdc_work_techinfo_tnid_steno_rank
where union_foreign_circuit not in 
(select union_foreign_circuit_id 
from work.contr_obligations_tdc_work_steno_tnid_techinfo_geneva_dedup
)
;

select foreign_circuit -- MISSING EB532662, EB599751
from finance.abt_circuit_bridge --work.contr_obligations_tdc_work_circuit_bridge_test
where foreign_circuit not in 
(select foreign_circuit 
from work.contr_obligations_tdc_work_circuit_bridge_test --finance.abt_circuit_bridge
)
;

select telia_circuit_id
from work.contr_obligations_tdc_work_circuit_bridge_test
where telia_circuit_id not in 
(select telia_circuit_id 
from finance.abt_circuit_bridge
)
;

select *
from finance.abt_circuit_bridge
where foreign_circuit = 'EB599751'
;

select *
from work.contr_obligations_tdc_work_circuit_bridge_test
where foreign_circuit = 'EB532662'
;


select *
from work.contr_obligations_tdc_work_steno_tnid_techinfo_geneva_full_join
where steno_foreign_circuit_id = 'FB-313902'
--union_foreign_circuit_id = 'EB532662'
;

select *
from work.contr_obligations_tdc_work_steno_tnid_techinfo_geneva_dedup
where union_foreign_circuit_id = 'EB532662'
;

select *
from work.contr_obligations_tdc_work_techinfo_tnid_steno
where union_foreign_circuit = 'EB532662'
;

select *
from work.contr_obligations_tdc_work_techinfo_union
where telia_circuit_id = 'TN-236333'
;



select foreign_circuit, count(*) c 
from work.contr_obligations_tdc_work_circuit_bridge_test
group by foreign_circuit
order by c desc
;

select union_foreign_circuit, count(*) c
from work.contr_obligations_tdc_work_techinfo_tnid_steno_rank
group by union_foreign_circuit
order by c desc
;

select *
from base.import_other_sources_base_tnid_extract
where telia_id = 'TN-236333'
;

select *
from base.manual_files_base_steno_extract
where steno_foreign_circuit_id = 'FB-313902'
;






select foreign_circuit, count(*) c 
from work.contr_obligations_tdc_work_circuit_bridge_test
group by foreign_circuit
order by c desc
;

select telia_circuit_id, count(*) c 
from work.contr_obligations_tdc_work_circuit_bridge_test
group by telia_circuit_id
order by c desc
;

select telia_circuit_id, count(*) c 
from finance.abt_circuit_bridge
group by telia_circuit_id
order by c desc
;


select count(distinct circuit_reference) 

from 
base.import_other_sources_base_geneva_product_long
where circuit_reference is not null
and circuit_reference in (select steno_telia_circuit_id from base.manual_files_base_steno_extract)
;

select circuit_reference --count(distinct circuit_reference) 
from 
base.import_other_sources_base_geneva_product_long
where circuit_reference is not null
and circuit_reference in (select telia_circuit_id 
from work.contr_obligations_tdc_work_circuit_bridge_test 
--finance.abt_circuit_bridge
)
;