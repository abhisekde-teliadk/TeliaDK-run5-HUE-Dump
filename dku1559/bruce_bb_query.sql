

-------------------------------------------------CUSTOMER SECTION-----------------------------------------------------------------------
SELECT *
FROM (

SELECT      NO_
        ,   name_
        ,   name_2
        ,   address
        ,   address_2
        ,   city
        ,   post_code
        ,   main_door
        ,   floor
        ,   door
        ,   street_number
        ,   road_code
        ,   global_dimension_1_code
        ,   global_dimension_2_code
        ,   segment_
        ,   sub_segment
        ,   municipality
        ,   end_cycle_code
        ,   payment_code
        ,   email
        ,   phone_no_

from bruce_1
where cast(no_ as int) = 90361499
) as q
;


------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------BB SECTION-----------------------------------------------------------------------

--FIND ALL CUSTOMERS WITH BB
CREATE TABLE BB AS
SELECT  DISTINCT NO_
      , design_product_code     AS BBSPEED_CODE
      , description             AS BBSPEED
      , next_period_price_vat   AS BBSPEED_PRICE

from bruce_1

WHERE       design_parent_product_code IN ('50100', '55100')
;



--FIND ALL CUSTOMERS WITH A BB-DISCOUNT
-- 46 custoemrs has more than one of these discount. error, but continue due to deadline.
CREATE TABLE DISCOUNTS_BB_25092019 AS
SELECT  NO_
      , design_product_code     AS BBDISCOUNT_CODE
      , description             AS BBDISCOUNT
      , next_period_price_vat   AS BBDISCOUNT_PRICE

from bruce_1

WHERE       design_product_code IN ('50010', '55010')
        and cast(next_period_price_vat as int) < -1
;


------------------------------------------------------------------------------------------------------------------------


-------------------------------------------------VOIP SECTION-----------------------------------------------------------------------

--FIND ALL CUSTOMERS WITH VOIP
CREATE TABLE VOIP_25092019 AS
SELECT  NO_
      , design_product_code     AS VOIP_CODE
      , description             AS VOIP
      , next_period_price_vat   AS VOIP_PRICE

from bruce_1

WHERE   design_parent_product_code IN ('50405', '55405')

;





----------------------------------------------------TV SECTION--------------------------------------------------------------------


----------------------------------------------
---FIND ALL CUSTOMERS WITH TRIPLE_PLAY
--
CREATE TABLE TRIPLE_PLAY_25092019 AS
select      no_
        ,   design_product_code     AS TVPLAN_CODE_1
        ,   description             AS TVPLAN_1
        ,   next_period_price_vat   AS TVPLAN_PRICE_1

      
FROM bruce_1

WHERE   1=1
    and design_parent_product_code IN ('55606')
    and cast(next_period_price_vat as int) >= 0
;
--------------------------------------------



----------------------------------------------
---FIND ALL CUSTOMERS WITH IPTV
--
CREATE TABLE IPTV_25092019 AS
SELECT  no_ 
      , design_product_code     AS TVPLAN_CODE_2
      , description             AS TVPLAN_2
      , next_period_price_vat   AS TVPLAN_PRICE_2
      
FROM bruce_1

WHERE   design_parent_product_code IN ('60606')
    and cast(next_period_price_vat as int) >= 0
;
--------------------------------------------



----------------------------------------------
---FIND ALL CUSTOMERS WITH DISCOUNT and TRIPLE_PLAY
--
CREATE TABLE DISCOUNT_TRIPLE_PLAY_25092019 AS
select      no_
        ,   design_product_code     AS TVPLAN_DISCOUNT_CODE
        ,   description             AS TVPLAN_DISCOUNT
        ,   next_period_price_vat   AS TVPLAN_DISCOUNT_PRICE

      
FROM bruce_1

WHERE   1=1
    and design_parent_product_code IN ('55606')
    and cast(next_period_price_vat as int) < -1
;
--------------------------------------------
 
 
 
