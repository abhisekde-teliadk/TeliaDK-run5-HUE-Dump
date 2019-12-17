SELECT count(*)
   /* status,
    customer_id AS customer_id,
    subscriber_no AS subscriber_no,
    subscriber_id AS subscriber_id,
    product AS product,
    date_as_string AS date_as_string,
    date_as_date AS date_as_date,
    event_date_min AS event_date_min,
    event_date_max AS event_date_max,
    event_day_lower AS event_day_lower,
    event_date AS event_date,
    event_date_lag AS event_date_lag,
    event_date_lag_diff AS event_date_lag_diff,
    event_day_lag_lower AS event_day_lag_lower,
    first_dealer_code AS first_dealer_code,
    last_dealer_code AS last_dealer_code,
    case when event_date_min is not null and event_date_lag is null then 'Y' else 'N' end AS active_traffic*/
  FROM (
    SELECT 
        work_subscribed_product_day.customer_id AS customer_id,
        work_subscribed_product_day.subscriber_no AS subscriber_no,
        work_subscribed_product_day.subscriber_id AS subscriber_id,
        work_subscribed_product_day.product_id AS product,
        work_subscribed_product_day.date_as_string AS date_as_string,
        work_subscribed_product_day.date_as_date AS date_as_date,
        work_traffic_distinct_min_max_date.event_date_min AS event_date_min,
        work_traffic_distinct_min_max_date.event_date_max AS event_date_max,
        work_traffic_distinct_min_max_date.event_day_lower AS event_day_lower,
        work_traffic_distinct_windows.event_date AS event_date,
        work_traffic_distinct_windows.event_date_lag AS event_date_lag,
        work_traffic_distinct_windows.event_date_lag_diff AS event_date_lag_diff,
        work_traffic_distinct_windows.event_day_lag_lower AS event_day_lag_lower,
        tbt_subscriber_history.first_dealer_code AS first_dealer_code,
        tbt_subscriber_history.dealer_code AS last_dealer_code,
        tbt_subscriber_history.status AS status
      FROM work.base_equation_kpis_work_subscribed_product_day work_subscribed_product_day
      LEFT JOIN (
        SELECT 
            subscriber_no AS subscriber_no,
            customer_id AS customer_id,
            event_date_min AS event_date_min,
            event_date_max AS event_date_max,
            event_date_min - interval 90 days AS event_day_lower
          FROM (
            SELECT *
              FROM work.base_equation_kpis_work_traffic_distinct_min_max_date work_traffic_distinct_min_max_date
            ) withoutcomputedcols_query
        ) work_traffic_distinct_min_max_date
        ON (work_subscribed_product_day.subscriber_no = work_traffic_distinct_min_max_date.subscriber_no)
          AND (work_subscribed_product_day.customer_id = work_traffic_distinct_min_max_date.customer_id)
          AND (work_subscribed_product_day.date_as_date >= work_traffic_distinct_min_max_date.event_day_lower)
          AND (work_subscribed_product_day.date_as_date <= work_traffic_distinct_min_max_date.event_date_max)
      LEFT JOIN (
        SELECT 
            event_date AS event_date,
            subscriber_no AS subscriber_no,
            customer_id AS customer_id,
            event_date_lag AS event_date_lag,
            event_date_lag_diff AS event_date_lag_diff,
            event_date_lag - interval 90 days AS event_day_lag_lower
          FROM (
            SELECT *
              FROM work.base_equation_kpis_work_traffic_distinct_windows work_traffic_distinct_windows
            ) withoutcomputedcols_query
        ) work_traffic_distinct_windows
        ON (work_subscribed_product_day.subscriber_no = work_traffic_distinct_windows.subscriber_no)
          AND (work_subscribed_product_day.customer_id = work_traffic_distinct_windows.customer_id)
          AND (work_subscribed_product_day.date_as_date >= work_traffic_distinct_windows.event_date)
          AND (work_subscribed_product_day.date_as_date <= work_traffic_distinct_windows.event_day_lag_lower)
      INNER JOIN work.base_equation_sub_tbt_subscriber_history tbt_subscriber_history
        ON (work_subscribed_product_day.subscriber_no = tbt_subscriber_history.subscriber_no)
          AND (work_subscribed_product_day.customer_id = tbt_subscriber_history.customer_id)
          AND (work_subscribed_product_day.date_as_date >= tbt_subscriber_history.start_date)
          AND (work_subscribed_product_day.date_as_date <= tbt_subscriber_history.end_date)
    ) withoutcomputedcols_query
    where product in (select product_id from work.base_equation_product_tbt_product where soc='4EF')  and status in ('A','S')
    and date_as_date='2019-05-06 00:00:00';
    
select product_id from work.base_equation_product_tbt_product where soc='4EF';  

select count(*) from work.base_equation_kpis_work_subscribed_product_day_active where product in (select product_id from work.base_equation_product_tbt_product where soc='4EF')
and date_as_date='2019-05-06 00:00:00';


select sum(subs_qty) from work.base_equation_kpis_tbt_stock_kpi where product_id in (select product_id from work.base_equation_product_tbt_product where soc='4EF')
and stock_date='2019-05-06 00:00:00';