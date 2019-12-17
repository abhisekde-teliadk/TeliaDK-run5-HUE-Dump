SELECT 
    base_user_ban.banid AS banid,
    base_user_ban.userid AS userid,
    base_user_ban.banaccessrightsid AS banaccessrightsid,
    base_user_ban.datecreated AS datecreated,
    base_ban.bannumber AS bannumber,
    abt_customer_current.customer_id AS customer_id,
    abt_customer_current.ban_status AS ban_status,
    abt_customer_current.start_service_date AS start_service_date,
    abt_customer_current.status_last_date AS status_last_date
  FROM base.import_self_service_base_user_ban base_user_ban
  INNER JOIN base.import_self_service_base_ban base_ban
    ON base_user_ban.banid = base_ban.id
  INNER JOIN analytics.abt_customer_current
    ON base_ban.bannumber = abt_customer_current.customer_id
where base_user_ban.userid=514862;

select * from base.import_self_service_base_user_ban where userid=514862;
select * from base.import_self_service_base_user where id=514862;
select * from base.import_self_service_base_ban where id=571766; --bannumber=825874217

select * from analytics.abt_customer_current where customer_id=825874217;
select * from analytics.abt_customer_history where customer_id=825874217;
select * from analytics.abt_customer_history where cpr_no=1809852047;

SELECT 
    userid AS userid,
    start_service_date_min AS ban_date,
    status_last_date_max AS status_last_date_max,
    rank AS rank_delete,
    w2_start_service_date_min AS w2_start_service_date_min_delete,
    w2_status_last_date_max AS last_ban_date,
    w2_rank AS w2_rank_delete
  FROM (
    SELECT *
      FROM (
        SELECT 
            userid AS userid,
            -- Window 1,
            MIN(start_service_date) OVER (PARTITION BY userid ORDER BY start_service_date ASC NULLS FIRST) AS start_service_date_min,
            MAX(status_last_date) OVER (PARTITION BY userid ORDER BY start_service_date ASC NULLS FIRST) AS status_last_date_max,
            RANK() OVER (PARTITION BY userid ORDER BY start_service_date ASC NULLS LAST) AS rank,
            -- Window 2,
            MIN(start_service_date) OVER (PARTITION BY userid ORDER BY status_last_date DESC NULLS LAST) AS w2_start_service_date_min,
            MAX(status_last_date) OVER (PARTITION BY userid ORDER BY status_last_date DESC NULLS LAST) AS w2_status_last_date_max,
            RANK() OVER (PARTITION BY userid ORDER BY status_last_date DESC NULLS LAST) AS w2_rank
          FROM work.self_service_data_work_base_user_ban_ban_cust_curr_join
        ) unfiltered_query
      WHERE (rank = 1) OR (w2_rank = 1)
    ) pristine_query
    where userid=47998;