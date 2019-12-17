select count(*) from sandbox.sandbox_brstak_abt_churn_churn_enrich_joined where kpi_subscriber_id is null and product_subgroup != 'Ekstra datakort' ;

select count(*) from sandbox.sandbox_sobotik_abt_churn_joined where kpi_subscriber_id is null and product_subgroup != 'Ekstra datakort' ;

select * from sandbox.sandbox_brstak_abt_churn_churn_enrich_joined where kpi_subscriber_id is null and product_subgroup != 'Ekstra datakort' ;

select * from sandbox.sandbox_brstak_abt_churn_churn_enrich_joined where kpi_subscriber_id is null and subscriber_no = 'GSM04526130595'; 

select * from sandbox.sandbox_brstak_abt_churn_churn_enrich_joined where kpi_subscriber_id is null and subscriber_no = 'GSM04526144537'; --2019-03-01

sandbox_brstak_abt_churn_chrun_enrich_joined;

--2019-03-01T00:00:00.000Z	GSM04553384053

select * from work.base_equation_sub_tbt_subscriber_history where subscriber_no = 'GSM04560220799'; 

select subscriber_id, *
from  raw.import_fokus_raw_subscriber where subscriber_no = 'GSM04560220799'
order by effective_date; --status A - jak muze byt churn???

select * from raw.import_fokus_raw_subscriber_history where subscriber_id = '15442928'; 
--subscriber id = 15442928 ten stary s C, subscriber no GSM04560220799
--subscriber id = 16290220 ten novy s A, subscriber no GSM04560220799

select table_name, subscriber_id, subscriber_no, customer_id, effective_date, expiration_date, sub_status from (

select 'S' table_name, subscriber_id, subscriber_no, customer_id, effective_date, null expiration_date, sub_status 
from  raw.import_fokus_raw_subscriber where subscriber_no = 'GSM04560220799'
order by effective_date
union
select 'H' table_name, null subscriber_id, subscriber_no, customer_id, effective_date, expiration_date, sub_status from raw.import_fokus_raw_subscriber_history where subscriber_no = 'GSM04560220799'
order by effective_date) b
order by effective_date;

--change entita: OK
select * from work.base_equation_sub_work_subscriber_change where change_subscriber_id = 15442928;

select * from work.base_equation_sub_work_subscriber_change where change_subscriber_id = 16290220;

--prvni join s change: OK
select * from work.base_equation_sub_work_subscriber_history_part where s_status_subscriber_id = 15442928;

select * from work.base_equation_sub_work_subscriber_history_part where s_status_subscriber_id = 16290220;

--history all: OK
select * from work.base_equation_sub_work_subscriber_history_all where s_status_subscriber_id = 15442928;

select * from work.base_equation_sub_work_subscriber_history_all where s_status_subscriber_id = 16290220;

--previous product: OK
select * from work.base_equation_sub_work_subscriber_previous_product where s_status_subscriber_id = 15442928;

select * from work.base_equation_sub_work_subscriber_previous_product where s_status_subscriber_id = 16290220;

--max previous product: OK
select * from work.base_equation_sub_work_subscriber_previous_product_max where s_status_subscriber_id = 15442928;

select * from work.base_equation_sub_work_subscriber_previous_product_max where s_status_subscriber_id = 16290220;

--rest data: OK
select * from work.base_equation_sub_work_subscriber_rest_data where s_status_subscriber_id = 15442928;

select * from work.base_equation_sub_work_subscriber_rest_data where s_status_subscriber_id = 16290220;


--subscriber id dedup: OK
select * from work.base_equation_sub_work_subscriber_id_deduplicated where s_status_subscriber_id = 15442928;

select * from work.base_equation_sub_work_subscriber_id_deduplicated where s_status_subscriber_id = 16290220;


--subscriber no dedup: notOK
select * from work.base_equation_sub_work_subscriber_no_deduplicated where s_status_subscriber_id = 15442928;

select count(*) from (
select start_date, s_status_subscriber_no, count(*) from work.base_equation_sub_work_subscriber_no_deduplicated
group by start_date, s_status_subscriber_no
having count(*) > 1) b --247
; 


select * from work.base_equation_sub_work_subscriber_no_deduplicated where s_status_subscriber_no = 'GSM04560220799';

select * from work.base_equation_sub_work_subscriber_end_date where s_status_subscriber_no = 'GSM04560220799';

select start_date, end_date, subscriber_id, subscriber_no, customer_id, fokus_status 
from work.base_equation_sub_tbt_subscriber_history where subscriber_no = 'GSM04560220799' 
and start_date >= to_timestamp('2019-03-01', 'yyyy-MM-dd');

