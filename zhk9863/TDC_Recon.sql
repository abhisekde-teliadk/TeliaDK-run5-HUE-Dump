select 
    tdc_circuit_id, 
    telia_circuit_id, 
    customer_number,
    cvr_no,
    segment_full,
    source_billing,
    source as source_circuit,

    sum(amount)
from 
analytics.abt_circuit_recon
GROUP BY
    tdc_circuit_id, 
    telia_circuit_id, 
    customer_number,
    cvr_no,
    segment_full,
    source_billing,
    source_circuit

;    


select distinct strleft(telia_circuit_id,2) from finance.abt_circuit_bridge order by 1 desc;



select 
    tdc_circuit_id, 
    telia_circuit_id, 

   count(*) c
from 
analytics.abt_circuit_recon
GROUP BY
    tdc_circuit_id, 
    telia_circuit_id
order by c desc

;    




select tdc_circuit_id, telia_circuit_id, source, source_billing, segment, customer_number, sum(amount) 
from 
analytics.abt_circuit_recon_failed
where bill_start_date between '2019-01-01' and '2019-03-31' 
group by tdc_circuit_id, telia_circuit_id, source, source_billing, segment, customer_number
;




select * from work.contr_obligations_tdc_edi_accounting_duplicate_count where invoice_number=3069446740411 and invoice_line=1066;



SELECT cb1.foreign_circuit, cb1.telia_circuit_id, cb2.telia_circuit_id --, edi.tdc_circuit_id
FROM finance.abt_circuit_bridge cb1 LEFT JOIN finance.abt_circuit_bridge cb2
ON (cb1.foreign_circuit = cb2.foreign_circuit)
-- LEFT JOIN base.import_other_sources_base_edi_extract edi ON (cb1.foreign_circuit = edi.tdc_circuit_id)
WHERE cb1.telia_circuit_id <> cb2.telia_circuit_id -- and edi.tdc_circuit_id IS NULL

;


SELECT * FROM finance.abt_circuit_bridge cbr,
    (
    SELECT foreign_circuit, telia_circuit_id, count(*) c

    FROM finance.abt_circuit_bridge cb
        LEFT JOIN  (

            SELECT DISTINCT tdc_circuit_id FROM base.import_other_sources_base_edi_extract
            WHERE account_name NOT LIKE 'DLG%'

        ) edi ON cb.foreign_circuit = edi.tdc_circuit_id 

    GROUP  BY  foreign_circuit, telia_circuit_id
    HAVING c > 1
    ORDER BY cb.foreign_circuit DESC
    ) c
WHERE c.foreign_circuit = cbr.foreign_circuit and c.telia_circuit_id = cbr.telia_circuit_id
;


select * from base.import_bpm_base_techinfodb_dsl where provider_circuit_no = 'EB508273';