--------------------------------------------
---FIND ALL CUSTOMERS WITH DISCOUNT and IPTV
--
CREATE TABLE DISCOUNT_IPTV_25092019 AS
SELECT  no_ 
      , design_product_code     AS TVPLAN_DISCOUNT_CODE_2
      , description             AS TVPLAN_DISCOUNT_2
      , next_period_price_vat   AS TVPLAN_DISCOUNT_PRICE_2
      
FROM bruce_1

WHERE   design_parent_product_code IN ('60606')
    and cast(next_period_price_vat as int) < -1
;
--------------------------------------------


------------------------------------------------------------------------------------------------------------------------





----------------------------------------------------JOIN SECTION--------------------------------------------------------------------

SELECT *
FROM analytics.BB
    LEFT JOIN analytics.DISCOUNTS_BB_25092019
        ON BB.no_ = DISCOUNTS_BB_25092019.no_
    LEFT JOIN analytics.VOIP_25092019
        ON BB.no_ = VOIP_25092019.no_
    LEFT JOIN TRIPLE_PLAY_25092019
        ON BB.no_ = TRIPLE_PLAY_25092019.no_
    LEFT JOIN DISCOUNT_TRIPLE_PLAY_25092019
        ON BB.no_ = DISCOUNT_TRIPLE_PLAY_25092019.no_
    LEFT JOIN IPTV_25092019
        ON BB.no_ = IPTV_25092019.no_
    LEFT JOIN DISCOUNT_IPTV_25092019
        ON BB.no_ = DISCOUNT_IPTV_25092019.no_

;




select count(NO_)
from bruce_1
WHERE       design_parent_product_code IN ('50100', '55100')
;


Select *
from bruce_1
where NO_ IN ('90161652')
;


select      campaign_no_
        ,   short_description
from analytics.bb_1

group by    campaign_no_
        ,   short_description
;

select product_product_group
FROM    analytics.prod_abt_subscriber_current
GROUP BY product_product_group
;


SELECT  * 
FROM    analytics.prod_abt_subscriber_current
WHERE   1=1
        and customer_id IN (419116116)
--        and product_product_group IN ('Broadband BtC')
;




-------------------------------------------------
--FIND ALL MIGRATION READY CUSTOMERS
SELECT *
FROM analytics.latest_migration_list_prepared
;



-- FIND ALL CUSTOMERS WITH VAS
SELECT      count(customer_id)
        ,   vas_type		
FROM analytics.prod_abt_service_current
group by vas_type
;



-------------------------------------------------------------------------------------
--step 1:
---- CREATE VAS_01102019 .... by JOIN  ole´s soc_update tabel WITH service_current tabel
CREATE TABLE VAS_01102019 AS
SELECT      a_customer_id
        ,   a_subscriber_id
        ,   a_subscriber_product_product_desc
        ,   a_subscriber_product_price
--        ,   a_soc_soc_description
--        ,   a_soc_price
--        ,   new_bi_vas_type
FROM (
        SELECT      a.customer_id                       as  a_customer_id
                ,   a.subscriber_id                     as  a_subscriber_id
                ,   a.subscriber_product_product_desc   as  a_subscriber_product_product_desc
                ,   a.subscriber_product_price          as  a_subscriber_product_price
                ,   a.soc                               as  a_soc
                ,   a.soc_soc_description	            as  a_soc_soc_description
                ,   a.soc_price                         as  a_soc_price
                ,   b.vas_type                          as  new_bi_vas_type
        FROM analytics.prod_abt_service_current a
            INNER JOIN   soc_liste_prepared b
                ON a.soc = b.soc
                ) as q
                
WHERE       a_subscriber_product_product_desc LIKE ('%Home%') 
;

--find customer in subscriber
SELECT *
FROM analytics.prod_abt_subscriber_current
WHERE customer_id = 400802211
;

