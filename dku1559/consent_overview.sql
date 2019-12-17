--STEP 1
-- find all Direct Marketing AND Metadata (eg. CRM) consents, 
-- then..only include following subscrptions (One, 4SurePremium , 4Everything Light, 4EverythingPremium)
-- then ...split into two groups (ONE) and (4SurePremium , 4Everything Light, 4EverythingPremium)

SELECT      sum( CASE WHEN product_subgroup IN ('ONE') THEN 1 ELSE 0 END )                                                 AS COUNT_ONE_subscriptions
        ,   sum( CASE WHEN product_subgroup IN ('4SURE', '4EVERYTHING Light', '4EVERYTHING Premium') THEN 1 ELSE 0 END )   AS COUNT_LEGACY_SUBSCRIPTIONS
        ,   *
        
FROM abt_consent_data_subscriber

WHERE   dmc = 'given' 
    and crm = 'given'
    and brand IN ('Telia')
    and segment IN  ('BtC')
    and product_group IN ('Postpaid BtC')
    and product_subgroup IN ('ONE', '4SURE', '4EVERYTHING Light', '4EVERYTHING Premium')

;


-- STEP 2
-- ADD customer_id (ban) to STEP 1 selection (e.g.consent data)
-- then.. GROUP BY customer_id 
-- then.. subquery the whole thing, and add filter to only include BANs with AT LEAST 1 ONE_subscriptions (e.g. b_count_one_subscriptions > 0)
--                                                                      AND  AT LEAST 1 LEGACY_subscription

SELECT *
FROM (
            SELECT      a.customer_id                                                                                                       AS a_customer_id
                    ,   sum( CASE WHEN b.product_subgroup IN ('ONE') THEN 1 ELSE 0 END )                                                 AS b_COUNT_ONE_subscriptions
                    ,   sum( CASE WHEN b.product_subgroup IN ('4SURE', '4EVERYTHING Light', '4EVERYTHING Premium') THEN 1 ELSE 0 END )   AS b_COUNT_LEGACY_SUBSCRIPTIONS
            
            FROM    prod_abt_subscriber_current     a
            RIGHT JOIN abt_consent_data_subscriber  b
                ON a.subscriber_id = b.subscriber_id
            
            WHERE   dmc = 'given' 
                and crm = 'given'
                and brand IN ('Telia')
                and segment IN  ('BtC')
                and product_group IN ('Postpaid BtC')
                and product_subgroup IN ('ONE', '4SURE', '4EVERYTHING Light', '4EVERYTHING Premium')
            
            GROUP BY a.customer_id
    )

WHERE       b_COUNT_ONE_subscriptions > 0
        and b_COUNT_LEGACY_SUBSCRIPTIONS > 0

;



--STEP 4, 
-- group counts on customer_id (ban)

--



--strategy
--find all ONE subscriptiones

SELECT      count(subscriber_id) AS count_ONE_subscriptions

FROM    abt_subscriber_current

WHERE       product_brand IN ('Telia')
        and product_product_group IN ('Postpaid BtC')
        and product_budget_product IN ('ONE')
        

--find all 4SurePremium (4SP), 4Everything Light, 4EverythingPremium
SELECT      count(subscriber_id) AS count_NOT_ONE_subscriptions

FROM    abt_subscriber_current

WHERE       product_brand IN ('Telia')
        and product_product_group IN ('Postpaid BtC')
        and product_budget_product NOT IN ('ONE')
;





--WINBACK 23.09.2019
-- STEP 1: Find all churners 
SELECT  *

FROM    prod_abt_subscriber_history

WHERE                   1 = 1
                    and churn_date >= trunc(add_months(current_timestamp(), -6), 'MM')
                    and product_brand IN ('Telia', 'Call me' )
                    and product_product_group IN ('Postpaid BtC', 'Call Me Postpaid BtC')
                    and robinson = 0

;






SELECT  

            YEAR(churn_date)                        AS  churn_year
        ,   MONTH(churn_date)                       AS  churn_month
        ,   DAY(churn_date)                         AS  churn_day
        ,   b.churn_date                            AS  churn_fulldate
        ,   a.dmc
        ,   a.dmc_channel_phone_call
        ,   b.product_brand
        ,   b.product_budget_product
        ,   b.recipient_operator_desc
        ,   b.subscriber_id
        ,   b.subscriber_no
        ,   b.customer_id
        ,   b.first_name
        ,   b.last_business_name
        ,   b.adr_primary_ln
        ,   b.adr_secondary_ln
        
        
FROM prod_abt_consent_data_subscriber   a
    RIGHT JOIN prod_abt_subscriber_history  b
        ON  a.subscriber_id = b.subscriber_id

WHERE                   1 = 1
                    and a.dmc = 'given'
                    and a.dmc_channel_phone_call = 'Yes'
                    and b.churn_date >= trunc(add_months(current_timestamp(), -6), 'MM')
                    and b.product_brand IN ('Telia', 'Call me' )
                    and b.product_product_group IN ('Postpaid BtC', 'Call Me Postpaid BtC')
                    and b.future_churn_reason = 'Cancelation - Port Out'
                    and b.product_prim_acc_type = 'VOICE'
                    and b.robinson = 0
                    
;


select      product_product_group
FROM        prod_abt_subscriber_current
group by    product_product_group
;

--use this count to reduce from total subscriber, to get those without consent.
select      dmc
        ,   crm
        ,   profiling
        ,   count(subscriber_id)
from abt_consent_data_subscriber
WHERE       brand IN ('Mit tele')
        and product_group IN ('Mit Tele Postpaid BtC')

group by dmc, crm, profiling
;        



select count(subscriber_id)
from prod_abt_subscriber_current
WHERE       product_brand IN ('Telia')
        and product_product_group IN ('Postpaid BtC')
        and product_prim_acc_type IN ('VOICE') 

;

--ONLY dmc
select count(subscriber_id)
from prod_abt_consent_data_subscriber
WHERE       brand IN ('Call me')
        and product_group IN ('Call Me Postpaid BtC')
        and dmc = 'given'
        and (crm IS NULL OR crm != 'given')
        and (profiling IS NULL OR profiling != 'given')

;

select count(subscriber_id)
from prod_abt_subscriber_current
WHERE       product_brand IN ('Call me')
        and product_product_group IN ('Call Me Postpaid BtC') 
