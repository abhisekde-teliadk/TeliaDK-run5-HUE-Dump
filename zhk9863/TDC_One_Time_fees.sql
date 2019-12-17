-- heath check: how fresh are our datasets
select * from base.admin_datasets_s3_dates where project_key='CONTR_OBLIGATIONS_TDC' and dataset='abt_circuit_otf' order by last_modified
;

select * from finance.abt_circuit_otf where source_circuit is null;

select * from finance.abt_circuit_otf;
select * from finance.abt_circuit_recon;
select * from finance.contr_obligations_tdc_abt_circuit_recon_summary
;


select * from analytics.abt_customer_current where customer_id = 541392213; --885503219;
select * from base.import_fokus_base_customer where customer_id = 885503219;



select id from base.IMPORT_FOKUS_base_name_data
Limit 100;


;
TB-401435
	
;
select customer_cvr_no, customer_root_cvr_no, internal_circuit_id from analytics.abt_subscriber_current where customer_id = 862403219
;
TB-401593
	

653403212
;
select customer_cvr_no, customer_root_cvr_no, internal_circuit_id from analytics.abt_subscriber_current where customer_id = 653403212
;

TB-401406
	

652403213
;
select customer_cvr_no, customer_root_cvr_no, internal_circuit_id 
from analytics.abt_subscriber_current
where customer_id in 
(652403213, 560803215, 862403219, 862403219)
;

select  from base.import_fokus_base_subscriber where customer_id = 652403213;

TB-401386
	

560803215


select * from finance.abt_circuit_bridge where strleft(foreign_circuit,2)='VB';

select count(*) from base.import_other_sources_base_edi_extract 
where strleft(tdc_circuit_id,2)='VB'
-- and account_name not like 'DLG%'
;
select * from abt_edi_accounting where strleft(tdc_circuit_id,2)='VB';

select * from base.manual_files_base_bruce where cust_no = 90372964;
select * from base.manual_files_base_bruce where segment = '3P_HO';



select * from finance.abt_edi_accounting where data_quality >1;

select invoice_number, invoice_line, tdc_circuit_id, order_number, comment_text 
from base.import_other_sources_base_edi_extract
where action_code <>'000' and account_name not like 'DLG%' --odfiltrujeme jen na OTF
and invoice_number = 2492251411123 and tdc_circuit_id = 'EB515880' -- 'EB622106'

-- and invoice_number = 2492251411123 and tdc_circuit_id = 'EB621107'
-- and invoice_number = 2464466510216 and tdc_circuit_id = 'EN112887'
-- and invoice_number = 2492251411117 and tdc_circuit_id = 'EB639238'
-- and invoice_number = 2492251411119 and tdc_circuit_id = 'EB683860'
order by invoice_number, invoice_line
;

select 
invoice_number, invoice_line, tdc_circuit_id, order_number,
lag(order_number,1) over (partition by invoice_number, tdc_circuit_id order by invoice_number, invoice_line) as order_lag1,
lag(invoice_line,1) over (partition by invoice_number, tdc_circuit_id order by invoice_number, invoice_line) as line_lag1,

nvl(order_number,
    lag(order_number,1) over (partition by invoice_number, tdc_circuit_id order by invoice_number, invoice_line)

        ) on_final 

from base.import_other_sources_base_edi_extract
where action_code <>'000' and account_name not like 'DLG%'
order by invoice_number, invoice_line
limit 1000
;


select foreign_circuit, count(*)
from finance.abt_circuit_bridge
group by foreign_circuit
order by 2 desc
;

select source_billing, count(*) from 
finance.abt_circuit_otf 
where customer_number IS NOT NULL
group by source_billing
;



select * from finance.abt_circuit_customer_bridge
where telia_circuit_id = 'TD-011424'
;

select * from analytics.abt_subscriber_current 
where internal_circuit_id = 'TD-011424';

select * from work.base_equation_sub_tbt_subscriber_current
--where internal_circuit_id = 'TD-011424'
;

select * from base.import_other_sources_base_edi_extract
where order_number = 206199233;

select 
invoice_number, invoice_line, tdc_circuit_id, order_number

from base.import_other_sources_base_edi_extract
where action_code <>'000' and account_name not like 'DLG%'
order by invoice_number, invoice_line
limit 100
;


select * from base.import_other_sources_base_edi_extract
where invoice_number = 2492251411123 and tdc_circuit_id = 'EB622106' --invoice_line = 10234
and action_code <>'000'
order by invoice_line
;