--find customer in vas
SELECT *
FROM analytics.prod_abt_service_current
WHERE customer_id = 400802211
;
-------------------------------------------------------------------------------------
--step 2
---- JOIN VAS_01102019 with latest_migration_list_prepared
SELECT *
FROM analytics.latest_migration_list_prepared a
    LEFT JOIN VAS_01102019 b
        ON a.fokus_customerid = b.customer_id

WHERE       fokus_broadband_subscription >= 1
        OR  fokus_4ghome_subscription >= 1 
;


-- FIND EACH VAS
-- JOIN THEM INDIVIDUALLY INTO BRUCE.

--VAS 1 - HBO 
SELECT      new_bi_vas_type
        ,   soc
        ,   soc_soc_description
        ,   soc_price
        
FROM    
WHERE


SELECT      subscriber_id
        ,   product_product_desc
        ,   product_price
FROM analytics.prod_abt_subscriber_current
WHERE       product_product_group IN ('Broadband BtC')
        and product_product_desc LIKE ('%Home%')

;







----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------BRUCE AREA---------------------------------------------------BRUCE AREA---------------------------------------------------BRUCE AREA---------------------------------------------------BRUCE AREA-----------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


;--BRUCE all

SELECT *
FROM analytics.bb_1
where no_ = '90150420'
LIMIT 100
;

-------------------------------------------------------------
---------------------- BB SECTION ---------------------------
-------------------------------------------------------------

--FIND ALL CUSTOMERS WITH BB
--COMMENT: Dropping distinct will remove people who actually have 2 bb products on same no_ 
--(e.g. cornercases will be rejected by jespers motor?)
CREATE TABLE BB_02102019 as
SELECT  DISTINCT no_
      , design_product_code     AS BBSPEED_CODE
      , description             AS BBSPEED_DESCRIPTION
      , cast(next_period_price_vat as int)   AS BBSPEED_PRICE

FROM analytics.bb_1

WHERE       design_parent_product_code IN ('50100', '55100')
;

--FIND ALL CUSTOMERS WITH A BB-DISCOUNT
-- COMMENT: 46 customers has more than one of these discount. error, but continue due to deadline.
CREATE TABLE DISCOUNTS_BB_02102019 AS
SELECT  DISTINCT NO_
      , design_product_code     AS BBDISCOUNT_CODE
      , description             AS BBDISCOUNT_DESCRIPTION
      , next_period_price_vat   AS BBDISCOUNT_PRICE

from analytics.bb_1

WHERE       design_product_code IN ('50010', '55010')
        and cast(next_period_price_vat as int) < -1
;

-------------------------------------------------------------
---------------------- VOIP SECTION -------------------------
-------------------------------------------------------------


--FIND ALL CUSTOMERS WITH VOIP
CREATE TABLE VOIP_02102019 AS
SELECT  DISTINCT NO_
      , design_product_code     AS VOIP_CODE
      , description             AS VOIP_DESCRIPTION
      , next_period_price_vat   AS VOIP_PRICE

from analytics.bb_1

WHERE   design_parent_product_code IN ('50405', '55405')
;

-------------------------------------------------------------
---------------------- TV SECTION ---------------------------
-------------------------------------------------------------

---FIND ALL CUSTOMERS WITH TRIPLE_PLAY
CREATE TABLE TRIPLE_PLAY_02102019 AS
select      DISTINCT no_
        ,   design_product_code     AS TRIPLEPLAY_CODE
        ,   description             AS TRIPLEPLAY_description
        ,   next_period_price_vat   AS TRIPLEPLAY_PRICE

      
FROM analytics.bb_1

WHERE   1=1
    and design_parent_product_code IN ('55606')
    and cast(next_period_price_vat as int) >= 0
;



---FIND ALL CUSTOMERS WITH TV (split between iptv and tv sa/vas is made later by looking at tv box) 
CREATE TABLE TV_PLAN1_02102019 AS
SELECT  DISTINCT no_ 
     , design_product_code     AS TV_PLAN1_CODE
     , description             AS TV_PLAN1_description
     , next_period_price_vat   AS TV_PLAN1_PRICE
      
