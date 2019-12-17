SELECT * FROM ddata.CHARGE WHERE inv_seq_no = 247845474;

SELECT count(*) FROM base.import_fokus_base_charge WHERE inv_seq_no = 255149847;

SELECT * FROM base.import_fokus_base_charge WHERE inv_seq_no = 255149847 and feature_code='BCPKG';

SELECT feature_code, subscriber_no FROM base.import_fokus_base_charge WHERE inv_seq_no = 254402758 order by feature_code asc;
SELECT feature_code, subscriber_no FROM analytics.abt_billing WHERE invoice_no = 254402758;

SELECT * FROM analytics.abt_billing WHERE invoice_no = 255149847 order by 1 desc;
SELECT feature_code FROM base.import_fokus_base_charge WHERE inv_seq_no = 255149847  order by 1 desc;

select distinct abt.feature_code FROM analytics.abt_billing abt
left outer join base.import_fokus_base_charge
on invoice_no=inv_seq_no
where invoice_no = 255149847;

select * from (select abt.feature_code FROM analytics.abt_billing abt where invoice_no = 255149847
UNION ALL
select feature_code FROM base.import_fokus_base_charge WHERE inv_seq_no = 255149847
) res
order by res.feature_code desc;

SELECT * FROM base.import_fokus_base_charge WHERE inv_seq_no = 255149847 LIMIT 100;

SELECT * FROM analytics.abt_billing WHERE invoice_no = 255149847 LIMIT 100;

select * from base_equation_work_billing_joined WHERE inv_seq_no = 255149847;

select * from analytics.abt_subscribed_product_history;

select 
bill.root_ban, bill.ban, bill.bill_seq_no, charge.subscriber_no as "charge_sub_no", subscribed_product.subscriber_no "sub_product_sub_no"
from
  base.import_fokus_base_charge charge join
  base.import_fokus_base_bill bill on
    bill.ban = charge.ban and
    bill.root_ban = charge.root_ban and
    bill.bill_seq_no = charge.actv_bill_seq_no
left outer join
analytics.abt_subscribed_product_history  subscribed_product
on
    --subscribed_product.subscriber_no = charge.subscriber_no and
    coalesce(subscribed_product.subscriber_no,'xyz!abc') = coalesce(charge.subscriber_no,'xyz!abc') and
    subscribed_product.ban = charge.ban
where
--charge.priod_cvrg_st_date between subscribed_product.Effective_date and subscribed_product.Expiration_date and
inv_seq_no = 255149847;

select count(*) from  base.import_fokus_base_charge charge where charge.subscriber_no is null;

select bill.root_ban, bill.ban, bill.bill_seq_no, charge.subscriber_no as "charge_sub_no"
from
  base.import_fokus_base_charge charge join
  base.import_fokus_base_bill bill on
    bill.ban = charge.ban and
    bill.root_ban = charge.root_ban and
    bill.bill_seq_no = charge.actv_bill_seq_no
    where inv_seq_no = 255149847;
    
select
bill.root_ban, bill.ban, bill.bill_seq_no, charge.subscriber_no as "charge_sub_no", subscribed_product.subscriber_no "sub_product_sub_no"
from
 base.import_fokus_base_charge charge join
 base.import_fokus_base_bill bill on
   bill.ban = charge.ban and
   bill.root_ban = charge.root_ban and
   bill.bill_seq_no = charge.actv_bill_seq_no
left outer join
analytics.abt_subscribed_product_history  subscribed_product
on
   subscribed_product.subscriber_no = charge.subscriber_no and
   --coalesce(subscribed_product.subscriber_no,'xyz!abc') = coalesce(charge.subscriber_no,'xyz!abc') and
   subscribed_product.ban = charge.ban and 
   charge.priod_cvrg_st_date between subscribed_product.Effective_date and subscribed_product.Expiration_date
where inv_seq_no = 255149847;    