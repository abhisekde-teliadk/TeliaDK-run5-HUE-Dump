select * from analytics.abt_customer_current where customer_id=417124906;

select price_plan,internal_circuit_id,product_product_line, * from analytics.abt_subscriber_current where customer_id=417124906 /*and a.is_active=true and a.internal_circuit_id is not null*/ order by price_plan desc nulls last;

select budget_product from base.manual_files_base_tvk_segment_full where source='Geneva';

select * from base.manual_files_base_tvk_segment where soc='MBBBTC1';

-- https://jira.atlassian.teliacompany.net/browse/DML-728
select DISTINCT 
    /*edi.invoice_date,
    edi.tdc_circuit_id, 
    cb.telia_circuit_id, 
    cub.cvr_no, 
    cub.segment, 
    cb.source source_circuit,*/
    cub.source_billing
    
from base.import_other_sources_base_edi_extract edi -- invoice lines from TDC

LEFT JOIN
finance.abt_circuit_bridge cb -- bridge that maps tdc_circuit_id to telia_circuit_id
ON edi.tdc_circuit_id = cb.foreign_circuit 

LEFT JOIN
finance.abt_circuit_customer_bridge cub -- bridge that maps telia_circuit_id to customer_number from variety of billings
ON cb.telia_circuit_id = cub.telia_circuit_id

WHERE  
edi.account_name NOT LIKE 'DLG%'
AND
strleft(cast(edi.invoice_date as string), 7) = '2019-03'
;

select distinct source_billing from finance.abt_circuit_customer_bridge;

SELECT DISTINCT 
    invoiceamt AS amount,
    cust_no AS customer_number,
    telia_circuitid AS telia_circuit_id,
    segment AS segment,
    NULL AS product,
    NULL AS bill_start_date,
    last_invoice_date AS bill_end_date,
    product_start_date AS product_start_date,
    product_cancel_date AS product_end_date,
    NULL AS geneva_account_num,
    cvr AS cvr_no,
    NULL AS geneva_customer_type_name,
    'Bruce' AS source_billing
  FROM base.manual_files_base_bruce
  WHERE (telia_circuitid != '' OR telia_circuitid IS NULL AND '' IS NOT NULL OR telia_circuitid IS NOT NULL AND '' IS NULL) AND telia_circuitid IS NOT NULL;
  
  select * from base.manual_files_base_tvk_segment_full where source='Geneva' and budget_product='Erhverv - LA';
  
  
  select distinct gen.customer_ref, seg.segment
from 
    base.import_other_sources_base_geneva_product gen
left join base.manual_files_base_tvk_segment_full seg
on 
(
    seg.source_lowercase = 'geneva'
    and lower(gen.segment) = seg.budget_product_group_lowercase
    and lower(gen.customer_type_name) = seg.budget_product_lowercase
)
;