FROM analytics.bb_1

WHERE   design_parent_product_code IN ('60606')
    and cast(next_period_price_vat as int) >= 0
;



---FIND ALL CUSTOMERS WITH A DISCOUNT and  TRIPLE_PLAY
CREATE TABLE DISCOUNT_TRIPLE_PLAY_02102019 AS
SELECT      DISTINCT no_
        ,   design_product_code     AS TRIPLEPLAY_DISCOUNT_CODE
        ,   description             AS TRIPLEPLAY_DISCOUNT_description
        ,   next_period_price_vat   AS TRIPLEPLAY_DISCOUNT_PRICE

      
FROM analytics.bb_1

WHERE   1=1
    and design_parent_product_code IN ('55606')
    and cast(next_period_price_vat as int) < -1
;



---FIND ALL CUSTOMERS WITH DISCOUNT AND NON_TRIPLEPLAY_TVPLAN
CREATE TABLE DISCOUNT_TV_PLAN1_02102019 AS
SELECT  DISTINCT no_ 
      , design_product_code     AS TV_PLAN1_DISCOUNT_CODE
      , description             AS TV_PLAN1_DISCOUNT_description
      , next_period_price_vat   AS TV_PLAN1_DISCOUNT_PRICE
      
FROM analytics.bb_1

WHERE   design_parent_product_code IN ('60606')
    and cast(next_period_price_vat as int) < -1
;




-------------------------------------------------------------
---------------------- JOIN SECTION -----------------------
-------------------------------------------------------------
SELECT *
FROM BB_02102019 a
    LEFT JOIN DISCOUNTS_BB_02102019 b
        ON a.no_ = b.no_

;

--CREATE DISCOUNTS



-- JOIN THEN



--COMPLEX JOIN
SELECT      CASE WHEN (a.no_ = b.no_ OR b.no_ IS NULL) AND (a.no_ = c.no_ OR c.no_ IS NULL) AND (a.no_ = d.no_ OR d.no_ IS NULL) AND (a.no_ = e.no_ OR e.no_ IS NULL) AND (a.no_ = f.no_ OR f.no_ IS NULL) AND (a.no_ = g.no_ OR g.no_ IS NULL)
            THEN 'MATCH' ELSE 'ERROR' END as check_field
        ,   *
    
FROM BB_02102019 a
    LEFT JOIN DISCOUNTS_BB_02102019 b
        ON a.no_ = b.no_
    LEFT JOIN VOIP_02102019 c
        ON a.no_ = c.no_
    LEFT JOIN TRIPLE_PLAY_02102019 d
        ON a.no_ = d.no_
    LEFT JOIN TV_PLAN1_02102019 e
        ON a.no_ = e.no_
    LEFT JOIN DISCOUNT_TRIPLE_PLAY_02102019 f
        ON a.no_ = f.no_
    LEFT JOIN DISCOUNT_TV_PLAN1_02102019 g
        ON a.no_ = g.no_

;


-------------------------------------------------------------
---------------------- CAMPAIGN CODES -----------------------
-------------------------------------------------------------

--------------------------------------
-- CAMPAIGN 68	Every 6. Month for Free
--
CREATE TABLE campaign_no_68_BOTH as
SELECT      DISTINCT no_ 
        ,   campaign_no_
        ,   short_description
        --CREATE DISCOUNT : bb_speed_product_price / 6 = monthly campaign discount
        ,   cast(next_period_price_vat as int) / 6 * -1 as discount
        
FROM bb_1
WHERE   campaign_no_ = '68' 
    and design_parent_product_code IN ('50100', '55100')



--------------------------------------
-- CAMPAIGN 43	Løbende rabat på 30 kr.
--
CREATE TABLE campaign_no_43_BOTH as
SELECT      DISTINCT no_ 
        ,   campaign_no_
        ,   short_description
        --CREATE DISCOUNT : cast(next_period_price_vat as int) = Ongoing price reduction of 30
        ,   cast(next_period_price_vat as int) as discount
        
