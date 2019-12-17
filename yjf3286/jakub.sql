drop table if exists work.tf_new;
create table work.tf_new stored as parquet as 
SELECT  straight_join 
    `action_code` AS `action_code`,
    `period_start` AS `period_start`,
    `period_end` AS `period_end`,
    `tdc_circuit_id` AS `tdc_circuit_id`,
    `segment_technology` AS `segment_technology`,
    `tdc_product_code` AS `tdc_product_code`,
    `invoice_line` AS `invoice_line`,
    `line_amount_excl_vat` AS `line_amount_excl_vat`,
    `invoice_date` AS `invoice_date`,
    `invoice_number` AS `invoice_number`,
    `account_no` AS `account_no`,
    `account_name` AS `account_name`,
    `action_name` AS `action_name`,
    `product_name` AS `product_name`,
    `telia_circuit_id` AS `telia_circuit_id`,
    `source` AS `source`,
    `customer_number` AS `customer_number`,
    `segment` AS `segment`,
    `geneva_account_num` AS `geneva_account_num`,
    `source_billing` AS `source_billing`,
    `cpr_no` AS `cpr_no`,
    `cvr_no` AS `cvr_no`,
    `fokus_status` AS `fokus_status`,
    `geneva_customer_type_name` AS `geneva_customer_type_name`,
    `segment_full` AS `segment_full`,
    `customer_name` AS `customer_name`,
    `organization_name` AS `organization_name`
     --nvl(customer_name,organization_name) AS `customer_name_all`
  FROM (
    SELECT 
        `base_edi_extract`.`action_code` AS `action_code`,
        `base_edi_extract`.`period_start` AS `period_start`,
        `base_edi_extract`.`period_end` AS `period_end`,
        `base_edi_extract`.`tdc_circuit_id` AS `tdc_circuit_id`,
        `base_edi_extract`.`segment_technology` AS `segment_technology`,
        `base_edi_extract`.`tdc_product_code` AS `tdc_product_code`,
        `base_edi_extract`.`invoice_line` AS `invoice_line`,
        `base_edi_extract`.`line_amount_excl_vat` AS `line_amount_excl_vat`,
        `base_edi_extract`.`invoice_date` AS `invoice_date`,
        `base_edi_extract`.`invoice_number` AS `invoice_number`,
        `base_edi_extract`.`account_no` AS `account_no`,
        `base_edi_extract`.`account_name` AS `account_name`,
        `base_edi_extract`.`action_name` AS `action_name`,
        `base_edi_extract`.`product_name` AS `product_name`,
        `abt_circuit_bridge`.`telia_circuit_id` AS `telia_circuit_id`,
        `abt_circuit_bridge`.`source` AS `source`,
        `abt_circuit_customer_bridge`.`customer_number` AS `customer_number`,
        `abt_circuit_customer_bridge`.`segment` AS `segment`,
        `abt_circuit_customer_bridge`.`geneva_account_num` AS `geneva_account_num`,
        `abt_circuit_customer_bridge`.`source_billing` AS `source_billing`,
        `abt_circuit_customer_bridge`.`cpr_no` AS `cpr_no`,
        `abt_circuit_customer_bridge`.`cvr_no` AS `cvr_no`,
        `abt_circuit_customer_bridge`.`fokus_status` AS `fokus_status`,
        `abt_circuit_customer_bridge`.`geneva_customer_type_name` AS `geneva_customer_type_name`,
        `abt_circuit_customer_bridge`.`segment_full` AS `segment_full`,
        `base_geneva_product`.`customer_name` AS `customer_name`,
        `tbt_customer_current`.`organization_name` AS `organization_name`
      FROM (
        SELECT `base_edi_extract`.*
          FROM `base`.`import_other_sources_base_edi_extract` `base_edi_extract`
          WHERE "account_name" != 'DLG%'
        ) `base_edi_extract`
      LEFT JOIN `finance`.`abt_circuit_bridge`
        ON `base_edi_extract`.`tdc_circuit_id` = `abt_circuit_bridge`.`foreign_circuit`
      LEFT JOIN `finance`.`abt_circuit_customer_bridge`
        ON `abt_circuit_bridge`.`telia_circuit_id` = `abt_circuit_customer_bridge`.`telia_circuit_id`
      LEFT JOIN `base`.`import_other_sources_base_geneva_product` `base_geneva_product`
        ON `abt_circuit_customer_bridge`.`customer_number` = `base_geneva_product`.`customer_ref`
      JOIN /* +BROADCAST */ `work`.`base_equation_sub_tbt_customer_current` `tbt_customer_current`
        ON `abt_circuit_customer_bridge`.`customer_number` = `tbt_customer_current`.`customer_id`
    ) `withoutcomputedcols_query`;


