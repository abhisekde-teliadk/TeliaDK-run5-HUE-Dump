select * from sandbox.abt_churn_kpi_churn_enrich_joined_prepared_prepared
where product_subgroup != product_subgroup_abt
;

--2180

--2. GSM04551898751 & GSM04526595714 is churnet from 4everything light (2018.01) but do not apppear in the churn KPI

select * from analytics.abt_churn_kpi where subscriber_no = 'GSM04551898751';



select * from analytics.abt_churn_kpi where subscriber_no = 'GSM04526595714';

select * from work.base_equation_sub_tbt_subscriber_history where subscriber_no = 'GSM04551898751';

--bereme posledni s vyplnenym churn datem - ztrati se to uprosted
select * from work.base_equation_sub_tbt_subscriber_history where subscriber_id = 14685346;

select * from work.base_equation_sub_work_subscriber_churn_date where subscriber_id = 14685346;

select * from work.base_equation_sub_tbt_subscriber_history where subscriber_no = 'GSM04551898751';

select * from temp.base_equation_sub_tmp_subscriber_history where subscriber_id = 14685346;

select * from work.base_equation_kpis_work_subscriber_history_last_sub_id where subscriber_no = 'GSM04551898751'; 

select * from work.base_equation_kpis_work_subscriber_history_last_sub_id where subscriber_no = 'GSM04526595714'; 

select * from work.base_equation_kpis_work_subscriber_history_last_sub_id where subscriber_id = 14685346;

select * from work.base_equation_kpis_work_subscriber_history_last_sub_id where subscriber_id = 7804792;

select count(*) from (
select subscriber_id, count(*) from work.base_equation_kpis_work_subscriber_history_last_sub_id
where churn_date >= to_timestamp('2018-01-01', 'yyyy-MM-dd')
group by subscriber_id
having count(*) > 1)x;

--case z mailu
select * from work.base_equation_sub_tbt_subscriber_history where Subscriber_no = 'GSM04552157502' and subscriber_id = 14013868;

select distinct fokus_status from work.base_equation_sub_tbt_subscriber_history;

select * from analytics.prod_abt_churn_kpi where subscriber_no = 'GSM04560725090';

select * from work.base_equation_product_work_subscribed_product_id where subscriber_no = 'GSM04560725090' and ban = 698122116 and subscriber_id = 14887653;;

select * from work.base_equation_product_tbt_subscribed_product_history where subscriber_no = 'GSM04560725090' and ban = 698122116 and subscriber_id = 14887653;;


select * from work.base_equation_kpis_tbt_churn_kpi where subscriber_no = 'GSM04560725090' and customer_id = 698122116 and subscriber_id = 14887653;;;

select * from work.base_equation_product_tbt_product where product_id = 'b18d2442b423d6445c5f435fe3a52598';

select * from work.base_equation_kpis_work_subscribed_product_rank where subscriber_no = 'GSM04560725090' and ban = 698122116; 

select * from work.base_equation_kpis_work_subscribed_product_w_date_last where subscriber_no = 'GSM04560725090' and ban = 698122116 and subscriber_id = 14887653;;;

select * from work.base_equation_sub_tbt_subscriber_history where subscriber_no = 'GSM04560725090' and customer_id = 698122116;

--b04711341add3bc08444b1f981c374d7

select * from work.base_equation_kpis_work_subscriber_history_last_sub_id where subscriber_no = 'GSM04560725090' and customer_id = 698122116; 

select * from work.base_equation_sub_tbt_subscriber_history where Subscriber_no = 'GSM04560725090' and customer_id = 698122116;

select * from work.base_equation_kpis_work_churn_and_products where subscriber_no = 'GSM04560725090' and customer_id = 698122116;

select subscriber_no, customer_id, churn_date, product_id, count(*) 
from work.base_equation_kpis_work_churn_and_products
group by  subscriber_no, customer_id, churn_date, product_id
having count(*) > 1;

select subscriber_no, customer_id, count(*) 
from work.base_equation_kpis_work_churn_last_product
group by  subscriber_no, customer_id
having count(*) > 1;

