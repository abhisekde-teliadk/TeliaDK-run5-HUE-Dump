SELECT count(distinct gre.customer_entity_group_id) FROM
base.import_consent_db_base_customer_entity_group_entities gre
;

-- which groups have inconsistent scubscribers
-- this is based on groups detected by a python script by Jan B. on Feb 8, 2019
-- inactive subscriptions not taken out from the group
-- 0148933f-ee94-4e82-8b76-81272ca1bc7f, 0179cbaa-a04f-44ed-bfad-370d0aa9969a group has inconcistency
SELECT gre.customer_entity_group_id, cuen.customer_entity_id, cd.* 

FROM 

work.analyst_sandbox_omi_consent_corrupted_groups crr, 
base.import_consent_db_base_customer_entity_group_entities gre,
base.import_consent_db_base_customer_entities cuen,
analytics.abt_consent_data_btc cd

WHERE

crr.line = gre.customer_entity_group_id
-- AND gre.customer_entity_group_id = '0148933f-ee94-4e82-8b76-81272ca1bc7f' --'0179cbaa-a04f-44ed-bfad-370d0aa9969a'

AND 
cuen.customer_entity_id = gre.customer_entity_id
AND cd.subscriber_id = cuen.customer_id
-- AND cd.status = 'active'
ORDER BY gre.customer_entity_group_id

LIMIT 500;

select * from
base.import_consent_db_base_customer_entities cuen
where cuen.customer_entity_id = 101562879
;

-- Jan B. - select
-- 
select
-- count(distinct ge.customer_entity_group_id, ge.customer_entity_id, cc.consent_id)
distinct ge.customer_entity_group_id, ge.customer_entity_id, cc.consent_id, cc.state_id
from
  base.import_consent_db_base_customer_consents        cc,
  base.import_consent_db_base_customer_entities cuen,
  base.import_consent_db_base_customer_entity_group_entities  ge

where
cuen.customer_entity_id = cc.customer_entity_id -- ktery uzivatel ma jake consenty
and
ge.customer_entity_id = cc.customer_entity_id
-- and ge.customer_entity_group_id =  '00007e5b-4a71-4a40-8235-23d45418bccd'
order by ge.customer_entity_group_id, ge.customer_entity_id, cc.consent_id, cc.state_id
Limit 100;


-- how many groups do we have - 323k
select count(distinct customer_entity_group_id)
from
base.import_consent_db_base_customer_entity_group_entities;

-- group consistency check input dataset
select 
-- count(distinct ge.customer_entity_group_id, ge.customer_entity_id, cc.consent_id)
distinct ge.customer_entity_group_id, ge.customer_entity_id, cc.consent_id, cc.state_id
from
    base.import_consent_db_base_customer_consents        cc,
    base.import_consent_db_base_customer_entities cuen,
    base.import_consent_db_base_customer_entity_group_entities  ge
    
where
cuen.customer_entity_id = cc.customer_entity_id -- ktery uzivatel ma jake consenty
and cuen.reference_type_id = 'SUBSCRIPTION-ID'
and
ge.customer_entity_id = cc.customer_entity_id
and ge.customer_entity_group_id = '001329c4-4c18-47b0-972b-ede9d40fd0ad'
order by ge.customer_entity_group_id, ge.customer_entity_id, cc.consent_id, cc.state_id
Limit 100
;


SELECT *
FROM 
analytics.abt_consent_switchr_bridge
WHERE 
subscriber_id in (13473411, 14281184)
;

-- how big are consent groups
SELECT subscriber_id, count(*) c
FROM 
analytics.abt_consent_switchr_bridge
GROUP BY subscriber_id
ORDER BY c DESC
LIMIT 100;


-- 24200, 22133, 21763 active in Fokus
SELECT
count(distinct sc.subscriber_id) 

FROM
    base.import_consent_db_base_customer_consents        cc,
    base.import_consent_db_base_customer_entities cuen,
    analytics.abt_subscriber_current sc,
    analytics.abt_customer_current cuc
 
WHERE

    cc.consent_id = '44f72576-dddc-4f8a-b376-9ca8a65b9f56' -- Metadata Testing
    -- cc.consent_id = '45a8b98e-1505-4a95-ae93-df709fe6a699' -- Extensive profiling
    -- cc.consent_id = '43760673-09b9-4885-b543-cac720d7ea1f' -- Metadata Network Improvement
 
    AND cc.customer_entity_id = cuen.customer_entity_id
    AND cuen.reference_type_id = 'SUBSCRIPTION-ID'
    AND sc.subscriber_id = cuen.customer_id -- yes, this join is correct for reference_type_id = 'SUBSCRIPTION-ID'
    AND cuc.customer_id = sc.customer_id
    AND cc.state_id = '3'
    AND sc.status = 'a'                  -- filter on active subscribtions
    -- AND cuc.identify IS NOT NULL
    LIMIT 100
    ;