drop table if exists work.tf;
create table work.tf stored as parquet as 
SELECT 
    `action_code` AS `action_code`,
    `period_start` AS `period_start`,
    `period_end` AS `period_end`,
    `tdc_circuit_id` AS `tdc_circuit_id`,
    `segment_technology` AS `segment_technology`,
    `tdc_product_code` AS `tdc_product_code`,
    `invoice_line` AS `invoice_line`,
    `line_amount_excl_vat` AS `line_amount_excl_vat`,
    `invoice_date` AS `invoice_date`,
    `invoice_number` AS `invoice_number`,
    `account_no` AS `account_no`,
    `account_name` AS `account_name`,
    `action_name` AS `action_name`,
    `product_name` AS `product_name`,
    `telia_circuit_id` AS `telia_circuit_id`,
    `source` AS `source`,
    `customer_number` AS `customer_number`,
    `segment` AS `segment`,
    `geneva_account_num` AS `geneva_account_num`,
    `source_billing` AS `source_billing`,
    `cpr_no` AS `cpr_no`,
    `cvr_no` AS `cvr_no`,
    `fokus_status` AS `fokus_status`,
    `geneva_customer_type_name` AS `geneva_customer_type_name`,
    `segment_full` AS `segment_full`,
    `customer_name` AS `customer_name`
    --`organization_name` AS `organization_name`
    --nvl(customer_name,organization_name) AS `customer_name_all`
  FROM (
    SELECT 
        `base_edi_extract`.`action_code` AS `action_code`,
        `base_edi_extract`.`period_start` AS `period_start`,
        `base_edi_extract`.`period_end` AS `period_end`,
        `base_edi_extract`.`tdc_circuit_id` AS `tdc_circuit_id`,
        `base_edi_extract`.`segment_technology` AS `segment_technology`,
        `base_edi_extract`.`tdc_product_code` AS `tdc_product_code`,
        `base_edi_extract`.`invoice_line` AS `invoice_line`,
        `base_edi_extract`.`line_amount_excl_vat` AS `line_amount_excl_vat`,
        `base_edi_extract`.`invoice_date` AS `invoice_date`,
        `base_edi_extract`.`invoice_number` AS `invoice_number`,
        `base_edi_extract`.`account_no` AS `account_no`,
        `base_edi_extract`.`account_name` AS `account_name`,
        `base_edi_extract`.`action_name` AS `action_name`,
        `base_edi_extract`.`product_name` AS `product_name`,
        `abt_circuit_bridge`.`telia_circuit_id` AS `telia_circuit_id`,
        `abt_circuit_bridge`.`source` AS `source`,
        `abt_circuit_customer_bridge`.`customer_number` AS `customer_number`,
        `abt_circuit_customer_bridge`.`segment` AS `segment`,
        `abt_circuit_customer_bridge`.`geneva_account_num` AS `geneva_account_num`,
        `abt_circuit_customer_bridge`.`source_billing` AS `source_billing`,
        `abt_circuit_customer_bridge`.`cpr_no` AS `cpr_no`,
        `abt_circuit_customer_bridge`.`cvr_no` AS `cvr_no`,
        `abt_circuit_customer_bridge`.`fokus_status` AS `fokus_status`,
        `abt_circuit_customer_bridge`.`geneva_customer_type_name` AS `geneva_customer_type_name`,
        `abt_circuit_customer_bridge`.`segment_full` AS `segment_full`,
        `base_geneva_product`.`customer_name` AS `customer_name`
        --`tbt_customer_current`.`organization_name` AS `organization_name`
      FROM (
        SELECT `base_edi_extract`.*
          FROM `base`.`import_other_sources_base_edi_extract` `base_edi_extract`
          WHERE "account_name" != 'DLG%'
        ) `base_edi_extract`
      LEFT JOIN `finance`.`abt_circuit_bridge`
        ON `base_edi_extract`.`tdc_circuit_id` = `abt_circuit_bridge`.`foreign_circuit`
      LEFT JOIN `finance`.`abt_circuit_customer_bridge`
        ON `abt_circuit_bridge`.`telia_circuit_id` = `abt_circuit_customer_bridge`.`telia_circuit_id`
      LEFT JOIN `base`.`import_other_sources_base_geneva_product` `base_geneva_product`
        ON `abt_circuit_customer_bridge`.`customer_number` = `base_geneva_product`.`customer_ref`
      --LEFT JOIN `work`.`base_equation_sub_tbt_customer_current` `tbt_customer_current`
    --    ON `abt_circuit_customer_bridge`.`customer_number` = `tbt_customer_current`.`customer_id`
    ) `withoutcomputedcols_query`;
    
compute stats work.tf;    

drop table if exists work.tf2;
create table work.tf2 stored as parquet as
select a.*, tbt_customer_current.organization_name
from work.tf a
LEFT JOIN `work`.`base_equation_sub_tbt_customer_current` `tbt_customer_current`
    ON `a`.`customer_number` = `tbt_customer_current`.`customer_id`;

select customer_number, count(*) from work.tf group by customer_number having count(*) > 100;

--select customer_id, count(*) from  `work`.`base_equation_sub_tbt_customer_current` group by customer_id having count(*) >10;