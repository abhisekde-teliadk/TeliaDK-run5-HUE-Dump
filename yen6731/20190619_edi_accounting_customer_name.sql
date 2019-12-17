select * from base.import_other_sources_base_geneva_product where event_source like 'TN%';

select distinct * from finance.abt_edi_accounting where invoice_number=2942795440096 and invoice_line=79;

select * from finance.abt_circuit_customer_bridge where telia_circuit_id = 'TN-158841';
select * from finance.abt_circuit_bridge where telia_circuit_id = 'TN-158841';


select * from finance.abt_edi_accounting where account_name like 'DLG%'; -- !!!! 246.709 !!!!
select count(*) from finance.abt_edi_accounting;

select count(*) from base.IMPORT_OTHER_SOURCES_base_edi_extract where account_name like 'DLG%';


SELECT count(*)
          FROM base.import_other_sources_base_edi_extract base_edi_extract
          where account_name not like 'DLG%';
          
          
          WHERE account_name != 'DLG%' OR account_name IS NULL AND 'DLG%' IS NOT NULL OR account_name IS NOT NULL AND 'DLG%' IS NULL;


select count(*) from base.import_other_sources_base_edi_extract;

select count(*) from work.contr_obligations_tdc_work_edi_accounting;


select * from
(SELECT 
    action_code AS action_code,
    period_start AS period_start,
    period_end AS period_end,
    tdc_circuit_id AS tdc_circuit_id,
    segment_technology AS segment_technology,
    tdc_product_code AS tdc_product_code,
    invoice_line AS invoice_line,
    line_amount_excl_vat AS line_amount_excl_vat,
    invoice_date AS invoice_date,
    invoice_number AS invoice_number,
    account_no AS account_no,
    account_name AS account_name,
    action_name AS action_name,
    product_name AS product_name,
    telia_circuit_id AS telia_circuit_id,
    source AS source,
    customer_number AS customer_number,
    segment AS segment,
    geneva_account_num AS geneva_account_num,
    source_billing AS source_billing,
    cpr_no AS cpr_no,
    cvr_no AS cvr_no,
    fokus_status AS fokus_status,
    geneva_customer_type_name AS geneva_customer_type_name,
    segment_full AS segment_full--,
   /* customer_name AS customer_name,
    organization_name AS organization_name,
    nvl(customer_name,organization_name) AS customer_name_full*/
  FROM (
    SELECT 
        base_edi_extract.action_code AS action_code,
        base_edi_extract.period_start AS period_start,
        base_edi_extract.period_end AS period_end,
        base_edi_extract.tdc_circuit_id AS tdc_circuit_id,
        base_edi_extract.segment_technology AS segment_technology,
        base_edi_extract.tdc_product_code AS tdc_product_code,
        base_edi_extract.invoice_line AS invoice_line,
        base_edi_extract.line_amount_excl_vat AS line_amount_excl_vat,
        base_edi_extract.invoice_date AS invoice_date,
        base_edi_extract.invoice_number AS invoice_number,
        base_edi_extract.account_no AS account_no,
        base_edi_extract.account_name AS account_name,
        base_edi_extract.action_name AS action_name,
        base_edi_extract.product_name AS product_name,
        abt_circuit_bridge.telia_circuit_id AS telia_circuit_id,
        abt_circuit_bridge.source AS source,
        abt_circuit_customer_bridge.customer_number AS customer_number,
        abt_circuit_customer_bridge.segment AS segment,
        abt_circuit_customer_bridge.geneva_account_num AS geneva_account_num,
        abt_circuit_customer_bridge.source_billing AS source_billing,
        abt_circuit_customer_bridge.cpr_no AS cpr_no,
        abt_circuit_customer_bridge.cvr_no AS cvr_no,
        abt_circuit_customer_bridge.fokus_status AS fokus_status,
        abt_circuit_customer_bridge.geneva_customer_type_name AS geneva_customer_type_name,
        abt_circuit_customer_bridge.segment_full AS segment_full--,
      /*  base_geneva_product.customer_name AS customer_name,
        tbt_customer_current.organization_name AS organization_name*/
      FROM (
        SELECT base_edi_extract.*
          FROM base.import_other_sources_base_edi_extract base_edi_extract
          --WHERE account_name not like 'DLG%'
        ) base_edi_extract
      LEFT JOIN finance.abt_circuit_bridge
        ON base_edi_extract.tdc_circuit_id = abt_circuit_bridge.foreign_circuit
      LEFT JOIN finance.abt_circuit_customer_bridge
        ON abt_circuit_bridge.telia_circuit_id = abt_circuit_customer_bridge.telia_circuit_id
      LEFT JOIN base.import_other_sources_base_geneva_product base_geneva_product
        ON source_billing='Geneva' and customer_number = customer_ref
      LEFT JOIN work.base_equation_sub_tbt_customer_current tbt_customer_current
        ON source_billing='Fokus' and customer_number = customer_id
    ) withoutcomputedcols_query
)tmp
where customer_number=2731987;

SELECT count(*) from base.import_other_sources_base_geneva_product where customer_ref is null;

select * from finance.abt_circuit_customer_bridge
left join base.import_other_sources_base_geneva_product
        ON customer_number = customer_ref
        where customer_number=2731987;
    --order by customer_number desc;

select * from finance.abt_circuit_customer_bridge where customer_number=999992217; --TB-360120
select * from base.import_other_sources_base_geneva_product where customer_ref=2519342 order by charge_start_date desc;

select distinct * from finance.abt_circuit_customer_bridge where customer_number=2519342; --TB-360120
select customer_ref, count(*) from base.import_other_sources_base_geneva_product group by customer_ref having count(*)>1 order by 2 desc;

select distinct customer_ref, customer_name from base.import_other_sources_base_geneva_product where customer_ref=2519342;