select start_date, s_status_subscriber_id, s_status_subscriber_no, s_customer_id, s_sub_status, subscriber_id_end_date, subscriber_no_end_date 
from work.base_equation_sub_work_subscriber_end_date where s_status_subscriber_no = 'GSM04560220799' 
and start_date >= to_timestamp('2019-03-01', 'yyyy-MM-dd');

select * from analytics.abt_subscriber_history 
where subscriber_no = 'GSM04560220799' 
and start_date >= to_timestamp('2019-03-01', 'yyyy-MM-dd');

select count(*) from work.base_equation_sub_tbt_subscriber_history where end_date < start_date;


select start_date, s_status_subscriber_no, s_customer_id, s_status_subscriber_id, s_sub_status
from work.base_equation_sub_work_subscriber_id_deduplicated where s_status_subscriber_no = 'GSM04560220799'
order by start_date, s_sub_status;



select * from work.base_equation_sub_work_subscriber_no_deduplicated where s_status_subscriber_id = 16290220;

select * from raw.import_fokus_raw_subscriber where subscriber_id = '15442928';

select *
from  raw.import_fokus_raw_subscriber_history where subscriber_no = 'GSM04560220799'
order by effective_date; --status A - jak muze byt churn???


select *
from  raw.import_fokus_raw_subscriber_history where subscriber_no = 'GSM04526130595'
order by effective_date;

select *
from  raw.import_fokus_raw_subscriber_history where subscriber_no = 'GSM04526144537'
order by effective_date;

	

select * from work.base_equation_kpis_tbt_churn_kpi where subscriber_no = 'GSM04526186433';

select * from work.base_equation_kpis_tbt_churn_kpi where subscriber_no = 'GSM04526130595';

select * from work.base_equation_kpis_tbt_churn_kpi where subscriber_no = 'GSM04526144537';

select count(*) from work.base_equation_kpis_tbt_churn_kpi where churn_date > to_timestamp('2018-01-01', 'yyyy-MM-dd');

select min(churn_date) from sandbox.abt_churn_kpi_churn_enrich;



select count(*) from sandbox.abt_churn_kpi_churn_enrich where
churn_date between to_timestamp('2019-01-01', 'yyyy-MM-dd') and to_timestamp('2019-01-31', 'yyyy-MM-dd');

; --17466

select * from work.base_equation_sub_tbt_subscriber_history where subscriber_no = 'GSM04520231403' and customer_id = 854395902;
--subscriber_id = 12533107
--churn date 2019-03-08 00:00:00

select subscriber_id, subscriber_no, customer_id,sub_status, sub_status_date from raw.import_fokus_raw_subscriber where subscriber_no = 'GSM04520231403' and customer_id = '854395902';


select subscriber_id, subscriber_no, customer_id,sub_status, sub_status_date from raw.import_fokus_raw_subscriber 
where subscriber_id = '12533107';

select * from raw.import_fokus_raw_subscriber 
where subscriber_id = '12533107';

select * from raw.import_fokus_raw_subscriber_history where subscriber_no = 'GSM04520231403' and customer_id = '854395902';

select * from raw.import_fokus_raw_subscriber_history where subscriber_id = '12533107';

select * from work.base_equation_sub_tbt_subscriber_history where subscriber_id = 12533107;


select start_date, s_status_subscriber_no, s_customer_id, count(*)
from work.base_equation_sub_v2_work_subscriber_id_deduplicated 
group by start_date, s_status_subscriber_no, s_customer_id
having count(*) > 1
order by 4 desc
;

select * from work.base_equation_sub_v2_work_subscriber_id_deduplicated where s_status_subscriber_no = 'GSM04530244530'
and s_customer_id = 922350608; --2008-11-21 23:59:58


select * from work.base_equation_sub_tbt_subscriber_history;

select * from work.base_equation_sub_tbt_subscriber_current;

select * from work.base_equation_kpis_tbt_churn_kpi
where customer_id = 876230707 and subscriber_no = 'GSM04528800441';

--subscriber ids: 9262697, 15836539
select * from work.base_equation_sub_tbt_subscriber_history where subscriber_id = 9262697;

select * from work.base_equation_sub_tbt_subscriber_history where subscriber_id = 15836539;

select * from work.base_equation_sub_work_subscriber_end_date where s_status_subscriber_id = 15836539;

