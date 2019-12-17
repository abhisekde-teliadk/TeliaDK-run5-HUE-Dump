SELECT DISTINCT *
  FROM (
    SELECT 
        id AS id,
        ssn AS ssn,
        datecreated AS datecreated,
       /* cpr_start_date AS cpr_start_date,
        cpr_end_date AS cpr_end_date,
        cpr_subscriber_id AS cpr_subscriber_id,
        cpr_subscriber_no AS cpr_subscriber_no,
        cpr_customer_id AS cpr_customer_id,*/
        userid AS userid,
        subscriptionid AS subscriptionid,
        subscriptionnumber,
  /*      sub_start_date AS sub_start_date,
        sub3_start_date,
        sub_end_date AS sub_end_date,
        sub3_end_date,
        sub_subscriber_id AS sub_subscriber_id,
        sub3_subscriber_id,
        sub_subscriber_no AS sub_subscriber_no,
        sub3_subscriber_no,
        sub_customer_id AS sub_customer_id,
        sub3_customer_id,*/
       
-- OLD
/* coalesce(cpr_start_date, sub_start_date, sub3_start_date) AS start_date,
        coalesce(cpr_end_date, sub_end_date, sub3_end_date) AS end_date,
        coalesce(cpr_subscriber_id,sub_subscriber_id, sub3_subscriber_id) AS subscriber_id,
        coalesce(cpr_subscriber_no,sub_subscriber_no, sub3_subscriber_no) AS subscriber_no,
        coalesce(cpr_customer_id, sub_customer_id, sub3_customer_id) AS customer_id,*/
        --test
        coalesce(cpr_start_date, sub3_start_date, sub_start_date ) AS start_date,
        coalesce(cpr_end_date, sub3_end_date, sub_end_date) AS end_date,
        coalesce(cpr_subscriber_id, sub3_subscriber_id, sub_subscriber_id) AS subscriber_id,
        coalesce(cpr_subscriber_no, sub3_subscriber_no, sub_subscriber_no) AS subscriber_no,
        coalesce(cpr_customer_id, sub3_customer_id, sub_customer_id) AS customer_id
        
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
            base_subscription.subscriptionnumber AS subscriptionnumber,
            abt_subscriber_history_2.start_date AS sub_start_date,
            abt_subscriber_history_2.end_date AS sub_end_date,
            abt_subscriber_history_2.subscriber_id AS sub_subscriber_id,
            abt_subscriber_history_2.subscriber_no AS sub_subscriber_no,
            abt_subscriber_history_2.customer_id AS sub_customer_id,
            
            --new
            abt_subscriber_history_3.start_date AS sub3_start_date,
            abt_subscriber_history_3.end_date AS sub3_end_date,
            abt_subscriber_history_3.subscriber_id AS sub3_subscriber_id,
            abt_subscriber_history_3.subscriber_no AS sub3_subscriber_no,
            abt_subscriber_history_3.customer_id AS sub3_customer_id
            
          FROM base.import_self_service_base_user base_user
          LEFT JOIN base.import_self_service_base_user_subscription base_user_subscription
            ON base_user.id = base_user_subscription.userid
          LEFT JOIN base.import_self_service_base_subscription base_subscription
            ON base_user_subscription.subscriptionid = base_subscription.id
          
          LEFT JOIN analytics.abt_subscriber_history
            ON base_user.ssn = abt_subscriber_history.customer_cpr_no
            
          LEFT JOIN analytics.abt_subscriber_history abt_subscriber_history_2
            ON base_user_subscription.subscriptionid = abt_subscriber_history_2.subscriber_id
            
          LEFT JOIN analytics.abt_subscriber_history abt_subscriber_history_3
            ON base_subscription.subscriptionnumber = abt_subscriber_history_3.subscriber_no
        ) withoutcomputedcols_query
    ) unfiltered_query
    where id=6003
    --order by new_start_date asc
    ;
    
    select count(*) from base.import_self_service_base_user;

select * from analytics.abt_self_service_profiles
where id in (336016,1378, 14150,7761,6003) ;   
    
    
select * from work.self_service_data_user_subscriber_eldest user_subscriber_join
left join analytics.abt_subscriber_history
ON (user_subscriber_join.start_date = abt_subscriber_history.start_date)
          AND (user_subscriber_join.end_date = abt_subscriber_history.end_date)
          AND (user_subscriber_join.subscriber_id = abt_subscriber_history.subscriber_id)
          AND (user_subscriber_join.subscriber_no = abt_subscriber_history.subscriber_no)
          AND (user_subscriber_join.customer_id = abt_subscriber_history.customer_id)
where id in (336016,1378, 14150,7761,6003); order by user_subscriber_join.start_date asc;
