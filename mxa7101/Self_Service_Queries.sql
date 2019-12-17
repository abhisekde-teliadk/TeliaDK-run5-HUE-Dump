-----------------------------------------------
-- START: DML-187 #1 active profiles
-----------------------------------------------
set request_pool=big;

SELECT 
       -- strleft(cast(t.datecreated as string), 7) yearmonth,
        count(*) total_profiles_count,
        sum(ghost) no_role,
        sum(login_count) total_logins,
        sum(login_30days_count) logins_30days,
        sum(CASE
               WHEN lo_count IS NOT NULL
                    AND claimed_sub_count IS NULL THEN 1
               ELSE 0
           END) AS legal_owner_only,
           
           

        sum(CASE
               WHEN lo_count IS NOT NULL
                    AND claimed_sub_count > 0 THEN 1
               ELSE 0
           END) AS legal_owner_and_user,


        sum(CASE
               WHEN lo_count IS NULL
                    AND claimed_sub_count > 0
                    AND loar_count IS NULL THEN 1
               ELSE 0
           END) AS user_only,


        sum(CASE
               WHEN lo_count IS NULL
                    AND claimed_sub_count > 0
                    AND loar_count > 0 THEN 1
               ELSE 0
           END) AS legal_owner_access_rights,
 

        sum(CASE
               WHEN churned > 0 THEN 1
               ELSE 0
           END) AS churned_profiles,
           
       sum(claimed_sub_count) AS claimed_subscriptions

FROM
  ( 

-- ##################################
-- ##   SUBQUERY START
-- ##################################
 SELECT
        DISTINCT 
        usr.id,
        brands.brand_name,
        segments.segment_name,
        sb.group_id,
        logins.login_count,
        logins_30days.login_30days_count,
        usr.datecreated,
        datediff(usr.datecreated, bandates.ban_date) ban_profile_days,
        datediff(usr.datecreated, subdates.subscriber_date) sub_profile_days,
        bandates.last_ban_date,
        subdates.last_churn_date,
        usr.name username,
        lo.lo_count,
        loar.loar_count,
        banchurn.ban_churned_count,
        claimed_sub.claimed_sub_count,
        claimed_sub_churned.claimed_sub_churned_count,
        CASE
            WHEN lo_count IS NOT NULL
                 AND claimed_sub_count IS NULL THEN 1
            ELSE 0
        END AS legal_owner_only,
        
        
        CASE
            WHEN lo_count IS NOT NULL
                 AND claimed_sub_count > 0 THEN 1
            ELSE 0
        END AS legal_owner_and_user,
        
        
        
        CASE
            WHEN lo_count IS NULL
                 AND claimed_sub_count > 0
                 AND loar_count IS NULL THEN 1
            ELSE 0
        END AS user_only,
        
        
        CASE
            WHEN lo_count IS NULL
                 AND claimed_sub_count > 0
                 AND loar_count > 0 THEN 1
            ELSE 0
        END AS legal_owner_access_rights,
        
        
        CASE
            WHEN lo_count IS NULL
                 AND claimed_sub_count IS NULL
                 AND loar_count IS NULL
                 AND claimed_sub_count IS NULL
                 AND ( banchurn.ban_churned_count > 0
                      OR claimed_sub_churned.claimed_sub_churned_count > 0 ) THEN 1
            ELSE 0
        END AS churned,
        
        CASE
            WHEN lo_count IS NULL
                 AND claimed_sub_count IS NULL
                 AND loar_count IS NULL
                 AND claimed_sub_count IS NULL
                 AND ( banchurn.ban_churned_count IS NULL
                      AND claimed_sub_churned.claimed_sub_churned_count is NULL ) THEN 1
            ELSE 0
        END AS ghost
        
        
        
   FROM 
    -- user entity
    base.import_self_service_base_user usr 
 
    -- brand
    LEFT JOIN (
    SELECT id, name brand_name FROM base.import_self_service_base_brand
    ) brands ON usr.brandid = brands.id

    -- segment
    LEFT JOIN (
    SELECT id, name segment_name FROM base.import_self_service_base_segment
    ) segments ON usr.segmentid = segments.id



    -- total cout of logins
    LEFT JOIN (
    SELECT al.userid loginuid,
        count(*) login_count
        FROM base.import_self_service_base_authentication_log al
        GROUP BY al.userid

    ) logins on usr.id = logins.loginuid


    -- total count of logins within last 30 days
    LEFT JOIN (
    SELECT al.userid login30uid,
        count(*) login_30days_count
        FROM base.import_self_service_base_authentication_log al
        WHERE datediff(now(), al.created) <= 30
        GROUP BY al.userid

    ) logins_30days on usr.id = logins_30days.login30uid

   LEFT JOIN
     ( 
    
    -- getting legal owners of a ban  
    SELECT usrban.userid AS loban_usr_id,
              count(*) lo_count

      FROM base.import_self_service_base_user_ban usrban,
           base.import_self_service_base_ban ban,
           analytics.abt_customer_current cucu

      WHERE cucu.ban_status = 'Open'
        AND ban.bannumber = cucu.customer_id
        AND ban.id = usrban.banid
        AND usrban.banaccessrightsid = 1 -- legal owner

      GROUP BY usrban.userid ) lo ON usr.id = lo.loban_usr_id 

   LEFT JOIN
     ( 
    
    -- getting cout of legal owners acces rights 
    SELECT usrban.userid AS loarban_usr_id,
              count(*) loar_count
      FROM base.import_self_service_base_user_ban usrban,
           base.import_self_service_base_ban ban,
           analytics.abt_customer_current cucu
      WHERE cucu.ban_status = 'Open'
        AND ban.bannumber = cucu.customer_id
        AND ban.id = usrban.banid
        AND usrban.banaccessrightsid = 2 -- legal owner access rights

      GROUP BY usrban.userid ) loar ON usr.id = loar.loarban_usr_id 

   LEFT JOIN
     ( 
     
    -- getting the BAN churned 
    SELECT usrban.userid AS banchurn_usr_id,
              count(*) ban_churned_count
      FROM base.import_self_service_base_user_ban usrban,
           base.import_self_service_base_ban ban,
           analytics.abt_customer_current cucu
      WHERE cucu.ban_status <> 'Open'
        AND ban.bannumber = cucu.customer_id
        AND ban.id = usrban.banid 

      GROUP BY usrban.userid ) banchurn ON usr.id = banchurn_usr_id 

   LEFT JOIN
     ( 
     
    -- getting the first ban date and last update ban date
    SELECT usrban.userid AS bandate_usr_id,
              first_value(cucu.start_service_date) OVER (PARTITION BY usrban.userid ORDER BY cucu.start_service_date ASC) AS ban_date,
               last_value(cucu.status_last_date) OVER (PARTITION BY usrban.userid ORDER BY cucu.start_service_date ASC) AS last_ban_date
      FROM base.import_self_service_base_user_ban usrban,
           base.import_self_service_base_ban ban,
           analytics.abt_customer_current cucu
      WHERE 
         ban.bannumber = cucu.customer_id
        AND ban.id = usrban.banid 

    
      ) bandates ON usr.id = bandate_usr_id 


   LEFT JOIN
     ( 
    
    -- getting claimed subscription count 
    SELECT usub.userid AS sub_usr_id,
              count(*) claimed_sub_count
      FROM base.import_self_service_base_user_subscription usub,
           analytics.abt_subscriber_current suc
      WHERE usub.subscriptionid = suc.subscriber_id
        AND suc.status = 'a'
      GROUP BY usub.userid ) claimed_sub ON usr.id = claimed_sub.sub_usr_id 

   LEFT JOIN
     ( 
    
    -- getting claimed subscription churned count 
    SELECT usub.userid AS sub_usr_id,
              count(*) claimed_sub_churned_count
      FROM base.import_self_service_base_user_subscription usub,
           analytics.abt_subscriber_current suc
      WHERE usub.subscriptionid = suc.subscriber_id
        AND suc.status <> 'a'
      GROUP BY usub.userid ) claimed_sub_churned ON usr.id = claimed_sub_churned.sub_usr_id
      



   LEFT JOIN
     ( 
    
    -- getting the first subscription and last churned day
    SELECT usub.userid AS subdate_usr_id,
              first_value(suc.act_date) OVER (PARTITION BY usub.userid ORDER BY suc.act_date ASC) AS subscriber_date,
              last_value(suc.churn_date) OVER (PARTITION BY usub.userid ORDER BY suc.act_date ASC) AS last_churn_date
              
      FROM base.import_self_service_base_user_subscription usub,
           analytics.abt_subscriber_current suc
      WHERE usub.subscriptionid = suc.subscriber_id
      -- GROUP BY usub.userid 
      ) subdates ON usr.id = subdates.subdate_usr_id
      
            
    LEFT JOIN work.consent_tbt_consent_switchr_bridge sb ON sb.switchr_id = usr.id
    
   WHERE TRUE and usr.id = 171

                      
    ORDER BY usr.datecreated DESC

-- ##################################
-- ##   SUBQUERY END
-- LIMIT 100;
-- ##################################
 -- end of subquery


) t
-- GROUP BY strleft(cast(t.datecreated as STRING), 7) 
-- ORDER BY yearmonth ASC
LIMIT 100 ;


