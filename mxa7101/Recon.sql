select tdc_circuit_id, foreign_circuit, telia_circuit_id
from analytics.abt_circuit_recon
where telia_circuit_id is null;

select tdc_circuit_id, foreign_circuit, telia_circuit_id
from analytics.abt_circuit_recon
where foreign_circuit = 'EN325921';

select *
from analytics.abt_circuit_bridge
where foreign_circuit = 'EN325921';


select edi.tdc_circuit_id, br.foreign_circuit, br.telia_circuit_id
from base.import_other_sources_base_edi_extract edi
left join
analytics.abt_circuit_bridge br
on edi.tdc_circuit_id = br.foreign_circuit
left join
analytics.tbt_circuit_customer_bridge cb
on
cb.telia_circuit_id = br.telia_circuit_id
left join
analytics.tbt_circuit_billing_lines bl
on
bl.customer_number = cb.customer_number
where br.foreign_circuit = 'EN325921';

select rc.tdc_circuit_id, rc.foreign_circuit, rc.telia_circuit_id
from work.contr_obligations_tdc_work_circuit_recon rc
where rc.foreign_circuit = 'EN325921';

select rc.tdc_circuit_id, rc.foreign_circuit, rc.telia_circuit_id
from work.contr_obligations_tdc_tbt_circuit_recon rc
where rc.foreign_circuit = 'EN325921';
