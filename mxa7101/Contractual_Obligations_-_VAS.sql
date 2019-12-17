select COUNT(*)
from analytics.abt_service_history
where to_date('2018-03-25 00:00:00') between effective_date
and
expiration_date
and soc = 'SFBTC3';


select date_as_date, vas_soc, sum(subscriber_id_count)
from work.contr_obligations_vas_work_vas_overview_daily
where vas_soc = 'SFBTC3'
group by date_as_date, vas_soc
order by date_as_date;