SELECT *
FROM import_consent_db_base_customer_consents
WHERE customer_entity_id in
(
100832659, 101193930, 101204365, 101221347, 101210006, 101132389, 101204364
)
ORDER BY customer_entity_id
;


-- how big are consent groups
SELECT customer_entity_group_id, count(*) c
FROM 
base.import_consent_db_base_customer_entity_group_entities 
GROUP BY customer_entity_group_id
ORDER BY c DESC
LIMIT 100;


SELECT *
FROM
import_consent_db_base_customer_entity_group_entities cgr,
base.import_consent_db_base_customer_entities cuen
WHERE
cgr.customer_entity_group_id = '83d12e93-86d8-42a9-84eb-2e4e116c07a4'
and cuen.customer_entity_id = cgr.customer_entity_id

;


--------------------------------------------
---
--- how to find if subscriber has SwitchrID
---
--------------------------------------------
SELECT *
FROM
 base.import_consent_db_base_customer_entities cuen
WHERE 
cuen.customer_entity_id IN 	(101008600, 100859096, 101092424) -- entity ids z grupy
 ;
 
 


SELECT *
FROM
import_consent_db_base_customer_entity_group_entities 
WHERE
customer_entity_group_id = 'b39a8f25-1554-4308-b836-1ed4c2ed4f41'
;


SELECT *
FROM
import_consent_db_base_customer_entity_group_entities 
WHERE
customer_entity_id = 101092424
;


SELECT *
FROM
 base.import_consent_db_base_customer_entities cuen
WHERE 
customer_id = 14627570 -- subscriber ID z nasi tabulky abt_consent
 ;
 
--------------------------------------------
---
--- END OF how to find if subscriber has SwitchrID
---
--------------------------------------------

 
 SELECT cuen.customer_id, count(*) c
 FROM
 base.import_consent_db_base_customer_entities cuen
 -- WHERE cuen.reference_type_id = 'SWITCHR-ID'
 GROUP BY cuen.customer_id
 ORDER BY c DESC
 LIMIT 100
 ;

----------------------------------------
-- Consent customers for test purposes
----------------------------------------
SELECT 
    strleft(cast(now() as VARCHAR), 10) as consent_valid_date,
    cuc.customer_id,    -- BAN from Fokus
    sc.subscriber_id,   
    cuc.cvr_no,         -- CVR in case it exists
    cuc.identify,       -- CVR or CPR
    sc.product_group

FROM 
    base.import_consent_db_base_customer_consents        cc,
    base.import_consent_db_base_customer_entities cuen,
    analytics.abt_subscriber_current sc,
    analytics.abt_customer_current cuc

WHERE 

    cc.consent_id = '45a8b98e-1505-4a95-ae93-df709fe6a699' -- Extensive profiling
    -- cc.consent_id = '44f72576-dddc-4f8a-b376-9ca8a65b9f56' -- Metadata Testing
    -- cc.consent_id = '43760673-09b9-4885-b543-cac720d7ea1f' -- Metadata Network Improvement

    AND cc.customer_entity_id = cuen.customer_entity_id
    AND cuen.reference_type_id = 'SUBSCRIPTION-ID'
    AND sc.subscriber_id = cuen.customer_id -- yes, this join is correct for reference_type_id = 'SUBSCRIPTION-ID'
    AND cuc.customer_id = sc.customer_id
    AND sc.status = 'a'                  -- filter on active subscribtions
    AND cuc.identify IS NOT NULL
    -- AND sc.product_group LIKE '%BtB%'    -- filter on BtB product group
LIMIT 100;


----------------------------------
-- CONSENT SWITHCER DATA ANALYSIS
-----------------------------------

SELECT * FROM work.consent_work_clean_consent_data 
WHERE customer_entity_id IN (101549086,101002846 )
LIMIT 100;


SELECT * FROM base.import_consent_db_base_customer_entity_groups
WHERE customer_entity_group_id = '629a62e8-4df6-4693-bedf-691dcd1fdc93'
LIMIT 100;

SELECT * FROM base.import_consent_db_base_customer_entity_group_entities 
WHERE customer_entity_group_id = '629a62e8-4df6-4693-bedf-691dcd1fdc93'
LIMIT 100;

