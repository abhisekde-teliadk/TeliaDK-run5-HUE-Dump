select * from base.manual_files_base_tvk_segment;


select 
count(*)
;

-- FOKUS segment map
select distinct sub.customer_id, seg.segment

from 
    analytics.abt_subscriber_current sub

left join base.manual_files_base_tvk_segment seg
on 
(
    seg.source_lowercase = 'fokus'
    and seg.soc = sub.product_soc
)
where
sub.internal_circuit_id IS NOT NULL
;



-- GENEVA segment map
select seg.segment, * 
from base.import_other_sources_base_geneva_product gen
left join base.manual_files_base_tvk_segment seg
on 
(
    seg.source_lowercase = 'geneva'
    and seg.budget_product_lowercase = lower(gen.customer_type_name)
    and seg.budget_product_group_lowercase = lower(gen.segment)
)
;


select customer_number, count(distinct segment) c

from finance.abt_circuit_customer_bridge
group by customer_number, segment
order by c desc
;

-- in this example the customer moved, closed the customer and created a new one
-- if the customer is multiple times in fokus, it should take the highest customer number
select * from analytics.abt_subscriber_current where customer_id in 
-- (625489018, 914981212)

-- (542592118, 512477902)

(571780212, 465880219)
;

select * from base.manual_files_base_tvk_segment
;

select distinct segment, customer_type_name from base.import_other_sources_base_geneva_product
order by segment desc
;

select * from base.import_bpm_base_techinfodb_coax where provider_circuit_no = 'YB146266'
;

-- 2811491082	Grønbæk
select * from analytics.abt_subscriber_current where internal_circuit_id = 'TC-006648' --'TC-002110'
;

select * from analytics.abt_billing where subscriber_no = 'LLN1100006491' and customer_id = 597923218
;

select * from analytics.abt_customer_current where customer_id = 597923218;

SELECT distinct segment_type, segment_group, segment_remark FROM  analytics.abt_customer_current 
;

select * from analytics.abt_subscriber_current where customer_id = 874431216; -- 825700214;
select * from base.import_other_sources_base_geneva_product where customer_ref = 2515762; -- 2517865 and account_num = 20219504;

;


select * from finance.abt_circuit_otf_btc_soho;

-- heath check: how fresh are our datasets
select * from base.admin_datasets_s3_dates where project_key='CONTR_OBLIGATIONS_TDC' and dataset='abt_circuit_otf' order by last_modified
;

-- 1:1 with Jan
-- analytics to finance pond
-- deploy to prod 


-- columns order
-- delete tdc product from tvk
-- order by data quality, invoice number, invoice line, invoice date


-- tvk segment update
-- segment for SAP with Jakub synchro

-- possible split to: BTC+SOHO and BTB + WS


select *
from analytics.abt_circuit_otf_btc_soho
-- where tvk is null
order by invoice_number, invoice_line, invoice_date, tvk, tvk_segment
;



-- checking sanity of TVK file
select tvk_action_code, tvk_product_code, tvk, tvk_telia_org, tvk_technology, count(*) c 
from 
base.manual_files_base_tvk 
group by tvk_action_code, tvk_product_code, tvk, tvk_telia_org, tvk_technology
order by c DESC
;
select distinct product_type, soc, product_group from base.manual_files_base_d_product
where product_type <> 'GSM'
order by product_type
;

select invoice_number, invoice_line, invoice_date, tvk, tvk_segment, count(*) c 
from analytics.abt_circuit_one_time_fees
-- where tvk is null
group by invoice_number, invoice_line, invoice_date, tvk, tvk_segment
order by c desc
;




-- count in EDI
select 'EDI' source, count(*) cnt
from 

    base.import_other_sources_base_edi_extract edi

where 
    edi.account_name not like 'DLG%' 
    and edi.action_code NOT IN ('000','777','888')
    and edi.line_amount_excl_vat > 0

UNION
select 'OTF' source, count(*) cnt
from finance.abt_circuit_otf
;





-- health check for tdc_circuit_id in One Time Fees
    SELECT tdc_circuit_id, count(*) c
    FROM
    (
    select distinct telia_circuit_id, tdc_circuit_id
    from analytics.abt_circuit_one_time_fees
    ) t
    GROUP BY tdc_circuit_id
    ORDER BY c DESC
    ;

select * from base.import_other_sources_base_edi_extract;

select * from analytics.abt_circuit_bridge where foreign_circuit = 'HB924420';

select * from analytics.abt_circuit_one_time_fees where tdc_circuit_id = 'HB955410';
select * from analytics.abt_circuit_bridge where foreign_circuit = 'HB955410';
select * from base.import_other_sources_base_tnid_extract where tnid_foreign_reference LIKE '%HB955410%';


select * from analytics.abt_circuit_bridge where foreign_circuit = 'CN131841';
select * from base.import_other_sources_base_tnid_extract where tnid_foreign_reference LIKE '%CN131841%';
select * from analytics.abt_circuit_one_time_fees where tdc_circuit_id = 'CN131841';
select * from analytics.abt_circuit_customer_bridge where telia_circuit_id in ( 'TN-150165', 'TN-150168');

-- health check for Telia_circuit_id in One Time Fees
    SELECT telia_circuit_id, source_billing, count(*) c
    FROM
    (
    select distinct telia_circuit_id, tdc_circuit_id, source_billing
    from analytics.abt_circuit_one_time_fees
    ) t
    GROUP BY telia_circuit_id, source_billing
    ORDER BY c DESC
    ;
    

-- 20190410
-- coax duplicate - TWO TDC related numbers in TechInfo in different states, different cities
SELECT tdc_circuit_id, source_circuit, count(*) c
FROM
(
select distinct telia_circuit_id, tdc_circuit_id, source_circuit
from finance.abt_circuit_otf
) t
GROUP BY tdc_circuit_id, source_circuit

ORDER BY c DESC, tdc_circuit_id ASC
;

select telia_circuit_id, count(*) c
from analytics.abt_circuit_customer_bridge
where strleft(telia_circuit_id,2) <>'TB'
group by telia_circuit_id

order by c desc

;





select distinct product_product_group 
from analytics.abt_subscriber_current 
where product_product_type <> 'GSM' and product_product_group  in
(select product_group from base.manual_files_base_tvk_segment);


select * from analytics.abt_circuit_one_time_fees 
order by 
data_quality desc, 
invoice_number asc, invoice_line asc;

select * from analytics.abt_circuit_one_time_fees where telia_circuit_id = 'TB-401221';

select * from analytics.tbt_circuit_billing_lines where telia_circuit_id = 'TB-401221';

select * from analytics.abt_circuit_customer_bridge where telia_circuit_id = 'TB-401221'
--Kisbi over-ruler Bruce if circuit is found in both systems

;

-- telia internal
select distinct source_billing, segment from analytics.abt_circuit_customer_bridge where cvr_no = '20367997';


-- correct mapping, two different addresses
SELECT * FROM base.import_other_sources_base_tnid_extract 
where tnid_circuit_number = 'TB-401557';

SELECT max(tvk_id) FROM base.manual_files_base_tvk 

;

SELECT * FROM base.manual_files_base_tvk_segment
;


select * from finance.abt_circuit_bridge;


SELECT tvk_action_code, tvk_product_code, tvk_technology, count(*) c FROM base.manual_files_base_tvk 
where tvk = 'T'
group by tvk_action_code, tvk_product_code, tvk_technology
order by c desc
;