SELECT id, count(*) FROM work.self_service_data_work_user_sub_current_userid_window GROUP BY id having count(*) > 1;

SELECT count(*) FROM analytics.abt_self_service_profiles;

    -- getting the first ban date and last update ban date
    SELECT usrban.userid AS bandate_usr_id,
              first_value(cucu.start_service_date) OVER (PARTITION BY usrban.userid ORDER BY cucu.start_service_date ASC) AS ban_date,
               last_value(cucu.status_last_date) OVER (PARTITION BY usrban.userid ORDER BY cucu.start_service_date ASC) AS last_ban_date
      FROM base.import_self_service_base_user_ban usrban,
           base.import_self_service_base_ban ban,
           analytics.abt_customer_current cucu
      WHERE 
         ban.bannumber = cucu.customer_id
        AND ban.id = usrban.banid;
        
        
    -- getting the first subscription and last churned day
    SELECT usub.userid AS subdate_usr_id,
              first_value(suc.act_date) OVER (PARTITION BY usub.userid ORDER BY suc.act_date ASC) AS subscriber_date,
              last_value(suc.churn_date) OVER (PARTITION BY usub.userid ORDER BY suc.act_date ASC) AS last_churn_date
              
      FROM base.import_self_service_base_user_subscription usub,
           analytics.abt_subscriber_current suc
      WHERE usub.subscriptionid = suc.subscriber_id
      and usub.id = 2461;
      
      
      select usub.id, usub.userid, suc.act_date, suc.churn_date
            FROM base.import_self_service_base_user_subscription usub,
           analytics.abt_subscriber_current suc
      WHERE usub.subscriptionid = suc.subscriber_id
      and usub.id = 5076;
      
      
      
       SELECT *
      FROM base.import_self_service_base_user_ban usrban,
           base.import_self_service_base_ban ban,
           analytics.abt_customer_current cucu
      WHERE 
         ban.bannumber = cucu.customer_id
        AND ban.id = usrban.banid
        and usrban.userid = 178;