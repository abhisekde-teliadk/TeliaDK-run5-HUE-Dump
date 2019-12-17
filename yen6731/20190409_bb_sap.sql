select DISTINCT 
    edi.invoice_date,
    edi.tdc_circuit_id, 
    cb.telia_circuit_id, 
    cub.cvr_no, 
    cub.segment, 
    cb.source source_circuit,
    cub.source_billing
    
from base.import_other_sources_base_edi_extract edi -- invoice lines from TDC

LEFT JOIN
analytics.abt_circuit_bridge cb -- bridge that maps tdc_circuit_id to telia_circuit_id
ON edi.tdc_circuit_id = cb.foreign_circuit 

LEFT JOIN
analytics.abt_circuit_customer_bridge cub -- bridge that maps telia_circuit_id to customer_number from variety of billings
ON cb.telia_circuit_id = cub.telia_circuit_id

WHERE  
strleft(cast(edi.invoice_date as string), 7) = '2019-01' -- actual months
;

select strleft(cast(edi.invoice_date as string), 7), from_timestamp(invoice_date, 'yyyy-MM'), from_timestamp(now() + interval -3 month, 'yyyy-MM') from base.import_other_sources_base_edi_extract edi;
WHERE  
--strleft(cast(edi.invoice_date as string), 7) = '2018-12'
edi.invoice_date
substring(invoice_date,0,7)
;