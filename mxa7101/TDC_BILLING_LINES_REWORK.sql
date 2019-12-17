select distinct * from finance.abt_edi_accounting where invoice_number=2942795440096 and invoice_line=79;

select * from finance.abt_circuit_customer_bridge where telia_circuit_id = 'TN-158841';

select * from work.contr_obligations_tdc_work_customer_bridge_subscriber_fokus
where telia_circuit_id = 'TN-158841';

select * from work.contr_obligations_tdc_work_circuit_customer_bridge
where telia_circuit_id = 'TN-158841';

select * from finance.abt_circuit_bridge
where telia_circuit_id = 'TN-158818';

select * from finance.abt_circuit_billing_lines
where telia_circuit_id = 'TN-158841';

select * from work.contr_obligations_tdc_work_circuit_billing
where telia_circuit_id = 'TN-158841';

select * from work.contr_obligations_tdc_work_techinfo_tnid_subscriber_joined
where telia_circuit_id = 'TN-158841';

select *
from work.contr_obligations_tdc_work_geneva_product_event_source
where event_source = 'TN-158818'
;

select *
from work.contr_obligations_tdc_work_steno_tnid_techinfo_geneva_full_join
where union_telia_circuit_id = 'TN-158818'
;

select *
from work.contr_obligations_tdc_work_steno_tnid_techinfo_geneva_dedup
where union_telia_circuit_id = 'TN-158818'
;

select * from base.import_other_sources_base_geneva_product where event_source = 'TN-158818';

select customer_number
from finance.abt_circuit_billing_lines
where customer_number not in (select customer_number
from work.contr_obligations_tdc_work_billing_lines_stacked)
;

select count(distinct customer_number)
from finance.abt_circuit_billing_lines
;

select count(distinct customer_number)
from work.contr_obligations_tdc_work_billing_lines_stacked
;

select customer_ref
from base.import_other_sources_base_geneva_product
where customer_ref not in (select customer_ref
from base.import_other_sources_base_geneva_product_long)
;

select customer_ref
from base.import_other_sources_base_geneva_product_long
;

select count(*) from finance.abt_edi_accounting where customer_number is null;

select * from finance.abt_edi_accounting where account_name like 'DLG%';

select count(distinct customer_number)
from finance.abt_circuit_customer_bridge
where customer_number not in (select customer_number
from work.contr_obligations_tdc_work_customer_billing_lines_priority)
;

select count(distinct customer_number)
from work.contr_obligations_tdc_work_customer_billing_lines_priority
where customer_number not in (select customer_number
from finance.abt_circuit_customer_bridge)
;

select distinct customer_number, source_billing
from finance.abt_circuit_customer_bridge
where customer_number not in (select customer_number
from work.contr_obligations_tdc_work_billing_lines_stacked)
;

--453281214	VOIP-0004	FIX04582301216
-- 556483212	TD-012163	LLD1300015623
select customer_id, internal_circuit_id, subscriber_no
from analytics.abt_subscriber_current
where customer_id = 556483212
;

select *
from finance.abt_circuit_bridge --finance.abt_circuit_bridge
where telia_circuit_id = 'TD-012163' --'VOIP-0004'
;

select *
from analytics.abt_billing
where customer_id = 556483212
;

select *
from finance.abt_circuit_customer_bridge
where customer_number = 556483212
;


