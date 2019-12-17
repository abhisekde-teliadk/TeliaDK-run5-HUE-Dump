select soc from analytics.abt_soc
where soc like 'ED%'
and   soc not like '%FREE%'
;

set request_pool=big;
select a.customer_id,
       a.subscriber_no,
       a.soc,
       a.effective_date,
       a.expiration_date
from   base.import_fokus_base_service_agreement a,
       base.manual_files_base_man_soc_groups b
          left outer join 
       analytics.abt_service_history c
          on a.customer_id = c.customer_id
          and a.subscriber_no = c.subscriber_no
          and b.soc = c.soc
          and c.end_date > to_date(now())
          and c.start_date <= to_date(now())

where  1=1
and    a.expiration_date > now()
and    a.effective_date <= now()
and    a.soc = b.soc
and    b.vas_report_monthly=1
--and    a.customer_id = 	440990117	
--and    a.subscriber_no = 'GSM04540417869'
and    c.subscriber_no is null
;

select * from analytics.abt_vas_overview_daily;

          left outer join 
       analytics.abt_vas_overview_daily d
          on c.subscriber_id = d.subsc
;

select * from analytics.abt_service_history
where  customer_id=548716018
and    subscriber_no='GSM04520955022'
and    soc = 'INSURCP'
;

select * from base.import_fokus_base_service_agreement
where  customer_id=548716018
and    subscriber_no='GSM04520955022'
and    soc = 'INSURCP'
;

select * from analytics.abt_subscriber_current
where  customer_id=548716018
and    subscriber_no='GSM04520955022'
and    is_active=1
;

select *
from   analytics.prod_abt_vas_overview_monthly_report
where  budget_product is null
and    month='201908'
;