select * from base.import_fokus_base_subscriber where subscriber_id = 15836539 
union
select * from base.import_fokus_base_subscriber_history where subscriber_id = 15836539;

select * from work.base_equation_sub_work_subscriber_history where subscriber_id = 15836539;



select * from work.base_equation_sub_work_subscriber_churn_date where subscriber_id = 15836539;

select * from work.base_equation_sub_work_subscriber_churn_date where subscriber_id = 9262697;

select count(*) from work.base_equation_sub_tbt_subscriber_history
where nvl(churn_date, to_timestamp('9999-12-31', 'yyyy-MM-dd')) != nvl(churn_date_v2, to_timestamp('9999-12-31', 'yyyy-MM-dd'))
;

select count(*) from work.base_equation_sub_tbt_subscriber_history where churn_date is not null; --18195508

select count(*) from work.base_equation_sub_tbt_subscriber_history where churn_date_v2 is not null;

18195508
 3590971;

select * from work.base_equation_sub_tbt_subscriber_history where subscriber_no = 'GSM04526130595';

select * from work.base_equation_sub_tbt_subscriber_history where subscriber_no = 'GSM04526144537';

--nekolik ruznych subscriber ids
select * from work.base_equation_sub_tbt_subscriber_history where subscriber_no = 'GSM04560108020';

--spatne
select 
start_date, end_date, subscriber_id, subscriber_no, customer_id, fokus_status, churn_date, churn_date_rank,
churn_date_v2
from work.base_equation_sub_tbt_subscriber_history where subscriber_id =  11443683;

--case ktery tam je, a nase logika ho zahodi
select * from sandbox.sandbox_brstak_abt_churn_churn_enrich_joined where subscriber_no = 'GSM04526755723';

--je v datasetu od Krystiana, nejake divne intervaly platnosti
select 
start_date, end_date, subscriber_id, subscriber_no, customer_id, fokus_status, churn_date, churn_date_rank,
churn_date_v2
from work.base_equation_sub_tbt_subscriber_history where subscriber_id =  11540025;

--je v datasetu od Krystiana, churn 2019-03-05, neukonceny zaznam, kdy je cislo pod jednim banem a prejde pod druhy
select 
start_date, end_date, subscriber_id, subscriber_no, customer_id, fokus_status, churn_date, churn_date_rank,
churn_date_v2
from work.base_equation_sub_tbt_subscriber_history where subscriber_id =  14517607;


--tenhle je spatne
select 
start_date, end_date, subscriber_id, subscriber_no, customer_id, fokus_status, churn_date, churn_date_rank,
churn_date_v2
from work.base_equation_sub_tbt_subscriber_history where subscriber_id =  12421607;

--stejny case jako vyse
select 
start_date, end_date, subscriber_id, subscriber_no, customer_id, fokus_status, churn_date, churn_date_rank,
churn_date_v2
from work.base_equation_sub_tbt_subscriber_history where subscriber_id =  3191073;

--potrebujeme zjistit, jestli pro stejne subscriber_id existuje jeste jine cislo, ktere je aktivni (end date > end date daneho radku).
--Pokud ano nejedna se o churn

--dobre
select start_date, end_date, subscriber_id, subscriber_no, customer_id, fokus_status, churn_date, churn_date_rank,
churn_date_v2
from work.base_equation_sub_tbt_subscriber_history where subscriber_id =  15836539;

select * from work.base_equation_sub_work_subscriber_churn_date where subscriber_id = 12421607;

select * from work.base_equation_sub_tbt_subscriber_history where subscriber_id =  12421607
;

select * from work.base_equation_sub_work_subscriber_hist where subscriber_id =  12421607
order by end_date desc, case when fokus_status = 'C' then 0 else 1 end desc
;


with subscriber_full_history as (select

    customer_id,

    subscriber_no,

    subscriber_id,

    effective_date,

    null as expiration_date,

    sub_status,

    sub_status_date,

    sub_status_rsn_code

    from

        base.import_fokus_base_subscriber

    union select

    customer_id,

    subscriber_no,

    subscriber_id,

    effective_date,

    expiration_date,

    sub_status,

    sub_status_date,

    sub_status_rsn_code

    from

        base.import_fokus_base_subscriber_history)

select

    customer_id,

    subscriber_no,

    subscriber_id,

    effective_date,

    expiration_date,

    sub_status,

    sub_status_date,

    sub_status_rsn_code

    from

        subscriber_full_history

    where subscriber_id in (16241588)

        --customer_id = 876230707 and

        --subscriber_no = 'GSM04528800441'

       

    order by

        subscriber_id,

        effective_date,

        subscriber_no;
        
        customer_id	subscriber_no	subscriber_id	effective_date	expiration_date	sub_status	sub_status_date	sub_status_rsn_code	