select strleft(cast(invoice_date as string), 7), count(*) 
from base.import_other_sources_base_edi_extract
group by strleft(cast(invoice_date as string), 7)
order by 1 asc
;


select count(*) from base.import_other_sources_base_edi_extract 
where invoice_date between '2019-04-01' and '2019-04-30'
--order by invoice_date desc
;

select * from finance.abt_circuit_otf
where invoice_date between '2019-02-24' and '2019-05-31'
;

select * from base.import_other_sources_base_edi_extract where tdc_circuit_id = 'EN106214'; 

select * from base.manual_files_base_bruce where telia_circuitid = 'TN-322013';

select * from base.import_other_sources_base_tnid_extract 
where tnid_circuit_number like '%TN-322013%'
;

select * from base.import_other_sources_base_tnid_extract 
where tnid_foreign_reference like '%EB532662%'
;

select * from base.manual_files_base_steno_extract 
where order_line_no like '%EB532662%'
;

select * from base.import_bpm_base_techinfodb_coax
where provider_circuit_no like '%EB532662%'
;

select * from base.import_bpm_base_techinfodb_dsl
where provider_circuit_no like '%EN106214%'
;


select * from base.import_bpm_base_techinfodb_fiber
where provider_circuit_no like '%EB532662%'
;

select * from analytics.abt_subscriber_current where internal_circuit_id = 'TN-322013';

select * from base.import_other_sources_base_edi_extract where tdc_circuit_id = 'EB532662';

select * from finance.abt_circuit_bridge where foreign_circuit = 'EB532662';

select 
distinct tdc_circuit_id
-- strleft(edi.tdc_circuit_id,2), count(*)
from
(select distinct tdc_circuit_id from base.import_other_sources_base_edi_extract
where invoice_date between '2019-01-01' and '2019-03-31'
and account_name not like 'DLG%'
) edi
left join finance.abt_circuit_bridge cb on edi.tdc_circuit_id = cb.foreign_circuit
where cb.telia_circuit_id is null -- and cb.foreign_circuit is not null
-- group by strleft(edi.tdc_circuit_id,2)
-- order by 2 desc
;

select * from base.import_other_sources_base_tnid_extract

;


select *
from work.contr_obligations_tdc_work_edi_cb_ccb_join
where foreign_circuit is null
;


select * from finance.abt_circuit_bridge
where telia_circuit_id is null
;



select 
foreign_circuit, source, count(*) c
from
finance.abt_circuit_bridge
group by foreign_circuit, source
order by 3 desc
;



select * from base.manual_files_base_steno_extract;

select * from base.manual_files_base_steno_extract;



select *

from finance.abt_edi_accounting
where 
invoice_date between '2019-01-01' and '2019-03-31'
and customer_number is null 
;

select *

from finance.abt_circuit_otf 
where 
invoice_date between '2019-01-01' and '2019-03-31'
-- and customer_number is not null and segment_full is null
;


select * from finance.

SELECT distinct source_billing, segment, segment_full from finance.abt_circuit_customer_bridge order by source_billing asc
;

SELECT * FROM base.import_other_sources_base_edi_extract WHERE tdc_circuit_id = 'FB-1529845';



SELECT * FROM base.import_other_sources_base_tnid_extract where tnid_foreign_reference = 'FB-1529845';

SELECT * FROM finance.abt_circuit_bridge WHERE foreign_circuit = 'EB627987'
;

SELECT * FROM base.import_other_sources_base_tnid_extract where tnid_foreign_reference = 'EB627987';

SELECT * FROM base.import_bpm_base_techinfodb_dsl where  provider_circuit_no = 'EB627987';

SELECT * FROM base.import_bpm_base_techinfodb_coax where telia_circuit_id = 'TC-001650';





select invoice_number, invoice_line, count(*) c
from analytics.abt_edi_accounting
group by invoice_number, invoice_line
order by c desc
;

select source_circuit, count(*) from finance.abt_circuit_otf 
where invoice_date between '2018-03-01' and '2019-03-31'
group by source_circuit;

select count(*)

from finance.abt_circuit_otf 
where 
invoice_date between '2019-01-01' and '2019-03-31'
and customer_number is not null and segment_full is null
;

select distinct source_billing from finance.abt_circuit_billing_lines;

select * from finance.abt_circuit_customer_bridge;

select invoice_number, invoice_line, count(*) c
from finance.abt_circuit_otf
group by invoice_number, invoice_line
order by c desc
-- where invoice_number = 2492251410963 and invoice_line = 4399
;

