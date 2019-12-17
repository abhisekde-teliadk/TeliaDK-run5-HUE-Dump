 -- source dataset (before grouping)
 select  * from work.vasdata_work_service_stock_join where service_soc='ALLBIZA' and month=201812;

 -- count group dataset (temporary) before join
 select * from vasdata_work_service_stock_count_group where service_soc='ALLBIZA' and month=201812;
 
 -- join after creating of groups for counts and percentage
 select  * from work.vasdata_work_service_stock_joined_groups where service_soc='ALLBIZA' and month=201812;
 
 
 -- result from final dataset
 select  * from analytics.abt_service_stock where soc='ALLBIZA' and reporting_month=201812;
 
 -- 127 null product_group in final abt dataset - should be there?
 select  * from analytics.abt_service_stock where product_group is null;
 
 
 -- example for ALLBIZA
 select * from work.vasdata_work_service_stock_join where service_soc='ALLBIZA' and month=201812 and sub_product_group is null;
 select * from work.vasdata_work_service_stock_join where service_soc='ALLBIZA' and month=201812;
 
  
-- duplicity tests  
  select reporting_month, product_group, soc, count(*) from analytics.abt_service_stock group by reporting_month, product_group, soc having count(*) > 1;
  
-- 17 rows  
select reporting_month, product_group, count(*) from analytics.abt_service_stock where reporting_month=201812 group by reporting_month, product_group;