981758014	GSM04560108020	14517607	2016-04-14 00:53:57	2017-02-06 23:59:59	A	2016-04-14 00:00:00	NP	
852703115	GSM04560108020	14517607	2017-02-01 00:00:00	2019-03-05 07:02:38	A	2017-02-01 00:00:00	CR	
981758014	GSM04560108020	14517607	2017-02-07 00:00:00	NULL	C	2017-02-01 00:00:00	CR	
852703115	GSM04560108020	14517607	2019-03-05 07:02:39	NULL	C	2019-03-05 00:00:00	IPI	
;

select * from work.base_equation_sub_work_subscriber_history_part where s_status_subscriber_no = 'GSM04560108020' and s_customer_id = 981758014;

select * from work.base_equation_sub_work_subscriber_change where subscriber_no = 'GSM04560108020' and customer_id = 981758014;

select effective_date, expiration_date from temp.base_equation_sub_tmp_subscriber_status where subscriber_no = 'GSM04560108020' and customer_id = 981758014;

select subscriber_id from work.base_equation_sub_work_subscriber_history where subscriber_no = 'GSM04560108020' and customer_id = 981758014;

select * from work.base_equation_sub_work_closed_subscriber where subscriber_no = 'GSM04560108020' and customer_id = 981758014;

select * from work.base_equation_sub_work_subscriber_history where subscriber_id = 14517607 and sub_status = 'C';

------------------------------------------------------------------------------------------------------------------------

select * from work.base_equation_sub_work_subscriber_history_part where s_status_subscriber_no = 'GSM04526755723' and s_customer_id = 423652601;

select * from work.base_equation_sub_work_subscriber_history_all where s_status_subscriber_no = 'GSM04526755723' and s_customer_id = 423652601;

select * from work.base_equation_sub_work_subscriber_rest_data where s_status_subscriber_no = 'GSM04526755723' and s_customer_id = 423652601;

select * from work.base_equation_sub_work_subscriber_previous_product where s_status_subscriber_no = 'GSM04526755723' and s_customer_id = 423652601;

select * from work.base_equation_sub_work_subscriber_previous_product_max where s_status_subscriber_no = 'GSM04526755723' and s_customer_id = 423652601;

select * from work.base_equation_sub_work_subscriber_previous_product_max where s_status_subscriber_id = 11540025;

select * from work.base_equation_sub_work_subscriber_change where subscriber_no = 'GSM04560108020' and customer_id = 981758014;

select effective_date, expiration_date from temp.base_equation_sub_tmp_subscriber_status where subscriber_no = 'GSM04560108020' and customer_id = 981758014;

select subscriber_id from work.base_equation_sub_work_subscriber_history where subscriber_no = 'GSM04560108020' and customer_id = 981758014;

select * from work.base_equation_sub_work_closed_subscriber where subscriber_no = 'GSM04526755723' and customer_id = 423652601;

select * from work.base_equation_sub_work_subscriber_history where subscriber_id = 14517607 and sub_status = 'C';

-----------------------------------------------------------------------------------------------------------------------


select * from work.base_equation_sub_tbt_subscriber_history where subscriber_no = 'GSM04527647835';

--958655904

--spatne
select 
start_date, end_date, subscriber_id, subscriber_no, customer_id, fokus_status, churn_date, churn_date_rank,
churn_date_v2
from work.base_equation_sub_tbt_subscriber_history where subscriber_id =  12486083;

select * from work.base_equation_sub_work_subscriber_history_part where s_status_subscriber_no = 'GSM04527647835' and s_customer_id = 958655904;

select * from work.base_equation_sub_work_subscriber_history_all where s_status_subscriber_no = 'GSM04526755723' and s_customer_id = 423652601;

select * from work.base_equation_sub_work_subscriber_rest_data where s_status_subscriber_no = 'GSM04526755723' and s_customer_id = 423652601;

select * from work.base_equation_sub_work_subscriber_previous_product where s_status_subscriber_no = 'GSM04527647835' and s_customer_id = 958655904;

select * from work.base_equation_sub_work_subscriber_previous_product_max where s_status_subscriber_no = 'GSM04527647835' and s_customer_id = 958655904;

select * from work.base_equation_sub_work_subscriber_rest_data where s_status_subscriber_no = 'GSM04527647835' and s_customer_id = 958655904;

