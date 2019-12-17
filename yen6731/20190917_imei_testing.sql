select 
*
--count(*)
from (
SELECT 
    tbt_subscriber_imei_history.source,
    tbt_subscriber_imei_history.start_date AS start_date,
    tbt_subscriber_imei_history.tac AS tac,
    tbt_subscriber_imei_history.prev_tac AS prev_tac,
    tbt_subscriber_imei_history.msisdn AS msisdn,
    tbt_subscriber_imei_history.imei14 AS imei14,
    tbt_subscriber_imei_history.prev_imei14 AS prev_imei14,
    tbt_subscriber_imei_history.end_date AS end_date,
    tbt_subscriber_imei_history.active_record_flag AS active_record_flag,
    tbt_subscriber_imei_history.subscriber_id AS subscriber_id,
    --tbt_subscriber_imei_history.source AS source,
    abt_subscriber_history.subscriber_no AS subscriber_no,
    abt_subscriber_history.customer_id AS customer_id,
    base_tac.marketing_name AS marketing_name,
    base_tac.manufacturer AS handset_manufacturer,
    base_tac.band AS band,
    base_tac.brand_name AS brand_name,
    base_tac.model_name AS handset_model,
    base_tac.operating_system AS operating_system,
    base_tac.nfc AS nfc,
    base_tac.bluetooth AS bluetooth,
    base_tac.wlan AS wlan,
    base_tac.device_type AS device_type,
    base_tac.removable_uicc AS removable_uicc,
    base_tac.removable_euicc AS removable_euicc,
    base_tac.nonremovable_uicc AS nonremovable_uicc,
    base_tac.nonremovable_euicc AS nonremovable_euicc,
    base_tac_2.marketing_name AS prev_marketing_name,
    base_tac_2.manufacturer AS prev_manufacturer,
    base_tac_2.model_name AS prev_handset_model
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
        source AS source,
        --least(now(),end_date) AS lowest_date
        least(now(),trunc(end_date,'dd')) AS lowest_date
      FROM (
        SELECT *
          FROM work.base_equation_other_tbt_subscriber_imei_history tbt_subscriber_imei_history
        ) withoutcomputedcols_query
    ) tbt_subscriber_imei_history
  LEFT JOIN analytics.abt_subscriber_history
    ON (tbt_subscriber_imei_history.lowest_date >= abt_subscriber_history.start_date)
      AND (tbt_subscriber_imei_history.subscriber_id = abt_subscriber_history.subscriber_id)
      AND (tbt_subscriber_imei_history.lowest_date <= abt_subscriber_history.end_date)
  LEFT JOIN base.import_other_sources_base_tac base_tac
    ON tbt_subscriber_imei_history.tac = base_tac.tac
  LEFT JOIN base.import_other_sources_base_tac base_tac_2
    ON tbt_subscriber_imei_history.prev_tac = base_tac_2.tac
    ) a
    where a.msisdn='29250139';
    --where subscriber_no is null;
    
-- TEST CASE with missing subscriber_no etc
SELECT * FROM work.base_equation_other_tbt_subscriber_imei_history where msisdn='28797611';
select * from work.base_equation_fat_work_subscriber_imei_history_join  where msisdn='29250139';
select * from analytics.abt_subscriber_history  where msisdn='29250139';
select * from analytics.abt_subscriber_imei_history  where subscriber_id is null;

select * from analytics.abt_subscriber_imei_history  where msisdn=29250139;

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
        source AS source,
        least(now(),end_date) AS lowest_date
      FROM (
        SELECT *
          FROM work.base_equation_other_tbt_subscriber_imei_history tbt_subscriber_imei_history
        ) withoutcomputedcols_query
        where msisdn='28103884';
        
-- TEST CASE nr.2 with missing subscriber_no etc
SELECT * FROM work.base_equation_other_tbt_subscriber_imei_history where msisdn='28448665' and subscriber_id=371;
select distinct * from analytics.abt_subscriber_history  where msisdn='28448665';
select distinct * from work.base_equation_fat_work_subscriber_imei_history_join  where msisdn='28448665';

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
        source AS source,
        least(now(),end_date) AS lowest_date
      FROM (
        SELECT *
          FROM work.base_equation_other_tbt_subscriber_imei_history tbt_subscriber_imei_history
        ) withoutcomputedcols_query
        where msisdn='28448665';        
        
-- TEST CASE nr.3 with missing subscriber_no etc
SELECT * FROM work.base_equation_other_tbt_subscriber_imei_history where msisdn='28107330';
select distinct * from analytics.abt_subscriber_history  where msisdn='28107330';
select * from work.base_equation_fat_work_subscriber_imei_history_join  where msisdn='28107330';

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
        source AS source,
        least(now(),end_date) AS lowest_date
      FROM (
        SELECT *
          FROM work.base_equation_other_tbt_subscriber_imei_history tbt_subscriber_imei_history
        ) withoutcomputedcols_query
        where msisdn='28107330';            