FROM bb_1
WHERE       CAMPAIGN_NO_ = '43'      
        and design_product_code IN ('50010', '55010')   
        and cast(next_period_price_vat as int) = -30
;


--------------------------------------
-- CAMPAIGN 5	no description
--
CREATE TABLE campaign_no_5 as
SELECT      DISTINCT no_
        ,   campaign_no_
        ,   short_description
        --CREATE DISCOUNT : price reduction is made to bbspeed price so it fits 249, unless price is <249 then no discount
        ,    
                CASE WHEN campaign_no_ = '5'    AND    design_parent_product_code IN ('50100', '55100')     AND   next_period_price_vat = '329' THEN -80
                     WHEN campaign_no_ = '5'    AND    design_parent_product_code IN ('50100', '55100')     AND   next_period_price_vat = '279' THEN -30
                ELSE 0 END as discount
            
FROM analytics.BB_1

WHERE       campaign_no_ = '5'
        and design_parent_product_code IN ('50100', '55100')
;


--------------------------------------
-- CAMPAIGN 52	20% discount on bb_speed_product (discount made on bill, no indication in bruce)
--
CREATE TABLE campaign_no_52 as
SELECT      DISTINCT no_
        ,   campaign_no_
        ,   short_description
        --CREATE DISCOUNT : 20% discount on bb_speed_product (discount made on bill, no indication in bruce)
        ,   CASE WHEN CAMPAIGN_NO_ = '52'   AND    DESIGN_PARENT_PRODUCT_CODE = '50100'     THEN cast(next_period_price_vat as int) * 0.2 * -1
            ELSE 0 END as discount
FROM analytics.BB_1

WHERE       campaign_no_ = '52'
        and design_parent_product_code IN ('50100')
;



--------------------------------------
-- CAMPAIGN 42	20 DKK discount on bb_speed_product (discount made on bill, no indication in bruce)
--
CREATE TABLE campaign_no_42 as
SELECT      DISTINCT no_
        ,   campaign_no_
        ,   short_description
        --CREATE DISCOUNT : 20 DKK discount on bb_speed_product (discount made on bill, no indication in bruce)
        ,   CASE WHEN CAMPAIGN_NO_ = '42'   AND    DESIGN_PRODUCT_CODE = '50010' AND cast(next_period_price_vat as int) <-1     THEN -20
            ELSE 0 END as discount
FROM analytics.BB_1

WHERE       campaign_no_ = '42'
        and design_product_code IN ('50010')
        and cast(next_period_price_vat as int) <-1
;

--------------------------------------
-- CAMPAIGN 54	10% discount on bb_speed_product (discount made on bill, no indication in bruce)
--
CREATE TABLE campaign_no_54 as
SELECT      DISTINCT no_
        ,   campaign_no_
        ,   short_description
        --CREATE DISCOUNT : 20% discount on bb_speed_product (discount made on bill, no indication in bruce)
        ,   CASE WHEN CAMPAIGN_NO_ = '54'   AND    DESIGN_PARENT_PRODUCT_CODE = '50100'     THEN cast(next_period_price_vat as int) * 0.1 * -1
            ELSE 0 END as discount
FROM analytics.BB_1

WHERE       campaign_no_ = '54'
        and design_parent_product_code IN ('50100')
;

--------------------------------------
-- CAMPAIGN 41	10 DKK discount on bb_speed_product (discount made on bill, no indication in bruce)
--
CREATE TABLE campaign_no_41 as
SELECT      DISTINCT no_
        ,   campaign_no_
        ,   short_description
        --CREATE DISCOUNT : 20 DKK discount on bb_speed_product (discount made on bill, no indication in bruce)
        ,   CASE WHEN CAMPAIGN_NO_ = '41'   AND    DESIGN_PRODUCT_CODE = '50010' AND cast(next_period_price_vat as int) <-1     THEN -10
            ELSE 0 END as discount