select * from work.base_equation_sub_work_subscriber_rest_data where s_status_subscriber_id = 12486083;

select * from work.base_equation_sub_work_subscriber_id_deduplicated where s_status_subscriber_no = 'GSM04527647835' and s_customer_id = 958655904;

select * from work.base_equation_sub_work_subscriber_deduplicated where s_status_subscriber_no = 'GSM04527647835' and s_customer_id = 958655904;

select * from work.base_equation_sub_work_subscriber_end_date where s_status_subscriber_no = 'GSM04527647835' and s_customer_id = 958655904;

select start_date, s_status_subscriber_no, s_customer_id, count(*) from work.base_equation_sub_work_subscriber_deduplicated
group by start_date, s_status_subscriber_no, s_customer_id
having count(*) > 1;

select * from work.base_equation_sub_work_subscriber_deduplicated where s_status_subscriber_no = 'GSM04527647835'
and s_customer_id = 958655904;

select * from work.base_equation_sub_work_subscriber_hist where subscriber_no = 'GSM04527647835'
and customer_id = 958655904;

select * from work.base_equation_sub_work_subscriber_previous_product_max where s_status_subscriber_id = 11540025;

select * from work.base_equation_sub_work_subscriber_change where subscriber_no = 'GSM04560108020' and customer_id = 981758014;

select effective_date, expiration_date from temp.base_equation_sub_tmp_subscriber_status where subscriber_no = 'GSM04560108020' and customer_id = 981758014;

select subscriber_id from work.base_equation_sub_work_subscriber_history where subscriber_no = 'GSM04560108020' and customer_id = 981758014;

select * from work.base_equation_sub_work_closed_subscriber where subscriber_no = 'GSM04526755723' and customer_id = 423652601;

select * from work.base_equation_sub_work_subscriber_history where subscriber_id = 14517607 and sub_status = 'C';

select count(*) from(
select start_date, subscriber_no, customer_id, count(*) from work.base_equation_sub_tbt_subscriber_history
group by start_date, subscriber_no, customer_id
having count(*) > 1) x;

-----------------------------------------------------------------------------------------------------------------------

select * from work.base_equation_sub_tbt_subscriber_history where subscriber_no = 'GSM04523473001';

select * from work.base_equation_sub_tbt_subscriber_history where subscriber_id = 13881197;


--958655904

--churn chybi asi v tbt churn
select 
start_date, end_date, subscriber_id, subscriber_no, customer_id, fokus_status, churn_date, churn_date_rank,
churn_date_v2
from work.base_equation_sub_tbt_subscriber_history where subscriber_id =  12486083;

select * from work.base_equation_kpis_tbt_churn_kpi where subscriber_no = 'GSM04523473001'; --chybi


select * from work.base_equation_kpis_work_subscriber_history_last_sub_id where subscriber_no = 'GSM04523473001';

-----------------------------------------------------------------------------------------------------------------------

--there is younger record with active state for same number, ban and subscriber id. So per my understanding it should not be a churn
--Is of for example the case that your dataset has been created before this new active record had been created (before 2019-03-11)

select * from work.base_equation_sub_tbt_subscriber_history where subscriber_no = 'GSM04552157502';
--same case

select * from work.base_equation_sub_tbt_subscriber_history where subscriber_id = 14013868;

select * from work.base_equation_sub_work_subscriber_churn_date where subscriber_no = 'GSM04552157502';

select COUNT(distinct subscriber_no) OVER (PARTITION BY `subscriber_id` order by subscriber_id) 
AS `subscriber_no_count`
from work.base_equation_sub_work_subscriber_hist where subscriber_no = 'GSM04552157502';
        

select * from work.base_equation_sub_tbt_subscriber_history where subscriber_id = 9394702;

select * from sandbox.sandbox_brstak_abt_churn_churn_enrich_joined where kpi_subscriber_id is null and product_subgroup != 'Ekstra datakort' ;

select * from work.base_equation_sub_tbt_subscriber_history where subscriber_no = 'GSM04528941239';


select * from work.base_equation_sub_tbt_subscriber_history where subscriber_no = 'GSM04528730024';

select count(*) from sandbox.sandbox_brstak_abt_churn_churn_enrich_joined where subscriber_no is not null;

--538 240 .....total count
--3071 ....missing 
-- 99.4% match..


-----------------------------------------------------------------------------------------------------------------------
--difference between dates - no differences. we have perfect match on churn date

select * from work.base_equation_sub_tbt_subscriber_history where subscriber_no = 'GSM04528354969';

