-- https://dataiku.dev.aws.telia.dk/projects/REPORTING_TO_AUTHORITIES/datasets/abt_usage_mobile/summary/
-- https://jira.atlassian.teliacompany.net/browse/DML-356
-- https://jira.atlassian.teliacompany.net/browse/DML-246
-- https://itwiki.atlassian.teliacompany.net/display/DID/Reporting+to+Authorities
SELECT replace(strleft(cast(now() as STRING),7), '-','')

; 

SELECT count(DISTINCT us.price_plan_code, us.at_soc) 

FROM 
raw.import_fokus_raw_detail_usage us 
LIMIT 100;

SELECT count(DISTINCT sa.soc, sa.campaign)


FROM base.import_fokus_base_service_agreement sa

WHERE 

'2018-01-01' between sa.effective_date AND sa.expiration_date
LIMIT 100;


-- this select shows differences between abt_usage_mobile and data from a reference excell file from finance
-- for 201801 only, our abt is synced and the excel is imported to the DSS ANALYST SANDBOX 
SELECT 
        round((mu.voice_min - muo.voice)) voice_diff,
        round((mu.voice_calls - muo.calls)) calls_diff,
        mu.finance_call_direction,
        mu.soc, mu.product_soc, mu.promotion, mu.call_description, mu.product_name 
        
FROM
work.analyst_sandbox_test_abt_usage_mobile_201801 mu
LEFT JOIN
work.analyst_sandbox_test_mobile_usage_original muo
ON
    (
    mu.soc = muo.soc
    AND
    mu.product_soc = muo.product_soc
    AND
    mu.promotion = muo.promotion_soc
    AND
    mu.call_description = muo.call_description
    AND
    mu.product_name = muo.product_name
    
    )

WHERE 
mu.finance_call_direction = "Outgoing"
AND
muo.finance_call_direction = "Outgoing+"
AND 
round(abs(mu.voice_min - muo.voice)) > 0
ORDER BY mu.soc, round(abs(mu.voice_min - muo.voice)) DESC
;

-- 524 distinct soc in ABT
SELECT count(DISTINCT mu.soc)
FROM work.analyst_sandbox_test_abt_usage_mobile_201801 mu
--GROUP BY muo.product_soc

;

-- 545 distinct soc 
SELECT count(DISTINCT muo.soc) 
FROM work.analyst_sandbox_test_mobile_usage_original muo
--GROUP BY muo.product_soc
;



-- 6501 outgoing, 549 incoming
SELECT muo.finance_call_direction, count(*)  
FROM work.analyst_sandbox_test_mobile_usage_original muo
GROUP BY muo.finance_call_direction
;


-- 8635 outgoing, 532 incoming, empyt 3
SELECT mu.finance_call_direction, count(*) 
FROM work.analyst_sandbox_test_abt_usage_mobile_201801 mu
GROUP BY mu.finance_call_direction
;

-- total 7050
-- Postpaid 6873
SELECT count(*) 
FROM work.analyst_sandbox_test_abt_usage_mobile_201801 mu
WHERE product_group LIKE '%Postpaid%'
;

SELECT *
FROM work.analyst_sandbox_test_abt_usage_mobile_201801 mu
LIMIT 100
;