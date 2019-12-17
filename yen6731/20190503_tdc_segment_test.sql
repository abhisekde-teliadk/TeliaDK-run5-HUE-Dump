SELECT distinct segment from work.contr_obligations_tdc_work_billing_lines;

SELECT distinct source_billing, segment, segment_full from finance.abt_circuit_customer_bridge order by source_billing asc;

SELECT * from finance.abt_circuit_customer_bridge where source_billing='Geneva' and segment_full is null;

select * from base.manual_files_base_tvk_segment_full where source='Geneva' and budget_product_group='TELIA_EXT_INT';

SELECT distinct source_billing, source_segment, segment_full from finance.abt_circuit_otf order by source_billing asc ;