select * from sandbox.sandbox_brstak_abt_churn_churn_enrich_joined where subscriber_no = 'GSM04528354969';



-

select * from sandbox.sandbox_brstak_abt_churn_churn_enrich_joined where kpi_subscriber_id is not null 
and product_subgroup != 'Ekstra datakort' and churn_date != kpi_churn_date ;

-----------------------------------------------------------------------------------------------------------------------
--what we have and does not exist in refernce dataset

--559 more churns in January
--total count for Jan 2019 32286 = 97,3 % match

--10697 more churns since 2018-01-01: it represent just 1,9%  of records from total count.

select
--count(*)
a.subscriber_no, a.customer_id, a.subscriber_id, a.churn_date, b.subscriber_no, b.churn_date
 from 
 (
select * from work.base_equation_kpis_tbt_churn_kpi where churn_date between to_timestamp('2019-01-01', 'yyyy-MM-dd') and
to_timestamp('2019-02-28', 'yyyy-MM-dd'))
a
left outer join (select * from  sandbox.abt_churn_kpi_churn_enrich where
churn_date between to_timestamp('2019-01-01', 'yyyy-MM-dd') and to_timestamp('2019-02-28', 'yyyy-MM-dd'))
b
on a.subscriber_no = b.subscriber_no
where b.subscriber_no is null
;

select count(*) from  sandbox.abt_churn_kpi_churn_enrich where
churn_date between to_timestamp('2019-01-01', 'yyyy-MM-dd') and to_timestamp('2019-01-31', 'yyyy-MM-dd');


--seems to be correct to me - there is only this row with sub_status = C
select * from work.base_equation_sub_tbt_subscriber_history where subscriber_no = 'GSM04524905868';

select * from work.base_equation_sub_tbt_subscriber_history where subscriber_id = 16225912;

select * from work.base_equation_sub_tbt_subscriber_history where subscriber_no = 'GSM04526486270';

select * from work.base_equation_sub_tbt_subscriber_history where subscriber_id =  15346763; --15346763, 16241588


SELECT subscriber_no, customer_id, count(*) AS pk_count
FROM work.base_equation_sub_tbt_subscriber_current
GROUP BY subscriber_no, customer_id
HAVING pk_count > 1;

select * from work.base_equation_sub_tbt_subscriber_current where subscriber_no = 'GSM04526790486' and customer_id = 305942203;

select start_date, end_date, subscriber_no, customer_id, subscriber_id, prol_duration
from work.base_equation_sub_tbt_subscriber_history where subscriber_no = 'GSM04526790486' and customer_id = 305942203
and end_date > now();
;

select min(birth_date), max(birth_date) from  work.base_equation_sub_tbt_subscriber_history where birth_date is not null;

select identify, substring(identify,1,6), to_timestamp(substring(identify,1,6),'ddMMyy') from  
work.base_equation_sub_tbt_subscriber_history where identify is not null;

select min(to_timestamp(substring(identify,1,6),'ddMMyy')), max(to_timestamp(substring(identify,1,6),'ddMMyy')) from  
work.base_equation_sub_tbt_subscriber_history where identify is not null;

select distinct to_timestamp(birth_date, 'yyyy-MM-dd') from base.import_fokus_base_name_data order by 1 asc;

select distinct min(birth_date), max(birth_date) from  work.base_equation_sub_tbt_customer_history where birth_date is not null;

select distinct birth_date, name_birth_date, name_birth_date_parsed, name_date_state from 
work.base_equation_sub_work_subscriber_hist where name_birth_date is not null order by 2 asc;

select distinct birth_date from work.base_equation_sub_work_subscriber_prolong_last where birth_date is not null order by 1 asc;

select to_timestamp('0001-02-03 00:00:00', 'yyyyy-MM-dd HH:mm:ss');

select * from work.base_equation_kpis_tbt_churn_kpi where subscriber_no = 'GSM04561125278';

select * from sandbox.abt_churn_kpi_Churn_enrich_joined_prepared
where subscriber_no = 'GSM04561125278' ;

select distinct to_timestamp(birth_date, 'yyyy-MM-dd') from base.import_fokus_base_name_data order by 1 asc;

select count(*) from (
select churn_date, subscriber_id, subscriber_no, customer_id, count(*)  from analytics.prod_abt_churn_kpi
group by churn_date, subscriber_id, subscriber_no, customer_id
having count(*) > 1)x;
/*where subscriber_no = 'GSM04561125278'*/

select count(*) from sandbox.sandbox_sobotik_abt_churn_joined where kpi_subscriber_id is null and product_subgroup != 'Ekstra datakort' ;