select * from work.base_equation_kpis_work_churn_and_products where subscriber_no = 'GSM04561626772' and 
customer_id = 827370016
and churn_date = to_timestamp('2019-02-25', 'yyyy-MM-dd');

select * from work.base_equation_kpis_work_churn_last_product where subscriber_no = 'GSM04525710635'
and customer_id = 360646608;

select count(*) from work.base_equation_kpis_tbt_churn_kpi where product_id is null; --11152

select count(*) from work.base_equation_kpis_work_churn_last_product where product_id is null;

--zaklad investigace - predtim byl produkt a ted neni
select a.subscriber_no, a.customer_id, a.churn_date, a.product_id,
b.subscriber_no, b.customer_id, b.churn_date, b.product_id
from work.base_equation_kpis_tbt_churn_kpi a
left outer join 
work.base_equation_kpis_work_churn_last_product b 
on 
a.subscriber_no = b.subscriber_no and
a.customer_id = b.customer_id and
a.churn_date = b.churn_date
where b.product_id is null and a.product_id is not null and b.subscriber_no is not null and a.subscriber_no like 'GSM%'
order by a.churn_date desc;

select count(*) from (
select a.subscriber_no tbt_sub_no, a.customer_id tbt_cust_id, a.churn_date tbt_churn_date, a.product_id tbt_product_id,
b.subscriber_no, b.customer_id, b.churn_date, b.product_id
from work.base_equation_kpis_tbt_churn_kpi a
left outer join 
work.base_equation_kpis_work_churn_last_product b 
on 
a.subscriber_no = b.subscriber_no and
a.customer_id = b.customer_id and
a.churn_date = b.churn_date
where b.product_id != a.product_id
--where b.product_id is null and a.product_id is not null
and b.subscriber_no is not null) x;
--28084 zaznamu ma jiny produkt
--198331 zaznamu ted produkt nema i kdyz ho predtim mela

------------------------------------------------------------------------------------------------------------------
--case #1: pomotane s domotany subscriber_history - jedno cislo se tvari ze je najednou pod dvemi bany
select * from work.base_equation_kpis_work_subscribed_product_rank
where subscriber_no = 'GSM04520103497' and ban = 510819907; --2016/06/21

select * from work.base_equation_kpis_tbt_churn_kpi where subscriber_no = 'GSM04520103497' and customer_id = 510819907;
--fa10e50272874ef1d1d130b53c641a7d

select * from work.base_equation_kpis_work_churn_and_products where subscriber_no = 'GSM04520103497' and 
customer_id = 510819907;

select * from work.base_equation_kpis_work_subscriber_history_last_sub_id where subscriber_no = 'GSM04520103497' and customer_id = 510819907; 
--f30705181d6273776f9ef406dc4f4cf6

select * from work.base_equation_sub_tbt_subscriber_history where 
subscriber_no = 'GSM04520103497' and 
customer_id = 510819907;

select start_date, end_date, subscriber_no, customer_id, from_product_id, product_id from 
work.base_equation_sub_tbt_subscriber_history where 
subscriber_no = 'GSM04520103497' and 
customer_id = 510819907;

--domotany subscriber_history - jedno cislo se tvari ze je najednou pod dvemi bany
select * from work.base_equation_sub_tbt_subscriber_history where 
subscriber_id = 12990753;

select start_date, end_date, subscriber_no, customer_id, from_product_id, product_id from work.base_equation_sub_tbt_subscriber_history where 
subscriber_id = 12990753;

select * from work.base_equation_sub_work_subscriber_history_all 
where 
s_status_subscriber_no = 'GSM04520103497' and 
s_customer_id = 510819907; --product_id = null, start_date = 2016-06-21 >= effective_id, subscriber_id = 12990753

select * from work.base_equation_product_tbt_subscribed_product where subscriber_id = 12990753;
--pro previous product vybere f30705181d6273776f9ef406dc4f4cf6

