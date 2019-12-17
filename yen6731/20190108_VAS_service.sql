SELECT cr.soc, cr.subscriber_no, cr.customer_id,cr.change_date, sc.vas_type
FROM work.vasdata_work_service_change_rate_joined as cr
inner join base.manual_files_base_service_soc as sc
on sc.soc = cr.soc
WHERE sc.vas_type = 'INSURANCE';


SELECT *
FROM work.vasdata_work_rate_product_joined
where soc in ('BASIS','BASISMIN','OSBINSUR','OSCBASIS');

SELECT *
FROM work.vasdata_work_rate_product_tertium_joined
where soc in ('BASIS','BASISMIN','OSBINSUR','OSCBASIS');

select * from base.manual_files_base_man_tertium_servicestatus_vw
where product_name in ('BASIS','BASISMIN','OSBINSUR','OSCBASIS');

SELECT *
  FROM (
    SELECT 
       *
      FROM work.vasdata_work_rate_product_joined work_rate_product_joined
      LEFT JOIN (
        SELECT base_man_tertium_servicestatus_vw.*
          FROM base.manual_files_base_man_tertium_servicestatus_vw base_man_tertium_servicestatus_vw
          WHERE active_state = 0
        ) base_man_tertium_servicestatus_vw
        ON (work_rate_product_joined.subscriber_id = base_man_tertium_servicestatus_vw.bss_subscriber_id)
          AND (work_rate_product_joined.soc = base_man_tertium_servicestatus_vw.product_name)
    ) unfiltered_query
  WHERE creation_date between effective_date and nvl(expiration_date, CAST('9999-12-31' as timestamp)) and soc in ('BASIS','BASISMIN','OSBINSUR','OSCBASIS'); 