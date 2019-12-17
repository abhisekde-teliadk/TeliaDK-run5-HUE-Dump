SELECT * 
FROM import_other_sources_base_tnid_extract
WHERE tnid_access_type LIKE '%VDSL%';


-- FOKUS - how many subscribed products do we have
SELECT soc, product_desc, count(*) c 
FROM analytics.abt_subscribed_product_current
WHERE (product_code LIKE '%ISDN%') -- soc LIKE '%ISDN%' or 
GROUP BY soc, product_desc
ORDER BY c DESC
;

-- FOKUS - how many subscribed products do we have
SELECT soc, product_desc, count(*) c 
FROM analytics.abt_subscribed_product_current
WHERE product_desc LIKE '%IP%'
GROUP BY soc, product_desc
ORDER BY c DESC
;