select * from work.base_equation_sub_work_subscriber_previous_product
where 
s_status_subscriber_no = 'GSM04520103497' and 
s_customer_id = 510819907;


------------------------------------------------------------------------------------------------------------------
--case #2

select * from work.base_equation_kpis_work_subscribed_product_rank
where subscriber_no = 'GSM04550184153' and ban = 533389011; 
--246b91155c282f6e56f4fa0b6c44a121

select * from work.base_equation_kpis_work_subscriber_history_last_sub_id where 
subscriber_no = 'GSM04550184153' and customer_id = 533389011;
--1de54861ba4abbd2e50543812786adc2

select * from work.base_equation_kpis_tbt_churn_kpi where subscriber_no = 'GSM04550184153' and customer_id = 533389011;
--246b91155c282f6e56f4fa0b6c44a121

select * from work.base_equation_sub_tbt_subscriber_history where 
subscriber_no = 'GSM04550184153' and 
customer_id = 533389011;

select * from work.base_equation_sub_work_subscriber_churn_date where subscriber_id = 14630601;

select * from work.base_equation_sub_tbt_subscriber_history where 
subscriber_id = 14630601;

select churn_date, product_price, product_life_time, subscriber_gender, subscriber_age, adr_city, activation_date subscriber_activation_date from analytics.prod_abt_churn_kpi where product_line = 'Mobile' and product_subgroup like '%BtC%' and churn_date >= to_timestamp('2018-01-01', 'yyyy-MM-dd')
and churn_date <= to_timestamp('2018-06-01', 'yyyy-MM-dd') and subscriber_gender is not null;


select * from analytics.prod_abt_churn_kpi where product_line = 'Mobile' and product_subgroup like '%BtC%' and churn_date >= to_timestamp('2018-01-01', 'yyyy-MM-dd')
and churn_date <= to_timestamp('2018-06-01', 'yyyy-MM-dd') and subscriber_gender is not null;

select count(*) from analytics.abt_subscriber_history where birth_date is not null; 

select count(*) from analytics.abt_customer_history where gender is not null;


5 239 546
4 985 796
;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--18/04/2019
select * from work.base_equation_kpis_work_max_churned_product where subscriber_no = 'GSM04560725090';;

select * from work.base_equation_kpis_work_churn_kpi_fat where subscriber_no = 'GSM04560725090';;

select * from work.base_equation_sub_tbt_subscriber_history where subscriber_no = 'GSM04560725090' and churn_date is not null;;

select start_date, end_date, subscriber_id, subscriber_no, customer_id, fokus_status, s_sub_status_date, churn_date_rank 
from work.base_equation_sub_work_subscriber_churn_date where /*subscriber_no = 'GSM04560725090'*/ subscriber_id = 14887653
order by end_date desc, case when fokus_status = 'C' then 0 else 1 end desc, s_sub_status_date desc
;



select * from work.base_equation_kpis_work_churn_kpi_fat;

select * from work.base_equation_kpis_work_churn_kpi_fat where subscriber_no = 'GSM04552390634';;

select start_date, end_date, subscriber_id, subscriber_no, customer_id, churn_date from analytics.abt_subscriber_history where subscriber_no in ('GSM04552390634','GSM04560725090')  and subscriber_id = 14887653;;


select count(*) from sandbox.sandbox_sobotik_sb_churn_subid where churn_date >= to_timestamp('2018-01-01', 'yyyy-MM-dd') and sub_subscriber_id is null; 
--18360

select * from work.base_equation_product_tbt_product where product_id = 'b04711341add3bc08444b1f981c374d7';

1147206
18360

GSM04551898751 & GSM04526595714; 

select * from work.base_equation_kpis_work_max_churned_product where subscriber_no = 'GSM04526595714';;


select * from analytics.abt_subscriber_history where customer_id = 100100296;

select * from analytics.abt_subscriber_history where customer_id = 931238018;

select customer_id, customer_start_date, count(subscriber_no) from analytics.abt_subscriber_history group by customer_id, customer_start_date;

select * from analytics.abt_customer_history where customer_id = 803703115;

