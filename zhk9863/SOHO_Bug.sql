-- 682 postpaid soho socs
SELECT soc, count(*) c
FROM base.manual_files_base_d_product
WHERE product_group = 'Postpaid SOHO'
GROUP BY soc
ORDER BY c DESC
;

-- how did Karina get this one?
SELECT *
FROM base.manual_files_base_d_product
WHERE soc = 'CHAMPEBA'
;

-- haw many postpaid soho socs with actual SA do we have? (filtering on campaing / promo missing)
SELECT count(DISTINCT sa.customer_id, sa.subscriber_no, sa.soc) 
FROM 
    base.manual_files_base_d_product dp
    LEFT JOIN 
    base.import_fokus_base_service_agreement sa
    ON dp.soc = sa.soc

WHERE 
dp.product_group  = 'Postpaid SOHO'
AND
now() BETWEEN sa.effective_date AND sa.expiration_date 
AND sa.service_type = 'P'
LIMIT 100;

-- which socs were relevant for the customers
SELECT concat('\'', group_concat(distinct sa.soc, '\', \'' ), '\'') 
FROM base.import_fokus_base_service_agreement sa
WHERE sa.customer_id = 789277209 AND sa.subscriber_no = 'GSM04526709545'

LIMIT 100
;

-- first sample customer
SELECT * FROM base.import_fokus_base_service_agreement sa
WHERE sa.customer_id = 789277209 AND sa.subscriber_no = 'GSM04526709545'
AND
now() BETWEEN sa.effective_date AND sa.expiration_date 
AND 
sa.service_type IN ('P', 'M')
LIMIT 100;


SELECT * FROM analytics.abt_customer_current WHERE customer_id  = 789277209 LIMIT 100;


-- ban Julie Hering Schmidt 789277209 from Karina
SELECT * FROM base.import_fokus_base_subscriber WHERE customer_ban  = 789277209 LIMIT 100;