select data_quality, count(*) c
from finance.abt_circuit_otf
group by  data_quality
order by c desc
;

select * from finance.abt_circuit_otf;

select error_type, count(*) c
from finance.abt_circuit_otf
group by error_type
order by c desc
;


select distinct product_product_line from analytics.abt_subscriber_current;


select * from finance.abt_circuit_otf_btb_ws
where invoice_date between '2018-04-01' and '2018-12-31'
order by data_quality desc, invoice_number asc, invoice_line asc;


-- customer bridge v pripade Fokusu
select 
sc.customer_id as customer_number,
sc.internal_circuit_id as telia_circuit_id,
sc.product_budget_product_group as segment, -- premapovat pres tvk_segment
'Fokus' source_billing,
sc.status fokus_status,
sc.customer_cvr_no -- case cvr, cpr podle BTB nebo BTC

from analytics.abt_subscriber_current sc

where sc.internal_circuit_id IS NOT NULL
;

select subscriber_id, internal_circuit_id,status, count(*) c
from analytics.abt_subscriber_current
where internal_circuit_id IS NOT NULL
group by subscriber_id, internal_circuit_id, status
order by c desc
;


-- 
select * from finance.abt_circuit_bridge where foreign_circuit = 'HN205070'
;

select * from finance.abt_circuit_customer_bridge WHERE telia_circuit_id = 'TN-131342'
;

select * from base.import_other_sources_base_geneva_event_source where event_source = 'TN-323594'
;


select * from finance.abt_circuit_billing_lines where telia_circuit_id = 'TN-323594'
;




select * from finance.abt_circuit_otf otf
left join analytics.abt_subscriber_current sub
ON (
otf.source_billing = 'Fokus'
sub.internal_circuit_id = otf.telia_circuit_id

)

;





select count(*) from import_other_sources_base_geneva_event_source where event_source  in

    (
    SELECT telia_circuit_id FROM analytics.abt_circuit_one_time_fees
    WHERE tdc_product_name LIKE 'Material%'
    and customer_number is null
    and telia_circuit_id is not null
    ) 
;



SELECT telia_circuit_id, count(*) c
FROM analytics.abt_circuit_customer_bridge
GROUP BY telia_circuit_id 
ORDER BY c DESC
;


SELECT * FROM analytics.abt_circuit_customer_bridge
WHERE telia_circuit_id = 'TB-290817'
;


Select * from analytics.abt_circuit_customer_bridge
WHERE telia_circuit_id = '33753373'
;

SELECT distinct circuit_status from import_bpm_base_techinfodb_coax
;



select * from import_other_sources_base_tnid_extract
where tnid_foreign_reference_transposed = 'CN107025'
;



SELECT * FROM analytics.abt_circuit_customer_bridge WHERE telia_circuit_id IN
('TR-120741','TN-316792')
;


SELECT * FROM analytics.abt_circuit_customer_bridge WHERE telia_circuit_id IN
('TN-322576','TD-006953','TN-119053')
;



select * from analytics.abt_subscriber_current
where internal_circuit_id = 'TD-002217'

;

select * from analytics.abt_billing
where subscriber_no = 'LLD1300005292'
;


SELECT * FROM analytics.abt_circuit_bridge WHERE telia_circuit_id = 'TD-006953'
;

SELECT * FROM analytics.abt_circuit_customer_bridge WHERE telia_circuit_id = 'TD-006953'
;

SELECT * FROM analytics.abt_subscriber_current where  internal_circuit_id = 'TD-006953';

SELECT * FROM analytics.abt_billing WHERE subscriber_no = "LLD1300005292" and customer_id = 555249010;


SELECT * FROM analytics.abt_circuit_one_time_fees
WHERE tdc_circuit_id = 'EB677227';

select * from import_other_sources_base_geneva_product


select count(*) c
/*
    edi.invoice_number,
    edi.invoice_line,
    edi.tdc_circuit_id,
    cib.telia_circuit_id,
    cub.customer_number,
    cub.source_billing,
    nvl(tvk1.tvk, tvk2.tvk) as tvk,
    nvl(tvk1.tvk_telia_product, tvk2.tvk_telia_product ) as tvk_product
*/

from 

    base.import_other_sources_base_edi_extract edi

left join
    analytics.abt_circuit_bridge cib on (edi.tdc_circuit_id = cib.foreign_circuit  )

