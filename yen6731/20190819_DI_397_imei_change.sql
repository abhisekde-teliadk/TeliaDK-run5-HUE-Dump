select * from work.base_equation_other_work_detail_usage_imei_change where ban=529147019;
select count(*) from work.base_equation_other_work_detail_usage_imei_change where subscriber_id is null;
select count(*) from work.base_equation_other_work_detail_usage_imei_change where subscriber_id is not null;


select * from work.base_equation_other_work_detail_usage_product where ban=529147019 order by call_date_time asc;

select * from work.base_equation_other_work_detail_usage_imei_change_no_part where ban=529147019;

select * from work.base_equation_other_work_detail_usage_imei_change_extend where ban=529147019 order by call_date_time desc;

-- TESTING ****

select * from work.base_equation_other_work_detail_usage_imei_change_extend where ban=529147019 order by start_date asc;
select * from work.base_equation_other_work_detail_usage_imei_change_extend where subscriber_no='GSM04528270897';

select * from work.base_equation_other_work_detail_usage_product where subscriber_no='GSM04528270897';
select * from work.base_equation_other_work_detail_usage_product where ban=529147019 order by call_date_time asc;

select * from work.base_equation_other_work_detail_usage_imei_change_no_part where ban=529147019 order by start_date asc;
select * from work.base_equation_other_work_detail_usage_imei_change_no_part where subscriber_no='GSM04528270897';

select * from work.base_equation_fat_work_handset_stats where subscriber_id=3175459;

SELECT * from work.base_equation_other_tbt_subscriber_imei_history where  msisdn in ('40346801','28270897') order by start_date asc;
SELECT * from work.base_equation_other_tbt_subscriber_imei_used_history where  msisdn in ('40346801','28270897') order by start_date asc;

SELECT distinct customer_id, subscriber_id, prev_imei, imei, prev_tac, tac, msisdn, active_record_flag, subscriber_id from work.base_equation_other_tbt_subscriber_imei_history where subscriber_id=13179159;
SELECT ban, subscriber_id, prev_imei, imei, prev_tac, tac, msisdn, subscriber_id from work.base_equation_other_work_detail_usage_imei_change_extend where subscriber_id=13179159;
SELECT * from work.base_equation_other_work_detail_usage_imei_change_extend where subscriber_id=13179159;
SELECT * from work.base_equation_other_work_subscriber_imei_last_change where  msisdn in ('40346801','28270897');--subscriber_id=13179159;
SELECT * from work.base_equation_other_work_detail_usage_imei_change_extend where subscriber_id=13179159;

SELECT * from work.base_equation_other_work_subscriber_imei_change_last_change_ranked where  msisdn in ('40346801','28270897') order by start_date;

SELECT * from work.base_equation_other_tbt_subscriber_imei_history where  msisdn in ('40346801','28270897') order by start_date asc;
;

select *
from analytics.abt_subscriber_imei_history
where msisdn in ('40346801','28270897')
order by msisdn,
start_date asc
;



SELECT ban, subscriber_id, prev_imei, imei, prev_tac, tac, msisdn, subscriber_id
from work.base_equation_other_work_detail_usage_imei_change_extend where subscriber_id=13179159
group by ban, subscriber_id, prev_imei, imei, prev_tac, tac, msisdn, subscriber_id;

SELECT * from analytics.abt_subscriber_imei_current where subscriber_id=3175459 order by start_date asc;
SELECT * from analytics.abt_subscriber_imei_history where subscriber_no='GSM04528270897' order by start_date asc;

-- !!!!! REMOVED PK CHECK ON CURRENT!!!!

SELECT COUNT(*) AS count_pk_distinct
FROM 
(SELECT start_date, subscriber_id, imei, count(*) AS pk_count
FROM work.base_equation_other_tbt_subscriber_imei_history
GROUP BY start_date, subscriber_id, imei
HAVING pk_count > 1)CNT;

SELECT start_date, subscriber_id, imei, count(*) AS pk_count
FROM work.base_equation_other_work_detail_usage_imei_change_extend
GROUP BY start_date, subscriber_id, imei
HAVING pk_count > 1;


select * from work.base_equation_other_work_detail_usage_product where imei='352976096665750' and call_date_time between to_timestamp('2019-04-03','yyyy-MM-dd') and to_timestamp('2019-04-05','yyyy-MM-dd') order by call_date_time asc;
select * from work.base_equation_other_work_detail_usage_imei_change_no_part where imei='352976096665750' and call_date_time between to_timestamp('2019-04-03','yyyy-MM-dd') and to_timestamp('2019-04-05','yyyy-MM-dd') order by call_date_time asc;
select * from work.base_equation_other_work_detail_usage_imei_change_extend where imei='352976096665750' and start_date between to_timestamp('2019-04-03','yyyy-MM-dd') and to_timestamp('2019-04-05','yyyy-MM-dd') order by start_date asc;

select * from work.base_equation_other_work_detail_usage_product where ban=659472211 and call_date_time between to_timestamp('2019-04-03','yyyy-MM-dd') and to_timestamp('2019-04-05','yyyy-MM-dd') order by call_date_time asc;
select * from work.base_equation_other_work_detail_usage_product where ban=552172215 and call_date_time between to_timestamp('2019-04-03','yyyy-MM-dd') and to_timestamp('2019-04-05','yyyy-MM-dd') order by call_date_time asc;


SELECT * from analytics.abt_subscriber_imei_current where subscriber_id=3175459 order by start_date asc;
SELECT * from analytics.abt_subscriber_imei_history where subscriber_no='GSM04528270897' order by start_date asc;

SELECT * from work.base_equation_other_tbt_subscriber_imei_used_history where subscriber_no='GSM04528270897' order by start_date asc;

SELECT * from work.base_equation_other_tbt_subscriber_imei_history where subscriber_no='GSM04528270897' order by start_date asc;

SELECT * from work.base_equation_other_tbt_subscriber_imei_history where  msisdn in ('40346801') order by start_date asc;
SELECT * from work.base_equation_other_tbt_subscriber_imei_history where  msisdn in ('28270897') order by start_date asc;

SELECT * from work.base_equation_fat_work_subscriber_imei_history where  msisdn in ('28270897') order by start_date asc;
SELECT * from analytics.abt_subscriber_imei_history where  msisdn in ('28270897') order by start_date asc;
SELECT * from analytics.abt_subscriber_imei_history where  msisdn in ('28270897') order by start_date asc;