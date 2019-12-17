select * from finance.abt_circuit_bridge;
select * from finance.abt_circuit_customer_bridge;











select count(distinct circuit_reference) 
from 
base.import_other_sources_base_geneva_product_long
where circuit_reference is not null
and circuit_reference in (select telia_circuit_id from work.contr_obligations_tdc_work_circuit_bridge_test --finance.abt_circuit_bridge

)
;


select * from finance.abt_edi_accounting order by data_quality desc;
select * from finance.abt_circuit_otf where data_quality > 1;
select * from finance.abt_circuit_otf where strleft(tdc_circuit_id,2) = 'HN';

select * from finance.contr_obligations_tdc_abt_circuit_recon_summary_email;

select distinct * from finance.abt_edi_accounting where invoice_number=2942795440096 and invoice_line=79;
select distinct * from finance.abt_edi_accounting where invoice_number=2942795440096 and invoice_line=79;


select * from analytics.abt_subscriber_current where internal_circuit_id = 'TN-158818';
select * from base.import_other_sources_base_geneva_product_long where circuit_reference = 'TN-158818';
select * from base.import_other_sources_base_geneva_product where event_source = 'TN-158818';
select * from base.import_other_sources_base_geneva_event_source where event_source = 'TN-158818';
select * from finance.abt_circuit_customer_bridge where telia_circuit_id = 'TN-158818';
select * from finance.abt_edi_accounting where telia_circuit_id = 'TN-158818';
select * from finance.abt_circuit_bridge where telia_circuit_id = 'TN-158818';


select distinct eac.customer_number, eac.source_billing, nvl(cc.last_business_name, gp.customer_name )
from finance.abt_edi_accounting eac
left join analytics.abt_customer_current cc on
(eac.source_billing = 'Fokus' and cc.customer_id = eac.customer_number)

left join base.import_other_sources_base_geneva_product gp on
(eac.source_billing = 'Geneva' and gp.customer_ref = eac.customer_number)


--where eac.source_billing in ('Fokus','Geneva') and gp.customer_ref = cc.customer_id
;
select * from finance.abt_circuit_customer_bridge;


select *
from 
base.import_other_sources_base_geneva_product_long
where circuit_reference is not null
;

select count(distinct circuit_reference) 

from 
base.import_other_sources_base_geneva_product_long
where circuit_reference is not null
and circuit_reference in (select steno_telia_circuit_id from base.manual_files_base_steno_extract)
;

select * from 
base.manual_files_base_steno_extract
where steno_telia_circuit_id IN
(
select distinct circuit_reference
from 
base.import_other_sources_base_geneva_product_long
)
limit 10;