select * from analytics.abt_subscriber_history where customer_id = 803703115;

select * from sandbox.sandbox_sobotik_sb_ban_size where customer_id = 954138608;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--23/4/2019
select count(*) from work.base_equation_kpis_work_max_churned_product; 
--4959602
--5239546

--co chybi v novem
select a.subscriber_id, a.subscriber_no, a.customer_id, a.churn_date, a.product_id, 
b.subscriber_id, b.subscriber_no, b.customer_id, b.churn_date, b.product_id 
from 
(select subscriber_id, subscriber_no, customer_id, churn_date, product_id from work.base_equation_kpis_work_churn_kpi_fat) a
left outer join
(select subscriber_id, subscriber_no, customer_id, churn_date, product_id from work.base_equation_kpis_work_max_churned_product) b
on 
a.subscriber_id = b.subscriber_id and
a.subscriber_no = b.subscriber_no and
a.customer_id = b.customer_id and
a.churn_date = b. churn_date and
a.product_id = b.product_id
where
b.subscriber_id is null and a.subscriber_no like 'GSM%';

select * from work.base_equation_kpis_work_churn_kpi_fat
where subscriber_id = 15492176 and subscriber_no = 'GSM04520283759' and customer_id = 462365115;

select subscriber_id, subscriber_no, customer_id, churn_date, product_id from work.base_equation_kpis_work_churn_kpi_fat
where subscriber_id = 15492176 and subscriber_no = 'GSM04520283759' and customer_id = 462365115;

select * from work.base_equation_kpis_work_churn_with_product
where subscriber_id = 15492176 and subscriber_no = 'GSM04520283759' and customer_id = 462365115;
;

select * from work.base_equation_kpis_work_max_churned_product
where subscriber_id = 15492176 and subscriber_no = 'GSM04520283759' and customer_id = 462365115;

select * from work.base_equation_sub_tbt_subscriber_history 
where subscriber_id = 15492176 and subscriber_no = 'GSM04520283759' and customer_id = 462365115;

select * from work.base_equation_sub_work_subscriber_churn_date
where subscriber_id = 15492176 and subscriber_no = 'GSM04520283759' and customer_id = 462365115;
;

select start_date, end_date, subscriber_id, subscriber_no, customer_id, status, case when status = 'C' then 0 else 1 end sub_status_rank, act_date, 
s_sub_status_date, churn_date_rank from work.base_equation_sub_work_subscriber_churn_date
where 
--subscriber_id = 13872022 /*and 
subscriber_no = 'GSM04526127590' --and 
--customer_id = 462365115*/;
;
--GSM04526127590	13872022	952355014
--GSM04526127590



select * from sandbox.sandbox_sobotik_sb_churn_subid where 
 subscriber_id = 13872022;
churn_date >= to_timestamp('2018-01-01', 'yyyy-MM-dd') and sub_subscriber_id is null; 

select * from sandbox.ABT_CHURN_KPI_Churn_enrich where subscriber_id = 13244115;

select * from sandbox.sandbox_sobotik_sb_churn_verification; 

select count(*) from sandbox.sandbox_sobotik_sb_churn_verification where churn_date >= to_timestamp('2018-01-01', 'yyyy-MM-dd') and dm_subscriber_id is null; 

select count(*) from sandbox.sandbox_sobotik_sb_churn_ver2 where churn_date >= to_timestamp('2018-01-01', 'yyyy-MM-dd') and dm_subscriber_id is null; 


select count(*) from sandbox.ABT_CHURN_KPI_Churn_enrich a
left outer join
work.base_equation_kpis_work_max_churned_product b 
on
a.subscriber_id = b.subscriber_id and
to_timestamp(a.churn_date, 'yyyy-MM-dd') = b.churn_date
where b.subscriber_id is null;

select * from work.base_equation_kpis_tbt_churn_kpi;

select * from work.base_equation_kpis_work_churn_with_product;

