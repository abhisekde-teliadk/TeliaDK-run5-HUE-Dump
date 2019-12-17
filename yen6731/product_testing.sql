select * from
(select 
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
NONSTD,
d_product.campaign,
d_product.SERVICE_SOC,
d_prod_master.free_sms,
d_prod_master.data_mb_incl,
--d_prod_master.,
extra_user,
rank() over (partition by d_product.soc, d_product.campaign, d_product.service_soc order by d_product.product_code) as product_rnk,
rank() over (partition by d_prod_master.pp_soc, d_prod_master.campaign, d_prod_master.service_soc order by d_prod_master.product_id) as prod_master_rnk
from
base.manual_files_base_d_product d_product left outer join
base.manual_files_base_d_prod_master d_prod_master
 on
 d_prod_master.pp_soc = d_product.soc and
 nvl(d_prod_master.campaign,'xyz!abc') = nvl(d_product.campaign,'xyz!abc') and
 nvl(d_prod_master.service_soc,'xyz!abc') = nvl(d_product.service_soc,'xyz!abc')
 ) as res
where res.product_rnk = 1 and res.prod_master_rnk=1 ;


with
product as
(select
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
rank() over (partition by d_product.soc, d_product.campaign, d_product.service_soc order by d_product.product_code) as product_rn
from base.manual_files_base_d_product d_product 
),
prod_master as (
select
d_product.campaign,
d_product.SERVICE_SOC,
d_prod_master.free_sms,
d_prod_master.data_mb_incl,
rank() over (partition by d_prod_master.pp_soc, d_prod_master.campaign, d_prod_master.service_soc order by d_prod_master.product_id) as prod_master_rnk
from base.manual_files_base_d_prod_master d_prod_master
--where prod_master_rnk =1
)
res as (
select * from product d_product left outer join prod_master d_prod_master on
 d_prod_master.pp_soc = d_product.soc and
 nvl(d_prod_master.campaign,'xyz!abc') = nvl(d_product.campaign,'xyz!abc') and
 nvl(d_prod_master.service_soc,'xyz!abc') = nvl(d_product.service_soc,'xyz!abc')
 )
 --,
-- select * from res;

 
 
where
not exists ( select * from base.manual_files_base_d_product as dp2 where
 dp2.soc = d_product.soc and
 nvl(dp2.campaign,'xyz!abc') = nvl(d_product.campaing,'xyz!abc') and
 nvl(dp2.service_soc,'xyz!abc') = nvl(d_product.service_soc,'xyz!abc') and
 dp2.product_code > d_product.code) and
not exists (select * from base.manual_files_base_d_prod_master as dp3 where
 dp3.pp_soc = d_prod_master.pp_soc and
 nvl(dp3.campaign,'xyz!abc') = nvl(d_prod_master.campaign,'xyz!abc') and
 nvl(dp3.service_soc,'xyz!abc') = nvl(d_prod_master.service_soc,'xyz!abc') and
 dp3.product_id > d_prod_master.id);
 
 rank() over (partition by soc, campaign, service_soc order by prod

select extra_user from base.manual_files_base_d_prod_master;
select extra_user from base.manual_files_base_d_product;

select  
PRODUCT_ID,
ORIGIN,
CA_UPGRADE,
PRICE,
PRODUCT_LINE,
PRODUCT_GROUP,
PRODUCT_SUBGROUP,
PRODUCT_CODE,
PRODUCT_DESC,
SOC,
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
NONSTD,
CAMPAIGN,
SERVICE_SOC
from base.manual_files_base_d_product;