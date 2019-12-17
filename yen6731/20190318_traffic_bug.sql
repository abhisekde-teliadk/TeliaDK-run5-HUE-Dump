-- Get some example
select subscriber_no FROM base.import_fokus_base_detail_usage where cycle_run_year=2018 and cycle_run_month=12 and unit_measure_code='O' and at_call_dur_sec>1;

-- DETAIL USAGE
select unit_measure_code, subscriber_no, at_call_dur_sec, call_date, call_time, call_type  FROM base.import_fokus_base_detail_usage
where cycle_run_year=2018 and cycle_run_month=12 and /*and unit_measure_code ='O' and at_call_dur_sec > 1*/subscriber_no='GSM04552195075' and call_date='2018-12-01 00:00:00'
and call_type='R';

-- AGGREGATED (our) dataset
select at_call_dur_sec_sum, * from work.base_equation_other_work_detail_usage_aggregated 
where subscriber_no='GSM04552195075' and call_date='2018-12-01 00:00:00' and call_type='R';

-- see at_call_dur_sec

select * from work.base_equation_other_tbt_traffic where subscriber_no='GSM04552195075' and event_date='2018-12-01 00:00:00';