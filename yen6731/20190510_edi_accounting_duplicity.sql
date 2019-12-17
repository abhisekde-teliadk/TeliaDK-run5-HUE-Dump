select * from base.admin_datasets_s3_dates where project_key='CONTR_OBLIGATIONS_TDC' and dataset='abt_circuit_otf' order by last_modified;

select * from base.import_other_sources_base_geneva_product_long where customer_ref in (2213834,2731955);
select * from  work.contr_obligations_tdc_work_customer_bridge_stacked where telia_circuit_id_old='75647187';


select * from  work.contr_obligations_tdc_work_customer_bridge_priority where telia_circuit_id='75647187';


select * from finance.abt_circuit_otf where invoice_date between '2019-01-01' and '2019-03-31';

select invoice_date, invoice_number, invoice_line,  /*, segment,*/  count(*)
from finance.abt_edi_accounting
--where source_billing='Geneva'
group by invoice_date, invoice_number, invoice_line--, segment
having count(*) > 1 
order by invoice_number asc
;

select distinct * from finance.abt_edi_accounting where data_quality>1 order by invoice_number,invoice_line desc;

select distinct * from finance.abt_edi_accounting where invoice_number=2492251411119 and invoice_line=1105;

-- two records - TNID vs Steno
select distinct * from finance.abt_edi_accounting where invoice_number=2414998843391 and invoice_line=210;

select distinct * from finance.abt_edi_accounting where invoice_number=2854996610434 and invoice_line=4100;

select * from finance.abt_circuit_customer_bridge where telia_circuit_id = 'TN-158841';
select * from finance.abt_circuit_bridge where telia_circuit_id = 'TN-158841';


select  * from finance.abt_edi_accounting where data_quality=2 order by invoice_number desc;
--2414998843383

select * from work.contr_obligations_tdc_edi_accounting_duplicate_count where invoice_number=3069446740411 and invoice_line=1066;


select * from finance.abt_edi_accounting where invoice_date>='25.2.2019';

select * from work.contr_obligations_tdc_edi_accounting_duplicate_count;


select * from base.import_other_sources_base_edi_extract_jakub;

select * from work.contr_obligations_tdc_work_edi_accounting where source_billing='Fokus';

drop table analytics.work_circuit_customer_bridge;

select * from work.contr_obligations_tdc_work_circuit_customer_bridge;

select distinct * from finance.abt_edi_accounting where data_quality=2 and geneva_account_num is not null order by invoice_line desc;

select distinct * from finance.abt_edi_accounting where invoice_number=2512660590233 and invoice_line=219;

select * from finance.abt_edi_accounting where strleft(tdc_circuit_id,2)='VB';