SELECT COUNT(*) AS count_pk_distinct
FROM 
(SELECT customer_entity_id, consent_id, count(*) AS pk_count
FROM work.consent_tbt_clean_consent_data_btc
GROUP BY customer_entity_id, consent_id
HAVING pk_count > 1)CNT;


SELECT * FROM work.consent_tbt_consent_switchr_bridge
WHERE consent_entity_id is NULL;

SELECT COUNT(*) AS count_pk_distinct
FROM 
(SELECT consent_entity_id, count(*) AS pk_count
FROM work.consent_tbt_consent_switchr_bridge
--WHERE consent_entity_id <> NULL
GROUP BY consent_entity_id
HAVING pk_count > 1)CNT;

SELECT consent_entity_id, count(*) AS pk_count
FROM work.consent_tbt_consent_switchr_bridge
--WHERE consent_entity_id <> NULL
GROUP BY consent_entity_id
HAVING pk_count > 1;

SELECT *
from work.consent_tbt_consent_switchr_bridge
where consent_entity_id
in (101558290, 101553598, 101682684);



SELECT COUNT(*) AS count_pk_distinct
FROM 
(SELECT consent_entity_id, count(*) AS pk_count
FROM work.consent_tbt_consent_switchr_bridge 
GROUP BY consent_entity_id
HAVING pk_count > 1)CNT;


SELECT COUNT(*) AS count_pk_distinct
FROM 
(SELECT soc, subscriber_no, customer_id, status_date, status, count(*) AS pk_count
FROM work.vasdata_tbt_service_activation
GROUP BY soc, subscriber_no, customer_id, status_date, status
HAVING pk_count > 1)CNT;

SELECT soc, subscriber_no, customer_id, status_date, status, count(*) AS pk_count
FROM work.vasdata_tbt_service_activation
GROUP BY soc, subscriber_no, customer_id, status_date, status
HAVING pk_count > 1;

SELECT *
FROM work.vasdata_tbt_service_activation
WHERE soc = 'SFBTC' and subscriber_no = 'GSM04528199276' 
and customer_id = 697517209 and status = 5
and status_date = cast('2015-10-23 00:00:00' as TIMESTAMP);

SELECT *
FROM base.manual_files_base_man_tertium_servicestatus_vw
WHERE product_name = 'SFBTC' --and subscriber_no = 'GSM04528199276' 
and active_state = 5
--customer_id = 697517209
and bss_subscriber_id = 8023843
and creation_date = cast('2015-10-23 00:00:00' as TIMESTAMP);