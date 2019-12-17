with fact as (select 
  mu.product_soc,
  --mu.product_name,
  replace(mu.call_description, 'Mobile - Other', 'Mobile - Other Operators') as call_description,
  mu.finance_call_direction,
  'New' source,
  /*mu.voice_min as new_min,
  0 as old_min,*/
  mu.voice_calls as new_calls,
  0 as old_calls
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
  /*0 as new_min,
  muo.voice as old_min,*/
  0 as new_calls,
  muo.calls as old_calls
  from
    work.analyst_sandbox_test_mobile_usage_original muo)
SELECT 
  fact.product_soc,
  --Fact.product_name,
  Fact.call_description,
  --Fact.finance_call_direction,
  --fact.source,
  /*sum(Fact.new_min),
  sum(fact.old_min),*/
  sum(Fact.new_calls) as new_count_of_calls,
  sum(fact.old_calls) as old_count_of_calls
 -- 100*abs(sum(Fact.new_min) - sum(fact.old_min))*2/(sum(Fact.new_min)+sum(fact.old_min)) as diff_min,
  --100*abs(sum(Fact.new_calls) - sum(fact.old_calls))*2/(sum(Fact.new_calls)+sum(fact.old_calls)) as diff_calls
  FROM
    Fact
  where
    --fact.product_soc = 'SIMPLEBTB' and
    fact.product_soc = 'DLTLPR2' and
    1=1
  group by
    Fact.product_soc,
    Fact.call_description
    --Fact.finance_call_direction,
    --fact.source
  order by
    fact.call_description asc
    --diff_calls desc
  limit 1000;