select count(*) from (
select churn_date, subscriber_id, subscriber_no, customer_id, count(*)  from work.base_equation_kpis_tbt_churn_kpi
group by churn_date, subscriber_id, subscriber_no, customer_id
having count(*) > 1)x;

select churn_date, subscriber_id, subscriber_no, customer_id, count(*)  from work.base_equation_kpis_tbt_churn_kpi
group by churn_date, subscriber_id, subscriber_no, customer_id
having count(*) > 1
;

select churn_date, subscriber_id, subscriber_no, customer_id, count(*)  from work.base_equation_kpis_work_churn_kpi_fat
group by churn_date, subscriber_id, subscriber_no, customer_id
having count(*) > 1 --0
;

select count(*) from (
select churn_date, subscriber_no, customer_id, count(*)  from work.base_equation_kpis_work_churn_kpi_service_history_joined
group by churn_date, subscriber_no, customer_id
having count(*) > 1)x --4380
;
/* test case
2018-05-04 00:00:00	GSM04522560818	617557012
*/

select * from work.base_equation_kpis_work_churn_kpi_fat where subscriber_no = 'GSM04522560818'	and customer_id = 617557012;

select * from work.base_equation_kpis_work_churn_kpi_service_history_joined
where subscriber_no = 'GSM04522560818'	and customer_id = 617557012;



select * from work.vasdata_tbt_service_history where subscriber_no = 'GSM04522560818'	and customer_id = 617557012
and start_date <= to_timestamp('2018-05-04', 'yyyy-MM-dd') and end_date >=  to_timestamp('2018-05-04', 'yyyy-MM-dd');


select count(*) from (
select churn_date, subscriber_no, customer_id, count(*)  from work.base_equation_kpis_work_churn_kpi_fat_joined
group by churn_date, subscriber_no, customer_id
having count(*) > 1)x; --37324

select * from work.base_equation_kpis_work_churn_kpi_fat_joined
where subscriber_no = 'GSM04523410182'	and customer_id = 639452010;

select * from work.base_equation_kpis_work_churn_kpi_fat_joined
where subscriber_no = 'GSM04521269414'	and customer_id = 646422113;

select * from work.base_equation_kpis_work_traffic_aggregated_prepared where subscriber_no = 'GSM04523410182'	and customer_id = 639452010;

select * from work.base_equation_kpis_work_traffic_aggregated where subscriber_no = 'GSM04523410182'
and customer_id = 639452010;

select * from work.base_equation_kpis_work_traffic_aggregated where subscriber_no = 'GSM04521269414'
and customer_id = 646422113;

select * from analytics.abt_traffic where subscriber_no = 'GSM04523410182'	and 
customer_id = 639452010
and event_month = '201812'
;

select event_month, customer_id, subscriber_no, count(*)  from work.base_equation_kpis_work_traffic_aggregated group by event_month, customer_id, subscriber_no
having count(*) > 1;

select count(*) from (
select churn_date, subscriber_no, customer_id, count(*)  from analytics.abt_churn_kpi
group by churn_date, subscriber_no, customer_id
having count(*) > 1)x; --37324

select * from work.vasdata_work_service_change where subscriber_no = 'GSM04522560818'	and customer_id = 617557012;

select * from work.base_equation_kpis_work_churn_kpi_service_history_pivot where subscriber_no = 'GSM04522560818'	and customer_id = 617557012;

select count(*) from (
select churn_date, subscriber_no, customer_id, count(*)  from work.base_equation_kpis_work_churn_kpi_service_history_pivot
group by churn_date, subscriber_no, customer_id
having count(*) > 1)x; 

select product_eu_data, * from analytics.abt_traffic where subscriber_no = 'GSM04521269414'	and 
customer_id = 646422113
and event_month = '201811'
;

select * from analytics.abt_subscriber_history where 
subscriber_no = 'GSM04521269414'	and 
customer_id = 646422113;

/*
problem v abt_traffic, kdy mi pro dany event date vrati vice radku ze subscribera, kde kazdy radek
ma jiny produkt
*/

select * from analytics.abt_traffic where subscriber_no = 'GSM04521269414'	and 
customer_id = 646422113
and event_month = '201811';


--------

