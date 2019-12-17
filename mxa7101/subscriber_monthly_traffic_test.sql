-- Voice Test -- OK

SELECT sum(volume/60) AS sum_vol
FROM work.base_equation_other_tbt_traffic
WHERE subscriber_no = 'GSM04528358173'
  AND customer_id = 455709709
  AND event_month = '201901'
  AND call_attempt_ind = FALSE
  AND traffic_type_id = '1';


SELECT *
FROM work.base_equation_kpis_base_equation_tbt_traffic_grouped
WHERE subscriber_no = 'GSM04528358173'
  AND customer_id = 455709709
  AND event_month = '201901';

-- SMS Test -- OK

SELECT sum(event_count) AS sum_event_count
FROM work.base_equation_other_tbt_traffic
WHERE subscriber_no = 'GSM04528358173'
  AND customer_id = 455709709
  AND event_month = '201901'
  AND nvl(call_attempt_ind, FALSE) = FALSE
  AND traffic_type_id = '2';

-- DK Data Test -- OK

SELECT sum(CASE
               WHEN nvl(call_attempt_ind, FALSE) = TRUE THEN 0
               WHEN traffic_type_id = '5' THEN CASE
                                                   WHEN network_id = 3 THEN 0
                                                   ELSE volume / 1073741824
                                               END
               ELSE 0
           END) AS sum_dk_data
FROM work.base_equation_other_tbt_traffic
WHERE subscriber_no = 'GSM04528358173'
  AND customer_id = 455709709
  AND event_month = '201901';

-- Roaming Data Test -- OK

SELECT sum(CASE
               WHEN nvl(call_attempt_ind, FALSE) = TRUE THEN 0
               WHEN traffic_type_id = '5' THEN CASE
                                                   WHEN network_id = 3 THEN volume / 1073741824
                                                   ELSE 0
                                               END
               ELSE 0
           END) AS sum_dk_data
FROM work.base_equation_other_tbt_traffic
WHERE subscriber_no = 'GSM04528358173'
  AND customer_id = 455709709
  AND event_month = '201901';

-- WW Data Test OK --

SELECT sum(CASE
               WHEN nvl(call_attempt_ind, FALSE) = TRUE THEN 0
               WHEN traffic_type_id = '5' THEN CASE
                                                   WHEN network_id = 3 THEN CASE
                                                                                WHEN roaming_region = 'EU' THEN 0
                                                                                WHEN roaming_region = 'Nordic/Baltic' THEN 0
                                                                                ELSE volume / 1073741824
                                                                            END
                                                   ELSE 0
                                               END
               ELSE 0
           END) AS sum_dk_data
FROM work.base_equation_other_tbt_traffic
WHERE subscriber_no = 'GSM04528358173'
  AND customer_id = 455709709
  AND event_month = '201901';


SELECT roaming_region,
       volume,
       traffic_type_id,
       network_id
FROM work.base_equation_other_tbt_traffic
WHERE nvl(call_attempt_ind, FALSE) = FALSE
  AND traffic_type_id = '5'
  AND network_id = 3
  AND roaming_region = 'Nordic/Baltic';


SELECT roaming_region,
       volume,
       traffic_type_id,
       network_id
FROM work.base_equation_other_tbt_traffic
WHERE subscriber_no = 'GSM04528358173'
  AND customer_id = 455709709
  AND event_month = '201901'
  AND traffic_type_id = '5';


SELECT *
FROM work.base_equation_kpis_base_equation_tbt_traffic_grouped
WHERE subscriber_no = 'GSM04522278767'
  AND customer_id = 561071218
  AND event_month = '201901';


SELECT count(*)
FROM work.base_equation_other_tbt_traffic
WHERE call_attempt_ind IS NULL;

SELECT adr_door_no
FROM work.base_equation_sub_tbt_customer_history
where customer_id = 724789201;


SELECT count(*)
FROM work.base_equation_kpis_work_customer_history_prepared ch
INNER JOIN work.base_equation_kpis_work_customer_history_prepared hh 
ON (ch.adr_door_no_nvl = hh.adr_door_no_nvl)
AND (ch.adr_story_nvl = hh.adr_story_nvl)
AND (ch.adr_house_letter_nvl = hh.adr_house_letter_nvl)
AND (ch.adr_country_nvl = hh.adr_country_nvl)
AND (ch.adr_pob_nvl = hh.adr_pob_nvl)
AND (ch.adr_direction_nvl = hh.adr_direction_nvl)
AND (ch.adr_street_name_nvl = hh.adr_street_name_nvl)
AND (ch.adr_house_no_nvl = hh.adr_house_no_nvl)
AND (ch.adr_zip_nvl = hh.adr_zip_nvl)
AND (ch.adr_city_nvl = hh.adr_city_nvl);