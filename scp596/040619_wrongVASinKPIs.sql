Select 

kpi.subscriber_id, 

kpi.customer_id, 

kpi.subscriber_no, 

kpi.churn_date, 

kpi.vas_soc_spotify as_is, 

sf.soc to_be 

from 

analytics.abt_churn_kpi as kpi 

left outer join ( 

    select 

    sa.ban, 

    sa.subscriber_no, 

    sa.soc, 

    sa.service_type, 

    sa.effective_date, 

    sa.expiration_date 

    from 

    base.import_fokus_base_service_agreement sa 

    join base.manual_files_base_man_soc_groups sg on 

        sg.soc_group = 'Spotify' and 

        sg.soc = sa.soc 

) sf on 

    sf.ban = kpi.customer_id and 

    sf.subscriber_no = kpi.subscriber_no and 

    kpi.churn_date between sf.effective_date and nvl(sf.expiration_date, kpi.churn_date) 

where 

kpi.subscriber_id in  

    (763792, 875476, 9203501, 10601861, 11690468, 11713600, 12459532, 15389328,  

    15711933, 15965315, 8486855, 12063591, 12469595, 16070333, 16087589, 16116411); 
    
    /*
    8486855	806946604	GSM04528880866	2019-05-06 00:00:00	NULL	OSBSF2
    */
    
select * from work.vasdata_tbt_service_history where subscriber_no = 'GSM04528880866'
and customer_id = 806946604;

select * from base.manual_files_base_man_soc_groups;

select effective_date, expiration_date, * from base.import_fokus_base_service_agreement
where subscriber_no = 'GSM04528880866'
and customer_id = 806946604
and soc = 'OSBSF2'
and service_type in ('R', 'O', 'S');

select * from work.vasdata_work_service_type_ros
where subscriber_no = 'GSM04528880866'
and customer_id = 806946604
and soc = 'OSBSF2';

select * from work.base_equation_product_work_soc_change where change_soc = 'OSBSF2';

--change entita: 3 radky
select * from work.vasdata_work_service_change where soc  = 'OSBSF2'
and subscriber_no = 'GSM04528880866'
and customer_id = 806946604
;

select * from work.vasdata_work_service_change_rate_joined where soc  = 'OSBSF2'
and subscriber_no = 'GSM04528880866'
and customer_id = 806946604
;

select * from work.vasdata_work_service_rate 
where soc  = 'OSBSF2'
and subscriber_no = 'GSM04528880866'
and customer_id = 806946604
;

select * from work.vasdata_work_service_rate_sum 
where soc  = 'OSBSF2'
/*and subscriber_no = 'GSM04528880866'
and customer_id = 806946604*/
;

select * from work.vasdata_work_service_change_lead 
where soc  = 'OSBSF2'
and subscriber_no = 'GSM04528880866'
and customer_id = 806946604
;

select * from work.vasdata_work_service_change_lead_prepared 
where soc  = 'OSBSF2'
and subscriber_no = 'GSM04528880866'
and customer_id = 806946604
;

select * from work.vasdata_work_service_change_agreement_joined 
where soc  = 'OSBSF2'
and subscriber_no = 'GSM04528880866'
and customer_id = 806946604;


set request_pool=big;