SELECT subscriber_id, customer_id, subscriber_no, churn_date, count(*) AS pk_count
FROM work.base_equation_kpis_tbt_churn_kpi
GROUP BY subscriber_id, customer_id, subscriber_no, churn_date
having count(*) > 1;

select * from work.base_equation_kpis_tbt_churn_kpi where subscriber_id = 7629262 and customer_id = 662426113  and subscriber_no =  'GSM04527854068';

select * from work.base_equation_kpis_work_churn_with_product where subscriber_id = 246932 and customer_id = 662426113  and subscriber_no =  'GSM04527854068';

select * from work.base_equation_product_tbt_subscribed_product_history where subscriber_no = 'GSM04527854068' and ban = 662426113 and subscriber_id = 7629262;

select * from work.base_equation_kpis_work_subscribed_product_rank where subscriber_no = 'GSM04527854068' and ban = 662426113 and subscriber_id = 7629262;

select * from work.base_equation_kpis_work_subscribed_product_rank where subscriber_id = 246932 and effective_date <= to_timestamp('2018-07-02', 'yyyy-MM-dd');

select * from work.base_equation_product_tbt_subscribed_product_history where subscriber_id = 7629262;

select * from work.base_equation_product_work_subscribed_product_id where subscriber_id = 246932;

select * from work.base_equation_product_work_subscribed_product_id where subscriber_id = 15601974;

select * from work.base_equation_sub_tbt_subscriber_history where subscriber_id = 246932  and churn_date is not null;

select * from base.import_fokus_base_service_agreement where subscriber_no in ('GSM04560378271', 'GSM04526116284') and service_type in ('P', 'M', 'N');

select ban, subscriber_no, soc, soc_seq_no, sys_creation_date, effective_date, expiration_date from base.import_fokus_base_service_agreement where subscriber_no in ('GSM04526832426') and service_type in ('P', 'M', 'N');

select * from work.base_equation_product_work_service_agreement_subscr_dedup where subscriber_no in ('GSM04560378271');

--16239019

select subscriber_id, effective_date, count(*) from work.base_equation_product_work_service_agreement_subscr_dedup group by subscriber_id, effective_date
having count(*) > 1;

select * from work.base_equation_product_work_service_agreement_subscr_dedup where subscriber_id = 16024367;

select * from work.base_equation_product_work_max_subscribed_product where subscriber_id = 16239019;

select subscriber_id, effective_date, count(*) from work.base_equation_product_work_max_subscribed_product group by subscriber_id, effective_date
having count(*) > 1;

select * from work.base_equation_kpis_work_subscribed_product_rank where subscriber_id = 246932; 

select subscriber_id, subscriber_no, customer_id, churn_date, status_reason, first_dealer_code, dealer_code, * from work.base_equation_sub_tbt_subscriber_history where subscriber_id = 246932  and churn_date is not null;

select * from work.base_equation_kpis_work_churn_with_product where subscriber_id = 246932;

select status_reason, * from work.base_equation_sub_work_subscriber_churn_date where subscriber_id = 246932 and s_sub_status_date = to_timestamp ('2003-09-01', 'yyyy-MM-dd');

select * from base.import_fokus_base_subscriber where subscriber_id = 246932;

select * from base.import_fokus_base_subscriber_history where subscriber_id = 246932 and sub_status = 'C';

select * from temp.base_equation_sub_tmp_subscriber_history where subscriber_id = 246932 and sub_status = 'C';

select count(*) from sandbox.sandbox_sobotik_sb_final_dev_churn_check where abt_subscriber_id is null;

select * from analytics.abt_churn_kpi where subscriber_no in ('GSM04551898751', 'GSM04526595714');

select annulment_flag, count(*) from work.base_equation_kpis_work_churn_with_product group by annulment_flag;

select distinct annulment_flag from work.base_equation_kpis_tbt_churn_kpi; 

select * from sandbox.sandbox_sobotik_sb_final_dev_churn_check where abt_subscriber_id is null;

select count(*) from sandbox.sandbox_sobotik_sb_churn_ver2 where dm_subscriber_id is null;

