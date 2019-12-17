select * from finance.abt_edi_accounting
where tdc_circuit_id in (
    select distinct tnid_foreign_reference
    from base.import_other_sources_base_tnid_history
    where tnid_foreign_reference NOT IN 
        (
        SELECT foreign_circuit
        FROM finance.abt_circuit_bridge
        
        )
    )
;

select * from finance.abt_circuit_recon
;

select *
from base.import_other_sources_base_tnid_history
;

select count(distinct tnid_foreign_reference) -- 31k+
--select distinct tnid_foreign_reference
from base.import_other_sources_base_tnid_history
where tnid_foreign_reference NOT IN 
    (
    SELECT foreign_circuit
    FROM finance.abt_circuit_bridge
    
    )
;





select distinct tnid_date
from base.import_other_sources_base_tnid_history
order by 1 desc
;

-- 81687 count(distinct tdc_circuit_id, period_start, period_end )
-- 67758  count(distinct edi.tdc_circuit_id, edi.period_start, edi.period_end, tnidh.telia_id )
select  
    edi.tdc_circuit_id, 
    edi.period_start, 
    edi.period_end, 
    tnidh.telia_id, 
    max(tnidh.tnid_date) max_date
    
from base.import_other_sources_base_edi_extract edi
left outer join 
base.import_other_sources_base_tnid_history tnidh
ON
(
edi.tdc_circuit_id = tnidh.tdc_id
and
tnidh.tnid_date BETWEEN edi.period_start and edi.period_end

)
where edi.account_name not like 'DLG%' and tnidh.telia_id is not null
-- and strleft(edi.tdc_circuit_id,2) IN ('EM','EN','CN','HN','HY','EV')

group by edi.tdc_circuit_id, edi.period_start, edi.period_end, 
                tnidh.telia_id
order by 5 desc

;

select *
from base.import_other_sources_base_tnid_history
where tnid_foreign_reference = 'EV561626'
;


select * from finance.abt_circuit_bridge where strleft(telia_circuit_id,2)='TS';

select tnid_foreign_reference, count(*)
from base.import_other_sources_base_tnid_history
group by tnid_foreign_reference
order by 2 desc
;
;


select * from finance.abt_circuit_bridge where 
foreign_circuit = '86627416'
;


select invoice_line, order_number,order_number_last, w2_order_number_last, order_number_estimated
from work.contr_obligations_tdc_work_edi_order_num_fixed_test
-- where tdc_circuit_id = 'EB579104' and invoice_number = 2492251411123
order by invoice_line
;

select * from finance.abt_circuit_otf;

select customer_id, subscriber_no, subscriber_id, product_product_subgroup, internal_circuit_id, 

from analytics.abt_subscriber_current
where product_product_subgroup like '%Siminn%'
;

select customer_id, subscriber_no, subscriber_id, product_product_group, internal_circuit_id, status, start_date, end_date
from analytics.abt_subscriber_current
where product_product_group like '%Siminn%'
;

