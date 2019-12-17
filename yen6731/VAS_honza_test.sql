set request_pool=big;
SELECT Day_.date_as_date AS Date_,
Man_vas_soc.vas_soc_group AS SOC_Group,
Service.soc AS SOC,
Service.soc_description AS SOC_Description,
Subscriber.product_subgroup AS Segment,
Status.deal AS Bundle_type,
Status.status_date AS Activation_date,
CASE
    WHEN active_state IN(0,2,4) THEN 'Y'
    ELSE "N"
END,
count(Service.subscriber_id) AS FOKUS_COUNT,
count(Status.bss_subscriber_id) AS TERTIUM_COUNT

FROM analytics.abt_service_history as Service
INNER JOIN base.manual_files_base_man_vas_soc as Man_vas_soc
ON (Man_vas_soc.vas_soc = Service.soc) 
INNER JOIN base.manual_files_base_man_d_calendar AS Day_
ON (Service.effective_date <= Day_.date_as_date
AND
Service.expiration_date >= Day_.date_as_date)
INNER JOIN work.base_equation_work_subscriber AS Subscriber
ON
(Subscriber.subscriber_id = Service.subscriber_id)
-------------
-- TERTIUM --
-------------
LEFT OUTER JOIN base.manual_files_base_man_tertium_servicestatus_vw as Status
ON 
Status.bss_subscriber_id = Subscriber.subscriber_id
AND
Status.product_name = Man_vas_soc.vas_soc

WHERE
Status.creation_date <= Day_.date_as_date
AND
Day_.date_as_date <= now()
AND NOT EXISTS
(SELECT *
FROM base.manual_files_base_man_tertium_servicestatus_vw as sx
WHERE sx.bss_subscriber_id = Subscriber.subscriber_id
AND
sx.product_name = Service.soc
AND
sx.creation_date <= Day_.date_as_date
AND
sx.creation_date > Status.creation_date
)
GROUP BY
Day_.date_as_date,
Man_vas_soc.vas_soc_group,
Service.soc,
Service.soc_description,
Subscriber.product_subgroup,
Status.deal,
Status.status_date,
CASE WHEN active_state IN (0, 2, 4) THEN 'Y' ELSE 'N' END;

select * from contr_obligations_vas_work_vas_overview_prepared;

select * from analytics.abt_vas_overview_daily where date_as_date=to_date('2018-08-23','yyyy-mm-dd');