select * from analytics.abt_prolonging_channel_performance order by 1 desc;

select * from analytics.abt_prolonging_channel_performance where consent_system='Tango - Telia BtC' order by 1 desc;

select * from analytics.abt_prolonging_channel_performance order by `date` desc;

select * from analytics.abt_prolonging_channel_performance where `date` = '2019-06-04 00:00:00' and consent_system='Tango - Telia BtC';





select * from analytics.abt_prolonging_channel_performance;
select * from analytics.abt_subscription_channel_performance;
select * from analytics.abt_consent_event_customer;
select * from analytics.abt_consent_event_subscriber;

select * from analytics.abt_consent_event_customer where dealer_code=13723;

select * from abt_dealer where dealer_code in (select distinct dealer_code from analytics.abt_consent_event_customer);
select * from abt_dealer where dealer_code in (select distinct dealer_code from analytics.abt_consent_event_subscriber);

select distinct * from base.import_consent_db_base_sales_agents where external_id in (select cast(dealer_code as string) from analytics.abt_consent_event_customer);
select distinct * from analytics.abt_dealer where dealer_code in (select cast(dealer_code as string) from analytics.abt_consent_event_customer);


select * from base.import_consent_db_base_sales_agents where external_id='13723';
select * from analytics.abt_consent_event_customer where dealer_code=13723;
select * from analytics.abt_dealer where dealer_code='13723';

select now().inc(-1, 'month');

select inc(now(), 2, "days");

select add(now(), 2, 'days');

select * from analytics.abt_dealer where dealer_code in (select distinct cast(dealer_code as string) from analytics.abt_consent_event_customer);


select * from base.import_consent_db_base_sales_agents where external_id='8314';
select * from analytics.abt_consent_event_subscriber where dealer_code='8314';
select * from analytics.abt_dealer where dealer_code='8314';
;