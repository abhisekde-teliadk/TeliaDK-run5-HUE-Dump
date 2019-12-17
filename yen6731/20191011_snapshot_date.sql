select last_day(to_timestamp(cast (dim_evt_dte_key as string), "yyyyMMdd"));

select trunc(now(),'mm');
select trunc(now(),'dd');
select trunc(now(),'ww');
select trunc(add_months(now(),-1),'mm');

select from_timestamp(now(), 'dd');

select if (trunc(now(),'mm') = trunc(now(),'dd')*/'2019-10-01 00:00:00','prvni','other');

truncate table analytics.abt_intake_kpi_snapshot;

select count(*) from analytics.abt_intake_kpi_snapshot;
