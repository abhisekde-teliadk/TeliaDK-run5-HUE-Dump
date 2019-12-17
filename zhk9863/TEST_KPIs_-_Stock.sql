
-- old dwh 7735
SELECT 'fokus.subscriber', count(*) 
FROM
import_fokus_base_service_agreement sa, 
import_fokus_base_subscriber su
WHERE
sa.subscriber_no = su.subscriber_no
AND sa.ban = su.customer_id
-- AND su.sub_status IN ('S','R','A','C')
AND su.sub_status NOT IN ('S') -- corresponds to not in d in status in BE.subscriber_current
AND sa.soc = 'NBMA11'
AND sa.campaign = 'NBMA11S'
--AND sa.campaign = 'MOFLT24N'
AND 
('2018-09-30' BETWEEN sa.effective_date and sa.expiration_date
OR

sa.expiration_date IS NULL
)

;




SELECT * FROM work.base_equation_work_subscribed_product_id 
WHERE 
product_id = '046990c5bfa044f71b1486f1147a3c21'
AND
campaign = 'NBMA11S'
AND
"2018-09-30" BETWEEN effective_date and expiration_date
LIMIT 100;


-- customers 7238, 7238
SELECT sum(subs_qty) --, sum(customer_qty) 
FROM analytics.abt_stock_kpi

WHERE 
product_id = '046990c5bfa044f71b1486f1147a3c21'
AND
 stock_date = "2018-09-30T00:00:00.000Z"
GROUP BY stock_date
 ;



----------------------------

-- Test Case 02 - intake
SELECT 'BE.abt_intake_kpi', count(*)   FROM analytics.abt_intake_kpi 
WHERE
product_id = '0033903b45ec2a16e9a02c2e555636ed'
AND
 stock_date = "2018-09-30T00:00:00.000Z"

;


-- Test Case 01
-- soc = 'MOFL3000N', campaign = 'MOFLT24N', promotion is NULL
SELECT 'fokus.subscriber', count(*) 
FROM
import_fokus_base_service_agreement sa, 
import_fokus_base_subscriber su
WHERE
sa.subscriber_no = su.subscriber_no
AND sa.ban = su.customer_id
-- AND su.sub_status IN ('S','R','A','C')
-- AND su.sub_status NOT IN ('C') -- corresponds to not in d in status in BE.subscriber_current
AND sa.soc = 'MOFL3000N'
--AND sa.campaign = 'MOFLT24N'
AND 
('2018-09-30' BETWEEN sa.effective_date and sa.expiration_date
OR

sa.expiration_date IS NULL
)
-- AND sa.promotion is NULL

UNION

SELECT 'BE.abt_stock_kpi', sum(subs_qty) s  FROM analytics.abt_stock_kpi 
WHERE
product_id = '0033903b45ec2a16e9a02c2e555636ed'
AND
 stock_date = "2018-09-30T00:00:00.000Z"

;

SELECT customer_id, subscriber_no, count(*) CNT
FROM base.import_fokus_base_subscriber 
GROUP BY customer_id, subscriber_no
ORDER BY CNT DESC
LIMIT 100;

-- how many status types do we have
SELECT sub_status, count(*)
FROM
import_fokus_base_subscriber
GROUP BY sub_status;

-- Test Case 01
SELECT * FROM work.base_equation_work_subscribed_product_id 
WHERE 
product_id = '0033903b45ec2a16e9a02c2e555636ed'
AND
"2018-09-30" BETWEEN effective_date and expiration_date
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
 stock_date = "2018-09-30T00:00:00.000Z"
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
