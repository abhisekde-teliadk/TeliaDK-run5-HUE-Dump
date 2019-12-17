select * from analytics.abt_subscription_channel_performance where dealer_name='T-Shop - Fields 401065' order by date desc;

select * from analytics.abt_subscription_channel_performance where dealer_name='T-Shop - Fields 401065' order by date desc;



select * from base.MANUAL_FILES_base_bruce where cust_no=90372964;

select * from base.import_fokus_base_customer where customer_id=987403219;

select * from work.contr_obligations_tdc_tbt_circuit_tnid_speeds;

select * from base.import_other_sources_base_edi_extract where strleft(tdc_circuit_id,2)='VB'
and account_name != 'DLG%'
and telia_circuit_id is not null;

select * from finance.abt_edi_accounting where strleft(tdc_circuit_id,2)='VB';


select * from work.contr_obligations_tdc_work_edi_accounting where strleft(tdc_circuit_id,2)='VB';

SELECT DISTINCT *
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
        abt_circuit_customer_bridge.segment_full AS segment_full
      FROM (
        SELECT base_edi_extract.*
          FROM base.import_other_sources_base_edi_extract base_edi_extract
          WHERE "account_name" != 'DLG%'
        ) base_edi_extract
      LEFT JOIN finance.abt_circuit_bridge
        ON base_edi_extract.tdc_circuit_id = abt_circuit_bridge.foreign_circuit
      LEFT JOIN finance.abt_circuit_customer_bridge
        ON abt_circuit_bridge.telia_circuit_id = abt_circuit_customer_bridge.telia_circuit_id
    ) unfiltered_query
  WHERE --from_timestamp(invoice_date, 'yyyy-MM') = from_timestamp(now(), 'yyyy-MM') and -- actual months
telia_circuit_id is not null
and
strleft(tdc_circuit_id,2)='VB';

select distinct comp_reg_id from base.IMPORT_FOKUS_base_name_data;

select count(*) from base.IMPORT_FOKUS_base_name_data where comp_reg_id is null;