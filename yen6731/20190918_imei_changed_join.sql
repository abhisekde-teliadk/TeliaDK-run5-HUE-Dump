SELECT 
    tbt_subscriber_imei_history.start_date AS start_date,
    tbt_subscriber_imei_history.tac AS tac,
    tbt_subscriber_imei_history.prev_tac AS prev_tac,
    tbt_subscriber_imei_history.msisdn AS msisdn,
    tbt_subscriber_imei_history.imei14 AS imei14,
    tbt_subscriber_imei_history.prev_imei14 AS prev_imei14,
    tbt_subscriber_imei_history.end_date AS end_date,
    tbt_subscriber_imei_history.active_record_flag AS active_record_flag,
    tbt_subscriber_imei_history.subscriber_id AS subscriber_id,
    tbt_subscriber_imei_history.source AS source,
    abt_subscriber_history.subscriber_no AS subscriber_no,
    abt_subscriber_history.customer_id AS customer_id
  FROM (
    SELECT 
        customer_id AS customer_id,
        subscriber_no AS subscriber_no,
        start_date AS start_date,
        tac AS tac,
        prev_tac AS prev_tac,
        msisdn AS msisdn,
        imei14 AS imei14,
        prev_imei14 AS prev_imei14,
        end_date AS end_date,
        active_record_flag AS active_record_flag,
        subscriber_id AS subscriber_id,
        source AS source
        --least(now(),date_trunc(end_date,'dd')) AS lowest_date
      FROM (
        SELECT *
          FROM work.base_equation_other_tbt_subscriber_imei_history tbt_subscriber_imei_history
        ) withoutcomputedcols_query
    ) tbt_subscriber_imei_history
  LEFT JOIN analytics.abt_subscriber_history
    ON (tbt_subscriber_imei_history.start_date >= abt_subscriber_history.start_date)
    --ON (trunc(tbt_subscriber_imei_history.start_date,'dd') >= abt_subscriber_history.start_date)
      AND (tbt_subscriber_imei_history.subscriber_id = abt_subscriber_history.subscriber_id)
      AND (tbt_subscriber_imei_history.start_date <= abt_subscriber_history.end_date)
      --AND (trunc(tbt_subscriber_imei_history.start_date,'dd') <= abt_subscriber_history.end_date)
  LEFT JOIN base.import_other_sources_base_tac base_tac
    ON tbt_subscriber_imei_history.tac = base_tac.tac
  LEFT JOIN base.import_other_sources_base_tac base_tac_2
    ON tbt_subscriber_imei_history.prev_tac = base_tac_2.tac
    where tbt_subscriber_imei_history.msisdn='28107330';
    
    select * from work.base_equation_fat_work_subscriber_imei_history_join where msisdn='28107330';
    
    -- TEST CASE with missing subscriber_no etc
SELECT * FROM work.base_equation_other_tbt_subscriber_imei_history where msisdn='28107330';
select * from work.base_equation_fat_work_subscriber_imei_history_join  where msisdn='28107330';
select * from analytics.abt_subscriber_history  where msisdn='28107330' order by start_date asc;