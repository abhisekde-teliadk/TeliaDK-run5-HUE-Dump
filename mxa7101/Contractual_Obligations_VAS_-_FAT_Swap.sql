SELECT * 
FROM work.contr_obligations_vas_work_service_history_daily_join sh; 

SELECT * 
FROM analytics.abt_subscribed_product_history sp; 

SELECT *
FROM work.contr_obligations_vas_work_service_history_daily_join sh 
LEFT OUTER JOIN analytics.abt_subscribed_product_history sp 
ON sh.ban = sp.ban 
AND sh.subscriber_no = sp.subscriber_no 
AND sp.effective_date >= cast('2018-01-01' as TIMESTAMP) 
AND sp.expiration_date <= now();


SELECT sho.ban, sho.subscriber_no, sho.soc, sho.soc_description, sho.start_date, sho.end_date
FROM analytics.abt_service_history_old sho
WHERE sho.ban = 559284906
AND sho.subscriber_no = 'GSM04527782570'
AND sho.soc = 'BARLEVEL';

SELECT shf.customer_id, shf.subscriber_no, shf.soc, shf.soc_description, shf.start_date, shf.end_date
FROM analytics.abt_service_history_fat shf
WHERE shf.customer_id = 559284906
AND shf.subscriber_no = 'GSM04527782570'
AND shf.soc = 'BARLEVEL';


SELECT shf.subscriber_no
FROM analytics.abt_service_history_old sho
INNER JOIN analytics.abt_service_history_fat shf
ON shf.subscriber_no = sho.subscriber_no;



SELECT *
FROM work.vasdata_work_service_change sc
WHERE sc.customer_id = 559284906
AND sc.subscriber_no = 'GSM04527782570'
AND sc.soc = 'BARLEVEL';

SELECT *
FROM work.vasdata_work_service_ranked sc
WHERE sc.customer_id = 559284906
AND sc.subscriber_no = 'GSM04527782570'
AND sc.soc = 'BARLEVEL';

SELECT *
FROM work.vasdata_work_service_change_agreement_joined sc
WHERE sc.customer_id = 559284906
AND sc.subscriber_no = 'GSM04527782570'
AND sc.soc = 'BARLEVEL';

SELECT *
FROM work.vasdata_work_service_change_lead sc
INNER JOIN base.import_fokus_base_service_agreement sa
ON sc.soc = sa.soc
AND sc.subscriber_no = sa.subscriber_no
AND sc.customer_id = sa.ban
AND sc.change_date >= sa.effective_date
AND  sc.change_date <= sa.expiration_date
WHERE sc.customer_id = 559284906
AND sc.subscriber_no = 'GSM04527782570'
AND sc.soc = 'BARLEVEL';


