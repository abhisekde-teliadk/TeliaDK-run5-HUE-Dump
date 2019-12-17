select count(*) from analytics.abt_subscriber_current_old;
select count(*) from analytics.abt_customer_current_old; -- 3782988
select count(*) from analytics.abt_subscriber_history_old;
select count(*) from analytics.abt_customer_history_old; --29428894
select count(*) from analytics.abt_traffic_old;
select count(*) from analytics.abt_billing_old; --280865302
select count(*) from analytics.abt_d_dealer_old; --13877

show create table analytics.abt_d_dealer_old;

invalidate metadata analytics.abt_billing_old;

select count(*) from analytics.abt_subscriber_imei_old; --1694634
select count(*) from analytics.abt_subscriber_imei_history_old; --6297632
select count(*) from analytics.abt_optional_service_current_old; --218490
select count(*) from analytics.abt_optional_service_history_old; -- 996755
select count(*) from analytics.abt_optional_service_container_current_old; --224022
select count(*) from analytics.abt_optional_service_container_history_old; --1086708
select count(*) from analytics.abt_subscribed_product_old; --77150394
select count(*) from analytics.abt_subscribed_product_history_old; --156154562
select count(*) from analytics.abt_product_old; --3472
select count(*) from analytics.abt_soc_old; --33730
select count(*) from analytics.abt_new_product_old; --14

select count(*) from analytics.abt_subscriber_current; -- 3840471
select count(*) from analytics.abt_customer_current; --3782988
select count(*) from analytics.abt_subscriber_history;
select count(*) from analytics.abt_customer_history; --29428894
select count(*) from analytics.abt_traffic; --1682176303
select count(*) from analytics.abt_billing; --72402251
select count(*) from analytics.abt_d_dealer; --13877
select count(*) from analytics.abt_subscriber_imei; --1694634
select count(*) from analytics.abt_subscriber_imei_history; --6297632
select count(*) from analytics.abt_optional_service_current; --218497
select count(*) from analytics.abt_optional_service_history; --996755
select count(*) from analytics.abt_optional_service_container_current; --224011
select count(*) from analytics.abt_optional_service_container_history; --8832179
select count(*) from analytics.abt_subscribed_product; --8832179
select count(*) from analytics.abt_subscribed_product_history; --15852446
select count(*) from analytics.abt_product; --3472
select count(*) from analytics.abt_soc; -- 33730
select count(*) from analytics.abt_new_product; --14

