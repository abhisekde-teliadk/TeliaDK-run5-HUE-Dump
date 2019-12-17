select count(*) from base.import_fokus_base_service_agreement where soc='CORFRI' and '2019-05-06' between effective_date and expiration_date;

select sum(subs_qty) from work.base_equation_kpis_tbt_stock_kpi where '2019-05-06'=stock_date and product_id='7f56c783d4e44f6c4d72e6dd16f48620'; --  soc='CORFRI'

select sum(subs_qty) from work.base_equation_kpis_tbt_stock_kpi where '2019-05-06'=stock_date and product_id='7f56c783d4e44f6c4d72e6dd16f48620';

select sum(subs_qty) from analytics.abt_stock_kpi where '2019-05-06'=stock_date and product_id='7f56c783d4e44f6c4d72e6dd16f48620'; --5106 for 


-- get product_id
select distinct product_id from analytics.abt_stock_kpi where '2019-05-06'=stock_date and soc='M100M';


select count(*) from sandbox.abt_stock_fokus_stock_20190506_v2_cp where priceplan='M100M'; -- 5233
select count(*) from sandbox.abt_stock_fokus_stock_20190506_v2_cp where priceplan='CORFRI'; -- 12631

--we have:
5106 in base and stock_kpi for M100M
12859 in base and stock_kpi for CORFRI

--
product_id='7f56c783d4e44f6c4d72e6dd16f48620'; 
soc='CORFRI'


product_id='4ec29a0cd671e078af8396a82912fcbc'; 
soc='M100M'