;

SELECT *
FROM analytics.abt_consent_data c
where c.customer_id IN (11898916,  15990158, 365886)
;

-- based on Maryam's test data, two subscription IDs and one Switchr-ID
SELECT *
FROM
base.import_consent_db_base_customer_entities cuen
where cuen.customer_id IN (11898916,  15990158, 365886)
;

---------------------------------------
--- OLD DATES ANALYSIS
---------------------------------------

-- example old dates for Mette, January 8th 2019
SELECT *
FROM analytics.abt_consent_data c
WHERE 
(c.crm_date BETWEEN '2000-01-01' AND '2018-05-01')
OR
(c.profiling_date BETWEEN '2000-01-01' AND '2018-05-01')
OR
(c.dmc_date BETWEEN '2000-01-01' AND '2018-05-01')

LIMIT 100
;

----------------------------------------------------------
-- count the old systems
----------------------------------------------------------

SELECT  
    sys.name as system,
    cn.name as consent, 
    ccs.name as state, 

    count(*)    

FROM
    base.import_consent_db_base_customer_entities   cuen   -- source system mapping
    LEFT JOIN
    -- !!! the important consent table
    import_consent_db_base_customer_consents        cc
    ON 
        cuen.customer_entity_id = cc.customer_entity_id


    -- consent name
    LEFT JOIN
    import_consent_db_base_consents                 cn
    ON 
        cc.consent_id = cn.consent_id
        
    -- state
    LEFT JOIN
    import_consent_db_base_customer_consent_states  ccs
    ON
        cast(ccs.state_id as STRING) = cc.state_id
        

    LEFT JOIN
    import_consent_db_base_systems                  sys
        ON sys.system_id = cc.change_system_id

WHERE
    cc.change_date BETWEEN '0000-01-01' AND '2018-05-01'

GROUP BY 
    sys.name,
    cn.name, 
    ccs.name

ORDER BY sys.name, cn.name


LIMIT 1000;




--- how many old consents do we have
SELECT cc.consent_id, cc.state_id,count(*)
FROM import_consent_db_base_customer_consents cc
WHERE cc.change_date BETWEEN '0000-01-01' AND '2018-05-01'
GROUP BY cc.consent_id, cc.state_id
;


-- on 21.12.2018 I found 28 records where MTM is Given but others are not
SELECT DISTINCT
cuen.reference_type_id, cuen.customer_id, cc.customer_entity_id, cc1.state_id, cc1.change_date,  cc2.state_id, cc2.change_date,  cc3.state_id, cc3.change_date,  cc4.state_id, cc4.change_date
-- count(*)
FROM 
base.import_consent_db_base_customer_entities cuen,
import_consent_db_base_customer_consents        cc
LEFT JOIN
import_consent_db_base_customer_consents        cc1
    ON (
    cc1.consent_id = 'f2225250-2b6d-4d8a-96d1-24155326282e'
    AND 
    cc.customer_entity_id = cc1.customer_entity_id
    )

LEFT JOIN
import_consent_db_base_customer_consents        cc2
    ON (
    cc2.consent_id = '3ec2e83c-ba64-4901-9cbf-56a6850f026d'
    AND 
    cc.customer_entity_id = cc2.customer_entity_id
    )

LEFT JOIN
import_consent_db_base_customer_consents        cc3
    ON (
    cc3.consent_id = '0577fa06-9b71-4cea-ab43-0be4cc9aeadd'
    AND 
    cc.customer_entity_id = cc3.customer_entity_id
    )

LEFT JOIN
import_consent_db_base_customer_consents        cc4
    ON (
    cc4.consent_id = '45a8b98e-1505-4a95-ae93-df709fe6a699'
    AND 
    cc.customer_entity_id = cc4.customer_entity_id
    )

WHERE
cuen.customer_entity_id = cc.customer_entity_id
AND
cc1.state_id = '3' AND (cc2.state_id <> '3' OR cc3.state_id <> '3' OR cc4.state_id <> '3')

ORDER BY cuen.reference_type_id
LIMIT 200;


-- on 11.1.2019 I found 8 records where MTM is NOT Given but others are 

SELECT DISTINCT
cuen.reference_type_id, cuen.customer_id, cc.customer_entity_id, cc1.state_id, cc1.change_date,  cc2.state_id, cc2.change_date,  cc3.state_id, cc3.change_date,  cc4.state_id, cc4.change_date
-- count(*)
FROM 
base.import_consent_db_base_customer_entities cuen,
base.import_consent_db_base_customer_consents        cc
LEFT JOIN
import_consent_db_base_customer_consents        cc1
    ON (
    cc1.consent_id = 'f2225250-2b6d-4d8a-96d1-24155326282e'
    AND 
    cc.customer_entity_id = cc1.customer_entity_id
    )

