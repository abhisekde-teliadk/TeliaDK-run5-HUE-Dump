select * from work.contr_obligations_tdc_work_geneva_product_event_source
where event_source like 'TN-117905';

select customer_ref, product_seq from base.import_other_sources_base_geneva_event_source 
where customer_ref=2621580 and product_seq=142;

select customer_ref, line_product_seq from base.import_other_sources_base_geneva_product 
where customer_ref=2621580 and line_product_seq=142;

select * from base.import_other_sources_base_geneva_event_source 
where customer_ref=2621580 and product_seq=2434;

select * from base.import_other_sources_base_geneva_product 
where customer_ref=2621580 and line_product_seq=2434;

select * from work.contr_obligations_tdc_work_geneva_product_grouped where customer_ref=2621580;

select * from work.contr_obligations_tdc_work_geneva_product_event_source where customer_ref=2621580;


select * from finance.abt_circuit_billing_lines where telia_circuit_id = 'TN-117905';
select * from finance.abt_circuit_billing_lines where telia_circuit_id = '39901129';



select customer_ref, product_seq from base.import_other_sources_base_geneva_event_source 
where event_source = 'TN-117905';