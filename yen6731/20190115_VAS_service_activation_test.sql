select count(*) from analytics.abt_service_activation; -- 300.705

with service as (
    select
        Soc,
        Subscriber_id,
        Subscriber_no,
        Customer_id,
        Product_id,
        start_date,
        end_date
    from analytics.abt_service_history),
status as (
    select
        Active_state,
        creation_date,
        product_name,
        bss_subscriber_id
    from base.manual_files_base_man_tertium_servicestatus_vw),
res as (
select * from status join service on
    service.soc = status.product_name and
    service.subscriber_id = status.bss_subscriber_id and
    status.creation_date between service.start_date and service.end_date
)
select count(*) from res;

select count(*) from (
SELECT 
    base_man_tertium_servicestatus_vw.active_state AS status,
    base_man_tertium_servicestatus_vw.creation_date AS status_date,
    abt_service_history.soc AS soc,
    abt_service_history.customer_id AS customer_id,
    abt_service_history.subscriber_no AS subscriber_no,
    abt_service_history.subscriber_id AS subscriber_id,
    abt_service_history.product_id AS product_id
  FROM base.manual_files_base_man_tertium_servicestatus_vw base_man_tertium_servicestatus_vw
  INNER JOIN analytics.abt_service_history
    ON (base_man_tertium_servicestatus_vw.product_name = abt_service_history.soc)
      AND (base_man_tertium_servicestatus_vw.bss_subscriber_id = abt_service_history.subscriber_id)
      AND (base_man_tertium_servicestatus_vw.creation_date >= abt_service_history.start_date)
      AND (base_man_tertium_servicestatus_vw.creation_date <= abt_service_history.end_date)
)x;

select count(*) from work.vasdata_work_tertium_status_service_joined;