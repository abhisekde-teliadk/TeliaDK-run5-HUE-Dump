SELECT 
    soc AS soc,
    effective_date AS effective_date,
    expiration_date AS expiration_date,
    subscriber_id AS subscriber_id,
    soc_description AS soc_description,
    vas_soc AS vas_soc,
    vas_soc_group AS vas_soc_group,
    date_as_date AS date_as_date,
    year AS year,
    month AS month,
    start_of_month AS start_of_month,
    end_of_month AS end_of_month,
    product_group AS product_group,
    service_name AS service_name,
    active_state AS active_state,
    bss_subscriber_id AS bss_subscriber_id,
    product_name AS product_name,
    deal AS deal,
    -- most will be N as there are few 0 and 4 active_state
case active_state
when 0 then 'Y'
when 2 then 'Y'
when 4 then 'Y'
else 'N'
end AS activated,
    case
 when deal like '%standalone%' then 'Standalone'
 when deal like '%hardbundle%' then 'Hardbundle'
 when deal like '%softbundle%' then 'Softbundle'
 else null
end  AS bundle_type
  FROM (
    SELECT 
        work_service_history_daily_join.soc AS soc,
        work_service_history_daily_join.effective_date AS effective_date,
        work_service_history_daily_join.expiration_date AS expiration_date,
        work_service_history_daily_join.subscriber_id AS subscriber_id,
        work_service_history_daily_join.soc_description AS soc_description,
        work_service_history_daily_join.vas_soc AS vas_soc,
        work_service_history_daily_join.vas_soc_group AS vas_soc_group,
        work_service_history_daily_join.date_as_date AS date_as_date,
        work_service_history_daily_join.year AS year,
        work_service_history_daily_join.month AS month,
        work_service_history_daily_join.start_of_month AS start_of_month,
        work_service_history_daily_join.end_of_month AS end_of_month,
        sp.product_group AS product_group,
        work_man_tertium_servicestatus_vw_last.service_name AS service_name,
        work_man_tertium_servicestatus_vw_last.active_state AS active_state,
        work_man_tertium_servicestatus_vw_last.bss_subscriber_id AS bss_subscriber_id,
        work_man_tertium_servicestatus_vw_last.product_name AS product_name,
        work_man_tertium_servicestatus_vw_last.deal AS deal
      FROM work.contr_obligations_vas_work_service_history_daily_join work_service_history_daily_join
      
      LEFT JOIN --work.base_equation_work_subscribed_product SP
      analytics.abt_subscribed_product_history sp
      ON work_service_history_daily_join.subscriber_no = sp.subscriber_no AND
      work_service_history_daily_join.ban = sp.ban AND
      work_service_history_daily_join.effective_date <= date_as_date and
      work_service_history_daily_join.expiration_date >= date_as_date
--LEFT JOIN work.base_equation_work_product P
  --    ON P.product_id = sp.product_id
      
--      INNER JOIN work.base_equation_work_subscriber work_subscriber
--        ON work_service_history_daily_join.subscriber_id = work_subscriber.subscriber_id
      LEFT JOIN work.contr_obligations_vas_work_man_tertium_servicestatus_vw_last work_man_tertium_servicestatus_vw_last
        ON (work_service_history_daily_join.soc = work_man_tertium_servicestatus_vw_last.product_name)
          AND (work_service_history_daily_join.subscriber_id = work_man_tertium_servicestatus_vw_last.bss_subscriber_id)
    ) res;
    

select te.bss_subscriber_id, te.product_name, te.active_state from base.import_other_sources_base_tertium_servicestatus_vw te
join base.import_other_sources_base_tertium_servicestatus_vw te2
on te.bss_subscriber_id=te2.bss_subscriber_id
and te.product_name=te2.product_name
where te.creation_date > to_date('2018-01-01')
--and te.bss_subscriber_id=14634083
and te.creation_date!=te2.creation_date

order by te.bss_subscriber_id desc
;

-- example of the one wrong calculated ID
select * from base.import_other_sources_base_tertium_servicestatus_vw where bss_subscriber_id=976579 and product_name like 'SFBTC3%' order by creation_date;

select * from work.contr_obligations_vas_work_man_tertium_servicestatus_vw_last where bss_subscriber_id=976579 and product_name like 'SFBTC3%';
select * from work.contr_obligations_vas_work_tertium_servicestatus_vw_end_date where bss_subscriber_id=976579 and product_name like 'SFBTC3%';

select count(*) from work.contr_obligations_vas_work_tertium_servicestatus_vw_null_end_date where end_date is null;


select * from analytics.abt_subscribed_product_history;

-- prepared
select * from work.contr_obligations_vas_work_vas_overview_prepared
where bss_subscriber_id=976579 
and vas_soc like 'SFBTC3%'
--and date_as_date between to_date('2018-04-02') and to_date('2018-05-03')
order by date_as_date asc
; 

-- daily
select * from work.contr_obligations_vas_work_vas_overview_daily
where 
date_as_date between to_date('2018-05-02') and to_date('2018-05-03')
and vas_soc='SFBTC3' 
order by date_as_date asc
;

select date_as_date, count(*) from work.contr_obligations_vas_work_vas_overview_prepared
where /*product_name*/vas_soc = 'SFBTC3'
and date_as_date between to_date('2018-05-02') and to_date('2018-05-03')
group by date_as_date
;
-- 3.5. = 6058
-- 2.5. = 5946 

select count(*) FROM contr_obligations_vas_work_vas_overview_prepared
where  date_as_date=to_date('2018-05-02') and vas_soc='SFBTC3'; -- 5946 => OK

select * FROM contr_obligations_vas_work_vas_overview_prepared
where  date_as_date=to_date('2018-05-02') and vas_soc='SFBTC3';

-- subscriber from service_history table including effective and expired date
select * from work.contr_obligations_vas_work_service_history_soc_join where soc='SFBTC3' and subscriber_id=976579 ;

select * from work.contr_obligations_vas_work_service_history_soc_join where soc='SFBTC3' and expiration_date=to_date('2018-05-03');