select count(*) from analytics.prod_abt_churn_kpi where priceplan_description like '4EVERYTHING Light'
 and churn_date >= to_timestamp('2018-01-01', 'yyyy-MM-dd') and churn_date < to_timestamp('2018-02-01', 'yyyy-MM-dd')
 and churn_reason_desc not in ('Cancelation - Regret buying before 31 days', 'Cancelation - Regret buying after 31 days', 'Change Subscriber - Number portability')
 ; --2109
 
 select distinct churn_reason_desc from analytics.prod_abt_churn_kpi where priceplan_description like '4EVERYTHING Light'
 and churn_date >= to_timestamp('2018-01-01', 'yyyy-MM-dd') and churn_date < to_timestamp('2018-02-01', 'yyyy-MM-dd');
 
 select sum(churn_excl_annulments) from analytics.prod_abt_stock_report where month = '201801' 
 and soc in ('NBMA01', 'NBMA11');
 
  select sum(churn_excl_annulments) from analytics.abt_stock_report where month = '201801' 
 and soc in ('NBMA01', 'NBMA11');
 
 select sum(annulment) from work.reporting_to_authorities_work_stock_report where year = 2018 and  month = 1 
 and soc in ('NBMA01', 'NBMA11'); --423.. 21 
 
 select count(*) from analytics.abt_billing; where discount_amt_incl_vat is null;
 
 select a.customer_id,
a.subscriber_no,
a.subscriber_id,

a.robinson,
a.customer_robinson
from analytics.prod_abt_subscriber_current a
where a.robinson <> a.customer_robinson and a.subscriber_id = 11564299;

select first_name, last_business_name, adr_street_name, adr_house_no, customer_first_name, customer_last_business_name, customer_adr_street_name, customer_adr_house_no
from analytics.prod_abt_subscriber_current where subscriber_id = 11564299 and subscriber_no = 'GSM04560632047' and customer_id = 847689809;

--Husarvej 4, 1. tv.
select * from base.manual_files_base_robinson where street like 'Rougsøvej 61';

select * from base.manual_files_base_robinson where street like 'Husarvej 4';

select call_month, subscriber_no, ban, count(*) from work.gruppetrafik_work_gruppe_traffic
where start_date is not null
group by call_month, subscriber_no, ban
having count(*) > 1;
;

select call_month, subscriber_no, ban, start_date, end_date 
from work.gruppetrafik_work_gruppe_traffic where subscriber_no = 'GSM04521799506' and ban = 340875608 and call_month = to_timestamp('2017-11-01', 'yyyy-MM-dd');

select call_month, subscriber_no, ban
from base.gruppetrafik_work_detail_usage_groupped where subscriber_no = 'GSM04521799506' and ban = 340875608 and call_month = to_timestamp('2017-11-01', 'yyyy-MM-dd');

select *
from base.gruppetrafik_work_detail_usage_groupped where subscriber_no = 'GSM04521799506' and ban = 340875608 and call_month = to_timestamp('2017-11-01', 'yyyy-MM-dd')
order by at_soc, price_plan_code, call_type, at_feature_code
;

select *
from work.gruppetrafik_work_gruppe_traffic where subscriber_no = 'GSM04521799506' and ban = 340875608 and call_month = to_timestamp('2017-11-01', 'yyyy-MM-dd')
order by at_soc, price_plan_code, call_type, at_feature_code
;

select ban, root_ban, cycle_run_year, cycle_run_month, at_feature_code, subscriber_no, ri_carrier, country_code, call_type, price_plan_code, at_soc, unit_measure_code, call_month, count(*)
from work.gruppetrafik_work_gruppe_traffic
group by ban, root_ban, cycle_run_year, cycle_run_month, at_feature_code, subscriber_no, ri_carrier, country_code, call_type, price_plan_code, at_soc, unit_measure_code, call_month
having count(*) > 1;

select * from work.gruppetrafik_work_gruppe_traffic where ban = 444485601 and cycle_run_year = 2019 and at_feature_code = 'MGPRNO' and subscriber_no = 'GSM04528301567' and ri_carrier =  24202
and call_type = 'R' and price_plan_code = 'NBMA11' and call_month = to_timestamp('2019-01-01', 'yyyy-MM-dd');

select * from work.gruppetrafik_work_detail_usage_group where ban = 444485601 and cycle_run_year = 2019 and at_feature_code = 'MGPRNO' and subscriber_no = 'GSM04528301567' and ri_carrier =  24202
and call_type = 'R' and price_plan_code = 'NBMA11' and call_month = to_timestamp('2019-01-01', 'yyyy-MM-dd');

select * from work.gruppetrafik_work_feature_bill_charge where feature_code = 'MGPRNO';

select * from work.gruppetrafik_work_feature_bill_category_prep where feature_category = 'MGIR';