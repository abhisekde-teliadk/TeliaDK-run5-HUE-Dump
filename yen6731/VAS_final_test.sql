-- there are others deal like bundle, loalty etc. that are skipped
select distinct deal from contr_obligations_vas_work_man_tertium_servicestatus_vw_last order by deal desc;

select * from contr_obligations_vas_work_vas_overview_daily where subscriber_id_count<>bss_subscriber_id_count;


select COUNT(*)
from analytics.abt_service_history
where to_date('2018-01-01 00:00:00') between effective_date and expiration_date
and soc = 'OSBFLIPP';

select date_as_date, vas_soc, sum(subscriber_id_count)
from work.contr_obligations_vas_work_vas_overview_daily
where vas_soc = 'OSBFLIPP'
group by date_as_date, vas_soc
order by date_as_date;

select * from analytics.abt_service_history where soc='OSBHBO';