left join
    analytics.abt_circuit_customer_bridge cub on (cub.telia_circuit_id = cib.telia_circuit_id)

left join 
    base.manual_files_base_tvk_segment seg on 
    (
    cub.segment = seg.product_group 
    AND 
    cub.source_billing = seg.system
    )

left join
    base.manual_files_base_tvk tvk1 on 
    (
    edi.action_code = tvk1.tvk_action_code
    and
    edi.tdc_product_code = tvk1.tvk_product_code
    and
    seg.tvk_segment = tvk1.tvk_telia_org
    and
    edi.tdc_circuit_id_tvk_technology = tvk1.tvk_technology
    )

left join
    base.manual_files_base_tvk tvk2 on 
    (
    edi.action_code = tvk2.tvk_action_code
    and
    edi.tdc_product_code = tvk2.tvk_product_code
    and
    tvk2.tvk = 'T'
    and
    tvk2.tvk_technology = "NULL"
    and
    tvk2.tvk_telia_org = "NULL"
    )


where 
    edi.account_name not like 'DLG%' 
    and action_code NOT IN ('000','777','888')
    and edi.line_amount_excl_vat > 0

LIMIT 1000
;




SELECT technology,should_be_found, count(*) c, round(sum(amount_edi)) edi, round(sum(amount_billing)) billing
FROM analytics.abt_circuit_data_quality
GROUP BY technology,should_be_found
ORDER BY c
;


SELECT strleft(tdc_circuit_id,2), sum(invoice_amount_excl_vat), count(*) c
FROM import_other_sources_base_edi_extract
WHERE account_name NOT LIKE 'DLG%'
GROUP BY  strleft(tdc_circuit_id,2)
ORDER BY c
;



SELECT count(*) FROM
import_other_sources_base_edi_extract edi
WHERE 
edi.account_name NOT LIKE 'DLG%'
AND edi.action_code <> '000'
AND edi.tdc_circuit_id  IN
(
SELECT tdc_circuit_id
FROM analytics.abt_circuit_one_time_fees
)
;




SELECT source_billing, segment, count(*) c
FROM analytics.abt_circuit_one_time_fees
GROUP BY source_billing, segment
ORDER BY c DESC
;




SELECT tdc_circuit_id, telia_circuit_id, customer_number, segment, tvk_id,
action_code, tdc_product_code, tvk_technology,

count(*) c
FROM analytics.abt_circuit_one_time_fees
WHERE telia_circuit_id IS NOT NULL
GROUP BY tdc_circuit_id, telia_circuit_id, customer_number, segment, tvk_id,
action_code, tdc_product_code, tvk_technology
ORDER BY c DESC

;

SELECT *
FROM analytics.abt_circuit_one_time_fees
WHERE
tdc_circuit_id = 'EN195020' 
and telia_circuit_id ='TN-323598' 
and customer_number=2654017
and segment = 'BTB' 
-- and tvk_id =235
and tvk_technology = 'EN'
and account_name NOT LIKE 'DLG%'
and action_code <> '000'
and tdc_product_code = 8211300
;

SELECT *
FROM base.import_other_sources_base_edi_extract
WHERE
tdc_circuit_id = 'EN195020' 
-- and telia_circuit_id ='TN-323598' 
-- and customer_number=2654017
-- and segment = 'BTB' 
-- and tvk_id =235
--- and tvk_technology = 'EN'
and account_name NOT LIKE 'DLG%'
and tdc_product_code = 8211300
and action_code <> '000'
;

select * from analytics.abt_circuit_bridge 
where foreign_circuit = 'EN195020'
;

select * from 
where foreign_circuit = 'EN195020'
;

select * from analytics.tbt_circuit_customer_bridge 
where telia_circuit_id = 'TN-323598'
;

SELECT count(*) FROM
import_other_sources_base_geneva_event_source
where event_source LIKE 'TN-%'
;


SELECT * FROM
import_other_sources_base_geneva_product
where event_source = 'TN-323598'
;
TN-323598	TN-323598	Geneva
;

SELECT count(distinct event_source) FROM
import_other_sources_base_geneva_event_source
where event_source LIKE 'TN-%'
and event_source not in 
(
    SELECT distinct telia_circuit_id FROM analytics.tbt_circuit_customer_bridge 
)
;

select * from finance.abt_circuit_bridge where telia_circuit_id = 'TN-117905';
select * from base.import_other_sources_base_geneva_event_source 
where event_source = 'TN-117905'
;


SELECT * from finance.abt_circuit_otf order by source_billing asc 
;