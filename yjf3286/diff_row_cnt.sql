--34 648 155

drop table if exists temp.tf2;
create table temp.tf2 stored as parquet as 
select * from work.base_equation_sub_work_customer_hist;
--Inserted 34648155 row(s)

create table temp.tf3 stored as parquet as 
select * from work.base_equation_sub_work_customer_hist;

select * from 
(select distinct customer_id, start_date  from temp.tf2 ) a 
left join ( select distinct customer_id, start_date from work.base_equation_sub_work_customer_hist  ) b on a.customer_id = b.customer_id and a.start_date = b.start_date
where b.customer_id is null;


881716807	2015-02-23 23:59:58

select min( start_date ), max( start_date ) from work.base_equation_sub_work_customer_hist;
select min( start_date ), max( start_date ) from temp.tf2;


select * from work.base_equation_sub_work_customer_hist where customer_id = 881716807 order by start_date;
select * from temp.tf2  where customer_id = 881716807 order by start_date;

select count(*) from temp.tf2 where adr_link_seq_no is null;
select count(*) from temp.tf2; -- 34 648 155
select count(*) from work.base_equation_sub_work_customer_hist; --11 991 065
--Hive 11991065

invalidate metadata work.base_equation_sub_work_customer_hist; 

select count(*) from 
(select distinct customer_id, start_date  from temp.tf2 ) a;

select * from work.base_equation_sub_work_customer_hist limit 10;


select count(*)
  FROM ( select * from `work`.`base_equation_sub_work_customer_change` where customer_id = 881716807 ) `work_customer_change`
      JOIN (
        SELECT `work_address`.*
          FROM `work`.`base_equation_sub_work_address` `work_address`
          WHERE `link_type` = 'L'
        ) `work_address`
        ON (`work_customer_change`.`customer_id` = `work_address`.`customer_id`)
          AND (`work_customer_change`.`change_date` >= `work_address`.`adr_effective_date_join`)
          AND (`work_customer_change`.`change_date` <= `work_address`.`adr_expiration_date_join`)
 JOIN (
        SELECT 
            `tree_root_ban` AS `tree_root_ban`,
            `ban` AS `ban`,
            `effective_date` AS `effective_date`,
            `sys_creation_date` AS `sys_creation_date`,
            `sys_update_date` AS `sys_update_date`,
            `operator_id` AS `operator_id`,
            `application_id` AS `application_id`,
            `dl_service_code` AS `dl_service_code`,
            `dl_update_stamp` AS `dl_update_stamp`,
            `tree_level` AS `tree_level`,
            `parent_ban` AS `parent_ban`,
            `expiration_date` AS `expiration_date`,
            `tml_ind` AS `tml_ind`,
            nvl(effective_date, cast('1970-01-01' as timestamp)) AS `hier_effective_date_join`,
            nvl(expiration_date, cast('9999-12-31' as timestamp)) AS `hier_expiration_date_join`
          FROM (
            SELECT *
              FROM `base`.`import_fokus_base_ban_hierarchy_tree` `base_ban_hierarchy_tree`
            ) `withoutcomputedcols_query`
        ) `base_ban_hierarchy_tree`
        ON (`work_customer_change`.`customer_id` = `base_ban_hierarchy_tree`.`ban`)
          AND (`work_customer_change`.`change_date` >= `base_ban_hierarchy_tree`.`hier_effective_date_join`)
          AND (`work_customer_change`.`change_date` <= `base_ban_hierarchy_tree`.`hier_expiration_date_join`)
     JOIN (
        SELECT `base_ban_pym_mtd`.*
          FROM `base`.`import_fokus_base_ban_pym_mtd` `base_ban_pym_mtd`
          WHERE `expiration_date` IS NOT NULL
        ) `base_ban_pym_mtd`
        ON (`work_customer_change`.`customer_id` = `base_ban_pym_mtd`.`ban`)
          AND (`work_customer_change`.`change_date` >= `base_ban_pym_mtd`.`effective_date`)
          AND (`work_customer_change`.`change_date` <= `base_ban_pym_mtd`.`expiration_date`)
    
select min( adr_effective_date_join ), max( adr_effective_date_join ), count( adr_effective_date_join ) , count(*) from `work`.`base_equation_sub_work_address`