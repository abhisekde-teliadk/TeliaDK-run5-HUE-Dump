-- used old edi files, store 3 years
-- edi files must be edited by Christian/Sukanya
select order_number, action_code
from base.import_other_sources_base_edi_extract
where invoice_number = 3069446740173
and tdc_circuit_id = 'EV532500'
;

select *
from finance.abt_circuit_otf
where invoice_number = 2427705264409
and tdc_circuit_id = '24919026'
;

select invoice_number, tdc_circuit_id
from base.import_other_sources_base_edi_extract
where action_code <> '000'
;
