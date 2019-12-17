-- Test Case 01
-- soc = 'MOFL3000N', campaign = 'MOFLT24N', promotion is NULL
SELECT 'curr', count(*) 
FROM
import_fokus_base_service_agreement sa, import_fokus_base_subscriber su
WHERE
sa.subscriber_no = su.subscriber_no
AND sa.ban = su.customer_id
AND su.sub_status != 'd'
AND sa.soc = 'MOFL3000N'
AND sa.campaign = 'MOFLT24N'
AND '2018-01-01' BETWEEN sa.effective_date and sa.expiration_date
-- AND sa.promotion is NULL

UNION


SELECT 'history', count(*) 
FROM
import_fokus_base_service_agreement sa, 
base.import_fokus_base_subscriber_history su
WHERE
sa.subscriber_no = su.subscriber_no
AND sa.ban = su.customer_id
AND su.sub_status != 'd'
AND sa.soc = 'MOFL3000N'
AND sa.campaign = 'MOFLT24N'
AND '2018-01-01' BETWEEN sa.effective_date and sa.expiration_date
-- AND sa.promotion is NULL

UNION

SELECT 'abt', sum(subs_qty) s  FROM analytics.abt_stock_kpi 
WHERE
product_id = '0033903b45ec2a16e9a02c2e555636ed'
AND
 stock_date = "2018-01-01T00:00:00.000Z"

;



-- Test Case 01
SELECT * FROM work.base_equation_work_subscribed_product_id 
WHERE 
product_id = '0033903b45ec2a16e9a02c2e555636ed'
AND
"2018-01-01" BETWEEN effective_date and expiration_date
LIMIT 100;

-- Test Case 01
SELECT count(*) FROM base_equation_work_subscribed_product_id 
WHERE 
product_id = '0033903b45ec2a16e9a02c2e555636ed'
LIMIT 100;

-- Test Case 01
SELECT sum(customer_qty) c, sum(subs_qty) s  FROM analytics.abt_stock_kpi 
WHERE
product_id = '0033903b45ec2a16e9a02c2e555636ed'
AND
 stock_date = "2018-01-01T00:00:00.000Z"
LIMIT 100
;


-- there shouldn't be more customers than subscribers
-- one customer can have multiple subscribers, not oposite
SELECT count(*) FROM analytics.abt_stock_kpi 
WHERE
customer_qty > subs_qty
LIMIT 100;

-- how many null products do we have
SELECT count(*) FROM analytics.abt_stock_kpi 
WHERE
product_id IS NULL
LIMIT 100;


-- how many null products do we have
SELECT count(*) FROM analytics.abt_stock_kpi 
WHERE
product_id IS NULL
LIMIT 100;



-- how many subscriptions do we have in "product origins" 
SELECT 'p1', count(*) 
FROM work.base_equation_work_subscribed_product_id 
WHERE p1_product_id is not null 
UNION
SELECT  'p2',count(*) 
FROM work.base_equation_work_subscribed_product_id 
WHERE p2_product_id is not null 
UNION
SELECT  'p3',count(*) 
FROM work.base_equation_work_subscribed_product_id 
WHERE p3_product_id is not null 
UNION
SELECT  'p4',count(*) 
FROM work.base_equation_work_subscribed_product_id 
WHERE p4_product_id is not null 
UNION
SELECT  'no product',count(*) 
FROM work.base_equation_work_subscribed_product_id 
WHERE product_id is null 