LEFT JOIN
import_consent_db_base_customer_consents        cc2
    ON (
    cc2.consent_id = '3ec2e83c-ba64-4901-9cbf-56a6850f026d'
    AND 
    cc.customer_entity_id = cc2.customer_entity_id
    )

LEFT JOIN
import_consent_db_base_customer_consents        cc3
    ON (
    cc3.consent_id = '0577fa06-9b71-4cea-ab43-0be4cc9aeadd'
    AND 
    cc.customer_entity_id = cc3.customer_entity_id
    )

LEFT JOIN
import_consent_db_base_customer_consents        cc4
    ON (
    cc4.consent_id = '45a8b98e-1505-4a95-ae93-df709fe6a699'
    AND 
    cc.customer_entity_id = cc4.customer_entity_id
    )

WHERE
cuen.customer_entity_id = cc.customer_entity_id
AND
cc1.state_id <> '3' AND (cc2.state_id = '3' AND cc3.state_id = '3' AND cc4.state_id = '3')

ORDER BY cuen.reference_type_id
LIMIT 200;




-- the result of this is 1729
-- we have roughly half milion of subscription ids and quarter milion of switch ids
SELECT count(*)
FROM
base.import_consent_db_base_customer_entities cuen1,
base.import_consent_db_base_customer_entities cuen
WHERE
cuen.reference_type_id = 'SUBSCRIPTION-ID'
AND
cuen1.reference_type_id = 'SWITCHR-ID'
AND
cuen.customer_id = cuen1.customer_id
;



-- how many product lines we have
SELECT count(*), sc.product_line
FROM
 analytics.abt_subscriber_current sc
 
 WHERE sc.status = 'a'
GROUP BY sc.product_line
 ;




SELECT count(*), cuen.reference_type_id
FROM
    analytics.abt_subscriber_current                sc      -- abt_subscriber info
    LEFT JOIN
    base.import_consent_db_base_customer_entities   cuen   -- source system mapping
        ON 
        (
            (
            sc.subscriber_id = cuen.customer_id
            AND 
                (
                    cuen.reference_type_id = 'SUBSCRIPTION-ID'
                    -- OR cuen.reference_type_id = 'SWITCHR-ID'
                )
            )
/*
        OR
            (
            sc.customer_id = cuen.customer_id
            AND
            cuen.reference_type_id = 'BAN'
            )
*/        
        )


    LEFT JOIN
    -- !!! the important consent table
    import_consent_db_base_customer_consents        cc
    ON 
        cuen.customer_entity_id = cc.customer_entity_id


    -- consent name
    LEFT JOIN
    import_consent_db_base_consents                 cn
    ON 
        cc.consent_id = cn.consent_id
        
    -- state
    LEFT JOIN
    import_consent_db_base_customer_consent_states  ccs
    ON
        cast(ccs.state_id as STRING) = cc.state_id
        

    LEFT JOIN
    import_consent_db_base_systems                  sys
        ON sys.system_id = cc.change_system_id

WHERE 
sc.status = 'a'
GROUP BY 
cuen.reference_type_id
;

----------------------------------------------------------
-- GET Consents
----------------------------------------------------------

SELECT  
    cuen.reference_type_id,
    cuen.customer_entity_id,
    sc.customer_id,
    sc.subscriber_id, 
    cn.name as consent, 
    ccs.name as state, 
    sc.status, 
    sc.price_plan,
    sys.name as system,
    sc.start_date as subscriber_start_date,
    datediff( now(), sc.start_date) div 30 as subscribed_months, -- hack
    sc.product_group,
    sc.churn_date_id,
    cc.change_date

FROM
    analytics.abt_subscriber_current                sc      -- abt_subscriber info
    LEFT JOIN
    base.import_consent_db_base_customer_entities   cuen   -- source system mapping
        ON 
       
            (
            sc.subscriber_id = cuen.customer_id
            AND 
                (
                    cuen.reference_type_id = 'SUBSCRIPTION-ID'
                    -- OR cuen.reference_type_id = 'SWITCHR-ID'
                )
            )
            
            /*
            (
            sc.customer_id = cuen.customer_id
            AND
            cuen.reference_type_id = 'BAN'
            )
        OR
        */  

      
        


    LEFT JOIN
    -- !!! the important consent table
    import_consent_db_base_customer_consents        cc
    ON 
        cuen.customer_entity_id = cc.customer_entity_id


    -- consent name
    LEFT JOIN
    import_consent_db_base_consents                 cn
    ON 
        cc.consent_id = cn.consent_id
        
    -- state
    LEFT JOIN
    import_consent_db_base_customer_consent_states  ccs
    ON
        cast(ccs.state_id as STRING) = cc.state_id
        

    LEFT JOIN
    import_consent_db_base_systems                  sys
        ON sys.system_id = cc.change_system_id


