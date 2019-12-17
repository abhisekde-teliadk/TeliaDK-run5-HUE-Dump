select * from sandbox.sandbox_sobotik_sb_churn_subid where sub_subscriber_id is null;
SELECT count(1) FROM base_equation_sub_tbt_subscriber_history where churn_date is not null; --17736042

select * from base_equation_sub_tbt_subscriber_history where subscriber_id=16330728 order by start_date desc;
select subscriber_no, subscriber_id, customer_id, sub_status, effective_date, expiration_date 
from temp.base_equation_sub_tmp_subscriber_history where subscriber_no='GSM04526778456' order by effective_date desc;
select * from base_equation_sub_work_subscriber_dates_resume where subscriber_no='GSM04527512657' order by effective_date desc;
select * from base_equation_sub_work_subscriber_act_date where subscriber_no='GSM04527512657' order by effective_date desc;
select * from base_equation_sub_work_subscriber_churn_dt where subscriber_no='GSM04527512657' order by effective_date desc;
select * from base_equation_sub_work_subscriber_history_part where subscriber_no='GSM04527512657' order by start_date desc;
select * from base_equation_sub_work_subscriber_rest_data where subscriber_no='GSM04553378209' order by start_date desc;
select * from base_equation_sub_work_subscriber_deduplicated where subscriber_no='GSM04553378209' order by start_date desc;
select * from base_equation_sub_work_subscriber_prolong_last where subscriber_no='GSM04553378209' order by start_date desc;
select * from base_equation_sub_tbt_subscriber_history where subscriber_no='GSM04527512657' order by start_date desc;

select * from base_equation_sub_tbt_subscriber_history where subscriber_id=13688047 order by start_date desc;
select subscriber_no, subscriber_id, customer_id, sub_status, effective_date, expiration_date 
from temp.base_equation_sub_tmp_subscriber_history where subscriber_id=13980597 order by effective_date desc;
select * from base_equation_sub_work_subscriber_dates_resume where subscriber_id=16330728 order by effective_date desc;
select * from base_equation_sub_work_subscriber_act_date where subscriber_id=16330728 order by effective_date desc;
select * from base_equation_sub_work_subscriber_churn_dt where subscriber_id=16330728 order by effective_date desc;
select * from base_equation_sub_work_subscriber_change where customer_id=531911113;
select * from base_equation_sub_work_subscriber_history_part where subscriber_id=16330728 order by start_date desc;
select * from base_equation_sub_work_subscriber_rest_data where subscriber_no='GSM04553378209' order by start_date desc;
select * from base_equation_sub_work_subscriber_deduplicated where subscriber_id=16330728 order by start_date desc;
select * from base_equation_sub_work_subscriber_prolong_last where subscriber_no='GSM04553378209' order by start_date desc;
select * from base_equation_sub_tbt_subscriber_history where subscriber_no='GSM04527512657' order by start_date desc;

select * from base.import_fokus_base_subscriber_history where subscriber_no='GSM04526179929';

select * from base_equation_kpis_work_churn_kpi_fat where subscriber_id=13688047 ;

13688047	GSM04526869828	665196010	2018-04-01 00:00:00;

select count(1) from base_equation_sub_work_subscriber_deduplicated where end_date is null;start_date>end_date;