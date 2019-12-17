select count(*) from (SELECT DISTINCT *
  FROM (
    SELECT 
        id AS id,
        ssn AS ssn,
        datecreated AS datecreated,
        cpr_start_date AS cpr_start_date,
        cpr_end_date AS cpr_end_date,
        cpr_subscriber_id AS cpr_subscriber_id,
        cpr_subscriber_no AS cpr_subscriber_no,
        cpr_customer_id AS cpr_customer_id,
        userid AS userid,
        subscriptionid AS subscriptionid,
        sub2_start_date AS sub2_start_date,
        sub2_end_date AS sub2_end_date,
        sub2_subscriber_id AS sub2_subscriber_id,
        sub2_subscriber_no AS sub2_subscriber_no,
        sub2_customer_id AS sub2_customer_id,
        subscriptionnumber AS subscriptionnumber,
        sub3_start_date AS sub3_start_date,
        sub3_end_date AS sub3_end_date,
        sub3_subscriber_id AS sub3_subscriber_id,
        sub3_subscriber_no AS sub3_subscriber_no,
        sub3_customer_id AS sub3_customer_id,
        coalesce(cpr_start_date, sub3_start_date, sub2_start_date) AS start_date,
        coalesce(cpr_end_date, sub3_end_date, sub2_end_date) AS end_date,
        coalesce(cpr_subscriber_id, sub3_subscriber_id, sub2_subscriber_id) AS subscriber_id,
        coalesce(cpr_subscriber_no, sub3_subscriber_no, sub2_subscriber_no) AS subscriber_no,
        coalesce(cpr_customer_id, sub3_customer_id, sub2_customer_id) AS customer_id
      FROM (
        SELECT 
            base_user.id AS id,
            base_user.ssn AS ssn,
            base_user.datecreated AS datecreated,
            abt_subscriber_history.start_date AS cpr_start_date,
            abt_subscriber_history.end_date AS cpr_end_date,
            abt_subscriber_history.subscriber_id AS cpr_subscriber_id,
            abt_subscriber_history.subscriber_no AS cpr_subscriber_no,
            abt_subscriber_history.customer_id AS cpr_customer_id,
            base_user_subscription.userid AS userid,
            base_user_subscription.subscriptionid AS subscriptionid,
            abt_subscriber_history_2.start_date AS sub2_start_date,
            abt_subscriber_history_2.end_date AS sub2_end_date,
            abt_subscriber_history_2.subscriber_id AS sub2_subscriber_id,
            abt_subscriber_history_2.subscriber_no AS sub2_subscriber_no,
            abt_subscriber_history_2.customer_id AS sub2_customer_id,
            base_subscription.subscriptionnumber AS subscriptionnumber,
            abt_subscriber_history_3.start_date AS sub3_start_date,
            abt_subscriber_history_3.end_date AS sub3_end_date,
            abt_subscriber_history_3.subscriber_id AS sub3_subscriber_id,
            abt_subscriber_history_3.subscriber_no AS sub3_subscriber_no,
            abt_subscriber_history_3.customer_id AS sub3_customer_id
          FROM base.import_self_service_base_user base_user
         
          LEFT JOIN base.import_self_service_base_subscription base_subscription
            ON base_user_subscription.subscriptionid = base_subscription.id
          LEFT JOIN base.import_self_service_base_user_subscription base_user_subscription
            ON base_user.id = base_user_subscription.userid
         
         
          LEFT JOIN analytics.abt_subscriber_history
            ON base_user.ssn = abt_subscriber_history.customer_cpr_no
         
         
          
          LEFT JOIN analytics.abt_subscriber_history abt_subscriber_history_2
            ON base_user_subscription.subscriptionid = abt_subscriber_history_2.subscriber_id
         
         
          LEFT JOIN analytics.abt_subscriber_history abt_subscriber_history_3
            ON base_subscription.subscriptionnumber = abt_subscriber_history_3.subscriber_no
        ) withoutcomputedcols_query
    ) unfiltered_query
    )a;
    
    select count(*) from (select distinct * from work.self_service_data_user_subscriber_one_prep) a;

select * from work.self_service_data_user_subscriber_two_distinct
where id=1378 order by start_date asc;

select * from analytics.abt_self_service_profiles
where id=6003 order by start_date asc;