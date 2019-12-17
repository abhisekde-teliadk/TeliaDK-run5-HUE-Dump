with product as (
select
--d_product.start_date AS start_date,
--d_product.end_date AS end_date,
--d_product.product_id AS product_id,
d_product.origin AS origin,
d_product.ca_upgrade AS ca_upgrade,
d_product.price AS price,
d_product.product_line AS product_line,
d_product.product_group AS product_group,
d_product.product_subgroup AS product_subgroup,
d_product.product_code AS product_code,
d_product.product_desc AS product_desc,
d_product.soc AS soc,
d_product.product_type AS product_type,
d_product.budget_product AS budget_product,
d_product.budget_product_group AS budget_product_group,
d_product.service_provider AS service_provider,
d_product.prim_acc_type AS prim_acc_type,
d_product.product_lt AS product_lt,
d_product.mdu_mbb AS mdu_mbb,
d_product.roaming_segment AS roaming_segment,
d_product.roaming_mb AS roaming_mb,
d_product.mdu_mbb_dev_roam AS mdu_mbb_dev_roam,
d_product.nonstd AS nonstd,
d_product.campaign AS campaign,
d_product.service_soc AS service_soc,
d_product.extra_user AS extra_user,
rank() over (partition by d_product.soc, d_product.campaign, d_product.service_soc order by d_product.product_code) as product_rn
from base.manual_files_base_d_product d_product 
),
prod_master as (
select 
--*,
bill_text AS bill_text,
min_usage AS min_usage,
data_mb_incl AS data_mb_incl,
data_mb_price AS data_mb_price,
free_sms AS free_sms,
free_mms AS free_mms,
messages_included AS messages_included,
sms_price AS sms_price,
mms_price AS mms_price,
free_voice AS free_voice,
voice_min_included AS voice_min_included,
voice_price AS voice_price,
free_telia_voice AS free_telia_voice,
rlh_ndb AS rlh_ndb,
services_incl AS services_incl,
services_duration AS services_duration,
dk_data_gb AS dk_data_gb,
eu_data_gb AS eu_data_gb,
pp_soc,
campaign,
service_soc,
rank() over (
partition by d_prod_master.pp_soc, d_prod_master.campaign, d_prod_master.service_soc
order by d_prod_master.product_id) as prod_master_rnk
from base.manual_files_base_d_prod_master d_prod_master
),
resp as (
select * from product 
where product_rn=1
),
res as (
select 
--start_date AS start_date,
--end_date AS end_date,
--product_id AS product_id,
'joined' as src,
origin AS origin,
ca_upgrade AS ca_upgrade,
price AS price,
product_line AS product_line,
product_group AS product_group,
product_subgroup AS product_subgroup,
product_code AS product_code,
product_desc AS product_desc,
resp.soc AS soc,
product_type AS product_type,
budget_product AS budget_product,
budget_product_group AS budget_product_group,
service_provider AS service_provider,
prim_acc_type AS prim_acc_type,
product_lt AS product_lt,
mdu_mbb AS mdu_mbb,
roaming_segment AS roaming_segment,
roaming_mb AS roaming_mb,
mdu_mbb_dev_roam AS mdu_mbb_dev_roam,
nonstd AS nonstd,
resp.campaign AS campaign,
resp.service_soc AS service_soc,
extra_user AS extra_user,
bill_text AS bill_text,
min_usage AS min_usage,
data_mb_incl AS data_mb_incl,
data_mb_price AS data_mb_price,
free_sms AS free_sms,
free_mms AS free_mms,
messages_included AS messages_included,
sms_price AS sms_price,
mms_price AS mms_price,
free_voice AS free_voice,
voice_min_included AS voice_min_included,
voice_price AS voice_price,
free_telia_voice AS free_telia_voice,
rlh_ndb AS rlh_ndb,
services_incl AS services_incl,
services_duration AS services_duration,
dk_data_gb AS dk_data_gb,
eu_data_gb AS eu_data_gb
--*
--resp.*, prod_master.free_sms, prod_master.data_mb_incl
from resp left outer join prod_master on
 prod_master.pp_soc = resp.soc and
 coalesce(prod_master.campaign,'xyz!abc') = coalesce(resp.campaign,'xyz!abc') and
 coalesce(prod_master.service_soc,'xyz!abc') = coalesce(resp.service_soc,'xyz!abc')
 and prod_master.prod_master_rnk=1
 )
select 
*
from res 
where soc is not null and
soc='P_MBBXL3'

union all
select
--*
--start_date AS start_date,
--end_date AS end_date,
--product_id AS product_id,
'abt_product' as src,
origin AS origin,
ca_upgrade AS ca_upgrade,
cast(price as string) AS price,
product_line AS product_line,
product_group AS product_group,
product_subgroup AS product_subgroup,
product_code AS product_code,
product_desc AS product_desc,
soc AS soc,
product_type AS product_type,
budget_product AS budget_product,
budget_product_group AS budget_product_group,
service_provider AS service_provider,
prim_acc_type AS prim_acc_type,
product_lt AS product_lt,
mdu_mbb AS mdu_mbb,
roaming_segment AS roaming_segment,
roaming_mb AS roaming_mb,
mdu_mbb_dev_roam AS mdu_mbb_dev_roam,
nonstd AS nonstd,
campaign AS campaign,
service_soc AS service_soc,
extra_user AS extra_user,
bill_text AS bill_text,
cast(min_usage as string) AS min_usage,
data_mb_incl AS data_mb_incl,
cast(data_mb_price as string) AS data_mb_price,
cast(free_sms as string) AS free_sms,
cast(free_mms as string) AS free_mms,
cast(messages_included as string) AS messages_included,
cast(sms_price as string) AS sms_price,
cast(mms_price as string) AS mms_price,
cast(free_voice as string) AS free_voice,
cast(voice_min_included as string) AS voice_min_included,
cast(voice_price as string) AS voice_price,
cast(free_telia_voice as string) AS free_telia_voice,
cast(rlh_ndb as string) AS rlh_ndb,
cast(services_incl as string) AS services_incl,
cast(services_duration as string) AS services_duration,
dk_data_gb AS dk_data_gb,
eu_data_gb AS eu_data_gb
from analytics.abt_d_product  abt
where abt.soc='P_MBBXL3'
;