select * from work.base_equation_kpis_work_churn_with_product where subscriber_id = 14145164;

select * from work.base_equation_kpis_work_churn_with_product 
where subscriber_id in (select subscriber_id from sandbox.sandbox_sobotik_sb_final_dev_churn_check where abt_subscriber_id is null)
and annulment_flag = true;

--case na annulmenty popsat Krystianovi do ticketu
select * from sandbox.sandbox_sobotik_sb_final_dev_churn_check where subscriber_id = 7229903;

select * from work.base_equation_kpis_work_churn_with_product where subscriber_id = 7229903;

select churn_date, act_date, * from work.base_equation_sub_tbt_subscriber_history where subscriber_id = 7229903 and churn_date is not null;

---------------

select * from sandbox.sandbox_sobotik_sb_final_dev_churn_check where subscriber_id = 11117413;

select * from work.base_equation_kpis_work_churn_with_product where subscriber_id = 11117413;

select churn_date, act_date, * from work.base_equation_sub_tbt_subscriber_history where subscriber_id = 11117413 and churn_date is not null;

--11117413


select * from work.base_equation_kpis_tbt_churn_kpi where subscriber_no in ( 'GSM04551898751', 'GSM04526595714' ) ;

select * from work. base_equation_kpis_work_churn_with_product where subscriber_no in ( 'GSM04551898751', 'GSM04526595714' ) ; 

select * from work.base_equation_product_tbt_product where product_id = 'b04711341add3bc08444b1f981c374d7';


--
select * from analytics.abt_subscriber_history where ((product_product_type = 'GSM' and product_product_line = 'Mobile' and product_product_group like '%BtC%') or 
(from_product_product_type = 'GSM' and from_product_product_line = 'Mobile' and from_product_product_group like '%BtC%')) and
 (
    (start_date <= to_timestamp('2018-01-01', 'yyyy-MM-dd') and end_date >= to_timestamp('2018-01-01', 'yyyy-MM-dd') and  end_date <= to_timestamp('2018-07-01', 'yyyy-MM-dd')) or 
    (start_date >= to_timestamp('2018-01-01', 'yyyy-MM-dd') and start_date <= to_timestamp('2018-07-01', 'yyyy-MM-dd'))
)
and subscriber_no = 'GSM04527123759' and customer_id = 388650707
;

select * from
(select * from analytics.abt_subscriber_history where product_product_type = 'GSM' and product_product_line = 'Mobile' and product_product_group like '%BtC%'
and (
    (start_date <= to_timestamp('2018-01-01', 'yyyy-MM-dd') and end_date >= to_timestamp('2018-01-01', 'yyyy-MM-dd') and  end_date <= to_timestamp('2018-07-01', 'yyyy-MM-dd')) or 
    (start_date >= to_timestamp('2018-01-01', 'yyyy-MM-dd') and start_date <= to_timestamp('2018-07-01', 'yyyy-MM-dd'))
)) A
left outer join
(
select * from analytics.abt_churn_kpi where product_line = 'Mobile' and 
    product_subgroup like '%BtC%' and 
    churn_date >= to_timestamp('2018-01-01', 'yyyy-MM-dd') and
    churn_date <= to_timestamp('2018-06-01', 'yyyy-MM-dd')
) B
on 
 a.customer_id = b.customer_id and
 a.subscriber_no = b.subscriber_no and
 a.start_date <= b.churn_date and
 a.end_date > = b.churn_date 
where b.churn_date is not null;


select * from analytics.abt_churn_kpi where product_line = 'Mobile' and 
    product_subgroup like '%BtC%' and 
    churn_date >= to_timestamp('2018-01-01', 'yyyy-MM-dd') and
    churn_date <= to_timestamp('2018-06-01', 'yyyy-MM-dd');
    
388650707
GSM04527123759
;
select * from analytics.abt_subscriber_history where subscriber_no = 'GSM04527123759' and customer_id = 388650707;

select count(*) from sandbox.sandbox_sobotik_sb_churn_and_customer where churn_date is not null;--ok