WHERE
    cuen.reference_type_id IS NOT NULL
   -- AND cc.change_date BETWEEN '2018-10-01' AND '2018-10-31'
    AND sc.status = 'a'

ORDER BY sc.subscriber_id

LIMIT 100;














-- hack
SELECT * FROM
base.import_consent_db_base_customer_consents   cc
WHERE 
customer_entity_id = 100800558
;
 
 
 
 
 
--- WHERE ONLY
SELECT DISTINCT 
-- count(*)

    cuen.reference_type_id,
    sc.subscriber_id, 
    cn.name as consent, 
    ccs.name as state, 
    sc.status, 
    sc.price_plan,
    sys.name as system,
--    chan.name as channel,
    sc.start_date as subscriber_start_date,
    datediff( now(), sc.start_date) div 30 as subscribed_months, -- hack
    sc.product_group,
    sc.churn_date_id,
    cc.change_date

FROM
    analytics.abt_subscriber_current                sc,     -- abt_subscriber info
    base.import_consent_db_base_customer_entities   cuen,   -- source system mapping

    -- !!! the important consent table
    import_consent_db_base_customer_consents        cc,     

    -- consent name
    import_consent_db_base_consents                 cn,

    -- state
    import_consent_db_base_customer_consent_states  ccs,

    -- channels
--    import_consent_db_base_customer_consent_channels  ccchan,    -- 
--    import_consent_db_base_channels                 chan,   -- 

    -- systems
    import_consent_db_base_consent_systems          consys,
    import_consent_db_base_systems                  sys
    

WHERE
--    sc.customer_id = cuen.customer_id
--    AND cuen.reference_type_id = 'BAN'

    sc.subscriber_id = cuen.customer_id
    AND cuen.reference_type_id = 'SUBSCRIPTION-ID'

    AND cuen.customer_entity_id = cc.customer_entity_id

    -- consent state
    AND cast(ccs.state_id as STRING) = cc.state_id
    AND cc.consent_id = cn.consent_id

    -- getting channels
 --   AND cc.customer_consent_id = ccchan.customer_consent_id
 --   AND chan.channel_id = ccchan.channel_id

    -- getting systems
    AND cc.consent_id = consys.consent_id
    AND sys.system_id = consys.system_id

ORDER BY sc.subscriber_id

LIMIT 100;


-- the key basic select
SELECT 
    sc.subscriber_id, 
    sc.status, 
    c.name as Consent, 
    ccs.name AS State, 
    cc.change_date

FROM
    analytics.abt_subscriber_current                sc,     -- abt_subscriber info
    base.import_consent_db_base_customer_entities   cuen,   -- source system ma
    import_consent_db_base_customer_consents        cc,     -- the important consent table
    import_consent_db_base_consents                 c,      -- lookup for name
    import_consent_db_base_customer_consent_states  ccs     -- lookup for state

WHERE
    sc.customer_id = cuen.customer_id
    AND cuen.customer_entity_id = cc.customer_entity_id
    AND cast(ccs.state_id as STRING) = cc.state_id
    AND cc.consent_id = c.consent_id
    AND cuen.reference_type_id = 'BAN'

LIMIT 100;


-- how many 'BAN' subscribers do we have in Fokus?
SELECT count(*)
FROM
base.import_consent_db_base_customer_entities cuen,
analytics.abt_subscriber_current sc
WHERE
sc.customer_id = cuen.customer_id
AND cuen.reference_type_id = 'BAN'


LIMIT 100;



-- do we have any duplicates?
SELECT cuen.customer_entity_id, count(*) cnt
FROM
base.import_consent_db_base_customer_entities cuen
WHERE 
cuen.reference_type_id = 'BAN'
GROUP BY
cuen.customer_entity_id

ORDER BY cnt DESC
LIMIT 100;


-- how many customers do we have accross Telia systems
SELECT cuen.reference_type_id, count(*)
FROM
base.import_consent_db_base_customer_entities cuen
GROUP BY
cuen.reference_type_id