SELECT DISTINCT 
            soc, subscriber_no, customer_id,
            trunc(change_date,'DD') + interval 1 day - interval 2 second as change_date 
        FROM
            /* - service_agreement changes */
            (SELECT soc, subscriber_no, customer_id, effective_date as change_date
             FROM base.import_fokus_base_service_agreement 
             WHERE service_type IN ('R', 'O', 'S')
            and soc  = 'OSBSF2'
            and subscriber_no = 'GSM04528880866'
            and customer_id = 806946604
             
             UNION
             
             SELECT soc, subscriber_no, customer_id,
             CASE 
                  WHEN expiration_date is null THEN CAST('9999-12-31' as timestamp) 
                  WHEN expiration_date = CAST('9999-12-31' as timestamp) THEN CAST(expiration_date as timestamp)
             ELSE
                  CAST(expiration_date as timestamp) + interval 1 day
             END as change_date
             FROM base.import_fokus_base_service_agreement 
             WHERE service_type IN ('R', 'O', 'S')
              and soc  = 'OSBSF2'
              and subscriber_no = 'GSM04528880866'
              and customer_id = 806946604
             
             /* - Subscribed product changes revised 9.1.*/
             UNION
            
             SELECT sa.soc, sa.subscriber_no, sa.ban, sp.effective_date as change_date
             FROM work.base_equation_product_tbt_subscribed_product as sp
             INNER JOIN base.import_fokus_base_service_agreement AS sa
             ON sa.subscriber_no = sp.subscriber_no
             AND sa.ban = sp.ban
             WHERE sp.effective_date BETWEEN sa.effective_date AND sa.expiration_date
             AND sa.service_type IN ('R', 'O', 'S')
              and sa.soc  = 'OSBSF2'
              and sa.subscriber_no = 'GSM04528880866'
              and sa.customer_id = 806946604
             
             UNION
            
             SELECT sa.soc, sa.subscriber_no, sa.ban, 
             CASE 
                  WHEN sp.expiration_date is null THEN CAST('9999-12-31' as timestamp) 
                  WHEN sp.expiration_date = CAST('9999-12-31' as timestamp) THEN CAST(sp.expiration_date as timestamp)
             ELSE
                  CAST(sp.expiration_date as timestamp) + interval 1 day
             END as change_date
             FROM work.base_equation_product_tbt_subscribed_product as sp
             INNER JOIN base.import_fokus_base_service_agreement AS sa
             ON sa.subscriber_no = sp.subscriber_no
             AND sa.ban = sp.ban
             WHERE sp.expiration_date BETWEEN sa.effective_date AND sa.expiration_date
             AND sa.service_type IN ('R', 'O', 'S')
              and sa.soc  = 'OSBSF2'
            and sa.subscriber_no = 'GSM04528880866'
            and sa.customer_id = 806946604
             
             /* - VAS price changes revised 9.1.*/
             
             UNION
             
             SELECT soc, subscriber_no, ban, effective_date as change_date
             FROM work.vasdata_work_service_type_ros_effective_date
            where soc  = 'OSBSF2'
            and subscriber_no = 'GSM04528880866'
            and customer_id = 806946604
             
             /*
             SELECT sa.soc, sa.subscriber_no, sa.ban, pp.effective_date as change_date
             FROM base.import_fokus_base_pp_rc_rate as pp
             INNER JOIN base.import_fokus_base_service_agreement AS sa
             ON sa.soc = pp.soc
             WHERE pp.effective_date BETWEEN sa.effective_date AND sa.expiration_date
             AND sa.service_type IN ('R', 'O', 'S')
             */
             
             UNION
             
             SELECT soc, subscriber_no, ban,  
             CASE 
                  WHEN expiration_date is null THEN CAST('9999-12-31' as timestamp) 
                  WHEN expiration_date = CAST('9999-12-31' as timestamp) THEN CAST(expiration_date as timestamp)
             ELSE
                  CAST(expiration_date as timestamp) + interval 1 day
             END as change_date
             FROM work.vasdata_work_service_type_ros_expiration_date
             where soc  = 'OSBSF2'
            and subscriber_no = 'GSM04528880866'
            and customer_id = 806946604
             
             /*
             SELECT sa.soc, sa.subscriber_no, sa.ban,  
             CASE 
                  WHEN pp.expiration_date is null THEN CAST('9999-12-31' as timestamp) 
                  WHEN pp.expiration_date = CAST('9999-12-31' as timestamp) THEN CAST(pp.expiration_date as timestamp)
             ELSE
                  CAST(pp.expiration_date as timestamp) + interval 1 day
             END as change_date
             FROM base.import_fokus_base_pp_rc_rate as pp
             INNER JOIN base.import_fokus_base_service_agreement AS sa
             ON sa.soc = pp.soc
             WHERE pp.expiration_date BETWEEN sa.effective_date AND sa.expiration_date
             AND sa.service_type IN ('R', 'O', 'S')
             */
            )X
where 
soc  = 'OSBSF2'
and subscriber_no = 'GSM04528880866'
and customer_id = 806946604;
/*WHERE change_date < CAST('9999-12-31' as timestamp)  */  

SELECT sa.soc, sa.subscriber_no, sa.ban, sp.effective_date as change_date
             FROM work.base_equation_product_tbt_subscribed_product as sp
             INNER JOIN base.import_fokus_base_service_agreement AS sa
             ON sa.subscriber_no = sp.subscriber_no
             AND sa.ban = sp.ban
             WHERE sp.effective_date BETWEEN sa.effective_date AND sa.expiration_date
             AND sa.service_type IN ('R', 'O', 'S')
            and sa.soc  = 'OSBSF2'
and sa.subscriber_no = 'GSM04528880866'
and sa.customer_id = 806946604;

   SELECT sa.soc, sa.subscriber_no, sa.ban, 
             CASE 
                  WHEN sp.expiration_date is null THEN CAST('9999-12-31' as timestamp) 
                  WHEN sp.expiration_date = CAST('9999-12-31' as timestamp) THEN CAST(sp.expiration_date as timestamp)
             ELSE
                  CAST(sp.expiration_date as timestamp) + interval 1 day
             END as change_date
             FROM work.base_equation_product_tbt_subscribed_product as sp
             INNER JOIN base.import_fokus_base_service_agreement AS sa
             ON sa.subscriber_no = sp.subscriber_no
             AND sa.ban = sp.ban
             WHERE sp.expiration_date BETWEEN sa.effective_date AND sa.expiration_date
             AND sa.service_type IN ('R', 'O', 'S')
                     and sa.soc  = 'OSBSF2'
and sa.subscriber_no = 'GSM04528880866'
and sa.customer_id = 806946604;

select sub_reason_desc, churn_reason_desc, sub_equation_group, equation_group, * from work.base_equation_kpis_fat_work_churn_fat;

select  

* 

from 

work.base_equation_product_work_service_agreement_subscr_joined x 

where 

x.ban = 100634763 and 

x.subscriber_no = 'GSM04528276703' 

order by 

effective_date; 

select * from work.base_equation_product_tbt_subscribed_product_history where subscriber_id = 39801;

select soc_seq_no, count(*) from base.import_fokus_base_service_agreement group by soc_seq_no having count(*) > 1;