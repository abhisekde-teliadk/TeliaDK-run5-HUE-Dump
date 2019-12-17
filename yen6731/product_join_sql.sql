with product as (
select
d_product.PRODUCT_ID,
ORIGIN,
CA_UPGRADE,
d_product.PRICE,
PRODUCT_LINE,
PRODUCT_GROUP,
PRODUCT_SUBGROUP,
PRODUCT_CODE,
PRODUCT_DESC,
d_product.SOC,
PRODUCT_TYPE,
BUDGET_PRODUCT,
BUDGET_PRODUCT_GROUP,
SERVICE_PROVIDER,
PRIM_ACC_TYPE,
PRODUCT_LT,
MDU_MBB,
ROAMING_SEGMENT,
ROAMING_MB,
MDU_MBB_DEV_ROAM,
NONSTD
extra_user,
d_product.campaign,
d_product.service_soc,
rank() over (partition by d_product.soc, d_product.campaign, d_product.service_soc order by d_product.product_code) as product_rn
from base.manual_files_base_d_product d_product 
),
prod_master as (
select
d_prod_master.pp_soc,
d_prod_master.campaign,
d_prod_master.service_soc,
d_prod_master.free_sms,
d_prod_master.data_mb_incl,
d_prod_master.sms_price,
d_prod_master.bill_text,
rank() over (partition by d_prod_master.pp_soc, d_prod_master.campaign, d_prod_master.service_soc order by d_prod_master.product_id) as prod_master_rnk
from base.manual_files_base_d_prod_master d_prod_master
),
resp as (
select * from product 
where product_rn=1
)
--res as (
select
resp.*, pp_soc, prod_master.bill_text, prod_master.free_sms, prod_master.data_mb_incl, prod_master.sms_price
from resp
left outer join prod_master
on
 prod_master.pp_soc = resp.soc and
 coalesce(prod_master.campaign,'xyz!abc') = coalesce(resp.campaign,'xyz!abc') and
 coalesce(prod_master.service_soc,'xyz!abc') = coalesce(resp.service_soc,'xyz!abc')
 and prod_master.prod_master_rnk=1 
--where resp.soc='P_MBBXL3' -- one row example
 ;

select * from base.manual_files_base_d_prod_master where pp_soc='P_MBBXL3';
select * from base.manual_files_base_d_product where soc='P_MBBXL3';

select count(*) from analytics.abt_d_product; -- 3466
select count(*) from base_equation_work_d_product_join where soc is not null; -- 3466