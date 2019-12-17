SELECT cycle_run_month, cycle_run_year,price_plan_code,at_soc,at_feature_code, unit_measure_code,call_attempt_ind, count(*) as antal, sum(at_call_dur_sec)/60 
FROM base.import_fokus_base_detail_usage
where price_plan_code ='SIMPLEBTB'
and cast(call_date as TIMESTAMP) >= cast('2018-01-01' as TIMESTAMP) 
and cast(call_date as TIMESTAMP) < cast('2018-02-01' as timestamp)
and (unit_measure_code ='M' or unit_measure_code is null) 
group by cycle_run_month, cycle_run_year,price_plan_code,at_soc,at_feature_code, unit_measure_code, call_attempt_ind
;

select *
FROM base.import_fokus_base_detail_usage
where price_plan_code ='SIMPLEBTB'
and cast(call_date as TIMESTAMP) > cast('2018-01-01' as TIMESTAMP) 
and cast(call_date as TIMESTAMP) < cast('2018-02-01' as timestamp)
and call_attempt_ind = 'Y'
and unit_measure_code is null
;