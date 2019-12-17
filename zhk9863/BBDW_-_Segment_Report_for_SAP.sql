

select root_customer_id ,  cvr_no, root_cvr_no -- customer_cvr_no, customer_root_cvr_no, internal_circuit_id

-- from analytics.abt_subscriber_current
from analytics.abt_customer_current

where root_customer_id in

(652403213, 560803215, 862403219, 862403219)
---(549292217,629292210,656292216 )
;

select * from base.manual_files_base_d_product where soc='DSLTML8';

select product_soc from analytics.abt_subscriber_current where customer_id = 652403213;

select * from base.manual_files_base_tvk_segment_full where soc = 'DSLTML8';

select * 
from finance.abt_edi_accounting
where invoice_date between '2019-02-25' and '2019-05-31' 
;

select distinct circuit_reference -- distinct customer_name, cvr_number, event_source, circuit_reference, product_name, product_id
from base.import_other_sources_base_geneva_product_long
where circuit_reference is not null and circuit_reference in 
(select steno_telia_circuit_id from base.manual_files_base_steno_extract)

-- (select telia_id from base.import_other_sources_base_tnid_extract)
;
---
(
select telia_circuit_id from finance.abt_circuit_bridge
)
;

select * 
from finance.abt_circuit_otf
where invoice_number = 2854994520417
and action_code <>'000'
--where invoice_date between '2019-03-01' and '2019-03-31' --and source_billing ='Rosetta' 
;

select strleft(telia_circuit_id,2) , source_billing, count(*) 
from finance.abt_circuit_customer_bridge
group by strleft(telia_circuit_id,2) , source_billing
;


select * from base.manual_files_base_bruce;

select invoice_date, invoice_number, invoice_line, count(*)
from analytics.abt_edi_accounting
group by invoice_date, invoice_number, invoice_line
having count(*) > 1
order by invoice_number asc
;


select distinct product_product_line from analytics.abt_subscriber_current
-- where internal_circuit_id IS NOT NULL
;



select invoice_date, invoice_number, invoice_line, count(*)
from analytics.abt_edi_accounting
group by invoice_date, invoice_number, invoice_line
order by 4 desc
;


select * from analytics.abt_edi_accounting where invoice_number=3069446740411 and invoice_line=1032
;

select distinct source_billing from analytics.abt_edi_accounting 
where 

segment_full is NULL 

and customer_number IS NOT NULL;

;

SELECT * FROM finance.abt_circuit_customer_bridge;



select distinct product_soc from analytics.prod_abt_subscriber_current
where
product_product_line = 'Data'
and
customer_id IN
(
select distinct customer_number from finance.abt_circuit_customer_bridge
where segment_full IS NULL and source_billing = 'Fokus'
) 
and product_soc NOT IN
                        (
                        select soc from base.manual_files_base_tvk_segment_full
                        )
;

select * from base.manual_files_base_tvk_segment_full
where soc in ('DSLBTC0','DSLBTC1')
;



select * from base.manual_files_base_tvk_segment_full where source_lowercase = 'geneva';

-- FOKUS segment map
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



SELECT distinct source_billing, segment, segment_full 
from finance.abt_circuit_customer_bridge order by source_billing asc
;

Select distinct customer_type_name, segment from base.import_other_sources_base_geneva_product;

select budget_product from base.manual_files_base_tvk_segment_full where source='Geneva';





-- questions for Jeppe
-- include DLG?
-- 000 or non 000 or all?
-- how to filter on date? invoice_date = current month?

select distinct segment from manual_files_base_rosetta;
;

select distinct segment, subsegment from manual_files_base_bruce

;
;


SELECT 
count(*) FROM base.manual_files_base_bruce;

SELECT count(*) FROM base.manual_files_base_rosetta;

;

select distinct segment, subsegment from manual_files_base_bruce
-- where subsegment LIKE 'TELIA%'
;
;

select source_billing, count(*) c from finance.abt_circuit_customer_bridge
group by source_billing
order by c desc

;

select * from base.manual_files_base_bruce

;

select * from analytics.abt_customer_current
LIMIT 100
;

select distinct product_type, budget_product, budget_product_group from manual_files_base_d_product
where product_type <> 'GSM'
;


-- https://jira.atlassian.teliacompany.net/browse/DML-728
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
finance.abt_circuit_bridge cb -- bridge that maps tdc_circuit_id to telia_circuit_id
ON edi.tdc_circuit_id = cb.foreign_circuit 

LEFT JOIN
finance.abt_circuit_customer_bridge cub -- bridge that maps telia_circuit_id to customer_number from variety of billings
ON cb.telia_circuit_id = cub.telia_circuit_id

WHERE  
edi.account_name NOT LIKE 'DLG%'
AND
strleft(cast(edi.invoice_date as string), 7) = '2018-12'
;



SELECT source, count(*) c FROM 
analytics.abt_circuit_bridge
GROUP BY source
ORDER BY c DESC
;