FROM analytics.BB_1

WHERE       campaign_no_ = '41'
        and design_product_code IN ('50010')
        and cast(next_period_price_vat as int) <-1
;
--check each campaign code


SELECT *
FROM analytics.bb_1
where no_ = '90090213'


------------ FINAL OUTPUT ------------ 

SELECT     a.no_ 
        ,  a.bbspeed_code
        ,  a.bbspeed_description
        ,  a.bbspeed_price
        
        --add campaign 68
        ,   b.no_               as  b_no_
        ,   b.campaign_no_      as  b_campaign_no_ 
        ,   b.short_description as  b_short_description
        ,   b.discount          as  b_discount

        --add campaign 43
        ,   c.no_               as  c_no_
        ,   c.campaign_no_      as  c_campaign_no_ 
        ,   c.short_description as  c_short_description
        ,   c.discount          as  c_discount
        
         --add campaign 5
        ,   d.no_               as  d_no_
        ,   d.campaign_no_      as  d_campaign_no_ 
        ,   d.short_description as  d_short_description
        ,   d.discount          as  d_discount

         --add campaign 52
        ,   e.no_               as  e_no_
        ,   e.campaign_no_      as  e_campaign_no_ 
        ,   e.short_description as  e_short_description
        ,   e.discount          as  e_discount
        
          --add campaign 42
        ,   f.no_               as  f_no_
        ,   f.campaign_no_      as  f_campaign_no_ 
        ,   f.short_description as  f_short_description
        ,   f.discount          as  f_discount       

          --add campaign 54
        ,   g.no_               as  g_no_
        ,   g.campaign_no_      as  g_campaign_no_ 
        ,   g.short_description as  g_short_description
        ,   g.discount          as  g_discount              
        
            --add campaign 41
        ,   h.no_               as  h_no_
        ,   h.campaign_no_      as  h_campaign_no_ 
        ,   h.short_description as  h_short_description
        ,   h.discount          as  h_discount 
        
            --calculate total current bb_speed_price
        ,   NVL(a.bbspeed_price,0) + NVL(c.discount,0) + NVL(d.discount,0) + NVL(e.discount,0) + NVL(f.discount,0) + NVL(g.discount,0) + NVL(h.discount,0) as current_bb_speed_price
        
            --insert NEW_bb_speed_price here (define previous price bracket)
        --  ,   

            --calculate difference in price
        -- ,   


FROM      analytics.BB_02102019 a
        LEFT JOIN analytics.campaign_no_68_BOTH b
            ON a.no_ = b.no_
        LEFT JOIN analytics.campaign_no_43_BOTH c
            ON a.no_ = c.no_
        LEFT JOIN analytics.campaign_no_5 d
            ON a.no_ = d.no_
        LEFT JOIN analytics.campaign_no_52 e
            ON a.no_ = e.no_
        LEFT JOIN analytics.campaign_no_42 f
            ON a.no_ = f.no_
        LEFT JOIN analytics.campaign_no_54 g
            ON a.no_ = g.no_
        LEFT JOIN analytics.campaign_no_41 h
            ON a.no_ = h.no_


;




SELECT  

            YEAR(churn_date)                        AS  churn_year
        ,   MONTH(churn_date)                       AS  churn_month
        ,   DAY(churn_date)                         AS  churn_day
        ,   b.churn_date                            AS  churn_fulldate
        ,   a.dmc
        ,   a.dmc_channel_phone_call
	    ,   b.robinson
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
                    and b.churn_date >= trunc(add_months(current_timestamp(), -6), 'MM')
                    and b.product_brand IN ('Telia', 'Call me' )
                    and b.product_product_group IN ('Postpaid BtC', 'Call Me Postpaid BtC')
                    and b.future_churn_reason = 'Cancelation - Port Out'
                    and b.product_prim_acc_type = 'VOICE'

;

