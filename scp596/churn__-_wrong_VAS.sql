select * from analytics.abt_churn_kpi where subscriber_id = 13222105; --churn date 2018-05-15 >= start date vas and 2018-05-15 <= end data vas

select * from work.vasdata_tbt_service_history where subscriber_id = 13222105 ; --soc: OSCSF2, ED15FREE

select * from work.base_equation_kpis_work_churn_kpi_service_history_joined where subscriber_no = 'GSM04520133432' ;

2017-07-13 00:00:00	2018-05-14 23:59:59;

select * from work.vasdata_work_service_change where subscriber_no = 'GSM04520133432' ;;

select * from work.vasdata_work_service_change_lead where subscriber_no = 'GSM04520133432' and soc = 'OSCSF2';

select * from work.vasdata_work_service_change_lead where change_date_lead is null;

select * from work.vasdata_work_service_change_lead_prepared where subscriber_no = 'GSM04520133432' and soc = 'OSCSF2';

select * from work.vasdata_work_service_change_agreement_joined where subscriber_no = 'GSM04520133432' and soc = 'OSCSF2';

select effective_date, expiration_date, * from base.import_fokus_base_service_agreement where  subscriber_no = 'GSM04520133432' and soc = 'OSCSF2';

select * from work.vasdata_work_service_change_agreement_joined where change_date_lead >= now();

--vypadne nam posledni change interval 2018-05-15 na joinu se service agreementem. problem mozna jen s casem change je  2018-05-15 23:59:59 a v service_agreementu je 2018-05-15 00:00:00
--proc tam je ten lead - vypadne z toho ten change date 2018-05-16, ktery uz nema zadny lead

------------------------------------------------------------------------------------------------------------------------------------------------------------------

select * from analytics.abt_churn_kpi where subscriber_id = 13919668; --churn date 2018-04-30 >= start date vas and 2018-05-15 <= end data vas

select * from work.vasdata_tbt_service_history where subscriber_id = 13919668 ; --soc: OSCSF2, ED15FREE

select * from work.base_equation_kpis_work_churn_kpi_service_history_joined where subscriber_no = 'GSM04520133432' ;

select * from work.vasdata_work_service_change where subscriber_no = 'GSM04520193488' ;;

select * from work.vasdata_work_service_change_lead where subscriber_no = 'GSM04520133432' and soc = 'OSCSF2';

select * from work.vasdata_work_service_change_lead_prepared where subscriber_no = 'GSM04520133432' and soc = 'OSCSF2';

select * from work.vasdata_work_service_change_agreement_joined where subscriber_no = 'GSM04520133432' and soc = 'OSCSF2';

select effective_date, expiration_date, * from base.import_fokus_base_service_agreement where  subscriber_no = 'GSM04520133432' and soc = 'OSCSF2';