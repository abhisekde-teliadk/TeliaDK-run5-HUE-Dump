

-- Test Case 02 - comparison against abt_ joins
SELECT 'Analytics.abt_joins', count(*) 
FROM
analytics.abt_subscribed_product sp,
analytics.abt_subscriber_current sc
WHERE
sp.subscriber_no = sc.subscriber_no
AND sp.ban = sc.customer_id
AND sc.status NOT IN ('d') -- corresponds to not in d in status in BE.subscriber_current
AND sp.soc = 'MOFL3000N'
AND ('2018-09-30' BETWEEN sp.effective_date and sp.expiration_date )
GROUP BY sp.product_id, sp.soc

UNION

SELECT 'BE_KPIs.abt_stock_kpi', sum(subs_qty) s  FROM analytics.abt_stock_kpi 
WHERE
product_id = '0033903b45ec2a16e9a02c2e555636ed'
AND
 stock_date = "2018-09-30T00:00:00.000Z"

;
