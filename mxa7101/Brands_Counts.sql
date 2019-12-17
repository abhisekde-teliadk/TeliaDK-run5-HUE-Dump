select brnd, count(*)
from (SELECT
  case  
    when customer_segment_subgroup in ('SOHO') then 'SoHo'
    when customer_segment_subgroup in ('Call Me Private Employee', 'DLG Private',
    'DLG Private Emplopyee', 'Private Employees', 'Private', 'DLG Private Employee',
    'Call Me Private') then 'Consumer (BtC)'
    else 'unknown'
  end AS brnd
  FROM analytics.abt_subscriber_current
  where is_active = true) brnds
group by brnd
;

select brnd, count(*)
from (SELECT
  case  
    when product_product_group like '%SOHO%' then 'SoHo'
    when product_product_group like '%BtC%' then 'Consumer (BtC)'
    else 'unknown'
  end AS brnd
  FROM analytics.abt_subscriber_current
  where product_product_group not like '%Broadband%'
  and is_active = true) brnds
group by brnd
;