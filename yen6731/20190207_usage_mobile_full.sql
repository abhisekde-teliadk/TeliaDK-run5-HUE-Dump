with fact as (select 
  mu.product_soc,
  --mu.product_name,
  replace(mu.call_description, 'Mobile - Other', 'Mobile - Other Operators') as call_description,
  mu.finance_call_direction,
  'New' source,
  mu.voice_min as new,
  0 as old
  from
    analytics.abt_usage_mobile_test mu
  where
    mu.reporting_month = cast ('2018-01-01 00:00:00' as timestamp)
  union all select 
  muo.product_soc,
  --muo.product_name,
  muo.call_description,
  replace(muo.finance_call_direction,'+','') finance_call_direction,
  'Old' source,
  0 as new,
  muo.voice as old
  from
    work.analyst_sandbox_test_mobile_usage_original muo)
SELECT 
  fact.product_soc,
  --Fact.product_name,
  Fact.call_description,
  --Fact.finance_call_direction,
  --fact.source,
  sum(Fact.new),
  sum(fact.old),
  100*abs(sum(Fact.new) - sum(fact.old))*2/(sum(Fact.new)+sum(fact.old)) as diff
  FROM
    Fact
  where
    --fact.call_description like '%Mobile Telia%' and
    fact.product_soc = '4YOU4' and
    1=1
  group by
    Fact.product_soc,
    Fact.call_description
    --Fact.finance_call_direction,
    --fact.source
/*  having
    100*abs(sum(Fact.new) - sum(fact.old))*2/(sum(Fact.new)+sum(fact.old)) > 5
  --  100*abs(sum(Fact.new) - sum(fact.old))*2/(sum(Fact.new)+sum(fact.old)) < 200
  order by
    100*abs(sum(Fact.new) - sum(fact.old))*2/(sum(Fact.new)+sum(fact.old)) desc*/
  order by
    100*abs(sum(Fact.new) - sum(fact.old))*2/(sum(Fact.new)+sum(fact.old)) desc
  limit 1000
  ;