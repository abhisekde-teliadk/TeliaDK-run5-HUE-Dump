-- Traffic data for Steen
SELECT *
FROM abt_traffic t
WHERE t.event_month = '201801'
  AND (t.soc IN ('ISND30FOK',
                 'ISND30F3P')
       OR t.promotion_soc IN ('ISND30FOK',
                              'ISND30F3P'));
                              

-- Optional service containers
select
  x.*
  from
(select
  'OLD' as source,
  old.*
  from
    abt_optional_service_container_history old
  union select
  'NEW' as source,
  new.*
  from
    abt_optional_service_container_history_1 new)
    x
  where
    x.subscriber_id = 6492173
  order by 
    x.source,
    x.start_date;

select
  *
  FROM
    ddata.service_agreement sa
    JOIN ddata.subscriber s ON
      s.SUBSCRIBER_NO = sa.SUBSCRIBER_NO AND
      s.CUSTOMER_ID = sa.BAN
  WHERE
    s.SUBSCRIBER_ID = 6492173 AND
    sa.SERVICE_TYPE IN ('R','O','S') AND
    substr(sa.SOC,1,3) in ('OSB', 'OSC');
    
-- Optional service
select
  *
  from
    abt_optional_service_history_1
  where
    subscriber_id = 6492173;
    
-- 20181218
-- Robinson issues
select * 
  from 
    manual_files_base_robinson
  where
    street = 'Bakkevej 28' and
    city = 'Lemvig';

-- Contractual VAS
select
  *
  from
    analytics.abt_vas_overview_daily
  where
    soc = 'BASIS'
  order by
    1;

select
  *
  from
    work.contr_obligations_vas_work_vas_overview_daily
  where
    vas_soc = 'BASIS'
  order by
    date_as_date;

select
  sum(abt_traffic.volume/60)
  from
    analytics.abt_traffic
  where
    abt_traffic.event_month = '201801' and
    abt_traffic.soc = 'ISND30FOK';
    
select
  *
  from
    analytics.abt_usage_mobile
  where  
    abt_usage_mobile.soc = 'ISND30FOK';
    
    
-- this select shows differences between abt_usage_mobile and data from a reference excell file from finance
-- for 201801 only, our abt is synced and the excel is imported to the DSS ANALYST SANDBOX 
SELECT 
        abs(round((mu.voice_calls - muo.calls)))/mu.voice_calls x ,
        mu.voice_calls,
        round((mu.voice_min - muo.voice)) voice_diff,
        round((mu.voice_calls - muo.calls)) calls_diff,
        mu.finance_call_direction,
        mu.soc, mu.product_soc, mu.promotion, mu.call_description, mu.product_name 
        
FROM
work.analyst_sandbox_test_abt_usage_mobile_201801 mu
LEFT JOIN
work.analyst_sandbox_test_mobile_usage_original muo
ON
    (
/*    mu.soc = muo.soc
    AND
    mu.product_soc = muo.product_soc
    AND
    mu.promotion = muo.promotion_soc
    AND*/
    mu.call_description = muo.call_description
    AND
    mu.product_name = muo.product_name
    
    )
 
WHERE 
mu.finance_call_direction = "Outgoing"
AND
muo.finance_call_direction = "Outgoing+"
AND 
round(abs(mu.voice_min - muo.voice)) > 0
ORDER BY 
abs(round((mu.voice_calls - muo.calls)))/mu.voice_calls desc,
mu.soc, round(abs(mu.voice_min - muo.voice))
;

SELECT 
  mu.product_name,
  mu.call_description,
  muo.finance_call_direction,
  mu.voice_calls,
  muo.voice,
  abs(mu.voice_calls - muo.calls)*2/(mu.voice_calls + muo.calls) diff
  FROM
    work.analyst_sandbox_test_abt_usage_mobile_201801 mu
    LEFT JOIN work.analyst_sandbox_test_mobile_usage_original muo ON
      mu.call_description = muo.call_description AND
      mu.product_name = muo.product_name
  WHERE 
    mu.finance_call_direction = "Outgoing" AND
    muo.finance_call_direction = "Outgoing+";
  
select
  sum(event_count)
  from
    analytics.abt_traffic
  where
    abt_traffic.event_month = '201801';
    
select distinct
  substr(cast (call_date as string),1,7)
--  count(*)
  from 
    import_fokus_raw_detail_usage
  where
    --call_date >= '2018-01-01' and
    --call_date < '2018-02-01'
    1=1
--  group by 
--    substr(cast (call_date as string),1,7)
  order by 1;
    
    
select
  p.product_desc, p.product_group,kpi.churn_date, kpi.subscriber_no
  from 
    analytics.abt_churn_kpi kpi
    join analytics.abt_d_product p on
      p.product_id = kpi.product_id
  limit 100;
  
select * from abt_consent_data limit 100;
    
select * from base.manual_files_base_man_d_calendar;

with fact as (select 
  mu.product_soc,
  --mu.product_name,
  replace(mu.call_description, 'Mobile - Other', 'Mobile - Other Operators') as call_description,
  mu.finance_call_direction,
  'New' source,
  mu.voice_calls as new,
  0 as old
  from
    analytics.abt_usage_mobile_test mu
  where
    mu.reporting_month = cast ('2018-01-01 00:00:00' as timestamp)
  union all select 
  muo.product_soc,
  --muo.product_name,
  muo.call_description,
  replace(muo.finance_call_direction,'+','') finance_call_direction,
  'Old' source,
  0 as new,
  muo.calls as old
  from
    work.analyst_sandbox_test_mobile_usage_original muo)
SELECT 
  fact.product_soc,
  --Fact.product_name,
  Fact.call_description,
  --Fact.finance_call_direction,
  --fact.source,
  1,
  sum(Fact.new),
  sum(fact.old),
  100*abs(sum(Fact.new) - sum(fact.old))*2/(sum(Fact.new)+sum(fact.old)) as diff
  FROM
    Fact
  where
    --fact.call_description like '%Fix%' and
    fact.product_soc = 'SIMPLEBTB' and
    1=1
  group by
    Fact.product_soc,
    Fact.call_description,
    --Fact.finance_call_direction,
    --fact.source
    1
  having
    100*abs(sum(Fact.new) - sum(fact.old))*2/(sum(Fact.new)+sum(fact.old)) > 5
  /*--  100*abs(sum(Fact.new) - sum(fact.old))*2/(sum(Fact.new)+sum(fact.old)) < 200
  order by
    100*abs(sum(Fact.new) - sum(fact.old))*2/(sum(Fact.new)+sum(fact.old)) desc*/
  order by
    100*abs(sum(Fact.new) - sum(fact.old))*2/(sum(Fact.new)+sum(fact.old)) desc
  limit 1000
  ;

select * from abt_traffic where call_attempt_ind is null limit 100;

select * from analytics.abt_usage_mobile_test mu where mu.soc = 'SIMPLEBTB';

select * from work.analyst_sandbox_test_mobile_usage_original muo where muo.soc = 'SIMPLEBTB';

select 
  * 
  from analytics.abt_traffic traffic 
  where 
    nvl(traffic.promotion_soc, traffic.soc) = 'SIMPLEBTB' and
    traffic.event_date >= cast('2018-01-01 00:00:00' as timestamp) and
    traffic.event_date < cast('2018-02-01 00:00:00' as timestamp) and
    1=1
    ;
    
select * from analytics.abt_customer_history
  where customer_id = 947722005;

SELECT * FROM base.manual_files_base_man_roaming_operator LIMIT 100;

SELECT 
    s.ban,
    s.soc,
    s.promotion,
    s.campaign,
    s.product_desc,
    du.* 
    FROM 
        base.import_fokus_base_detail_usage du
        join analytics.abt_subscribed_product_history s on
            s.subscriber_no = du.subscriber_no and
            s.ban = du.ban and
            du.call_date between s.effective_date and s.expiration_date
    where 
        du.call_date >= cast('2018-01-01 00:00:00' as timestamp) and
        du.call_date < cast('2018-02-01 00:00:00' as timestamp) and
        du.call_attempt_ind = 'Y' and
        du.price_plan_code = 'SIMPLEBTB' and
        1=1
    limit 20;
    



SELECT
  ft.at_feature_code,
  ft.call_characteristic_cd,
  ft.product_type,
  ft.call_type,
  ft.traffic_type_id,
  ft.call_type_id,
  ft.network_id,
  ft.feature_dest_code,
  ft.call_direction_id,
  ft.net_code,
  ft.service_calc,
  ft.call_type_id,
  ft.operator_id,
  ft.destination_id,
  --du.country_code, 
  1,
  sum(du.at_call_dur_sec) as volume,
  sum(1) as event_count,
  sum(du.at_call_dur_sec/60) as voice_min,
  sum(du.at_call_dur_sec/(1024*1024)) data_mb
  FROM 
    base.import_fokus_base_detail_usage du
    left outer join base.manual_files_base_man_feature_translation ft on
      ft.at_feature_code = du.at_feature_code and
      nvl(ft.call_type,'') = nvl(du.call_type,'') and
      nvl(ft.call_characteristic_cd,'') = nvl(du.call_characteristic_cd,'') and
      nvl(ft.product_type,'') = nvl(du.product_type,'')
  where
    du.price_plan_code = '4YOU4' and
    call_date >= cast ('2018-01-01 00:00:00' as timestamp) and
    call_date < cast ('2018-02-01 00:00:00' as timestamp) and
    --ft.traffic_type_id = 1 and
    1=1
  GROUP BY
    ft.at_feature_code,
    ft.call_characteristic_cd,
    ft.product_type,
    ft.call_type,
    ft.traffic_type_id,
    ft.call_type_id,
    ft.network_id,
    ft.feature_dest_code,
    ft.call_direction_id,
    ft.net_code,
    ft.service_calc,
    ft.call_type_id,
    ft.operator_id,
    ft.destination_id,
    --du.country_code,
    1;
    
select * from abt_product where soc = '4YOU4';


select 
  sum(tr.call_duration)
from analytics.abt_traffic tr
where 
  event_month = '201801' and 
  traffic_type_id = '1' and 
  network_id = 1 limit 100;
  
SELECT * FROM analytics.abt_usage_mobile_test where reporting_month = cast ('2018-01-01 00:00:00' as timestamp) LIMIT 100;

SELECT 
  distinct 
  call_description 
  FROM 
    analytics.abt_usage_mobile_test
  where 
    reporting_month = cast ('2018-01-01 00:00:00' as timestamp) 
  LIMIT 100;


select distinct reporting_month from analytics.abt_usage_mobile;
  
select
  sum(abt_traffic.event_count)
  from 
    analytics.abt_traffic
    join (select
      distinct
      traffic.du_at_feature_code
      from 
        analytics.abt_traffic traffic
        join base.manual_files_base_man_feature_translation translation on
          translation.at_feature_code = traffic.du_at_feature_code
      where 
        translation.network_id = 2 and
        translation.network_id <> traffic.network_id) other_network on
      other.network.du_at_feature_code = abt_traffic.du_at_feature_code
  where
    abt_traffic.event_month = '201801'
  limit 100;
  
select
  distinct
  traffic.du_at_feature_code,
  traffic.network_id,
  translation.network_id
  from 
    analytics.abt_traffic traffic
    join base.manual_files_base_man_feature_translation translation on
    translation.at_feature_code = traffic.du_at_feature_code
  where 
    translation.network_id = 2 and
    translation.network_id <> traffic.network_id;

select
  sum(volume)
  from 
     analytics.abt_traffic traffic
  where
    traffic.du_at_feature_code like 'MISM%' and
    traffic.soc = 'CM15T25GB' and
    traffic.event_month = '201801'
  limit 100;
    

select
  *
  from 
    base.manual_files_base_man_feature_translation 
  where 
    network_id = 2
  limit 100;
  
select
  *
  from
    raw.import_fokus_raw_detail_usage du
  where
    du.at_feature_code = 'MISMM'
  limit 100;
  
select
  distinct
  feature_code
  from
    raw.import_fokus_raw_rated_feature 
  where
    feature_code like 'PN%';

select
  kpi.churn_date,
  subscriber.act_date_id,
  subscriber.reason_desc,
  subscriber.equation_group,
  subscriber.status_reason,
  product.Product_desc,
  product.soc as priceplan,
  product.product_group,
  product.product_line
  from
    analytics.abt_churn_kpi kpi
    join analytics.abt_product product on
      product.product_id = kpi.product_id
    join analytics.abt_subscriber_history subscriber on
      subscriber.subscriber_id = kpi.subscriber_id and
      kpi.churn_date between subscriber.start_date and subscriber.end_date
  order by 
    kpi.churn_date desc,
    subscriber.act_date_id asc,
    product.product_desc asc
  limit 100;

select
  *
  from 
    analytics.abt_service_history_fat s
  where
    soc_type = 'VAS'
  limit 100;
  
select
  kpi.migration_date,
  kpi.subscriber_no,
  kpi.ban,
  from_product.product_desc from_product_desc,
  from_product.product_group from_product_group,
  from_product.product_line from_product_line,
  to_product.product_desc to_product_desc,
  to_product.product_group to_product_group,
  to_product.product_line to_product_line
  from
    analytics.abt_migration_kpi kpi
    join analytics.abt_product from_product on
      from_product.product_id = kpi.from_product_id
    join analytics.abt_product to_product on
      to_product.product_id = kpi.to_product_id
  limit 100;
  
select 
  * 
  from 
    raw.import_consent_db_raw_customer_consents 
  limit 100;
  
SELECT * FROM raw.import_consent_db_raw_consents LIMIT 100;

SELECT * FROM raw.import_consent_db_raw_customer_consent_states LIMIT 100;

SELECT * FROM raw.manual_files_raw_normalization LIMIT 100;

SELECT * FROM analytics.abt_subscriber_current where subscriber_id in (139553, 763928, 844720)  LIMIT 100;

SELECT distinct product_group FROM raw.manual_files_raw_d_product;

SELECT count(*) FROM analytics.abt_vas_overview_daily LIMIT 100;

SELECT count(*) FROM analytics.abt_vas_overview_monthly LIMIT 100;

select 
  *
  from 
    work.vasdata_work_service_ranked --analytics.abt_service_history 
  where 
    soc = 'TOPUP33' and 
    subscriber_no = 'GSM04528834675' and
    customer_id = 863708806 and
    change_date = cast ('2013-08-30 23:59:58' as timestamp);

  SELECT distinct middle_initial, first_name, last_business_name FROM base.import_fokus_base_name_data LIMIT 100;


SELECT * FROM work.crt_subscriber 
where fokus_subscriber_id in ('139553', '763928', '844720')LIMIT 100;

select distinct fokus_status from analytics.abt_subscriber_history;

SELECT 'old' as source, sho.ban, sho.subscriber_no, sho.soc, sho.soc_description, sho.start_date, sho.end_date
FROM analytics.abt_service_history_old sho
WHERE sho.ban = 559284906
AND sho.subscriber_no = 'GSM04527782570'
AND sho.soc = 'BARLEVEL'
union all
SELECT 'new' as source, shf.customer_id, shf.subscriber_no, shf.soc, shf.soc_description, shf.start_date, shf.end_date
FROM analytics.abt_service_history_fat shf
WHERE shf.customer_id = 559284906
AND shf.subscriber_no = 'GSM04527782570'
AND shf.soc = 'BARLEVEL';

SELECT*
FROM work.vasdata_work_service_change sc
WHERE sc.customer_id = 559284906
AND sc.subscriber_no = 'GSM04527782570'
AND sc.soc = 'BARLEVEL';


SELECT*
FROM work.vasdata_work_service_change_lead_prepared sc
WHERE sc.customer_id = 559284906
AND sc.subscriber_no = 'GSM04527782570'
AND sc.soc = 'BARLEVEL';

SELECT *
FROM work.vasdata_work_service_ranked sc
WHERE sc.customer_id = 559284906
AND sc.subscriber_no = 'GSM04527782570'
AND sc.soc = 'BARLEVEL';

SELECT *
FROM work.vasdata_work_service_change_agreement_joined sc
WHERE sc.customer_id = 559284906
AND sc.subscriber_no = 'GSM04527782570'
AND sc.soc = 'BARLEVEL';

SELECT * 
FROM analytics.abt_service_history_fat shf
WHERE shf.customer_id = 559284906
AND shf.subscriber_no = 'GSM04527782570'
AND shf.soc = 'BARLEVEL';

SELECT * 
FROM analytics.abt_service_history_old sho
WHERE sho.ban = 559284906
AND sho.subscriber_no = 'GSM04527782570'
AND sho.soc = 'BARLEVEL';

SELECT * FROM analytics.abt_subscriber_history LIMIT 100; 

SELECT * FROM analytics.abt_churn_kpi_fat 
  order by churn_date desc
  LIMIT 100;
  
  
SELECT * FROM analytics.abt_migration_kpi_fat LIMIT 100;

SELECT * FROM analytics.abt_service_history_fat LIMIT 100;

SELECT * FROM analytics.abt_subscriber_history LIMIT 100;

SELECT --distinct
*
FROM analytics.abt_subscriber_imei_history 
where imei='350146204834490'
--and active_record_flag=true
--and end_date > now()
order by imei,
start_date,
end_date
;

select
  anl.subscriber_no,
  anl.customer_id,
  nd.first_name,
  nd.last_business_name,
  nd.identify
  from
    base.import_fokus_base_address_name_link anl
    join base.import_fokus_base_name_data nd on
      nd.name_id = anl.name_id
  where
    anl.link_type = 'U' and
    length(nd.identify) = 10
  limit 100;
  
select * from analytics.abt_customer_current limit 100;


SELECT * FROM base.manual_files_base_d_country LIMIT 100;

SELECT * FROM analytics.abt_traffic LIMIT 100;

SELECT distinct product_line, product_type FROM analytics.abt_product LIMIT 100; 

SELECT distinct year, month, end_of_month FROM analytics.abt_calendar order by 1, 2;

SELECT * FROM analytics.abt_product where soc = 'CHAMP01A' LIMIT 100; 


	select
		Product_product_group,
		Product_product_desc,
		Price_plan,		
		s.Campaign,
		c.campaign_desc,
		Promotion,
		Count(subscriber_no) as Number_of_active_subscriptions,
		Count(distinct customer_id) as Number_of_BANs
		From
			analytics.Prod_abt_subscriber_current s
			left outer join base.import_fokus_base_campaign c on
			    c.campaign = s.campaign
		Where
			Fokus_status not in ('C') and
			(Product_product_group like '%Call Me%' or
				Product_product_group like '%Mit Tele%')
		group by
		    Product_product_group,
		    Product_product_desc,
		    Price_plan,		
		    Campaign,
		    c.campaign_desc,
		    Promotion
		order by
		    product_product_group,
		    Count(subscriber_no) desc
		limit 100000000000;

	select
		Product_product_group,
        customer_credit_class,
		Count(subscriber_no) as Number_of_active_subscriptions,
		Count(distinct customer_id) as Number_of_BANs
		From
			analytics.Prod_abt_subscriber_current
		Where
			Fokus_status not in ('C') and
			1=1
			--(Product_product_group like '%Call Me%' or
				--Product_product_group like '%Mit Tele%')
		group by
		    Product_product_group,
            customer_credit_class
		order by
		    product_product_group,
		    Count(subscriber_no) desc
		limit 100000000000;


select
    distinct
    prim_acc_type,
    product_line,
    product_group
    from
        analytics.prod_abt_product
    order by
        prim_acc_type,
        product_line,
        product_group;

    
SELECT * FROM analytics.abt_orders LIMIT 100;

SELECT * FROM analytics.abt_credit_memo LIMIT 100;

SELECT * FROM base.manual_files_base_tac LIMIT 100;

SELECT distinct lpwan FROM base.manual_files_base_tac LIMIT 100;

select * from analytics.abt_soc where soc in ('NBME05V','TELBIZ3');

SELECT soc, effective_date, expiration_date, feature_code, inclusive_mou  FROM base.import_fokus_base_inclus_by_period 
    where
        SOC like 'MC100SM1T%' and
        feature_code like 'MSMS%'
    LIMIT 100;
    
SELECT * FROM base.import_fokus_base_pp_uc_rate 
    where
        SOC like 'TELBIZ3%' and
        feature_code = 'MMMS'
    order by
        effective_date desc
    LIMIT 100;
    
select 
    soc, effective_date, expiration_date, feature_code, rate, tier_level_code, rate_scenario_cd
    from base.import_fokus_base_pp_uc_rate 
    where soc='MC100SM1T' and feature_code like 'MSMS%';

SELECT 
    product_group,
    product_desc,
    count(*)
    FROM 
        analytics.prod_abt_product p
        join base.import_fokus_base_service_agreement s on
--        left outer join analytics.prod_abt_subscriber_current s on
            s.soc = p.soc and
            s.service_type in ('P','M','N') and
            cast('2019-03-11 00:00:00' as TIMESTAMP) between
                s.effective_date and s.expiration_date
    where
        product_group like '%Call Me%' and
        s.soc is not null
    group by
        product_group,
        product_desc
    LIMIT 10000;
    
    
with subscriber_full_history as (select
    customer_id,
    subscriber_no,
    subscriber_id,
    effective_date,
    null as expiration_date,
    sub_status,
    sub_status_date,
    sub_status_rsn_code
    from
        base.import_fokus_base_subscriber
union select
    customer_id,
    subscriber_no,
    subscriber_id,
    effective_date,
    expiration_date,
    sub_status,
    sub_status_date,
    sub_status_rsn_code
    from
        base.import_fokus_base_subscriber_history)
select
    customer_id,
    subscriber_no,
    subscriber_id,
    effective_date,
    expiration_date,
    sub_status,
    sub_status_date,
    sub_status_rsn_code
    from
        subscriber_full_history
        where 
            subscriber_id in (13179159)
            --customer_id = 876230707 and
            --subscriber_no = 'GSM04528800441'
        order by
            subscriber_id,
            effective_date,
            subscriber_no;
            
select
    customer_id,
    subscriber_no,
    subscriber_id,
    start_date,
    end_date,
    status
    from
        analytics.prod_abt_subscriber_history
        where 
            subscriber_id in (13179159)
            --customer_id = 876230707 and
            --subscriber_no = 'GSM04528800441'
        order by
            subscriber_id,
            start_date,
            subscriber_no;



        
SELECT 
    distinct
    prim_acc_type
    FROM 
        base.manual_files_base_d_product 
        order by prim_acc_type;

SELECT 
    distinct
    prim_acc_type
    FROM 
        analytics.prod_abt_product
        order by prim_acc_type;
        
SELECT 
    distinct
    prim_acc_type
    FROM 
        analytics.prod_abt_stock_kpi 
        order by prim_acc_type;
        
SELECT * FROM base.manual_files_base_d_country LIMIT 1000; 

SELECT * FROM base.manual_files_base_man_roaming_operator LIMIT 100;

SELECT
    churn_reason_group,
    count(*)
    FROM 
        analytics.prod_abt_churn_kpi
        group by
            churn_reason_group; 
            
SELECT
    equation_group,
    count(*)
    FROM 
        analytics.prod_abt_subscriber_history
        group by
            equation_group; 
            
SELECT * FROM base.manual_files_base_man_activity_reason LIMIT 100;

SELECT 
    subscriber_id,
    subscriber_no,
    customer_id,
    recipient_operator,
    prod_abt_churn_kpi.* 
    FROM 
        analytics.prod_abt_churn_kpi 
        LIMIT 100;

select  
    subscriber_id,
    port_number,
    effective_date,
    expiration_date,
    int_order_id,
    import_fokus_base_np_number_info.*
    from
        base.import_fokus_base_np_number_info
        where
            subscriber_id = 13026282;

select  
    int_order_id,
    trx_source,
    trx_code,
    recip_serv_oper,
    import_fokus_base_np_trx_detail.*
    from
        base.import_fokus_base_np_trx_detail
        where
            int_order_id = 12425574;

SELECT 
    * 
    FROM 
        base.manual_files_base_man_activity_reason
        where
            reason_desc like 'Cancelation%';

SELECT
    recipient_operator,
    count(*)
    FROM 
        analytics.prod_abt_churn_kpi
        group by
            recipient_operator; 

SELECT
    recipient_operator,
    count(*)
    FROM 
        analytics.prod_abt_subscriber_history
        group by
            recipient_operator; 

SELECT
    ,
    count(*)
    FROM 
        analytics.prod_abt_churn_kpi
        group by
            recipient_operator; 
            
SELECT 
    kpi.subscriber_id,
    kpi.subscriber_no,
    kpi.customer_id,
    kpi.churn_date,
    kpi.subscriber_last_business_name,
    nd.last_business_name,
    kpi.subscriber_first_name,
    nd.first_name,
    kpi.customer_last_business_name,
    --cnd.last_business_name,
    kpi.customer_first_name,
    --cnd.first_name,
    1
    --kpi.* 
    FROM 
        analytics.prod_abt_churn_kpi kpi
        join base.import_fokus_base_address_name_link anl on    
            anl.link_type = 'U' and
            anl.customer_id = kpi.customer_id and
            anl.subscriber_no = kpi.subscriber_no and
            kpi.churn_date between anl.effective_date and nvl(anl.expiration_date, kpi.churn_date)
        join base.import_fokus_base_name_data nd on
            nd.name_id = anl.name_id
        /*
        join base.import_fokus_base_address_name_link canl on    
            canl.link_type = 'L' and
            canl.customer_id = kpi.customer_id and
            kpi.churn_date between canl.effective_date and nvl(canl.expiration_date, kpi.churn_date)
        join base.import_fokus_base_name_data cnd on
            cnd.name_id = canl.name_id
        */
        where   
            subscriber_first_name is null and
            nvl(nd.first_name,'-') != '-' 
        LIMIT 100;
        
SELECT 
    kpi.subscriber_id,
    kpi.subscriber_no,
    kpi.customer_id,
    kpi.churn_date,
    kpi.churn_reason_desc,
    kpi.churn_reason_group as_is,
    ar.equation_group to_be
    FROM 
        analytics.prod_abt_churn_kpi kpi
        join base.manual_files_base_man_activity_reason ar on
            ar.reason_desc = kpi.churn_reason_desc
        LIMIT 100;
        
SELECT 
    kpi.subscriber_id,
    kpi.subscriber_no,
    kpi.customer_id,
    kpi.churn_date,
    kpi.churn_reason_desc,
    kpi.recipient_operator as_is,
    td.recip_serv_oper to_be
    FROM 
        analytics.prod_abt_churn_kpi kpi
        join base.import_fokus_base_np_number_info ni on
            ni.subscriber_id = kpi.subscriber_id and
            ni.port_number = substr(kpi.subscriber_no,7,8)
        join base.import_fokus_base_np_trx_detail td on
            td.trx_source = 'EXT' and
            td.trx_code = '1' and
            td.int_order_id = ni.int_order_id
        LIMIT 100;
        
SELECT 
kpi.subscriber_id,
kpi.subscriber_no,
kpi.customer_id,
kpi.churn_date,
kpi.subscriber_gender,
--anl.name_id,
nd.gender,
nd.identify,
1
--kpi.* 
FROM 
analytics.prod_abt_churn_kpi kpi
join base.import_fokus_base_address_name_link anl on    
    anl.link_type = 'U' and
    anl.customer_id = kpi.customer_id and
    anl.subscriber_no = kpi.subscriber_no and
    kpi.churn_date between anl.effective_date and nvl(anl.expiration_date, kpi.churn_date)
join base.import_fokus_base_name_data nd on
    nd.name_id = anl.name_id
/*
join base.import_fokus_base_address_name_link canl on    
    canl.link_type = 'L' and
    canl.customer_id = kpi.customer_id and
    kpi.churn_date between canl.effective_date and nvl(canl.expiration_date, kpi.churn_date)
join base.import_fokus_base_name_data cnd on
    cnd.name_id = canl.name_id
*/
where   
kpi.subscriber_gender is null and
1=1
LIMIT 10;

with kpi as (SELECT 
kpi.subscriber_id,
kpi.subscriber_no,
kpi.customer_id,
kpi.intake_date,
kpi.subscriber_age,
anl.name_id
FROM 
analytics.abt_intake_kpi kpi
join base.import_fokus_base_address_name_link anl on    
    anl.link_type = 'U' and
    anl.customer_id = kpi.customer_id and
    anl.subscriber_no = kpi.subscriber_no and
    kpi.intake_date between anl.effective_date and nvl(anl.expiration_date, kpi.intake_date)
where   
kpi.subscriber_age is null and
1=1
LIMIT 10000)
select
kpi.subscriber_id,
kpi.subscriber_no,
kpi.customer_id,
kpi.intake_date,
kpi.subscriber_age,
nd.birth_date,
nd.identify,
1
from
kpi
join base.import_fokus_base_name_data nd on
    nd.name_id = kpi.name_id
where
nd.birth_date is not null or
length(nd.identify) = 10
limit 100;

SELECT * FROM base.import_other_sources_base_tac LIMIT 100;

select
*
from
analytics.abt_subscriber_history
where
subscriber_id = 16330728
order by
start_date;

select
*
from
base.import_fokus_base_subscriber_history
where
subscriber_id = 16330728
order by
effective_date;

select
*
from
base.manual_files_base_man_activity_reason ;


select
kpi.subscriber_id,
kpi.subscriber_no,
kpi.customer_id,
kpi.intake_date,
kpi.handset_count cnt_as_is,
count(distinct imei.imei) as cnt_to_be,
kpi.handset_last_bought_date as date_as_is,
max(imei.start_date) as cnt_as_is
from
analytics.abt_intake_kpi kpi
join analytics.abt_subscriber_imei_history imei on
    imei.subscriber_id = kpi.subscriber_id and
    imei.start_date <= kpi.intake_date 
--where
--kpi.handset_count is null or
--kpi.handset_count = 0
group by
kpi.subscriber_id,
kpi.subscriber_no,
kpi.customer_id,
kpi.intake_date,
kpi.handset_count,
kpi.handset_last_bought_date
having
count(distinct imei.imei) <> kpi.handset_count
order by
subscriber_id,
customer_id,
subscriber_no
limit 100;

select
count(*)
from
analytics.prod_abt_churn_kpi kpi
where
kpi.handset_count is null or
kpi.handset_count = 0
limit 100;


Select
    Kpi.subscriber_id,
    Kpi.customer_id,
    Kpi.subscriber_no,
    Kpi.intake_date,
    Kpi.dmc_given as_is,
    Customer_Consent.state_id to_be
From
Analytics.abt_intake_kpi kpi
Join base.import_consent_db_base_customer_entities customer_entity on
	Customer_entity.reference_type_id = 'SUBSCRIPTION-ID' and
	Customer_entity.customer_id = kpi.subscriber_id
Join base.import_consent_db_base_customer_consents customer_consent on
	Customer_consent.customer_entity_id = customer_entity.customer_entity_id
Join base.import_consent_db_base_consents consent on
	Consent.Name = 'Direct Marketing Contact' and
	Consent.consent_id = customer_consent.consent_id and
	Consent.version = customer_consent.consent_version
Where
	Kpi.dmc_given is null
order by
    Kpi.subscriber_id,
    Kpi.customer_id,
    Kpi.subscriber_no
limit 100;


Select
    Kpi.subscriber_id,
    Kpi.customer_id,
    Kpi.subscriber_no,
    Kpi.churn_date,
    Kpi.household_subscriber_count as_is,
    count(*) to_be
From
Analytics.prod_abt_churn_kpi kpi
join analytics.prod_abt_customer_history customer on
    customer.customer_id = kpi.customer_id and
    kpi.churn_date between customer.start_date and customer.end_date
join analytics.prod_abt_customer_history household_customer on
    nvl(household_customer.ADR_DOOR_NO, '') = nvl(customer.ADR_DOOR_NO, '') and
    nvl(household_customer.ADR_STORY, '') = nvl(customer.ADR_STORY , '') and
    nvl(household_customer.ADR_HOUSE_LETTER, '') = nvl(customer.ADR_HOUSE_LETTER , '') and
    nvl(household_customer.ADR_COUNTRY, '') = nvl(customer.ADR_COUNTRY, '') and
    nvl(household_customer.ADR_POB, '') = nvl(customer.ADR_POB , '') and
    nvl(household_customer.ADR_DIRECTION, '') = nvl(customer.ADR_DIRECTION , '') and
    nvl(household_customer.ADR_STREET_NAME, '') = nvl(customer.ADR_STREET_NAME , '') and
    nvl(household_customer.ADR_HOUSE_NO, '') = nvl(customer.ADR_HOUSE_NO, '') and
    nvl(household_customer.ADR_ZIP, '') = nvl(customer.ADR_ZIP, '') and
    nvl(household_customer.ADR_CITY, '') = nvl(customer.ADR_CITY, '') and
    kpi.churn_date between household_customer.start_date and household_customer.end_date
join analytics.prod_abt_subscriber_history household_subscriber on
    household_subscriber.customer_id = household_customer.customer_id and
    kpi.churn_date between household_subscriber.start_date and household_subscriber.end_date
/*
join analytics.prod_abt_product product on 
    product.Extra_user = false and
    product.Extra_datacard = false and
    product.product_id = household_subscriber.product_product_id
*/
Where
	Kpi.household_subscriber_count is null
group by
    Kpi.subscriber_id,
    Kpi.customer_id,
    Kpi.subscriber_no,
    Kpi.churn_date,
    Kpi.household_subscriber_count
/*
order by
    Kpi.subscriber_id,
    Kpi.customer_id,
    Kpi.subscriber_no
*/
limit 100;

select * 
from 
analytics.prod_abt_intake_kpi
order by
    intake_date
limit 1000;

Select
    Kpi.subscriber_id,
    Kpi.customer_id,
    Kpi.subscriber_no,
    Kpi.intake_date,
    Kpi.household_subscriber_count as_is,
    count(*) to_be
From
Analytics.abt_intake_kpi kpi
join analytics.prod_abt_customer_history customer on
    customer.customer_id = kpi.customer_id and
    kpi.intake_date between customer.start_date and customer.end_date
join analytics.prod_abt_customer_history household_customer on
    nvl(household_customer.ADR_DOOR_NO, '') = nvl(customer.ADR_DOOR_NO, '') and
    nvl(household_customer.ADR_STORY, '') = nvl(customer.ADR_STORY , '') and
    nvl(household_customer.ADR_HOUSE_LETTER, '') = nvl(customer.ADR_HOUSE_LETTER , '') and
    nvl(household_customer.ADR_COUNTRY, '') = nvl(customer.ADR_COUNTRY, '') and
    nvl(household_customer.ADR_POB, '') = nvl(customer.ADR_POB , '') and
    nvl(household_customer.ADR_DIRECTION, '') = nvl(customer.ADR_DIRECTION , '') and
    nvl(household_customer.ADR_STREET_NAME, '') = nvl(customer.ADR_STREET_NAME , '') and
    nvl(household_customer.ADR_HOUSE_NO, '') = nvl(customer.ADR_HOUSE_NO, '') and
    nvl(household_customer.ADR_ZIP, '') = nvl(customer.ADR_ZIP, '') and
    nvl(household_customer.ADR_CITY, '') = nvl(customer.ADR_CITY, '') and
    kpi.intake_date between household_customer.start_date and household_customer.end_date
join analytics.prod_abt_subscriber_history household_subscriber on
    household_subscriber.customer_id = household_customer.customer_id and
    kpi.intake_date between household_subscriber.start_date and household_subscriber.end_date
join analytics.prod_abt_product product on 
    nvl(product.Extra_user,false) = false and
    nvl(product.Extra_datacard,false) = false and
    product.product_id = household_subscriber.product_product_id
Where
	1=1
group by
    Kpi.subscriber_id,
    Kpi.customer_id,
    Kpi.subscriber_no,
    Kpi.intake_date,
    Kpi.household_subscriber_count
/*
order by
    Kpi.subscriber_id,
    Kpi.customer_id,
    Kpi.subscriber_no
*/
limit 10;

Select
    Kpi.subscriber_id,
    Kpi.customer_id,
    Kpi.subscriber_no,
    Kpi.intake_date,
    datediff(now(),kpi.intake_date) + 1 as to_be 
From
Analytics.abt_intake_kpi kpi
limit 100;

select
reporting_month,
count(*)
from prod_abt_international_roaming
where
    1=1
group by
reporting_month,
1
limit 100;

select 
start_date,
end_date,
subscriber_id,
subscriber_no,
customer_id,
status,
churn_date
from
prod_abt_subscriber_history
where
subscriber_id = 15810262
order by
start_date;

with x as (
select
    effective_date,
    null expiration_date,
    subscriber_id,
    subscriber_no,
    customer_id,
    sub_status,
    sub_status_date,
    sub_status_last_act,
    sub_status_rsn_code
from 
base.import_fokus_base_subscriber
union
select
    effective_date,
    expiration_date,
    subscriber_id,
    subscriber_no,
    customer_id,
    sub_status,
    sub_status_date,
    sub_status_last_act,
    sub_status_rsn_code
from 
base.import_fokus_base_subscriber_history)
select
    *
from x
where
    subscriber_id = 8777957 
    --subscriber_no = 'GSM04528550563'
order by
    effective_date;
    
SELECT * FROM base.import_fokus_base_adjustment_reason 
where
reason_code = 'PONO'
LIMIT 100;

SELECT 
    csa_activity_code, 
    csa_activity_desc, 
    csa_activity_rsn_code, 
    csa_activity_rsn_desc 
FROM base.import_fokus_base_csm_status_activity 
where
csa_activity_code = 'NAC' and
csa_activity_rsn_code = 'CA'
LIMIT 100;

select
    kpi.subscriber_id,
    kpi.subscriber_no,
    --kpi.activation_date,
    kpi.churn_date,
    --kpi.churn_reason_desc,
    kpi.vas_soc_spotify,
    sh.soc,
    sh.start_date,
    sh.end_date
from
analytics.prod_abt_churn_kpi kpi
join analytics.prod_abt_service_history sh on
    sh.subscriber_no = kpi.subscriber_no and
    sh.customer_id = kpi.customer_id and
    --kpi.churn_date between sh.start_date and sh.end_date and
    1=1
where
    sh.soc = 'OSCSF2' and
    kpi.subscriber_id in (14322674, 13448403, 1205048, 13389748)
order by
    kpi.subscriber_id,
    sh.start_date
-- 16176882, 
;

select
    kpi.subscriber_id,
    kpi.subscriber_no,
    --kpi.activation_date,
    kpi.churn_date,
    --kpi.churn_reason_desc,
    kpi.vas_soc_spotify spotify_as_is,
    sh.soc spotify_to_be,
    sh.effective_date,
    sh.expiration_date
from
analytics.prod_abt_churn_kpi kpi
join base.import_fokus_base_service_agreement sh on
    sh.subscriber_no = kpi.subscriber_no and
    sh.ban = kpi.customer_id and
    --kpi.churn_date between sh.start_date and sh.end_date and
    1=1
where
    sh.soc = 'OSCSF2' and
    kpi.subscriber_id in (14322674, 13448403, 1205048, 13389748)
order by
    kpi.subscriber_id,
    sh.effective_date
-- 16176882, 
;

select
    churn_date,
    subscriber_id,
    subscriber_no,
    from_product_soc,
    customer_id,
    subscriber_id_activation_date
from
analytics.prod_abt_subscriber_history
where
    subscriber_id in (14322674, 13448403, 1205048, 13389748) and
    churn_date between start_date and end_date and
    1=1;

-- , 5994870, 3405518, 1280352

select
    start_date,
    end_date,
    subscriber_id,
    subscriber_no,
    customer_id,
    from_product_soc,
    status,
    churn_date,
    subscriber_id_activation_date
from
prod_abt_subscriber_history
where
    subscriber_id in (5994870, 3405518, 1280352) and
    --churn_date between start_date and end_date and
    1=1
order by
    subscriber_id,
    start_date;

SELECT
DISTINCT
adr_district,
county_code
FROM 
base.import_fokus_base_address_data 
LIMIT 100;

select * from base.import_fokus_base_memo
where
memo_ban = 831739008 and
memo_subscriber = 'GSM04528550563'
order by memo_date;

select
count(*) 
from analytics.prod_abt_churn_kpi
where
priceplan is null;

select
kpi.subscriber_id,
kpi.subscriber_no,
kpi.customer_id,
kpi.churn_date,
kpi.priceplan,
kpi.campaign,
kpi.promotion
from 
analytics.prod_abt_churn_kpi kpi
left outer join analytics.prod_abt_product product on
    kpi.priceplan = product.soc and
    (kpi.campaign = product.campaign or kpi.campaign is null and product.campaign is null) and
    (kpi.promotion = product.service_soc or kpi.promotion is null and product.service_soc is null)
where
kpi.product_group is null and
kpi.priceplan is null and
--kpi.subscriber_no = 'GSM04520852882' and
--kpi.customer_id = 810645705 and
1=1
order by
subscriber_id
;

select
kpi.subscriber_id,
kpi.subscriber_no,
kpi.customer_id,
kpi.churn_date,
kpi.priceplan,
kpi.campaign,
kpi.promotion
from 
analytics.prod_abt_churn_kpi kpi
where
kpi.priceplan is null and
--kpi.subscriber_no = 'GSM04520852882' and
--kpi.customer_id = 810645705 and
1=1
order by
subscriber_id
;

select
kpi.subscriber_id,
kpi.customer_id,
kpi.subscriber_no,
kpi.churn_date,
kpi.priceplan pp_as_is,
sa.soc pp_to_be,
kpi.campaign campaign_as_is,
sa.campaign campaign_to_be
from
analytics.prod_abt_churn_kpi kpi
left outer join base.import_fokus_base_service_agreement sa on
    sa.service_type in ('P','M') and
    sa.subscriber_no = kpi.subscriber_no and
    sa.customer_id = kpi.customer_id and
    kpi.churn_date between sa.effective_date and nvl(sa.expiration_date,kpi.churn_date)
where
kpi.priceplan is null and
--kpi.subscriber_id = 9032292 and
1=1
order by
    kpi.subscriber_id
limit 100;

select
sa.subscriber_no,
sa.customer_id,
sa.soc,
sa.campaign,
sa.service_type,
sa.effective_date,
sa.expiration_date
from
base.import_fokus_base_service_agreement sa
where
    sa.service_type in ('P','M') and
    sa.subscriber_no = 'GSM04526486270' and
    sa.customer_id = 504131210
order by
    sa.effective_date
limit 100;

set request_pool = big;

select
cnt_seq_no,
customer_id,
subscriber_no,
subscriber_id,
effective_date,
expiration_date,
sub_status,
sub_status_date,
--sub_status_rsn_code,
memo.memo_date
from
(
    select
    cnt_seq_no,
    customer_id,
    subscriber_no,
    subscriber_id,
    effective_date,
    null as expiration_date,
    sub_status,
    sub_status_date,
    sub_status_rsn_code
    from
    base.import_fokus_base_subscriber
    union select
    cnt_seq_no,
    customer_id,
    subscriber_no,
    subscriber_id,
    effective_date,
    expiration_date,
    sub_status,
    sub_status_date,
    sub_status_rsn_code
    from
    base.import_fokus_base_subscriber_history
) subscriber
left outer join base.import_fokus_base_memo memo on
    memo.memo_type = '0008' and
    memo.memo_subscriber = subscriber.subscriber_no and
    memo.memo_ban = subscriber.customer_id and
    subscriber.sub_status_date >= memo.memo_date
where 
    subscriber_id in (1280352)
    --customer_id = 876230707 and
    --subscriber_no = 'GSM04526486270'
order by
subscriber_id,
effective_date,
subscriber_no;

select
customer_id,
subscriber_no,
subscriber_id,
start_date,
end_date,
status,
price_plan,
churn_date
from
analytics.prod_abt_subscriber_history
where
    subscriber_id in (1280352)
    --customer_id = 876230707 and
    --subscriber_no = 'GSM04526486270'
order by
subscriber_id,
start_date,
subscriber_no;

select
*
from
analytics.abt_subscribed_product_history
where
subscriber_id = 16241588;

SELECT 
* 
FROM 
work.base_equation_kpis_fat_work_all_kpis all_kpis
where
all_kpis.subscriber_id = 16241588
LIMIT 100;

select
*
from 
work.base_equation_kpis_fat_work_all_kpis_fat all_kpis_fat
where
all_kpis_fat.subscriber_id = 16241588
LIMIT 100;

select 
x.customer_id, 
change_date, 
lag(change_date,1) over (partition by x.customer_id order by change_date desc) as next_change_date
from 
(
    SELECT
    distinct
    customer_id, nvl(trunc(change_date,'DD'), to_date('9999-12-30')) + interval 1 day - interval 2 SECONDS as change_date 
    FROM temp.base_equation_sub_tmp_customer_change_all
    where
    change_date <= now()
) x
join base.import_fokus_base_billing_account billing_account on 
    billing_account.customer_id = x.customer_id
join base.import_fokus_base_customer customer on
    customer.customer_id = billing_account.ban
where
x.customer_id = 831739008
order by
change_date;

select
*
from
base.import_fokus_base_billing_account
where
ban = 831739008;

select
*
from
base.import_fokus_base_customer
where
customer_id = 831739008;

select
*
from
work.base_equation_sub_work_customer_hist
where
customer_id = 831739008
order by
start_date;

select
*
from
work.base_equation_sub_work_customer_change
where
customer_id = 831739008
order by
change_date;

SELECT 
    `start_date` AS `start_date`,
    `end_date` AS `end_date`,
    `adr_link_seq_no` AS `adr_link_seq_no`,
    `adr_expiration_date` AS `adr_expiration_date`,
    `adr_effective_date` AS `adr_effective_date`,
    `adr_secondary_ln` AS `adr_secondary_ln`,
    `adr_primary_ln` AS `adr_primary_ln`,
    `adr_city` AS `adr_city`,
    `adr_zip` AS `adr_zip`,
    `adr_house_no` AS `adr_house_no`,
    `adr_street_name` AS `adr_street_name`,
    `adr_direction` AS `adr_direction`,
    `adr_pob` AS `adr_pob`,
    `adr_country` AS `adr_country`,
    `adr_house_letter` AS `adr_house_letter`,
    `adr_story` AS `adr_story`,
    `adr_door_no` AS `adr_door_no`,
    `adr_email` AS `adr_email`,
    `since_date` AS `since_date`,
    `adr_district` AS `adr_district`,
    `accommodation_type` AS `accommodation_type`,
    `adr_co_name` AS `adr_co_name`,
    `last_business_name` AS `last_business_name`,
    `first_name` AS `first_name`,
    `additional_title` AS `additional_title`,
    `birth_date` AS `birth_date`,
    `identify` AS `identify`,
    `cvr_no` AS `cvr_no`,
    `middle_initial` AS `middle_initial`,
    `gender` AS `gender`,
    `birth_date_identify` AS `birth_date_identify`,
    `tree_root_ban` AS `tree_root_ban`,
    `hier_effective_date` AS `hier_effective_date`,
    `hier_sys_creation_date` AS `hier_sys_creation_date`,
    `tree_level` AS `tree_level`,
    `hier_expiration_date` AS `hier_expiration_date`,
    `ban_entry_seq_no` AS `ban_entry_seq_no`,
    `payment_method` AS `payment_method`,
    `payment_sub_method` AS `payment_sub_method`,
    `pym_effective_date` AS `pym_effective_date`,
    `pym_expiration_date` AS `pym_expiration_date`,
    `ban` AS `ban`,
    `account_type` AS `account_type`,
    `account_sub_type` AS `account_sub_type`,
    `ar_balance` AS `ar_balance`,
    `ban_status` AS `ban_status`,
    `status_last_date` AS `status_last_date`,
    `start_service_date` AS `start_service_date`,
    `col_delinq_status` AS `col_delinq_status`,
    `col_delinq_sts_date` AS `col_delinq_sts_date`,
    `col_agncy_code` AS `col_agncy_code`,
    `credit_class` AS `credit_class`,
    `bill_cycle` AS `bill_cycle`,
    `bl_prt_category` AS `bl_prt_category`,
    `bl_due_day` AS `bl_due_day`,
    `customer_id` AS `customer_id`,
    `customer_telno` AS `customer_telno`,
    `employment_type` AS `employment_type`,
    `marketing_state_id` AS `marketing_state_id`,
    `marketing_change_date` AS `marketing_change_date`,
    `profiling_state_id` AS `profiling_state_id`,
    `profiling_change_date` AS `profiling_change_date`,
    case when cvr_no is null or middle_initial is not null
    then
        identify
    else
        null
    end AS `cpr_no`,
    nvl(middle_initial, last_business_name) AS `organization_name`,
    concat(concat(account_type, '-'), account_sub_type)   AS `account_type_id`,
    coalesce(birth_date_identify,birth_date) AS `birth_date_final`,
    case 
    when birth_date_identify is not null and substr(identify,-1) in ('1','3','5','7','9') then 'M'
    when birth_date_identify is not null and substr(identify,-1) not in ('1','3','5','7','9') then 'F'
    else gender
    end     AS `gender_final`
  FROM (
    SELECT 
        `work_customer_change`.`change_date` AS `start_date`,
        `work_customer_change`.`next_change_date` AS `end_date`,
        `work_address`.`link_seq_no` AS `adr_link_seq_no`,
        `work_address`.`expiration_date` AS `adr_expiration_date`,
        `work_address`.`effective_date` AS `adr_effective_date`,
        `work_address`.`adr_secondary_ln` AS `adr_secondary_ln`,
        `work_address`.`adr_primary_ln` AS `adr_primary_ln`,
        `work_address`.`adr_city` AS `adr_city`,
        `work_address`.`adr_zip` AS `adr_zip`,
        `work_address`.`adr_house_no` AS `adr_house_no`,
        `work_address`.`adr_street_name` AS `adr_street_name`,
        `work_address`.`adr_direction` AS `adr_direction`,
        `work_address`.`adr_pob` AS `adr_pob`,
        `work_address`.`adr_country` AS `adr_country`,
        `work_address`.`adr_house_letter` AS `adr_house_letter`,
        `work_address`.`adr_story` AS `adr_story`,
        `work_address`.`adr_door_no` AS `adr_door_no`,
        `work_address`.`adr_email` AS `adr_email`,
        `work_address`.`since_date` AS `since_date`,
        `work_address`.`adr_district` AS `adr_district`,
        `work_address`.`accommodation_type` AS `accommodation_type`,
        `work_address`.`adr_co_name` AS `adr_co_name`,
        `work_address`.`last_business_name` AS `last_business_name`,
        `work_address`.`first_name` AS `first_name`,
        `work_address`.`additional_title` AS `additional_title`,
        `work_address`.`birth_date` AS `birth_date`,
        `work_address`.`identify` AS `identify`,
        `work_address`.`comp_reg_id` AS `cvr_no`,
        `work_address`.`middle_initial` AS `middle_initial`,
        `work_address`.`gender` AS `gender`,
        `work_address`.`birth_date_identify` AS `birth_date_identify`,
        `base_ban_hierarchy_tree`.`tree_root_ban` AS `tree_root_ban`,
        `base_ban_hierarchy_tree`.`effective_date` AS `hier_effective_date`,
        `base_ban_hierarchy_tree`.`sys_creation_date` AS `hier_sys_creation_date`,
        `base_ban_hierarchy_tree`.`tree_level` AS `tree_level`,
        `base_ban_hierarchy_tree`.`expiration_date` AS `hier_expiration_date`,
        `base_ban_pym_mtd`.`ban_entry_seq_no` AS `ban_entry_seq_no`,
        `base_ban_pym_mtd`.`payment_method` AS `payment_method`,
        `base_ban_pym_mtd`.`payment_sub_method` AS `payment_sub_method`,
        `base_ban_pym_mtd`.`effective_date` AS `pym_effective_date`,
        `base_ban_pym_mtd`.`expiration_date` AS `pym_expiration_date`,
        `base_billing_account`.`ban` AS `ban`,
        `base_billing_account`.`account_type` AS `account_type`,
        `base_billing_account`.`account_sub_type` AS `account_sub_type`,
        `base_billing_account`.`ar_balance` AS `ar_balance`,
        `base_billing_account`.`ban_status` AS `ban_status`,
        `base_billing_account`.`status_last_date` AS `status_last_date`,
        `base_billing_account`.`start_service_date` AS `start_service_date`,
        `base_billing_account`.`col_delinq_status` AS `col_delinq_status`,
        `base_billing_account`.`col_delinq_sts_date` AS `col_delinq_sts_date`,
        `base_billing_account`.`col_agncy_code` AS `col_agncy_code`,
        `base_billing_account`.`credit_class` AS `credit_class`,
        `base_billing_account`.`bill_cycle` AS `bill_cycle`,
        `base_billing_account`.`bl_prt_category` AS `bl_prt_category`,
        `base_billing_account`.`bl_due_day` AS `bl_due_day`,
        `base_customer`.`customer_id` AS `customer_id`,
        `base_customer`.`customer_telno` AS `customer_telno`,
        `base_customer`.`employment_type` AS `employment_type`,
        `work_grouped_consents`.`marketing_state_id` AS `marketing_state_id`,
        `work_grouped_consents`.`marketing_change_date` AS `marketing_change_date`,
        `work_grouped_consents`.`profiling_state_id` AS `profiling_state_id`,
        `work_grouped_consents`.`profiling_change_date` AS `profiling_change_date`
      FROM `base_equation_sub_work_customer_change` `work_customer_change`
      LEFT JOIN (
        SELECT `work_address`.*
          FROM `base_equation_sub_work_address` `work_address`
          WHERE `link_type` = 'L'
        ) `work_address`
        ON (`work_customer_change`.`customer_id` = `work_address`.`customer_id`)
          AND (`work_customer_change`.`change_date` >= `work_address`.`adr_effective_date_join`)
          AND (`work_customer_change`.`change_date` <= `work_address`.`adr_expiration_date_join`)
      LEFT JOIN (
        SELECT 
            `tree_root_ban` AS `tree_root_ban`,
            `ban` AS `ban`,
            `effective_date` AS `effective_date`,
            `sys_creation_date` AS `sys_creation_date`,
            `sys_update_date` AS `sys_update_date`,
            `operator_id` AS `operator_id`,
            `application_id` AS `application_id`,
            `dl_service_code` AS `dl_service_code`,
            `dl_update_stamp` AS `dl_update_stamp`,
            `tree_level` AS `tree_level`,
            `parent_ban` AS `parent_ban`,
            `expiration_date` AS `expiration_date`,
            `tml_ind` AS `tml_ind`,
            nvl(effective_date, cast('1970-01-01' as timestamp)) AS `hier_effective_date_join`,
            nvl(expiration_date, cast('9999-12-31' as timestamp)) AS `hier_expiration_date_join`
          FROM (
            SELECT *
              FROM base.`import_fokus_base_ban_hierarchy_tree` `base_ban_hierarchy_tree`
            ) `withoutcomputedcols_query`
        ) `base_ban_hierarchy_tree`
        ON (`work_customer_change`.`customer_id` = `base_ban_hierarchy_tree`.`ban`)
          AND (`work_customer_change`.`change_date` >= `base_ban_hierarchy_tree`.`hier_effective_date_join`)
          AND (`work_customer_change`.`change_date` <= `base_ban_hierarchy_tree`.`hier_expiration_date_join`)
      LEFT JOIN (
        SELECT `base_ban_pym_mtd`.*
          FROM base.`import_fokus_base_ban_pym_mtd` `base_ban_pym_mtd`
          WHERE `expiration_date` IS NOT NULL
        ) `base_ban_pym_mtd`
        ON (`work_customer_change`.`customer_id` = `base_ban_pym_mtd`.`ban`)
          AND (`work_customer_change`.`change_date` >= `base_ban_pym_mtd`.`effective_date`)
          AND (`work_customer_change`.`change_date` <= `base_ban_pym_mtd`.`expiration_date`)
      RIGHT JOIN base.`import_fokus_base_billing_account` `base_billing_account`
        ON `work_customer_change`.`customer_id` = `base_billing_account`.`customer_id`
      INNER JOIN base.`import_fokus_base_customer` `base_customer`
        ON `base_billing_account`.`customer_id` = `base_customer`.`customer_id`
      LEFT JOIN (
        SELECT `work_grouped_consents`.*
          FROM `base_equation_sub_work_grouped_consents` `work_grouped_consents`
          WHERE `reference_type_id` = 'BAN'
        ) `work_grouped_consents`
        ON `base_billing_account`.`ban` = `work_grouped_consents`.`customer_id`
    ) `withoutcomputedcols_query`
where
customer_id = 831739008;


select
count(*)
from
base_equation_sub_tbt_customer_history;
-- 29246221

select
count(*)
from
base_equation_kpis_fat_work_customer_pay_method;
-- 30485500

select
*
from
base_equation_sub_tbt_customer_history
where
customer_id = 100321457;

select
*
from 
base_equation_sub_tbt_subscriber_history 
where
customer_id = 100321457;

select
distinct
subscriber_id,
customer_id,
subscriber_no,
subscriber_id_activation_date,
start_date,
end_date
from 
base_equation_sub_tbt_subscriber_history 
where
customer_id = 100321457
order by
subscriber_id_activation_date,
start_date;

select
cnt_seq_no,
customer_id,
subscriber_no,
subscriber_id,
effective_date,
expiration_date,
sub_status,
sub_status_date,
--sub_status_rsn_code,
memo.memo_date
from
(
    select
    cnt_seq_no,
    customer_id,
    subscriber_no,
    subscriber_id,
    effective_date,
    null as expiration_date,
    sub_status,
    sub_status_date,
    sub_status_rsn_code
    from
    base.import_fokus_base_subscriber
    union select
    cnt_seq_no,
    customer_id,
    subscriber_no,
    subscriber_id,
    effective_date,
    expiration_date,
    sub_status,
    sub_status_date,
    sub_status_rsn_code
    from
    base.import_fokus_base_subscriber_history
) subscriber
left outer join base.import_fokus_base_memo memo on
    memo.memo_type = '0008' and
    memo.memo_subscriber = subscriber.subscriber_no and
    memo.memo_ban = subscriber.customer_id and
    subscriber.sub_status_date >= memo.memo_date
where 
    subscriber_id in (14890177)
    --customer_id = 100321457
    --subscriber_no = 'GSM04526486270'
order by
subscriber_id,
effective_date,
subscriber_no;

select
zipcode,
count(*)
from work.base_equation_kpis_fat_work_distinct_region_by_zip
group by
zipcode
having
count(*) > 1;
-- 7160

select
*
from 
--base.manual_files_base_dnk_region
work.base_equation_kpis_fat_work_distinct_region_by_zip
where
zipcode = '7160'
limit 100;

select
count(*)
from
(
    select
    subscriber_id,
    --subscriber_no,
    --customer_id,
    min(start_date),
    min(subscriber_id_activation_date)
    from
    analytics.abt_subscriber_history
    group by
    subscriber_id
    --subscriber_no,
    --customer_id
    having
    min(subscriber_id_activation_date) >= min(start_date)
) x
left outer join (
    select
    subscriber_id,
    --subscriber_no,
    --ban customer_id,
    min(effective_date)
    from
    analytics.abt_subscribed_product_history
    group by
    subscriber_id
    --subscriber_no,
    --ban
) y on
    y.subscriber_id = x.subscriber_id and
    --y.subscriber_no = x.subscriber_no and
    --y.customer_id = x.customer_id
    1=1
limit 100;

select last_business_name, * from work.base_equation_sub_tbt_subscriber_history where 
subscriber_no = 'GSM04527871609' and customer_id = 692513112 
and cast('2017-02-01 00:00:00' as timestamp) between start_date and end_date;

select
*
from
work.base_equation_sub_work_address
where
subscriber_no = 'GSM04527871609' and
customer_id = 692513112 and
cast('2017-02-01 00:00:00' as timestamp) between effective_date and nvl(expiration_date, cast('2017-02-01 00:00:00' as timestamp));

select
cnt_seq_no,
customer_id,
subscriber_no,
subscriber_id,
effective_date,
expiration_date,
sub_status,
sub_status_date,
--sub_status_rsn_code,
memo.memo_date
from
(
    select
    cnt_seq_no,
    customer_id,
    subscriber_no,
    subscriber_id,
    effective_date,
    null as expiration_date,
    sub_status,
    sub_status_date,
    sub_status_rsn_code
    from
    base.import_fokus_base_subscriber
    union select
    cnt_seq_no,
    customer_id,
    subscriber_no,
    subscriber_id,
    effective_date,
    expiration_date,
    sub_status,
    sub_status_date,
    sub_status_rsn_code
    from
    base.import_fokus_base_subscriber_history
) subscriber
left outer join base.import_fokus_base_memo memo on
    memo.memo_type = '0008' and
    memo.memo_subscriber = subscriber.subscriber_no and
    memo.memo_ban = subscriber.customer_id and
    subscriber.sub_status_date >= memo.memo_date
where 
    --subscriber_id in (39801)
    --customer_id = 100321457
    subscriber_no = 'GSM04528276703'
order by
subscriber_id,
effective_date,
subscriber_no;

select
*
from
analytics.abt_subscribed_product_history sph
where
sph.subscriber_id = 39801;

select
*
from
analytics.abt_subscriber_history x
where
x.subscriber_id = 39801;

select
ban,
subscriber_no,
service_type,
effective_date,
expiration_date
from
base.import_fokus_base_service_agreement sa
where
sa.subscriber_no = 'GSM04528276703' and
sa.ban = 100634763
order by
effective_date;

select 
*
from
work.base_equation_product_work_service_agreement_subscr_joined x
where
x.ban = 100634763 and
x.subscriber_no = 'GSM04528276703'
order by
effective_date;

select 
x.customer_id,
x.subscriber_no,
x.subscriber_id,
x.effective_date,
x.expiration_date,
x.sub_status,
x.sub_status_date
from
work.base_equation_product_work_subscriber_union x
where
x.customer_id = 100634763 and
x.subscriber_no = 'GSM04528276703'
order by
effective_date;

select * from work.base_equation_product_work_service_agreement_subscr_joined  where subscriber_id = 39801;

select
su.sub_status,
sa.ban,
sa.subscriber_no,
sa.service_type,
sa.effective_date,
sa.expiration_date,
su.effective_date,
su.dealer_code,
su.org_dealer_code
from
base.import_fokus_base_service_agreement sa
join (
    select
    cnt_seq_no,
    customer_id,
    subscriber_no,
    subscriber_id,
    effective_date,
    null as expiration_date,
    sub_status,
    sub_status_date,
    sub_status_rsn_code,
    org_dealer_code,
    dealer_code
    from
    base.import_fokus_base_subscriber
    union select
    cnt_seq_no,
    customer_id,
    subscriber_no,
    subscriber_id,
    effective_date,
    expiration_date,
    sub_status,
    sub_status_date,
    sub_status_rsn_code,
    dealer_code,
    org_dealer_code
    from
    base.import_fokus_base_subscriber_history
) su on
    su.customer_id = sa.ban and
    su.subscriber_no = sa.subscriber_no and
    sa.effective_date <= nvl(su.expiration_date, sa.effective_date) and
    nvl(sa.expiration_date, su.effective_date) >= su.effective_date
where
cast('2019-05-06 23:59:58' as timestamp) between sa.effective_date and nvl(sa.expiration_date, cast('2019-05-06 23:59:58' as timestamp)) and
cast('2019-05-06 23:59:58' as timestamp) between su.effective_date and nvl(su.expiration_date, cast('2019-05-06 23:59:58' as timestamp)) and
sa.soc = 'NP_4EP' and
su.sub_status in ('A', 'S', 'R')
order by
su.sub_status,
sa.subscriber_no,
sa.customer_id,
sa.effective_date,
su.effective_date;

select * from analytics.abt_stock_kpi where stock_date='2019-05-06 00:00:00' and soc='NP_4EP';

SELECT 
sc.customer_id,
ch.customer_id
FROM 
`analytics`.`abt_subscriber_current` sc
left outer join (
    SELECT customer_id,
	is_active
    FROM `analytics`.`abt_customer_history`
    --FROM `analytics`.`abt_customer_current`
) ch on
    sc.customer_id = ch.customer_id and
    ch.is_active = 1
where sc.subscriber_no = 'GSM04540346801'
and sc.is_active=1;

select
sa.soc_seq_no,
count(*)
from
base.import_fokus_base_service_agreement sa
group by
sa.soc_seq_no
having
count(*) > 1
limit 100;

select
su.sub_status,
su.subscriber_id,
sa.ban,
sa.subscriber_no,
sa.service_type,
sa.effective_date,
sa.expiration_date,
su.effective_date,
su.expiration_date,
su.dealer_code,
su.org_dealer_code
from
base.import_fokus_base_service_agreement sa
join (
    select
    cnt_seq_no,
    customer_id,
    subscriber_no,
    subscriber_id,
    effective_date,
    null as expiration_date,
    sub_status,
    sub_status_date,
    sub_status_rsn_code,
    org_dealer_code,
    dealer_code
    from
    base.import_fokus_base_subscriber
    union select
    cnt_seq_no,
    customer_id,
    subscriber_no,
    subscriber_id,
    effective_date,
    expiration_date,
    sub_status,
    sub_status_date,
    sub_status_rsn_code,
    dealer_code,
    org_dealer_code
    from
    base.import_fokus_base_subscriber_history
) su on
    su.customer_id = sa.ban and
    su.subscriber_no = sa.subscriber_no and
    sa.effective_date <= nvl(su.expiration_date, sa.effective_date) and
    nvl(sa.expiration_date, su.effective_date) >= su.effective_date
where
sa.service_type in ('P', 'M', 'N') and
sa.effective_date = sa.expiration_date
/*
sa.ban = 630997708 and
sa.subscriber_no = 'GSM04542784363'
*/
order by
sa.subscriber_no,
sa.customer_id,
su.subscriber_id,
su.sub_status,
sa.effective_date,
su.effective_date;

select * 
from 
work.base_equation_product_work_service_agreement_subscr_dedup sad
where
sad.ban = 630997708 and
sad.subscriber_no = 'GSM04542784363';

select
cnt_seq_no,
customer_id,
subscriber_no,
subscriber_id,
effective_date,
expiration_date,
sub_status,
sub_status_date,
--sub_status_rsn_code,
memo.memo_date
from
(
    select
    cnt_seq_no,
    customer_id,
    subscriber_no,
    subscriber_id,
    effective_date,
    null as expiration_date,
    sub_status,
    sub_status_date,
    sub_status_rsn_code
    from
    base.import_fokus_base_subscriber
    union select
    cnt_seq_no,
    customer_id,
    subscriber_no,
    subscriber_id,
    effective_date,
    expiration_date,
    sub_status,
    sub_status_date,
    sub_status_rsn_code
    from
    base.import_fokus_base_subscriber_history
) subscriber
left outer join base.import_fokus_base_memo memo on
    memo.memo_type = '0008' and
    memo.memo_subscriber = subscriber.subscriber_no and
    memo.memo_ban = subscriber.customer_id and
    subscriber.sub_status_date >= memo.memo_date
where 
subscriber_id = 9972774
--customer_id = 630997708 and
--subscriber_no = 'GSM04542784363'
order by
subscriber_id,
effective_date,
subscriber_no;

select 
x.customer_id,
x.subscriber_no,
x.subscriber_id,
x.effective_date,
x.expiration_date,
x.sub_status,
x.sub_status_date,
x.cnt_seq_no
from
work.base_equation_product_work_subscriber_union x
where
/*
x.customer_id = 630997708 and
x.subscriber_no = 'GSM04542784363'
*/
x.effective_date != x.expiration_date
order by
x.cnt_seq_no
--effective_date
;

select
sa.ban,
sa.subscriber_no,
sa.service_type,
sa.effective_date,
sa.expiration_date
from
base.import_fokus_base_service_agreement sa
where
sa.service_type in ('P', 'M', 'N') and
sa.ban = 630997708 and
sa.subscriber_no = 'GSM04542784363'
order by
sa.subscriber_no,
sa.ban,
sa.effective_date;

select
count(*)
/*
x.customer_id,
x.subscriber_no,
x.subscriber_id,
x.effective_date,
x.expiration_date,
x.sub_status,
x.sub_status_date
*/
from
work.base_equation_product_work_subscriber_union x
where
x.effective_date = x.expiration_date
;

select
sa.ban,
sa.subscriber_no,
sa.service_type,
sa.effective_date,
sa.expiration_date
from
base.import_fokus_base_service_agreement sa
where
sa.service_type in ('P', 'M', 'N') and
--sa.effective_date = sa.expiration_date

sa.ban = 630997708 and
sa.subscriber_no = 'GSM04542784363'

order by
sa.subscriber_no,
sa.ban,
sa.effective_date
limit 100;

SELECT 
kpi.subscriber_id,
kpi.subscriber_no,
kpi.customer_id,
kpi.churn_date,
kpi.churn_reason_desc,
kpi.recipient_operator as_is,
td.recip_serv_oper to_be
FROM 
analytics.prod_abt_churn_kpi kpi
join base.import_fokus_base_np_number_info ni on
    ni.subscriber_id = kpi.subscriber_id and
    ni.port_number = substr(kpi.subscriber_no,7,8)
join base.import_fokus_base_np_trx_detail td on
    td.trx_source = 'EXT' and
    td.trx_code = '1' and
    td.int_order_id = ni.int_order_id
LIMIT 100;

select  
subscriber_id,
port_number,
effective_date,
expiration_date,
int_order_id,
import_fokus_base_np_number_info.*
from
base.import_fokus_base_np_number_info
where
subscriber_id = 12103056;

select
*
from
work.base_equation_sub_work_subscriber_history_all su
where
su.subscriber_id = 12103056
order by
su.start_date;

select
*
from
work.base_equation_sub_work_subscriber_rest_data su
where
su.subscriber_id = 12103056
order by
su.start_date;

select
*
from
work.base_equation_sub_tbt_subscriber_history su
where
su.subscriber_id = 12103056
order by
su.start_date;

select
*
from
analytics.prod_abt_subscriber_history su
where
su.subscriber_id = 12103056
order by
su.start_date;

select * from work.base_equation_product_tbt_subscribed_product_history where ban=597776111 and subscriber_no='FIX04588626769';

select *
from
analytics.abt_churn_kpi
where
customer_id=597776111 and 
subscriber_no='FIX04588626769';

select distinct soc, service_type from base.import_fokus_base_service_agreement
where soc like 'DIS%';

select 
distinct 
soc 
from 
analytics.abt_service_history
where soc like 'DIS%';


SELECT 
roaming_operator_cd,
rm_operator_desc
FROM 
base.import_fokus_base_roaming_operator 
order by
roaming_operator_cd
LIMIT 100;

select 
country_code,
country_name
from 
base.import_fokus_base_foreign_country
order by country_name
limit 1000;

select
distinct
bp_category_desc
from
base.import_fokus_base_bill_category
where
bp_bill_format = 'MS'
limit 100;

select
--call_month,
--roaming_country,
call_type,
nrtype,
feature_bill_text,
--bill_category,
--feature_desc,
bp_category_desc,
sum(at_call_dur_sec)
from
analytics.abt_gruppetrafik
where
roaming_country is not null and
call_type in ('R', 'L')
group by
--call_month,
--roaming_country,
call_type,
nrtype,
feature_bill_text,
--bill_category,
--feature_desc,
bp_category_desc
limit 100;

select
cnt_seq_no,
customer_id,
subscriber_no,
subscriber_id,
effective_date,
expiration_date,
sub_status,
sub_status_date,
init_activation_date,
--sub_status_rsn_code,
memo.memo_date
from
(
    select
    cnt_seq_no,
    customer_id,
    subscriber_no,
    subscriber_id,
    effective_date,
    null as expiration_date,
    sub_status,
    sub_status_date,
    init_activation_date,
    sub_status_rsn_code
    from
    base.import_fokus_base_subscriber
    union select
    cnt_seq_no,
    customer_id,
    subscriber_no,
    subscriber_id,
    effective_date,
    expiration_date,
    sub_status,
    sub_status_date,
    init_activation_date,
    sub_status_rsn_code
    from
    base.import_fokus_base_subscriber_history
) subscriber
left outer join base.import_fokus_base_memo memo on
    memo.memo_type = '0008' and
    memo.memo_subscriber = subscriber.subscriber_no and
    memo.memo_ban = subscriber.customer_id and
    subscriber.sub_status_date >= memo.memo_date
where 
subscriber_id in (12469595)
--customer_id = 682216700 and
--subscriber_no = 'GSM04553344342'
order by
subscriber_id,
effective_date,
subscriber_no;

SELECT * FROM base.import_fokus_base_soc LIMIT 100;

SELECT * FROM base.import_fokus_base_customer LIMIT 100; 
SELECT * FROM base.import_fokus_base_billing_account LIMIT 100;

SELECT * FROM base.import_fokus_base_fokus_detail_usage LIMIT 100;

select
kpi.subscriber_id,
kpi.customer_id,
kpi.subscriber_no,
kpi.churn_date,
kpi.vas_soc_spotify as_is
from
analytics.prod_abt_churn_kpi as kpi
where
kpi.subscriber_id in (8486855, 12063591, 12469595, 16070333, 16087589, 16116411);

select
kpi.subscriber_id,
kpi.customer_id,
kpi.subscriber_no,
kpi.churn_date,
kpi.vas_soc_spotify as_is,
sf.soc to_be
from
analytics.prod_abt_churn_kpi as kpi
left outer join (
    select
    sa.ban,
    sa.subscriber_no,
    sa.soc,
    sa.service_type,
    sa.effective_date,
    sa.expiration_date
    from
    base.import_fokus_base_service_agreement sa
    join base.manual_files_base_man_soc_groups sg on
        sg.soc_group = 'Spotify' and
        sg.soc = sa.soc
) sf on
    sf.ban = kpi.customer_id and
    sf.subscriber_no = kpi.subscriber_no and
    kpi.churn_date between sf.effective_date and nvl(sf.expiration_date, kpi.churn_date)
where
kpi.subscriber_id in
    (14322674, 13448403, 1205048, 13389748)
/*
    (763792, 875476, 9203501, 10601861, 11690468, 11713600, 12459532, 15389328, 
    15711933, 15965315, 8486855, 12063591, 12469595, 16070333, 16087589, 16116411)
*/
order by
subscriber_id;

select
sh.vas_type,
*
from
analytics.prod_abt_service_history sh
join base.manual_files_base_man_soc_groups sg on
    sg.soc_group = 'Spotify' and
    sg.soc = sh.soc
where
subscriber_id = 15965315
order by
start_date;



set request_pool = big;

select distinct upper(soc_group), soc_group from base.manual_files_base_man_soc_groups;
select distinct vas_type from analytics.prod_abt_service_history;
select distinct vas_type from base.manual_files_base_service_soc;

select
*
from
base.import_fokus_base_np_number_info
limit 100;

select
*
from
raw.manual_files_raw_normalization;

select
subscriber_no,
customer_id,
subscriber_id,
churn_date,
kpi.priceplan
from
analytics.prod_abt_churn_kpi kpi
where
churn_date = '2019-05-06 00:00:00' and
kpi.subscriber_no in (
    'FIX04575422965',
    'GSM04522746516',
    'GSM04527850940',
    'FIX04588626769'
);

select 
*
from
base.import_fokus_base_roaming_operator;

select distinct call_type, unit_measure_code from base.import_fokus_base_fokus_detail_usage;

select 
du.ri_carrier,
ro.country_code,
ro.operator_symbol,
ro.rm_operator_desc
from 
base.import_fokus_base_fokus_detail_usage du
left outer join base.import_fokus_base_roaming_operator ro on
    ro.roaming_operator_cd = du.ri_carrier
where
call_type = 'R' and
unit_measure_code = 'O'
limit 100;

select 
*
from 
(
select
kpi.subscriber_id,
kpi.customer_id,
kpi.subscriber_no,
kpi.churn_date,
kpi.vas_soc_spotify as_is,
sf.soc to_be
from
analytics.abt_churn_kpi as kpi
left outer join (
    select
    sa.ban,
    sa.subscriber_no,
    sa.soc,
    sa.service_type,
    sa.effective_date,
    sa.expiration_date
    from
    base.import_fokus_base_service_agreement sa
    join base.manual_files_base_man_soc_groups sg on
        sg.soc_group = 'Spotify' and
        sg.soc = sa.soc
) sf on
    sf.ban = kpi.customer_id and
    sf.subscriber_no = kpi.subscriber_no and
    kpi.churn_date between sf.effective_date and nvl(sf.expiration_date, kpi.churn_date)
where
/*
kpi.subscriber_id in 
    (763792, 875476, 9203501, 10601861, 11690468, 11713600, 12459532, 15389328, 
    15711933, 15965315, 8486855, 12063591, 12469595, 16070333, 16087589, 16116411)
*/
--kpi.churn_date = '2019-05-06 00:00:00' and
1=1
) x
where
/*
as_is <> to_be or
as_is is null and to_be is not null or
as_is is not null and to_be is null
*/
customer_id = 100321748 and
subscriber_no = 'GSM04528404056'
order by
customer_id,
subscriber_no
;

select *
from 
(-- find all active subscriber_id i BASE
    select distinct customer_id as raw_customer_id,
    subscriber_no as raw_subscriber_no,
    subscriber_id as raw_subscriber_id,
    sub_status as raw_status
    from 
    raw.import_fokus_raw_subscriber 
    where 
    sub_status in ('A','S')
) a
full outer join (-- find all active subscriber_id in ANALYTICS
    select distinct customer_id as ABT_customer_id,
    subscriber_no as ABT_subscriber_no,
    subscriber_id as ABT_subscriber_id,
    status as ABT_status
    from analytics.abt_subscriber_current
    where status in ('A','S')
) b on 
    cast(a.raw_customer_id as bigint) = b.ABT_customer_id
    and a.raw_subscriber_no = b.ABT_subscriber_no
    and a.raw_status = b.ABT_status
where 
a.raw_customer_id is null
or b.ABT_customer_id is null
;

select 
*
from 
(-- find all active subscriber_id i BASE
    select 
    distinct 
    customer_id as raw_customer_id,
    subscriber_no as raw_subscriber_no,
    subscriber_id as raw_subscriber_id
    from 
    base.import_fokus_base_subscriber 
    where 
    --sub_status in ('A','S')
    1=1
) a
full outer join (-- find all active subscriber_id in ANALYTICS
    select 
    distinct 
    customer_id as ABT_customer_id,
    subscriber_no as ABT_subscriber_no,
    subscriber_id as ABT_subscriber_id
    --status as ABT_status
    from analytics.prod_abt_subscriber_current
    where 
    -- status in ('A','S')
    1=1
) b on 
    a.raw_customer_id = b.ABT_customer_id
    and a.raw_subscriber_no = b.ABT_subscriber_no
    and a.raw_subscriber_id = b.ABT_subscriber_id
    --and a.raw_status = b.ABT_status
where 
a.raw_customer_id is null
or b.ABT_customer_id is null
;


select *
from 
(-- find all active subscriber_id i BASE
    select 
    distinct 
    customer_id as raw_customer_id,
    subscriber_no as raw_subscriber_no,
    subscriber_id as raw_subscriber_id
    --sub_status as raw_status
    from 
    base.import_fokus_base_subscriber 
    where 
    sub_status in ('A','S')
) a
where 
a.raw_customer_id = 758587505
;




select
source,
cnt_seq_no,
customer_id,
subscriber_no,
subscriber_id,
effective_date,
expiration_date,
sub_status,
sub_status_date,
init_activation_date,
--sub_status_rsn_code,
memo.memo_date
from
(
    select
    'subscriber' as source,
    cnt_seq_no,
    customer_id,
    subscriber_no,
    subscriber_id,
    effective_date,
    null as expiration_date,
    sub_status,
    sub_status_date,
    init_activation_date,
    sub_status_rsn_code
    from
    base.import_fokus_base_subscriber
    where
    1=1
    union select
    'subscriber_history' as source,
    cnt_seq_no,
    customer_id,
    subscriber_no,
    subscriber_id,
    effective_date,
    expiration_date,
    sub_status,
    sub_status_date,
    init_activation_date,
    sub_status_rsn_code
    from
    base.import_fokus_base_subscriber_history
    where 
    1=1
) subscriber
left outer join base.import_fokus_base_memo memo on
    memo.memo_type = '0008' and
    memo.memo_subscriber = subscriber.subscriber_no and
    memo.memo_ban = subscriber.customer_id and
    subscriber.sub_status_date >= memo.memo_date
where 
--subscriber_id in (7527049)
customer_id = 667672703 and
subscriber_no = 'GSM04550725582'
order by
subscriber_id,
effective_date,
subscriber_no;

select
*
from
analytics.prod_abt_subscriber_history
where
--subscriber_id = 7527049
customer_id = 648207702 and
subscriber_no = 'GSM04520114107'
;

select
*
from 
work.base_equation_sub_work_subscriber_change_end_dt
where
customer_id = 648207702 and
subscriber_no = 'GSM04520114107'
order by 
change_date,
end_date
;

select
*
from 
work.base_equation_sub_work_subscriber_churn_dt
where
customer_id = 648207702 and
subscriber_no = 'GSM04520114107'
;


select
*
from 
work.base_equation_sub_work_subscriber_joined_prolong
where
customer_id = 648207702 and
subscriber_no = 'GSM04520114107'
;

select 
equipment_no,
effective_date,
expiration_date,
*
from raw.import_fokus_raw_physical_device
where subscriber_no ='GSM04528112973'
and cast(customer_id as bigint) =110109375
and device_type = 'H'
order by effective_date desc;

select 
imei,
start_date,
end_date,
customer_id,
subscriber_no,
status,
imei,
*
from analytics.abt_subscriber_current
where 
subscriber_no ='GSM04528112973'
and customer_id =110109375
;

;


SELECT * FROM `analytics`.`abt_vas_overview_monthly`
where soc in(
'SFBTC5',
'BASIS5',
'OSCFDATA',
'HBOBTC5',
'LOYHBOC03',
'INSURC',
'INSURCP',
'TVEBTC5',
'OSCTSC',
'OFFBTC5',
'INSUR3',
'LOYTVEC03',
'LOYESPC03',
'ESPBTC5',
'LOYFLPC03',
'TSCBTC5',
'FLIPPBTC5',
'LOYSFB06',
'LOYHBOB06',
'TSCBTC2');

SELECT * FROM base.import_fokus_base_csm_future_request LIMIT 100;

SELECT * FROM base.manual_files_base_man_activity_reason LIMIT 100;

select 
--count(*)
*
from
(
	select
	kpi.subscriber_id,
	kpi.customer_id,
	kpi.subscriber_no,
	kpi.churn_date,
	kpi.priceplan pp_as_is,
	sa.soc pp_to_be,
	kpi.campaign campaign_as_is,
	sa.campaign campaign_to_be,
	sa.sys_creation_date,
	sa.expiration_date,
	sa.effective_date,
	rank() over (
	partition by
	    kpi.subscriber_id,
	    kpi.customer_id,
	    kpi.subscriber_no,
	    kpi.churn_date
    order by
        sa.sys_creation_date desc,
        sa.expiration_date desc,
        sa.effective_date desc
    ) as rnk
	from
	analytics.prod_abt_churn_kpi kpi
	left outer join base.import_fokus_base_service_agreement sa on
	    sa.service_type in ('P','M') and
	    sa.subscriber_no = kpi.subscriber_no and
	    sa.customer_id = kpi.customer_id and
	    kpi.churn_date between sa.effective_date and nvl(sa.expiration_date,kpi.churn_date)
	where
	--kpi.priceplan is null and
	kpi.subscriber_id = 12455848 and
	kpi.churn_date between 
	    '1900-01-01 00:00:00' and
	    '2019-12-31 00:00:00' and
	1=1
	order by
	    kpi.subscriber_id
) x
where
--rnk = 1 and
--pp_as_is <> pp_to_be and
1=1;

select
effective_date,
expiration_date,
effective_date,
sa_expiration_date,
soc
--*
from
work.base_equation_product_work_subscribed_product -- _filter_dup
where
ban = 474945904 and
subscriber_no = 'GSM04560128016' and
'2019-05-22 00:00:00' between effective_date and sa_expiration_date
order by
effective_date,
expiration_date;

select
effective_date,
expiration_date,
soc,
sa.sys_creation_date
--*
from
base.import_fokus_base_service_agreement sa
where
sa.service_type in ('P','M') and
ban = 474945904 and
subscriber_no = 'GSM04560128016' and
'2019-05-22 00:00:00' between effective_date and expiration_date
order by
effective_date,
expiration_date;

set REQUEST_POOL=big;

	select
		subscriber_id,
		subscriber_no,
		customer_id,
		start_date,
		end_date,
		status
		from 
		analytics.abt_subscriber_history
		where
		customer_id = 648207702 and
		subscriber_no = 'GSM04520114107'
		order by 
		start_date,
		end_date
		;

select
To_be.Subscriber_id,
To_be.Customer_id,
To_be.Subscriber_no,
To_be.Start_date,
As_is.Start_date
/*
To_be.End_date,
As_is.End_date
*/
From
(
	select
	Subscriber_id,
	Customer_id,
	Subscriber_no,
	Trunc(effective_date, 'D') as start_date,
	Trunc(expiration_date, 'D') as end_date,
	Init_activation_date
	From
	(
		select
		Subscriber_id,
		Customer_id,
		Subscriber_no,
		effective_date,
		expiration_date,
		Init_activation_date
		From
		base.import_fokus_base_subscriber_history
    	union
		select
		Subscriber_id,
		Customer_id,
		Subscriber_no,
		effective_date,
		cast('9999-12-31 00:00:00' as timestamp) as expiration_date,
		Init_activation_date
		From
		base.import_fokus_base_subscriber
	) x
) to_be
left outer join (
	select
	change_subscriber_id as Subscriber_id,
	Customer_id,
	Subscriber_no,
	Trunc(change_date,'D') as start_date,
	Trunc(end_date, 'D') as end_date
	From
	work.base_equation_sub_work_subscriber_change_end_dt
) as_is on
    as_is.subscriber_id = to_be.subscriber_id and
    as_is.customer_id = to_be.customer_id and
    as_is.subscriber_no = to_be.subscriber_no and
    as_is.start_date = to_be.start_date
    --as_is.end_date = to_be.end_date
where
    to_be.start_date <> to_be.end_date and
    -- to_be.subscriber_id = 9737632 and
    as_is.start_date is null and
    --as_is.end_date is null and
    1=1
order by
To_be.Subscriber_id,
To_be.Start_date,  
--To_be.End_date,  
To_be.Customer_id,
To_be.Subscriber_no;

select
*
from
(
	select
	Subscriber_id,
	Customer_id,
	Subscriber_no,
	effective_date,
	expiration_date,
	sub_status,
	Init_activation_date
	From
	base.import_fokus_base_subscriber_history
	union
	select
	Subscriber_id,
	Customer_id,
	Subscriber_no,
	effective_date,
	cast('9999-12-31 00:00:00' as timestamp) as expiration_date,
	sub_status,
	Init_activation_date
	From
	base.import_fokus_base_subscriber
) subscriber
where
subscriber_id in (16369118, 16369119) --, 16369119, 16369118);
order by
subscriber_id,
effective_date asc
;

select
orig.subscriber_id,
kpi.intake_date,
subscriber.min_init_activation_date,
orig.init_activation_date,
subscriber.min_memo_date
from
sandbox.abt_intake_kpi_intake_v2_20190506_20190604_prepared orig
left outer join work.base_equation_kpis_tbt_intake_kpi kpi on
    orig.subscriber_id = kpi.subscriber_id
left outer join (
    select
    subscriber_id,
    min(init_activation_date) min_init_activation_date,
    min(memo.memo_date) as min_memo_date
    from (
	    select
	    Subscriber_id,
	    Customer_id,
	    Subscriber_no,
	    Init_activation_date,
	    sub_status_date
	    From
	    base.import_fokus_base_subscriber_history
	    union
	    select
	    Subscriber_id,
	    Customer_id,
	    Subscriber_no,
	    Init_activation_date,
	    sub_status_date
	    From
	    base.import_fokus_base_subscriber
    ) x
    left outer join base.import_fokus_base_memo memo on
        memo.memo_type = '0008' and
        memo.memo_subscriber = x.subscriber_no and
        memo.memo_ban = x.customer_id and
        x.sub_status_date >= memo.memo_date
    group by
    subscriber_id
) subscriber on
    subscriber.Subscriber_id = orig.subscriber_id
where
orig.init_activation_date = '2019-05-06' and
--min_memo_date is null and
--min_init_activation_date <> intake_date
kpi.subscriber_id is null and
1=1
order by
subscriber_id;

select
*
from 
sandbox.abt_intake_kpi_intake_v2_20190506_20190604_prepared
where
init_activation_date = sub_status_date;

select
source,
cnt_seq_no,
customer_id,
subscriber_no,
subscriber_id,
effective_date,
expiration_date,
sub_status,
sub_status_date,
init_activation_date,
--sub_status_rsn_code,
memo.memo_date
from
(
    select
    'subscriber' as source,
    cnt_seq_no,
    customer_id,
    subscriber_no,
    subscriber_id,
    effective_date,
    null as expiration_date,
    sub_status,
    sub_status_date,
    init_activation_date,
    sub_status_rsn_code
    from
    base.import_fokus_base_subscriber
    where
    1=1
    union select
    'subscriber_history' as source,
    cnt_seq_no,
    customer_id,
    subscriber_no,
    subscriber_id,
    effective_date,
    expiration_date,
    sub_status,
    sub_status_date,
    init_activation_date,
    sub_status_rsn_code
    from
    base.import_fokus_base_subscriber_history
    where 
    1=1
) subscriber
left outer join base.import_fokus_base_memo memo on
    memo.memo_type = '0008' and
    memo.memo_subscriber = subscriber.subscriber_no and
    memo.memo_ban = subscriber.customer_id and
    subscriber.sub_status_date >= memo.memo_date
where 
subscriber_id in (16369118, 16369119)
--customer_id = 667672703 and
--subscriber_no = 'GSM04550725582'
order by
subscriber_id,
effective_date,
subscriber_no;

	select customer_cvr_no, customer_root_cvr_no, internal_circuit
	_id
	from analytics.abt_subscriber_current
	where customer_id in
	(652403213, 560803215, 862403219, 862403219)
	;

select
anl.customer_id,
anl.effective_date,
anl.expiration_date,
name.comp_reg_id as cvr_no,
name.identify as cpr_no,
name.id_type,
name.*
from
base.import_fokus_base_address_name_link anl
join base.import_fokus_base_name_data name on
    name.name_id = anl.name_id
where
anl.link_type = 'L' and
anl.customer_id in (652403213, 560803215, 862403219, 862403219)
order by
anl.customer_id,
anl.effective_date;

select
*
from 
work.base_equation_kpis_work_subscriber_churn_date
where
subscriber_id = 7902500
order by
churn_date;

select
x.subscriber_id,
x.resume_date_x,
sub_status_date,
effective_date,
expiration_date,
sub_status,
ctn_seq_no,
churn_date_rank,
customer_id,
subscriber_no
from (
    select
    coalesce(resume_date, cast('1900-01-01 00:00:00' as timestamp)) as resume_date_x,
    *
    from 
    work.base_equation_sub_work_subscriber_churn_dt
    where
    subscriber_id = 7902500
) x
where
churn_date_rank = 1 and
sub_status = 'C'
order by
x.subscriber_id,
x.resume_date_x,
sub_status_date,
effective_date,
ctn_seq_no
;

select 
count(*)
-- *
from
(
	select
	kpi.subscriber_id,
	kpi.customer_id,
	kpi.subscriber_no,
	kpi.churn_date,
	kpi.priceplan pp_as_is,
	sa.soc pp_to_be,
	kpi.campaign campaign_as_is,
	sa.campaign campaign_to_be,
	sa.sys_creation_date,
	sa.expiration_date,
	sa.effective_date,
	rank() over (
	partition by
	    kpi.subscriber_id,
	    kpi.customer_id,
	    kpi.subscriber_no,
	    kpi.churn_date
	    order by
	        sa.sys_creation_date desc,
	        sa.expiration_date desc,
	        sa.effective_date desc
	    ) as rnk
	from
	analytics.prod_abt_churn_kpi kpi
	left outer join base.import_fokus_base_service_agreement sa on
	    sa.service_type in ('P','M') and
	    sa.subscriber_no = kpi.subscriber_no and
	    sa.customer_id = kpi.customer_id and
	    kpi.churn_date between sa.effective_date and nvl(sa.expiration_date,kpi.churn_date)
	where
	--kpi.priceplan is null and
	--kpi.subscriber_id = 12455848 and
	kpi.churn_date between 
	    '1900-01-01 00:00:00' and
	    '2019-12-31 00:00:00' and
	1=1
	order by
	    kpi.subscriber_id
) x
where
rnk = 1 and
pp_as_is <> pp_to_be and
1=1;

select
x.subscriber_id,
x.resume_date_x,
intake_date,
sub_status_date,
effective_date,
expiration_date,
sub_status,
ctn_seq_no,
churn_date_rank,
customer_id,
subscriber_no
from (
    select
    coalesce(resume_date, cast('1900-01-01 00:00:00' as timestamp)) as resume_date_x,
    (
        case 
        when resume_date is null then init_activation_date_min
        else sub_status_date
        end 
    ) as intake_date,
    rank() over (
        partition by
            subscriber_id,
            resume_date
        order by
            churn_date_rank desc
    ) as intake_date_rank,
    *
    from 
    work.base_equation_sub_work_subscriber_churn_dt
    where
    (
        sub_status in ('A', 'S') or
        sub_status = 'C' and churn_date_rank = 1
    ) and
    --subscriber_id = 7902500 and
    1=1
) x
where
intake_date_rank = 1 and
intake_date = '2019-05-06 00:00:00' and
1=1
order by
x.subscriber_id,
x.resume_date_x,
sub_status_date,
effective_date,
ctn_seq_no
;

select
--count(*)
y.subscriber_id,
y.subscriber_no,
y.customer_id,
y.intake_date,
sb.subscriber_id,
sb.subscriber_no,
sb.customer_id,
--sb.init_activation_date
sb.intake_date
from
(
    select
    x.subscriber_id,
    x.resume_date_x,
    intake_date,
    sub_status_date,
    effective_date,
    expiration_date,
    sub_status,
    ctn_seq_no,
    churn_date_rank,
    customer_id,
    subscriber_no
    from (
        select
        coalesce(resume_date, cast('1900-01-01 00:00:00' as timestamp)) as resume_date_x,
        (
            case 
            when resume_date is null then init_activation_date_min
            else sub_status_date
            end 
        ) as intake_date,
        rank() over (
            partition by
                subscriber_id,
                resume_date
            order by
                churn_date_rank desc
        ) as intake_date_rank,
        *
        from 
        work.base_equation_sub_work_subscriber_churn_dt
        where
        (
            sub_status in ('A', 'S') or
            sub_status = 'C' and churn_date_rank = 1 and resume_date is null
        ) and
        --subscriber_id = 7902500 and
        1=1
    ) x
    where
    intake_date_rank = 1 and
    intake_date = '2019-05-06 00:00:00' and
    1=1
) y
/*
full outer join sandbox.abt_intake_kpi_intake_v2_20190506_20190604_prepared sb on
    sb.subscriber_id = y.subscriber_id and
    sb.customer_id = y.customer_id and
    sb.subscriber_no = y.subscriber_no
*/
full outer join ( 
    select
    *
    from
    work.base_equation_kpis_tbt_intake_kpi 
    where
    intake_date = '2019-05-06 00:00:00' and
    1=1
) sb on
    sb.subscriber_id  = y.subscriber_id and
    sb.customer_id = y.customer_id and
    sb.subscriber_no = y.subscriber_no
where
--y.sub_status = 'C' and
--(sb.init_activation_date is null or y.intake_date is null) and
(sb.intake_date is null or y.intake_date is null) and
1=1;

select 
*
from 
work.base_equation_kpis_work_subscriber_churn_date
where
subscriber_id = 7902500;

select
as_is.subscriber_id,
to_be.subscriber_id,
as_is.customer_id,
to_be.customer_id,
as_is.subscriber_no,
to_be.subscriber_no,
as_is.churn_date,
to_be.churn_date
from 
(
    select
    *
    from
    work.base_equation_kpis_work_subscriber_churn_date
    where
    churn_date = '2019-05-06 00:00:00'
) as_is
full outer join sandbox.sandbox_fejtek_FOKUS_PRODUCT_INFO_CHURN_prepared to_be on
    as_is.subscriber_id = to_be.subscriber_id and
    as_is.customer_id = to_be.customer_id and
    as_is.subscriber_no = to_be.subscriber_no and
    as_is.churn_date = to_be.churn_date
where
(to_be.churn_date is null or as_is.churn_date is null);

select
subscriber_id,
resume_date,
customer_id,
subscriber_no,
sub_status,
sub_status_date,
effective_date,
expiration_date,
ctn_seq_no,
churn_date_rank
from
work.base_equation_sub_work_subscriber_churn_dt
where
subscriber_id in (
15980202,
13852075,
16369119,
16368036,
16368184,
16369118,
15647716,
-1
)
order by
subscriber_id,
ctn_seq_no;

select
subscriber_id,
customer_id,
subscriber_no,
sub_status,
sub_status_date,
effective_date,
expiration_date,
ctn_seq_no,
sys_creation_date,
sys_update_date
from
temp.base_equation_sub_tmp_subscriber_history
where
subscriber_id in (
15980202,
--13852075,
16369119,
16368036,
16368184,
16369118,
--15647716,
16315485,
9868348,
-1
)
order by
subscriber_id,
ctn_seq_no;

select 
count(*)
from 
work.base_equation_kpis_work_subscriber_churn_date
;
-- 5138911

select 
count(*)
from 
work.base_equation_kpis_work_churn_join_date
;
--5185896

select
count(*)
from
work.base_equation_kpis_work_subscriber_churn_date cd
left outer join work.base_equation_sub_tbt_subscriber_history sh on
    sh.subscriber_no = cd.subscriber_no and
    sh.customer_id = cd.customer_id and
    sh.subscriber_id = cd.subscriber_id and
    seconds_add(trunc(cd.churn_date,'dd'),-2) between
        sh.start_date and
        sh.end_date
;

select
*
from
analytics.prod_abt_churn_kpi
limit
100;

select
vas_soc_forsikring,
count(*)
from
analytics.prod_abt_churn_kpi
group by
vas_soc_forsikring
;

select
count(*)
from 
(
select
subscriber_id,
customer_id,
subscriber_no,
churn_date,
count(*) as cnt
from
work.base_equation_kpis_work_subscriber_churn_date cd
group by
subscriber_id,
customer_id,
subscriber_no,
churn_date
) as x
where 
cnt > 1 
;

SELECT subscriber_id,count(*)
FROM analytics.abt_crt_subscriber
group by 1
having count(*)  > 1
;

select
subscriber_id,
count(*)
from
(
select
distinct
*
from
analytics.abt_crt_subscriber
where
subscriber_id in (
16143048,
16099754,
16299530,
16099057,
16297033,
15464473,
8334968,
16298456,
16150820,
16296811,
16297779,
16300634,
14427127
)
) x
group by 
subscriber_id
having count(*) > 1
;

select
distinct
subscriber_id,
access_installation_address,
access_installation_zipcode,
access_installation_city
from
analytics.abt_crt_subscriber
where
subscriber_id in (
16300634,
16299530,
16298456,
16297033,
16297779,
16296811
)
;

select
subscriber_id,
internal_circuit_id,
access_installation_address
from 
work.crt_subscriber_act_date
where
subscriber_id = 16296811;

select
*
from 
work.crt_work_tnid_techinfo_deduplicated
where
tnid_circuit_number = 'TB-402062';

select
*
from 
base.import_other_sources_base_tnid_extract
where
tnid_circuit_number = 'TB-402062';

select 
a.subscriber_id,
b.subscriber_id
from 
analytics.abt_crt_subscriber a
left outer join (
    select 
    subscriber_id
    from 
    analytics.abt_subscriber_current
    where 
    is_active = true
) b on 
    a.subscriber_id = b.subscriber_id
where 
b.subscriber_id is null
;

select 
a.subscriber_id,
b.subscriber_id
from 
(
    select 
    subscriber_id
    from 
    analytics.prod_abt_subscriber_current
    where 
    is_active = true
) b

left outer join analytics.prod_abt_crt_subscriber a on 
    a.subscriber_id = b.subscriber_id
where 
a.subscriber_id is null
;

set REQUEST_POOL=big;

select
*
from prod_abt_subscriber_current
where
subscriber_id = 10591139
;

select
subscriber_id,
subscriber_no,
customer_id,
from_priceplan,
to_priceplan,
migration_date
from
analytics.abt_migration_kpi
where
subscriber_id in (
--16334473,
--3852075,
1011367
--15297039
)
order by
subscriber_id,
migration_date
;

select
ban,
subscriber_no,
soc,
soc_seq_no,
effective_date,
expiration_date
from
base.import_fokus_base_service_agreement sa
where
sa.service_type in ('P','M') and
subscriber_no = 'GSM04528299316'
order by
effective_date;

select
subscriber_id,
subscriber_no,
ban,
sph.soc,
sph.effective_date
from
work.base_equation_product_tbt_subscribed_product_history sph
where
sph.subscriber_no = 'GSM04528299316'
order by
subscriber_id,
sph.effective_date
;

select
sfh.subscriber_id,
sfh.customer_id,
sfh.subscriber_no,
sfh.sub_status,
sfh.sub_status_date,
sfh.ctn_seq_no,
sfh.effective_date,
sfh.expiration_date
from
temp.base_equation_sub_tmp_subscriber_history sfh
left outer join (
    select
    subscriber_id,
    customer_id,
    subscriber_no,
    sub_status_date,
    effective_date,
    expiration_date
    from
    temp.base_equation_sub_tmp_subscriber_history
    where
    sub_status = 'C' and
    sub_status_date < trunc(effective_date,'dd')
) x on
    x.subscriber_id = sfh.subscriber_id
where
--x.subscriber_id is not null and
sfh.subscriber_id = 9267176
order by
sfh.subscriber_id,
sfh.ctn_seq_no
;

/*
select
count(*)
from 
(
*/
select
sfh.subscriber_id,
sfh.effective_date,
count(*)
from
(
    select
    distinct
    subscriber_id,
    effective_date
    from
    temp.base_equation_sub_tmp_subscriber_history
    where
    sub_status in ('A','S')
) sfh
left outer join (
    select
    subscriber_id,
    effective_date,
    expiration_date
    from
    temp.base_equation_sub_tmp_subscriber_history
    where
    sub_status in ('A','S')
) x on
    x.subscriber_id = sfh.subscriber_id and
    sfh.effective_date between
        x.effective_date and
        coalesce(x.expiration_date, sfh.effective_date)
group by
sfh.subscriber_id,
sfh.effective_date
having
count(*) > 1


) y
;



select
roaming_country,
unit_measure_code,
call_type,
bp_category_desc,
sum(event_count),
sum(at_call_dur_sec),
sum(at_call_dur_round_min)
from
analytics.prod_abt_gruppetrafik
where
call_month = 201904 and
roaming_country = 'Turkey'
group by
roaming_country,
ri_carrier,
call_type,
unit_measure_code,
bp_category_desc
order by
roaming_country,
unit_measure_code,
call_type,
bp_category_desc
;

select
event_month,
call_type,
call_description,
roaming_country_id,
country.name,
sum(event_count)
from
analytics.prod_abt_traffic traffic
left outer join base.manual_files_base_d_country as country on
    country.id = traffic.roaming_country_id
where
event_month = '201904' and
--call_description = 'SMS Roaming' and
roaming_country_id = 236
group by
event_month,
call_type,
call_description,
roaming_country_id,
country.name
order by
event_month,
call_type,
call_description,
roaming_country_id,
country.name
;

select
*
from
(
    select
    call_month as period,
    'Grouped traffic' as source,
    sum(event_count) as event_count
    from
    analytics.prod_abt_gruppetrafik
    group by
    call_month
    union
    select
    cast(event_month as int) as period,
    'Traffic' as source,
    sum(event_count) as event_count
    from
    analytics.prod_abt_traffic
    group by
    event_month
) x
where    
period between 201901 and 201905
order by
period,
source;

select
count(*),
max(difference),
avg(difference),
appx_median(difference)
from
(
Select
product_desc,
closing_stock as as_is,
(
    openning_stock + 
    activations + product_change_to - 
    annulments - churn_excl_annulments - product_change_from
) as to_be,
(
    openning_stock + 
    activations + product_change_to - 
    annulments - churn_excl_annulments - product_change_from - 
    closing_stock
) as difference,
annulments
From
(
select
Cs.Month,
Cs.Product_id,
Cs.Product_desc,
Cs.Closing_stock,
Cs.activations,
Cs.product_change_to,
Cs.annulments,
Cs.churn_excl_annulments,
Cs.product_change_from,
Coalesce(os.closing_stock, 0) as Openning_stock
From
Analytics.prod_Abt_stock_report as cs
Left outer join analytics.prod_Abt_stock_report as os on
	Cs.Month = cast( (cast (os.month as int) + 1) as char(6)) and
	Cs.product_id = os.product_id
Where
Cs.month = '201905'
) x
Where
1=1
) y 
where
difference <> 0;

select
*
from
base.manual_files_base_normalization
;

select
'before' source,
count(*)
from work.base_equation_kpis_work_subscribed_product_day_active
group by source
union
select
'after' source,
count(*)
from work.base_equation_kpis_work_subscribed_product_day_active_windows
group by source
;

select
date_as_date,
subscriber_id,
count(*)
from work.base_equation_kpis_work_subscribed_product_day_active_windows
group by
date_as_date,
subscriber_id
having
count(*) > 1
limit 10
;

select
cvr_no,
prodcat,
month,
year,
sum(amount) as amount

from
base.import_other_sources_base_sap_finance_data_new

group by
cvr_no,
prodcat,
month,
year

order by
cvr_no,
prodcat,
year,
month

limit 100;

select
to_be.cvr,
to_be.prodcat,
to_be.year,
to_be.month,
to_be.amount,
as_is.amount

from
(
select
cast(cvr_no as bigint) cvr,
prodcat,
month,
year,
sum(amount) as amount

from
base.import_other_sources_base_sap_finance_data_new

group by
cvr_no,
prodcat,
month,
year
) to_be

full outer join (
select
cast(customer_cvr_no as bigint) cvr,
product_category prodcat,
year,
month,
amount

from
work.salesforce_kpis_work_revenue_per_cvr
) as as_is on
    to_be.cvr = as_is.cvr and
    nvl(to_be.prodcat,'-') = nvl(as_is.prodcat,'-') and
    to_be.year = as_is.year and
    to_be.month = as_is.month

where
as_is.amount <> to_be.amount
;


select
customer.cvr_no as customer_cvr_no,
sim_category.prim_acc_type as sim_category,
sum(1) as sim_count
/*
pp.soc,
pp.ban,
pp.subscriber_no,
*/
from
(
select
date_as_date,
year,
month,
start_of_month,
end_of_month

from
abt_calendar

where
date_as_date = trunc(now(),'MM') - interval 1 day
) reporting_month

join base.import_fokus_base_service_agreement pp on
pp.service_type in ('P','M','N') and
pp.effective_date <= reporting_month.end_of_month and
pp.expiration_date > reporting_month.start_of_month

join (
select distinct
soc,
prim_acc_type
from
abt_product
) sim_category on
    sim_category.soc = pp.soc

join analytics.abt_customer_history customer on
customer.customer_id = pp.ban and
reporting_month.end_of_month between customer.start_date and customer.end_date

where
customer.cvr_no is not null

group by
customer.cvr_no,
sim_category.prim_acc_type

limit 100;

select
--count(*)
as_is.customer_cvr_no,
as_is.sim_category,
as_is.sum_count as_is,
to_be.sim_count to_be
from

(
select
*
from
work.salesforce_kpis_work_sim_count_for_sf
where
year = 2019 and
month = 6
) as_is

full outer join (
select
customer.cvr_no as customer_cvr_no,
sim_category.prim_acc_type as sim_category,
sum(1) as sim_count
/*
pp.soc,
pp.ban,
pp.subscriber_no,
*/
from
(
select
year,
month,
start_of_month,
end_of_month
from
abt_calendar
where
date_as_date = trun
cast ('2019-06-30 00:00:00' as timestamp)
) reporting_month

join base.import_fokus_base_service_agreement pp on
pp.service_type in ('P','M','N') and
pp.effective_date <= reporting_month.end_of_month and
pp.expiration_date > reporting_month.start_of_month

join (
select distinct
soc,
prim_acc_type
from
abt_product
) sim_category on
    sim_category.soc = pp.soc

join analytics.abt_customer_history customer on
customer.customer_id = pp.ban and
reporting_month.end_of_month between customer.start_date and customer.end_date

where
customer.cvr_no is not null

group by
customer.cvr_no,
sim_category.prim_acc_type

) as to_be on
to_be.customer_cvr_no = as_is.customer_cvr_no and
to_be.sim_category = as_is.sim_category

where
to_be.sim_count <> as_is.sum_count
limit 100;

select
customer_cvr_no,
product_prim_acc_type,
start_date,
end_date,
subscriber_id,
status
from
analytics.abt_subscriber_history
where
customer_cvr_no = '29938121'
order by
start_date;

select
date_as_date,
year,
month,
start_of_month,
end_of_month
from
abt_calendar
where
date_as_date = trunc(now(),'MM') - interval 1 day;

select
customer.cvr_no as customer_cvr_no,
sim_category.prim_acc_type as sim_category,
sum(1) as sim_count
/*
pp.soc,
pp.ban,
pp.subscriber_no,
*/
from
(
    select
    end_of_month,
    sim.soc,
    sim.ban,
    sim.subscriber_no
    from
    (
        select
        date_as_date,
        year,
        month,
        start_of_month,
        end_of_month
        
        from
        abt_calendar
        
        where
            date_as_date = trunc(now(),'MM') - interval 1 day
    ) reporting_month
    
    join base.import_fokus_base_service_agreement sim on
        sim.effective_date <= reporting_month.end_of_month and
        reporting_month.end_of_month < sim.expiration_date
        
    left outer join analytics.abt_soc soc on
        soc.soc = sim.soc
    
    where
        soc.extra_datacard is not null or 
        soc.extra_user is not null or
        sim.service_type in ('P','M')
) sim

join analytics.abt_customer_history customer on
    customer.customer_id = sim.ban and
    customer.start_date <= sim.end_of_month and 
    sim.end_of_month <= customer.end_date

left outer join (
    select distinct
    soc,
    prim_acc_type
    from
    abt_product
) sim_category on
    sim_category.soc = sim.soc

where
customer.cvr_no is not null

group by
customer.cvr_no,
sim_category.prim_acc_type

limit 100;

select  
prodcat,
round(sum(amount),2) as Revenue,
count(*) as row_count,
min(cast(year as bigint)*100+cast(month as bigint)) as from_month,
max(cast(year as bigint)*100+cast(month as bigint)) as to_month
from 
base.IMPORT_OTHER_SOURCES_base_sap_finance_data_new
where
cvr_no is not null
group by
prodcat
order by 
prodcat;

select distinct prodcat from raw.import_other_sources_raw_sap_finance_data_new
;

with 
as_is as (
select
customer_cvr_no,
product_prim_acc_type as sim_category,
count(*) as sim_count
from
(
select
distinct
subscriber.customer_cvr_no,
subscriber.product_prim_acc_type,
subscriber.subscriber_id,
subscriber.customer_id,
subscriber.subscriber_no
from 
analytics.abt_subscriber_history subscriber
where
subscriber.status not in ('C') and
subscriber.customer_cvr_no is not null and
(trunc(now(),'MM') - interval 1 day) between subscriber.start_date and subscriber.end_date
) x
group by
customer_cvr_no,
product_prim_acc_type
),

to_be as (
select
customer.cvr_no as customer_cvr_no,
sim_category.prim_acc_type as sim_category,
count(*) as sim_count

from
(
    select
    end_of_month,
    sim.soc,
    sim.ban,
    sim.subscriber_no
    from
    (
        select
        date_as_date,
        year,
        month,
        start_of_month,
        end_of_month
        
        from
        abt_calendar
        
        where
            date_as_date = trunc(now(),'MM') - interval 1 day
    ) reporting_month
    
    join base.import_fokus_base_service_agreement sim on
        sim.effective_date <= reporting_month.end_of_month and
        reporting_month.end_of_month < sim.expiration_date
        
    left outer join analytics.abt_soc soc on
        soc.soc = sim.soc and
        soc.start_date <= reporting_month.end_of_month and
        reporting_month.end_of_month <= soc.end_date
    
    where
        --soc.extra_datacard is not null or 
        --soc.extra_user is not null or
        sim.service_type in ('P','M')
) sim

join analytics.abt_customer_history customer on
    customer.customer_id = sim.ban and
    customer.start_date <= sim.end_of_month and 
    sim.end_of_month <= customer.end_date

left outer join (
    select distinct
    soc,
    prim_acc_type
    from
    abt_product
) sim_category on
    sim_category.soc = sim.soc

where
customer.cvr_no is not null

group by
customer.cvr_no,
sim_category.prim_acc_type
)

select
as_is.customer_cvr_no,
as_is.sim_category,
as_is.sim_count,
to_be.sim_count

from
as_is

full outer join to_be on
as_is.customer_cvr_no = to_be.customer_cvr_no and
as_is.sim_category = to_be.sim_category

where
as_is.sim_count <> to_be.sim_count
limit 100;

select
sim.*,
sim_category.*
from
(
    select
    end_of_month,
    sim.soc,
    sim.ban,
    sim.subscriber_no,
    sim.service_type
    from
    (
        select
        date_as_date,
        year,
        month,
        start_of_month,
        end_of_month
        
        from
        abt_calendar
        
        where
            date_as_date = trunc(now(),'MM') - interval 1 day
    ) reporting_month
    
    join base.import_fokus_base_service_agreement sim on
        sim.effective_date <= reporting_month.end_of_month and
        reporting_month.end_of_month < sim.expiration_date
        
    left outer join analytics.abt_soc soc on
        soc.soc = sim.soc and
        soc.start_date <= reporting_month.end_of_month and
        reporting_month.end_of_month <= soc.end_date
    
    where
        --soc.extra_datacard is not null or 
        --soc.extra_user is not null or
        sim.service_type in ('P','M')
) sim

join analytics.abt_customer_history customer on
    customer.customer_id = sim.ban and
    customer.start_date <= sim.end_of_month and 
    sim.end_of_month <= customer.end_date
    
left outer join (
    select distinct
    soc,
    prim_acc_type
    from
    abt_product
) sim_category on
    sim_category.soc = sim.soc

where
sim.ban = 950891218 and
sim.subscriber_no = 'GSM04527635041'
;
/*
customer.cvr_no = '18211114' and
sim_category.prim_acc_type = 'DATA'
*/

select
ban,
subscriber_no,
soc,
sim.campaign,
effective_date,
expiration_date,
sim.soc_seq_no
from 
base.import_fokus_base_service_agreement sim
where
sim.service_type = 'P' and
sim.ban = 950891218 and
sim.subscriber_no = 'GSM04527635041'
order by
sim.effective_date,
sim.soc_seq_no
;

select
customer_id,
subscriber_no,
subscriber_id,
effective_date,
null expiration_date,
sub_status,
sub_status_date,
init_activation_date
from
base.import_fokus_base_subscriber
where
customer_id = 950891218 and
subscriber_no = 'GSM04527635041';

select
customer_id,
subscriber_no,
subscriber_id,
effective_date,
expiration_date,
sub_status,
sub_status_date,
init_activation_date
from
base.import_fokus_base_subscriber_history
where
customer_id = 950891218 and
subscriber_no = 'GSM04527635041';

select
customer_id,
subscriber_no,
subscriber_id,
start_date,
end_date,
status,
churn_date,
subscriber_id_on_ban_first_activation_date,
subscriber_id_on_ban_first_activation_date
from
analytics.prod_abt_subscriber_history
where
customer_id = 950891218 and
subscriber_no = 'GSM04527635041';

select
memo_ban,
memo_subscriber,
memo_date,
memo_type,
memo_system_text
from
base.import_fokus_base_memo memo
where
memo.memo_ban = 950891218 and
memo.memo_subscriber = 'GSM04527635041';

select
*
from
(
select
/*
customer_cvr_no,
product_prim_acc_type as sim_category,
*/
x.*
from
(
select
distinct
subscriber.customer_cvr_no,
subscriber.product_prim_acc_type as sim_category,
subscriber.subscriber_id,
subscriber.customer_id,
subscriber.subscriber_no,
subscriber.start_date,
subscriber.end_date,
subscriber.status
from 
analytics.abt_subscriber_history subscriber
where
subscriber.status not in ('C') and
subscriber.customer_cvr_no is not null and
(trunc(now(),'MM') - interval 1 day) between subscriber.start_date and subscriber.end_date
) x
/*
group by
customer_cvr_no,
product_prim_acc_type
*/
) y
where
customer_cvr_no = '18211114' and
sim_category = 'DATA';

select
soc,
count(distinct product_group)
from abt_product
group by
soc
having
count(distinct product_group) > 1
order by
count(distinct product_group) desc
;

select
pp.ban,
pp.subscriber_no,
count(*)
from base.import_fokus_base_service_agreement pp
join base.import_fokus_base_service_agreement pp2 on
    pp2.service_type in ('P','M') and
    pp2.ban = pp.ban and
    pp2.subscriber_no = pp.subscriber_no and
    pp.effective_date < pp2.expiration_date and
    pp2.effective_date < pp.expiration_date
where
    pp.service_type in ('P','M')
group by
pp.ban,
pp.subscriber_no
having
count(*) > 1
order by 
count(*) desc;

select
count(*)
/*
pp.ban,
pp.subscriber_no,
count(*)
*/
from base.import_fokus_base_service_agreement pp
join base.import_fokus_base_service_agreement pp2 on
    pp2.service_type in ('P') and
    pp2.ban = pp.ban and
    pp2.subscriber_no = pp.subscriber_no and
    pp.effective_date < pp2.expiration_date and
    pp2.effective_date < pp.expiration_date
where
    pp.service_type in ('P') and
    (
        pp.effective_date <> pp2.effective_date or
        pp.expiration_date <> pp2.expiration_date
    )
/*
group by
pp.ban,
pp.subscriber_no
having
count(*) > 0
order by 
count(*) desc
*/
;

select count(*) from base.import_fokus_base_service_agreement pp where pp.service_type in ('P');

select
/*
ban,
pp.subscriber_no,
pp.soc,
pp.soc_seq_no,
pp.effective_date,
pp.expiration_date
*/
soc.*
from base.import_fokus_base_service_agreement pp
join raw.import_fokus_raw_soc soc on
    soc.soc = pp.soc
where
pp.service_type in ('P') and
ban = 625703111 and
pp.subscriber_no = 'GSM04560401703'
order by
pp.effective_date,
pp.soc_seq_no;

select
pp.ban,
pp.subscriber_no,
pp.soc,
pp.service_type,
pp.effective_date,
pp.expiration_date,
pp2.soc,
pp2.service_type,
pp2.effective_date,
pp2.expiration_date
from base.import_fokus_base_service_agreement pp
join base.import_fokus_base_service_agreement pp2 on
    pp2.service_type in ('P','M') and
    pp2.ban = pp.ban and
    pp2.subscriber_no = pp.subscriber_no and
    pp.effective_date < pp2.expiration_date and
    pp2.effective_date < pp.expiration_date
where
    pp.service_type in ('P','M') and
    pp.ban = 625703111 and
    pp.subscriber_no = 'GSM04560401703' and
    (
        pp.effective_date <> pp2.effective_date or
        pp.expiration_date <> pp2.expiration_date
    )
order by 
pp.effective_date,
pp2.effective_date;

With 
-- get price plans as service agreement of P, M service type
pp as (
	Select
	Soc,
	Ban,
	subscriber_no,
	Effective_date,
	Expiration_date,
	Soc_seq_no
	From 
	base.import_fokus_base_service_agreement as service_agreement
	Where
	Service_type in ('P','M') and
	1=1 -- effective_date < expiration_date
),
-- get subscriber full history as union subscriber and subscriber_history
Sfh as (
	Select
	Subscriber_id,
	Subscriber_no,
	Customer_id,
	Effective_date,
	Cast('9999-12-31 00:00:00' as timestamp) as expiration_date,
	Ctn_seq_no,
	sub_status
	From
	base.import_fokus_base_Subscriber as subscriber
	union
	Select
	Subscriber_id,
	Subscriber_no,
	Customer_id,
	Effective_date,
	expiration_date,
	Ctn_seq_no,
	sub_status
	From
	base.import_fokus_base_Subscriber_history as Subscriber_history
),
Pp_subid as (
	Select
	*
	From
	(
		Select
		Pp.Soc,
		Pp.Ban,
		Pp.subscriber_no,
		Pp.Effective_date,
		Pp.Expiration_date,
		Pp.Soc_seq_no,
		Sfh.subscriber_id,
		(
			Row_number() over (
			Partition by
			Pp.soc,
			Pp.ban,
			Pp.subscriber_no,
			Pp.soc_seq_no,
			Pp.expiration_date
			Order by
			/*
			Prefer not closed subscription if exists. There are the following situations:

		    In service_agreement table there could be rows:
		    Priceplan 1, ban x, subno y, eff ..., exp 31.12.2018. 
		    Priceplan 2, ban x, subno y, eff 6.5.2019, exp 6.5.2019. 
		    Priceplan 3, ban x, subno y, eff 6.5.2019, exp 31.12.4700.
		    
		    In subscriber union subscriber_history table there could be rows:
		    Ban x, subno y, subid a, status C, eff 31.12.2018 ..., exp = 6.5.2019 ...
		    Ban x, subno y, subid b, status A, eff 6.5.2019 ..., exp null
            
            If we did not prefer not closed rows, the priceplan 2 would get subid a and would be reported as churn. But Priceplan 2 is of subid b.
            */
			(
				Case
				When sfh.sub_status = 'C' 
				then 1
				Else 0
				End
			) asc,
			sfh.expiration_date asc,
			sfh.ctn_seq_no asc
			)
		) as rnk
		from
		Pp
		Join sfh on
			Sfh.customer_id = pp.ban and
			Sfh.subscriber_no = pp.subscriber_no and
			Pp.expiration_date < sfh.expiration_date
	) as x
	Where
	Rnk = 1
),
-- Get memo of resume type and join it with pp_subid to enrich it of subscriber_id
Memo_subid as (
	Select
	*
	From
	(
		Select
		Pp_subid.Soc,
		Pp_subid.Ban,
		Pp_subid.subscriber_no,
		Pp_subid.Effective_date,
		Pp_subid.Expiration_date,
		Pp_subid.Soc_seq_no,
		Pp_subid.subscriber_id,
		Memo.memo_date as resume_date,
		(
			Row_number() over (
			Partition by
			Memo.memo_ban,
			Memo.memo_subscriber,
			Memo.memo_date
			Order by
			Pp_subid.effective_date desc
			)
		) as rnk
		From
		base.import_fokus_base_Memo as memo
		Join pp_subid on
		Memo.memo_ban = pp_subid.ban and
		Memo.memo_subscriber = pp_subid.subscriber_no and
		Pp_subid.effective_date < memo.memo_date
		where
		Memo.memo_type = '0008'
	)  x
	Where
	Rnk = 1
),
-- Join pp_subid with memo_subid to enrich pp_subid of resume date
Pp_subid_memo as (
	Select
	*
	From
	(
		Select
		Pp_subid.Soc,
		Pp_subid.Ban,
		Pp_subid.subscriber_no,
		Pp_subid.Effective_date,
		Pp_subid.Expiration_date,
		Pp_subid.Soc_seq_no,
		Pp_subid.subscriber_id,
		Nvl(
			Memo_subid.resume_date,
			Cast('9999-12-31 00:00:00' as timestamp)
		) as resume_date,
		(
			Row_number() over (
			Partition by
			Pp_subid.Soc,
			Pp_subid.Ban,
			Pp_subid.subscriber_no,
			Pp_subid.Effective_date,
			Pp_subid.Expiration_date,
			Pp_subid.Soc_seq_no,
			Pp_subid.subscriber_id
			Order by
			Memo_subid.resume_date asc
			)
		) as rnk
		from
		Pp_subid
		Left outer join memo_subid on
			Memo_subid.subscriber_id = pp_subid.subscriber_id and
			Pp_subid.effective_date < memo_subid.resume_date
	) x
	Where
	Rnk = 1
),
-- Find churns as last rows over subscriber_id, resume_date with expiration date in the past
Churn_kpi as (
	Select
	*
	From
	(
		Select
		Soc,
		Ban,
		subscriber_no,
		Effective_date,
		Pp_subid_memo.Expiration_date as churn_date,
		Soc_seq_no,
		subscriber_id,
		resume_date,
		(
			Row_number() 
			over (
    			Partition by 
    			Subscriber_id,
    			Resume_date
    			Order by 
    			Pp_subid_memo.Expiration_date desc,
    			soc_seq_no desc
			)
		) as rnk,
		(
		    min(pp_subid_memo.effective_date) 
		    over (
    			Partition by 
    			Subscriber_id,
    			Resume_date
			)
	     ) as intake_date   
		From
		Pp_subid_memo
	) x
	Where
	x.Rnk = 1 and
	x.churn_date < now()
)
/*
select
*
FROM pp_subid_memo
where
subscriber_id = 929463
*/
select
*
from
(
    select
    subscriber_id,
    subscriber_no,
    ban as customer_id,
    resume_date,
    intake_date
    from churn_kpi
    where churn_date = cast('2019-05-06 00:00:00' as timestamp)
) as to_be
right outer join (
    select
    subscriber_id,
    subscriber_no,
    customer_id
    from analytics.prod_abt_churn_kpi
    where churn_date = cast('2019-05-06 00:00:00' as timestamp)
) as as_is on
    as_is.subscriber_no = to_be.subscriber_no and
    as_is.customer_id = to_be.customer_id and
    as_is.subscriber_id = to_be.subscriber_id
where
to_be.subscriber_id is null
order by
as_is.subscriber_id
limit 100;

/*
count(*)
from
churn_kpi
where
churn_date = cast('2019-05-06 00:00:00' as timestamp)
limit 100
--1773
*/

set request_pool = big;

select count(*) from analytics.prod_abt_churn_kpi where churn_date = cast('2019-05-06 00:00:00' as timestamp);

select
--*
ban,
subscriber_no,
effective_date,
expiration_date,
soc,
soc_seq_no
from
base.import_fokus_base_service_agreement
where
service_type in ('P','M') and
--ban = 904281904 and
subscriber_no = 'GSM88853267045'
order by
effective_date,
soc_seq_no;

select
*
from
(
    select
    customer_id,
    subscriber_no,
    effective_date,
    null as expiration_date,
    subscriber_id,
    sub_status,
    sub_status_date,
    ctn_seq_no,
    'Current' as source
    from
    base.import_fokus_base_subscriber
    union
    select
    customer_id,
    subscriber_no,
    effective_date,
    expiration_date,
    subscriber_id,
    sub_status,
    sub_status_date,
    ctn_seq_no,
    'History' as source
    from
    base.import_fokus_base_subscriber_history
) as subscriber
where
/*
customer_id = 602041212 and
subscriber_no = 'GSM04530378136'
*/
subscriber_id = 16416819
order by
effective_date,
ctn_seq_no;

select
*
from
analytics.prod_abt_churn_kpi
where
subscriber_id = 9973227;

select
memo_ban,
memo_subscriber,
memo_date,
*
from base.import_fokus_base_memo
where
memo_type = '0008' and
memo_subscriber = 'PBX04598109022';

select
*
from base.import_fokus_base_subscriber
where
sub_status = 'R'
limit 100;
-- GSM88853267045
-- 479673212
;

Select
customer.cvr_no as customer_cvr_no,
sim_category.prim_acc_type as sim_category,
sum(1) as sim_count
from
(
    select
    end_of_month,
    sim.soc,
    sim.ban,
    sim.subscriber_no
    from
    (
        select
        date_as_date,
        year,
        month,
        start_of_month,
        end_of_month
        
        from
        abt_calendar
        
        where
            date_as_date = trunc(now(),'MM') - interval 1 day
    ) reporting_month
    
    join base.import_fokus_base_service_agreement sim on
        sim.effective_date <= reporting_month.end_of_month and
        reporting_month.end_of_month < sim.expiration_date
        
    left outer join analytics.abt_soc soc on
        soc.soc = sim.soc and
        soc.start_date <= reporting_month.end_of_month and
        reporting_month.end_of_month < soc.end_date
    
    where
        soc.extra_datacard is not null or 
        soc.extra_user is not null or
        sim.service_type in ('P','M')
) sim

join analytics.abt_customer_history customer on
    customer.customer_id = sim.ban and
    customer.start_date <= sim.end_of_month and 
    sim.end_of_month <= customer.end_date

left outer join (
    select distinct
    soc,
    prim_acc_type
    from
    abt_product
) sim_category on
    sim_category.soc = sim.soc

where
customer.cvr_no is not null and
customer.cvr_no = '16077593'

group by
customer.cvr_no,
sim_category.prim_acc_type

-- limit 100;
;

with x as (
select
roaming_country,
ri_carrier,
rm_operator_desc,
unit_measure_code,
call_type,
bp_category_desc,
sum(event_count) as event_count,
sum(at_call_dur_sec) as at_call_dur_sec,
sum(at_call_dur_round_min) as at_call_dur_round_min
from
analytics.prod_abt_gruppetrafik
where
call_month = 201904 and
roaming_country = 'Turkey'
group by
roaming_country,
ri_carrier,
rm_operator_desc,
call_type,
unit_measure_code,
bp_category_desc
)
/*
select * from x
order by
roaming_country,
unit_measure_code,
call_type,
bp_category_desc
*/
select
'MOC Voice Duration' as KPI,
sum (at_call_dur_round_min) as value
from x where
unit_measure_code = 'M' and
call_type <> 'L'
union select
'MTC Voice Duration' as KPI,
sum (at_call_dur_round_min) as value
from x where
unit_measure_code = 'M' and
call_type = 'L'
union select
'MOC SMS' as KPI,
sum (at_call_dur_round_min) as value
from x where
unit_measure_code = 'O' and
bp_category_desc not like '%MMS%'
union select
'MOC MMS' as KPI,
sum (at_call_dur_round_min) as value
from x where
unit_measure_code = 'O' and
bp_category_desc like '%MMS%'
union select
'MOC GPRS' as KPI,
sum (at_call_dur_round_min/10) as value
from x where
unit_measure_code = 'A'
;

With 
/*
	• Get ban, subno and date when product might change. 
	• These dates are those when
		○ pp and promo starts 
		○ promo ends 
	• We do not need dates when pp ends, because we will derive it from pp expiration date when searching for next change_date and nothing is found.
*/
chd as (
    select
    Ban,
	Subscriber_no,
	Effective_date as change_date
	From
	base.import_fokus_base_service_agreement
	where 
	service_type in ('P','M','N')
	union
	select
    Ban,
	Subscriber_no,
	expiration_date as change_date
	From
	base.import_fokus_base_service_agreement
	where 
	service_type in ('N')
),

/*
	• Join price plans to have also pp soc, campaign, soc_seq_no, effective_date and expiration_date.
	• We will need it to derive product
	• Joined price plans are those which 
		○ Starts at or before change date
		○ (Ends after change date) or (ends at change date but are of 0 days duration)
	• We need also 0 days duration price plans and promotions to correctly report migration
*/
pp as (
	Select
	Soc,
	campaign,
	Ban,
	subscriber_no,
	Effective_date,
	Expiration_date,
	Soc_seq_no
	From 
	base.import_fokus_base_service_agreement as service_agreement
	Where
	Service_type in ('P','M') and
	1=1 -- effective_date < expiration_date
),

chd_pp as (
    select
	chd.Ban,
    chd.subscriber_no,
    chd.change_date,
    Soc as pp_soc,
    campaign as pp_campaign,
	Effective_date as pp_effective_date,
	Expiration_date as pp_expiration_date,
	Soc_seq_no as pp_soc_seq_no
    from
    chd
    join pp on
        pp.ban = chd.ban and
        pp.subscriber_no = chd.subscriber_no
    where
    pp.effective_date <= chd.change_date and
    pp. Expiration_date > chd.Change_date or
	(
	    pp.Expiration_date = chd.Change_date and
        Pp.effective_date = pp. Expiration_date
    )
),

/*
	• Join promotions to have also promotion soc, effective_date and expiration_date. 
	• We will need it to derive product.
	• Joined promotions are only these which starts at the change_date. We know that these ends either in next change date or at pp expiration date.
*/
promo as (
	Select
	Soc,
	campaign,
	Ban,
	subscriber_no,
	Effective_date,
	Expiration_date,
	Soc_seq_no
	From 
	base.import_fokus_base_service_agreement as service_agreement
	Where
	Service_type in ('N') and
	1=1 -- effective_date < expiration_date
),

chd_pp_promo as (
	select
	chd_pp.Ban,
    chd_pp.subscriber_no,
    chd_pp.change_date,
    pp_soc,
    pp_campaign,
	pp_effective_date,
	pp_expiration_date,
	pp_soc_seq_no,
	promo.soc as promo_soc,
	promo.effective_date as promo_effective_date,
	promo.expiration_date as promo_expiration_date,
	promo.soc_seq_no as promo_soc_seq_no
    from
    chd_pp
    left outer join promo on
        promo.ban = chd_pp.ban and
        promo.subscriber_no = chd_pp.subscriber_no and
        promo.effective_date = chd_pp.change_date
),
/*
	• Extend data of start_date and end_date derived from change_date, next_change_date and pp expiration_date
	• Start date is change_date
	• End date is next_change_date if exists. If not, it means there is no change date in partition of ban, subscriber_no, soc and soc_seq_no. So End date is then price plan expiration date.
	• It works also for price plans and promotion with 0 duration. In case in one day there are multiple price plans and promotions, these multiply each other. And this is ok, we simply do not know wich pp corresponds to which promotion - so we cover all combinations.
*/
chd_pp_promo_sed as (
    select
    Ban,
    subscriber_no,
    change_date,
    pp_soc,
    pp_campaign,
	pp_effective_date,
	pp_expiration_date,
	pp_soc_seq_no,
	promo_soc,
	promo_effective_date,
	promo_expiration_date,
	promo_soc_seq_no,
	change_date as start_date,
	coalesce(
    	lead(change_date, 1, null) over (
	        partition by
	            ban,
	            subscriber_no,
	            pp_soc,
	            pp_soc_seq_no
	        order by
	            change_date,
	            promo_soc_seq_no
        ),
        pp_expiration_date
    ) as end_date
    from
    chd_pp_promo
),

/*
	• Join subscriber union subscriber history to have subscriber_id
	• Joined subscriber rows are these with the same ban, subno as with expiration_date after end_date.
	• In case there are more such subscriber rows, select one row by the following way:
		○ Sort subscriber rows in partition defined by ban, subno, end_date so that:
			§ Prefer active rows with status A, C before inactive ones with status R, C
				□ In case subscriber row is closed, the pp might be one day pp which belongs to active row starting after end date.
				□ But we cannot exclude C rows, because there are cases when no active row exists in subscriber history (annulments)
			§ Prefer rows with lower expiration_date
		○ Select the very first row of the sorted partition into the result row
*/
Sfh as (
	Select
	Subscriber_id,
	Subscriber_no,
	Customer_id,
	Effective_date,
	Cast('9999-12-31 00:00:00' as timestamp) as expiration_date,
	Ctn_seq_no,
	sub_status
	From
	base.import_fokus_base_Subscriber as subscriber
	union
	Select
	Subscriber_id,
	Subscriber_no,
	Customer_id,
	Effective_date,
	expiration_date,
	Ctn_seq_no,
	sub_status
	From
	base.import_fokus_base_Subscriber_history as Subscriber_history
),
chd_pp_promo_sed_subid as (
	Select
	*
	From
	(
		Select
		chd_pp_promo_sed.*,
		Sfh.subscriber_id,
		(
			Row_number() over (
			Partition by
			chd_pp_promo_sed.pp_soc,
			chd_pp_promo_sed.ban,
			chd_pp_promo_sed.subscriber_no,
			chd_pp_promo_sed.Pp_soc_seq_no,
			chd_pp_promo_sed.end_date
			Order by
			/*
			Prefer not closed subscription if exists. There are the following situations:

		    In service_agreement table there could be rows:
		    Priceplan 1, ban x, subno y, eff ..., exp 31.12.2018. 
		    Priceplan 2, ban x, subno y, eff 6.5.2019, exp 6.5.2019. 
		    Priceplan 3, ban x, subno y, eff 6.5.2019, exp 31.12.4700.
		    
		    In subscriber union subscriber_history table there could be rows:
		    Ban x, subno y, subid a, status C, eff 31.12.2018 ..., exp = 6.5.2019 ...
		    Ban x, subno y, subid b, status A, eff 6.5.2019 ..., exp null
            
            If we did not prefer not closed rows, the priceplan 2 would get subid a and would be reported as churn. But Priceplan 2 is of subid b.
            */
			(
				Case
				When sfh.sub_status = 'C' 
				then 1
				Else 0
				End
			) asc,
			sfh.expiration_date asc,
			sfh.ctn_seq_no asc
			)
		) as rnk
		from
		chd_pp_promo_sed
		left outer Join sfh on
			Sfh.customer_id = chd_pp_promo_sed.ban and
			Sfh.subscriber_no = chd_pp_promo_sed.subscriber_no and
			chd_pp_promo_sed.end_date < sfh.expiration_date
	) as x
	Where
	Rnk = 1
),
/*
	• Join products by special logic:
		○ Outer Join all products by pp soc, promo soc, campaing
		○ Outer Join products with empty campaing by pp soc, promo soc
		○ Outer Join products with empty promo soc by pp soc, campaign
		○ Outer Join products with empty campaign, promo soc by pp soc
		○ Outer join products by first non empty product_id from the above (in given order)
	• Product id from the last joined product listed above it the one we need
*/
subscribed_product as (
    select
    chd_pp_promo_sed_subid.*,
    p.product_id,
    p.product_code,
    p.product_desc
    FROM
    chd_pp_promo_sed_subid
    left outer join work.base_equation_product_tbt_product as p1 on
        chd_pp_promo_sed_subid.pp_soc = p1.soc and
        chd_pp_promo_sed_subid.pp_campaign = p1.campaign and
        chd_pp_promo_sed_subid.promo_soc = p1.service_soc
    left outer join work.base_equation_product_tbt_product as p2 on
        chd_pp_promo_sed_subid.pp_soc = p2.soc and
        p2.campaign is null and
        chd_pp_promo_sed_subid.promo_soc = p2.service_soc
    left outer join work.base_equation_product_tbt_product as p3 on
        chd_pp_promo_sed_subid.pp_soc = p3.soc and
        chd_pp_promo_sed_subid.pp_campaign = p3.campaign and
        p3.service_soc is null
    left outer join work.base_equation_product_tbt_product as p4 on
        chd_pp_promo_sed_subid.pp_soc = p4.soc and
        p4.campaign is null and
        p4.service_soc is null
    left outer join work.base_equation_product_tbt_product as p on
        p.product_id = coalesce(
            p1.product_id,
            p2.product_id,
            p3.product_id,
            p4.product_id
        )
)
select * from subscribed_product 
where 
--promo_soc is not null
ban = 100126492 and
subscriber_no = 'GSM04528192042'
order by subscriber_id, start_date
limit 100;

select * from work.base_equation_product_tbt_product where soc = 'TELBIZ1';

SELECT * FROM analytics.prod_abt_gruppetrafik LIMIT 100;


With 
/*
    ○ Get memo
    ○ Join it with sa_product on ban, subno to have memo_date and subscriber_id
    ○ Get subscribed_product
    ○ Join it with memo enriched of subscribed_id
	○ Find churns as last product over partition by subscriber_id, resume date
*/

/*
    ○ Get memo
    ○ Join it with sa_product on ban, subno to have memo_date and subscriber_id
*/
Memo_subid as (
	Select
	*
	From
	(
		Select
        sa_product.s_subscriber_id as subscriber_id,
		Memo.memo_date as resume_date,
		(
			Row_number() over (
			Partition by
			Memo.memo_ban,
			Memo.memo_subscriber,
			Memo.memo_date
			Order by
			sa_product.effective_date desc
			)
		) as rnk
		From
		base.import_fokus_base_Memo as memo
		Join work.base_equation_product_work_sa_product as sa_product on
		    Memo.memo_ban = sa_product.ban and
		    Memo.memo_subscriber = sa_product.subscriber_no and
		    sa_product.effective_date < memo.memo_date
		where
		    Memo.memo_type = '0008'
	)  x
	Where
	Rnk = 1
),

/*
    ○ Get subscribed_product
    ○ Join it with memo enriched of subscribed_id
*/

sa_product_memo as (
	Select
	*
	From
	(
		Select
        sa_product.*,
		Nvl(
			Memo_subid.resume_date,
			Cast('9999-12-31 00:00:00' as timestamp)
		) as resume_date,
		(
			Row_number() over (
			Partition by
			sa_product.product_id,
			sa_product.Ban,
			sa_product.subscriber_no,
			sa_product.s_subscriber_id,
			sa_product.Effective_date,
			sa_product.Expiration_date
			Order by
			Memo_subid.resume_date asc
			)
		) as rnk
		from
		work.base_equation_product_work_sa_product as sa_product
		Left outer join memo_subid on
			Memo_subid.subscriber_id = sa_product.s_subscriber_id and
			sa_product.effective_date < memo_subid.resume_date
	) x
	Where
	Rnk = 1
),
/*
	○ Find churns as last product over partition by subscriber_id, resume date
*/
Churn_kpi as (
	Select
	*
	From
	(
		Select
		Expiration_date as churn_date,
		sa_product_memo.*,
		(
			Row_number() 
			over (
    			Partition by 
    			s_Subscriber_id,
    			Resume_date
    			Order by 
    			Expiration_date desc,
    			promo_soc_seq_no desc,
    			soc_seq_no desc
			)
		) as churn_rnk,
		(
		    min(effective_date) 
		    over (
    			Partition by 
    		    s_Subscriber_id,
    			Resume_date
			)
	    ) as intake_date   
		From
		sa_product_memo
	) x
	Where
	x.churn_rnk = 1 and
	x.churn_date < now()
),
to_be as (
    Select 
    *
    from churn_kpi 
    where
    churn_date = cast('2019-05-06 00:00:00' as TIMESTAMP) and
    datediff(churn_date, intake_date) > 30
),
as_is as (
    select
    *
    from 
    analytics.prod_abt_churn_kpi
    where
    churn_date = cast('2019-05-06 00:00:00' as TIMESTAMP)
)
select
to_be.churn_date,
to_be.s_subscriber_id,
to_be.subscriber_no,
to_be.ban,
to_be.resume_date,
as_is.subscriber_id
from
to_be
left outer join as_is on 
    as_is.subscriber_id = to_be.s_subscriber_id
    /*
    as_is.subscriber_no = to_be.subscriber_no and
    as_is.customer_id = to_be.ban
    */
where
as_is.subscriber_id is null;
;

select
s_subscriber_id,
ban,
subscriber_no,
sa_product.product_desc,
effective_date,
expiration_date,
*
from
work.base_equation_product_work_sa_product as sa_product
where
subscriber_no = 'GSM04524417903' and
ban = 656107703  
--s_subscriber_id = 9736950
order by sa_product.effective_date;


select
*
from 
analytics.prod_abt_churn_kpi
where
subscriber_id = 9736950
;

set request_pool = big;

;

select
subscriber_id,
customer_id,
subscriber_no,
effective_date,
expiration_date
from 
work.base_equation_product_work_subscriber_union
where
subscriber_no = 'GSM04524417903' and
customer_id = 656107703  
order by effective_date
;
--subscriber_id = 9736950

with
hs_cnt as (
select
handset_count,
count(*)
from analytics.prod_abt_churn_kpi
group by
handset_count
order by handset_count desc
)
select * from hs_cnt;


with x as (
select
soc_seq_no,
soc_ver_no,
soc,
count(*)
from base.import_fokus_base_service_agreement
group by 
soc_seq_no, 
soc_ver_no, 
soc
having count(*) > 1
),
y as (
select 
sa.*
from 
base.import_fokus_base_service_agreement sa
join x on
x.soc_seq_no = sa.soc_seq_no and
x.soc_ver_no = sa.soc_ver_no and
x.soc = sa.soc
),
z as (
select count(*) from x
)
select * from y; 
-- order by soc_seq_no limit 100



select * 
from work.base_equation_product_work_sa_product
where s_subscriber_id = 16289657;

select * from work.base_equation_product_work_subscriber_union where subscriber_no='GSM04542143231';

With 
/*
    • Get ban, subno and date when product might change. 
    • These dates are those when
        ○ pp and promo starts 
        ○ promo ends 
    • We do not need dates when pp ends, because we will derive it from pp expiration date when searching for next change_date and nothing is found.
*/
chd as (
    select
    Ban,
    Subscriber_no,
    Effective_date as change_date
    From
    base.import_fokus_base_service_agreement
    where 
    service_type in ('P','M','N')
    union
    select
    Ban,
    Subscriber_no,
    expiration_date as change_date
    From
    base.import_fokus_base_service_agreement
    where 
    service_type in ('N')
),

/*
    • Join price plans to have also pp soc, campaign, soc_seq_no, effective_date and expiration_date.
    • We will need it to derive product
    • Joined price plans are those which 
        ○ Starts at or before change date
        ○ (Ends after change date) or (ends at change date but are of 0 days duration)
    • We need also 0 days duration price plans and promotions to correctly report migration
*/
pp as (
    Select
    Soc,
    campaign,
    Ban,
    subscriber_no,
    Effective_date,
    Expiration_date,
    Soc_seq_no
    From 
    base.import_fokus_base_service_agreement as service_agreement
    Where
    Service_type in ('P','M') and
    1=1 -- effective_date < expiration_date
),

chd_pp as (
    select
    chd.Ban,
    chd.subscriber_no,
    chd.change_date,
    Soc as pp_soc,
    campaign as pp_campaign,
    Effective_date as pp_effective_date,
    Expiration_date as pp_expiration_date,
    Soc_seq_no as pp_soc_seq_no
    from
    chd
    join pp on
        pp.ban = chd.ban and
        pp.subscriber_no = chd.subscriber_no
    where
    pp.effective_date <= chd.change_date and
    pp. Expiration_date > chd.Change_date or
    (
        pp.Expiration_date = chd.Change_date and
        Pp.effective_date = pp. Expiration_date
    )
),

/*
    • Join promotions to have also promotion soc, effective_date and expiration_date. 
    • We will need it to derive product.
    • Joined promotions are only these which starts at the change_date. We know that these ends either in next change date or at pp expiration date.
*/
promo as (
    Select
    Soc,
    campaign,
    Ban,
    subscriber_no,
    Effective_date,
    Expiration_date,
    Soc_seq_no
    From 
    base.import_fokus_base_service_agreement as service_agreement
    Where
    Service_type in ('N') and
    1=1 -- effective_date < expiration_date
),

chd_pp_promo as (
    select
    chd_pp.Ban,
    chd_pp.subscriber_no,
    chd_pp.change_date,
    pp_soc,
    pp_campaign,
    pp_effective_date,
    pp_expiration_date,
    pp_soc_seq_no,
    promo.soc as promo_soc,
    promo.effective_date as promo_effective_date,
    promo.expiration_date as promo_expiration_date,
    promo.soc_seq_no as promo_soc_seq_no
    from
    chd_pp
    left outer join promo on
        promo.ban = chd_pp.ban and
        promo.subscriber_no = chd_pp.subscriber_no and
        promo.effective_date = chd_pp.change_date
),
/*
    • Extend data of start_date and end_date derived from change_date, next_change_date and pp expiration_date
    • Start date is change_date
    • End date is next_change_date if exists. If not, it means there is no change date in partition of ban, subscriber_no, soc and soc_seq_no. So End date is then price plan expiration date.
    • It works also for price plans and promotion with 0 duration. In case in one day there are multiple price plans and promotions, these multiply each other. And this is ok, we simply do not know wich pp corresponds to which promotion - so we cover all combinations.
*/
chd_pp_promo_sed as (
    select
    Ban,
    subscriber_no,
    change_date,
    pp_soc,
    pp_campaign,
    pp_effective_date,
    pp_expiration_date,
    pp_soc_seq_no,
    promo_soc,
    promo_effective_date,
    promo_expiration_date,
    promo_soc_seq_no,
    change_date as start_date,
    coalesce(
        lead(change_date, 1, null) over (
            partition by
                ban,
                subscriber_no,
                pp_soc,
                pp_soc_seq_no
            order by
                change_date,
                promo_soc_seq_no
        ),
        pp_expiration_date
    ) as end_date
    from
    chd_pp_promo
),

/*
    • Join subscriber union subscriber history to have subscriber_id
    • Joined subscriber rows are these with the same ban, subno as with expiration_date after end_date.
    • In case there are more such subscriber rows, select one row by the following way:
        ○ Sort subscriber rows in partition defined by ban, subno, end_date so that:
            § Prefer active rows with status A, C before inactive ones with status R, C
                □ In case subscriber row is closed, the pp might be one day pp which belongs to active row starting after end date.
                □ But we cannot exclude C rows, because there are cases when no active row exists in subscriber history (annulments)
            § Prefer rows with lower expiration_date
        ○ Select the very first row of the sorted partition into the result row
*/
Sfh as (
    Select
    Subscriber_id,
    Subscriber_no,
    Customer_id,
    Effective_date,
    Cast('9999-12-31 00:00:00' as timestamp) as expiration_date,
    Ctn_seq_no,
    init_activation_date,
    sub_status
    From
    base.import_fokus_base_Subscriber as subscriber
    union
    Select
    Subscriber_id,
    Subscriber_no,
    Customer_id,
    Effective_date,
    expiration_date,
    Ctn_seq_no,
    init_activation_date,
    sub_status
    From
    base.import_fokus_base_Subscriber_history as Subscriber_history
),
chd_pp_promo_sed_subid as (
    Select
    *
    From
    (
        Select
        chd_pp_promo_sed.*,
        Sfh.subscriber_id,
        (
            Row_number() over (
            Partition by
            chd_pp_promo_sed.pp_soc,
            chd_pp_promo_sed.ban,
            chd_pp_promo_sed.subscriber_no,
            chd_pp_promo_sed.Pp_soc_seq_no,
            chd_pp_promo_sed.end_date
            Order by
            /*
            Prefer not closed subscription if exists. There are the following situations:

            In service_agreement table there could be rows:
            Priceplan 1, ban x, subno y, eff ..., exp 31.12.2018. 
            Priceplan 2, ban x, subno y, eff 6.5.2019, exp 6.5.2019. 
            Priceplan 3, ban x, subno y, eff 6.5.2019, exp 31.12.4700.
            
            In subscriber union subscriber_history table there could be rows:
            Ban x, subno y, subid a, status C, eff 31.12.2018 ..., exp = 6.5.2019 ...
            Ban x, subno y, subid b, status A, eff 6.5.2019 ..., exp null
            
            If we did not prefer not closed rows, the priceplan 2 would get subid a and would be reported as churn. But Priceplan 2 is of subid b.
            */
            (
                Case
                When sfh.init_activation_date <= chd_pp_promo_sed.end_date 
                then 0
                Else 1
                End
            ) asc,
            (
                Case
                When sfh.sub_status = 'C' 
                then 1
                Else 0
                End
            ) asc,
            sfh.expiration_date asc,
            sfh.ctn_seq_no asc
            )
        ) as rnk
        from
        chd_pp_promo_sed
        left outer Join sfh on
            Sfh.customer_id = chd_pp_promo_sed.ban and
            Sfh.subscriber_no = chd_pp_promo_sed.subscriber_no and
            chd_pp_promo_sed.end_date < sfh.expiration_date
    ) as x
    Where
    Rnk = 1
),
/*
    • Join products by special logic:
        ○ Outer Join all products by pp soc, promo soc, campaing
        ○ Outer Join products with empty campaing by pp soc, promo soc
        ○ Outer Join products with empty promo soc by pp soc, campaign
        ○ Outer Join products with empty campaign, promo soc by pp soc
        ○ Outer join products by first non empty product_id from the above (in given order)
    • Product id from the last joined product listed above it the one we need
*/
subscribed_product as (
    select
    chd_pp_promo_sed_subid.*,
    p.product_id,
    p.product_code,
    p.product_desc
    FROM
    chd_pp_promo_sed_subid
    left outer join work.base_equation_product_tbt_product as p1 on
        chd_pp_promo_sed_subid.pp_soc = p1.soc and
        chd_pp_promo_sed_subid.pp_campaign = p1.campaign and
        chd_pp_promo_sed_subid.promo_soc = p1.service_soc
    left outer join work.base_equation_product_tbt_product as p2 on
        chd_pp_promo_sed_subid.pp_soc = p2.soc and
        p2.campaign is null and
        chd_pp_promo_sed_subid.promo_soc = p2.service_soc
    left outer join work.base_equation_product_tbt_product as p3 on
        chd_pp_promo_sed_subid.pp_soc = p3.soc and
        chd_pp_promo_sed_subid.pp_campaign = p3.campaign and
        p3.service_soc is null
    left outer join work.base_equation_product_tbt_product as p4 on
        chd_pp_promo_sed_subid.pp_soc = p4.soc and
        p4.campaign is null and
        p4.service_soc is null
    left outer join work.base_equation_product_tbt_product as p on
        p.product_id = coalesce(
            p1.product_id,
            p2.product_id,
            p3.product_id,
            p4.product_id
        )
)
select * from subscribed_product 
where 
--promo_soc is not null
ban = 100126492 and
subscriber_no = 'GSM04528192042'
order by subscriber_id, start_date
limit 100;


With 
/*
    ○ Get memo
    ○ Join it with sa_product on ban, subno to have memo with subscriber_id
    ○ Get subscribed_product
    ○ Join it with memo enriched of subscribed_id
    ○ Find churns as last product over partition by subscriber_id, resume date
*/

/*
    ○ Get memo
    ○ Join it with sa_product on ban, subno to have memo with subscriber_id
*/
Memo_subid as (
    Select
    *
    From
    (
        Select
        sa_product.s_subscriber_id as subscriber_id,
        Memo.memo_date as resume_date,
        (
            Row_number() over (
            Partition by
            Memo.memo_ban,
            Memo.memo_subscriber,
            Memo.memo_date
            Order by
            sa_product.effective_date desc
            )
        ) as rnk
        From
        base.import_fokus_base_Memo as memo
        Join work.base_equation_product_work_sa_product as sa_product on
            Memo.memo_ban = sa_product.ban and
            Memo.memo_subscriber = sa_product.subscriber_no and
            sa_product.effective_date < memo.memo_date
        where
            Memo.memo_type = '0008'
    )  x
    Where
    Rnk = 1
),

/*
    ○ Get subscribed_product
    ○ Join it with memo enriched of subscribed_id
*/

sa_product_memo as (
    Select
    *
    From
    (
        Select
        sa_product.*,
        Nvl(
            Memo_subid.resume_date,
            Cast('9999-12-31 00:00:00' as timestamp)
        ) as resume_date,
        (
            Row_number() over (
            Partition by
            sa_product.product_id,
            sa_product.Ban,
            sa_product.subscriber_no,
            sa_product.s_subscriber_id,
            sa_product.Effective_date,
            sa_product.Expiration_date
            Order by
            Memo_subid.resume_date asc
            )
        ) as rnk
        from
        work.base_equation_product_work_sa_product as sa_product
        Left outer join memo_subid on
            Memo_subid.subscriber_id = sa_product.s_subscriber_id and
            sa_product.effective_date < memo_subid.resume_date
    ) x
    Where
    Rnk = 1
),
/*
    ○ Find churns as last product over partition by subscriber_id, resume date
*/
Churn_kpi as (
    Select
    *
    From
    (
        Select
        Expiration_date as churn_date,
        sa_product_memo.*,
        (
            Row_number() 
            over (
                Partition by 
                s_Subscriber_id,
                Resume_date
                Order by 
                Expiration_date desc,
                promo_soc_seq_no desc,
                soc_seq_no desc
            )
        ) as churn_rnk,
        (
            min(effective_date) 
            over (
                Partition by 
                s_Subscriber_id,
                Resume_date
            )
        ) as intake_date   
        From
        sa_product_memo
    ) x
    Where
    x.churn_rnk = 1 and
    x.churn_date < now()
),
/*
    ○ Here should be the final select providing churn_kpis: 
        ○ select * from churn_kpi
    ○ Below are other queries used for testing - leaving it here for inspiration
*/

to_be as (
    Select 
    *
    from churn_kpi 
    where
    churn_date = cast('2019-05-06 00:00:00' as TIMESTAMP) and
    datediff(churn_date, intake_date) > 30
),
as_is as (
    select
    *
    from 
    analytics.prod_abt_churn_kpi
    where
    churn_date = cast('2019-05-06 00:00:00' as TIMESTAMP)
)
select
to_be.churn_date,
to_be.s_subscriber_id,
to_be.subscriber_no,
to_be.ban,
to_be.resume_date,
as_is.subscriber_id
from
to_be
left outer join as_is on 
    as_is.subscriber_id = to_be.s_subscriber_id
    /*
    as_is.subscriber_no = to_be.subscriber_no and
    as_is.customer_id = to_be.ban
    */
where
as_is.subscriber_id is null;

SELECT count(*) 
FROM raw.import_other_sources_raw_cim_address 
where kvhx is not null
LIMIT 100;

SELECT 
    at.description, account_type, account_subtype, 
    round (
        sum (case when a.kvhx is not null then 1 else 0 end) 
        / sum (1) 
        *100,
        2
    ) kvhx_not_null_perc,
    sum (case when a.kvhx is null then 1 else 0 end) kvhx_null_qty, 
    sum (case when a.kvhx is not null then 1 else 0 end) kvhx_not_null_qty, 
    sum (1) row_qty
FROM raw.import_other_sources_raw_cim_address a
join raw.import_other_sources_raw_cim_customer c
on a.party_id = c.party_id
join base.import_fokus_base_account_type at
on at.acc_type = c.account_type
and at.acc_sub_type = c.account_subtype
where status in ('O','T','S')
group by at.description, account_type, account_subtype, status
order by at.description, account_type, account_subtype, status
LIMIT 10000;

SELECT * FROM base.import_fokus_base_account_type LIMIT 100;

select *
from work.base_equation_kpis_fat_work_intake_kpi_sub_dedup
where last_dealer_code is null
limit 100;

select s_subscriber_id, ban, subscriber_no, effective_date, expiration_date, soc, soc_seq_no, *
from work.base_equation_product_work_sa_product 
where s_subscriber_id = 16468051
order by soc_seq_no, promo_soc_seq_no;

select * 
from work.base_equation_product_work_subscriber_union
where subscriber_id = 6610431;

With 
/*
    ○ Get memo
    ○ Join it with sa_product on ban, subno to have memo with subscriber_id
    ○ Get subscribed_product
    ○ Join it with memo enriched of subscribed_id
    ○ Find churns as last product over partition by subscriber_id, resume date
*/

/*
    ○ Get memo
    ○ Join it with sa_product on ban, subno to have memo with subscriber_id
*/
Memo_subid as (
    Select
    *
    From
    (
        Select
        sa_product.s_subscriber_id as subscriber_id,
        Memo.memo_date as resume_date,
        (
            Row_number() over (
            Partition by
            Memo.memo_ban,
            Memo.memo_subscriber,
            Memo.memo_date
            Order by
            sa_product.effective_date desc
            )
        ) as rnk
        From
        base.import_fokus_base_Memo as memo
        Join work.base_equation_product_work_sa_product as sa_product on
            Memo.memo_ban = sa_product.ban and
            Memo.memo_subscriber = sa_product.subscriber_no and
            sa_product.effective_date < memo.memo_date
        where
            Memo.memo_type = '0008'
    )  x
    Where
    Rnk = 1
),

/*
    ○ Get subscribed_product
    ○ Join it with memo enriched of subscribed_id
*/

sa_product_memo as (
    Select
    *
    From
    (
        Select
        sa_product.*,
        Nvl(
            Memo_subid.resume_date,
            Cast('9999-12-31 00:00:00' as timestamp)
        ) as resume_date,
        (
            Row_number() over (
            Partition by
            sa_product.product_id,
            sa_product.Ban,
            sa_product.subscriber_no,
            sa_product.s_subscriber_id,
            sa_product.Effective_date,
            sa_product.Expiration_date
            Order by
            Memo_subid.resume_date asc
            )
        ) as rnk
        from
        work.base_equation_product_work_sa_product as sa_product
        Left outer join memo_subid on
            Memo_subid.subscriber_id = sa_product.s_subscriber_id and
            sa_product.effective_date < memo_subid.resume_date
    ) x
    Where
    Rnk = 1
),
/*
    ○ Find churns as last product over partition by subscriber_id, resume date
*/
Churn_kpi as (
    Select
    *
    From
    (
        Select
        Expiration_date as churn_date,
        sa_product_memo.*,
        (
            Row_number() 
            over (
                Partition by 
                s_Subscriber_id,
                Resume_date
                Order by 
                Expiration_date desc,
                promo_soc_seq_no desc,
                soc_seq_no desc
            )
        ) as churn_rnk,
        (
            min(effective_date) 
            over (
                Partition by 
                s_Subscriber_id,
                Resume_date
            )
        ) as intake_date   
        From
        sa_product_memo
    ) x
    Where
    x.churn_rnk = 1 and
    x.churn_date < now()
),
/*
    ○ Here should be the final select providing churn_kpis: 
        ○ select * from churn_kpi
    ○ Below are other queries used for testing - leaving it here for inspiration
*/

to_be as (
    Select 
    *
    from churn_kpi 
    where
    churn_date = cast('2019-05-06 00:00:00' as TIMESTAMP) and
    datediff(churn_date, intake_date) > 30
),
as_is as (
    select
    *
    from 
    analytics.prod_abt_churn_kpi
    where
    churn_date = cast('2019-05-06 00:00:00' as TIMESTAMP)
)
select
to_be.churn_date,
to_be.s_subscriber_id,
to_be.subscriber_no,
to_be.ban,
to_be.resume_date,
as_is.subscriber_id
from
to_be
right outer join as_is on 
    as_is.subscriber_id = to_be.s_subscriber_id
    /*
    as_is.subscriber_no = to_be.subscriber_no and
    as_is.customer_id = to_be.ban
    */
where
to_be.s_subscriber_id is null;

set REQUEST_POOL=big;


With 
/*
    ○ Get memo
    ○ Join it with sa_product on ban, subno to have memo with subscriber_id
    ○ Get subscribed_product
    ○ Join it with memo enriched of subscribed_id
    ○ Find churns as last product over partition by subscriber_id, resume date
*/

/*
    ○ Get memo
    ○ Join it with sa_product on ban, subno to have memo with subscriber_id
*/
Memo_subid as (
    Select
    *
    From
    (
        Select
        sa_product.s_subscriber_id as subscriber_id,
        Memo.memo_date as resume_date,
        (
            Row_number() over (
            Partition by Memo.memo_ban, Memo.memo_subscriber, Memo.memo_date
            Order by soc_seq_no, promo_soc_seq_no
            )
        ) as rnk
        From
        base.import_fokus_base_Memo as memo
        Join work.base_equation_product_work_sa_product as sa_product 
            on Memo.memo_ban = sa_product.ban 
            and Memo.memo_subscriber = sa_product.subscriber_no
            and Memo.memo_type = '0008'
            and (
                memo.memo_date < sa_product.expiration_date
                or memo.memo_date = sa_product.expiration_date
                and sa_product.expiration_date = sa_product.effective_date
            )
    )  x
    Where
    Rnk = 1
),

/*
    ○ Get subscribed_product
    ○ Join it with memo enriched of subscribed_id
*/

sa_product_memo as (
    Select
    *
    From
    (
        Select
        sa_product.*,
        Nvl(
            Memo_subid.resume_date,
            Cast('1900-01-01 00:00:00' as timestamp)
        ) as resume_date,
        (
            Row_number() over (
            Partition by soc, soc_seq_no, soc_ver_no, promo_soc, promo_soc_seq_no, promo_soc_ver_no
            Order by Memo_subid.resume_date desc
            )
        ) as rnk
        from
        work.base_equation_product_work_sa_product as sa_product
        Left outer join memo_subid 
            on Memo_subid.subscriber_id = sa_product.s_subscriber_id
            and (
                sa_product.expiration_date > memo_subid.resume_date
                or sa_product.expiration_date = memo_subid.resume_date
                and sa_product.expiration_date = sa_product.effective_date
            )
    ) x
    Where
    Rnk = 1
),
/*
    ○ Find churns as last product over partition by subscriber_id, resume date
*/
Churn_kpi as (
    Select
    *
    From
    (
        Select
        Expiration_date as churn_date,
        sa_product_memo.*,
        (
            Row_number() 
            over (
                Partition by 
                s_Subscriber_id,
                Resume_date
                Order by 
                Expiration_date desc,
                promo_soc_seq_no desc,
                soc_seq_no desc
            )
        ) as churn_rnk,
        (
            min(effective_date) 
            over (
                Partition by 
                s_Subscriber_id,
                Resume_date
            )
        ) as intake_date   
        From
        sa_product_memo
    ) x
    Where
    x.churn_rnk = 1 and
    x.churn_date < now()
),
/*
    ○ Here should be the final select providing churn_kpis: 
        ○ select * from churn_kpi
    ○ Below are other queries used for testing - leaving it here for inspiration
*/

to_be as (
    Select 
    *
    from churn_kpi 
    where
    churn_date = cast('2019-05-06 00:00:00' as TIMESTAMP) and
    datediff(churn_date, intake_date) >= 30
),
as_is as (
    select
    *
    from 
    analytics.prod_abt_churn_kpi
    where
    churn_date = cast('2019-05-06 00:00:00' as TIMESTAMP)
)
select
to_be.churn_date,
to_be.s_subscriber_id,
as_is.churn_date,
as_is.subscriber_id
from to_be
full outer join as_is 
    on as_is.subscriber_id = to_be.s_subscriber_id
where as_is.subscriber_id is null
    or to_be.s_subscriber_id is null;

/*
select *
from sa_product_memo
where s_subscriber_id in (15346018, 15308477, 15939196, 12470398)
order by s_subscriber_id, effective_date, expiration_date

select *
from memo_subid
where subscriber_id in (15346018, 15308477, 15939196, 12470398)


select *
from base.import_fokus_base_memo memo
where memo_type = '0008'
and memo_subscriber = 'GSM04527845402'
and memo_ban = 915469118
*/

With 
/*
    ○ Get memo
    ○ Join it with sa_product on ban, subno to have memo with subscriber_id
    ○ Get subscribed_product
    ○ Join it with memo enriched of subscribed_id
    ○ Find churns as last product over partition by subscriber_id, resume date
*/

/*
    ○ Get memo
    ○ Join it with sa_product on ban, subno to have memo with subscriber_id
*/
Memo_subid as (
    Select *
    From (
        Select sa_product.s_subscriber_id as subscriber_id, Memo.resume_date,
            Row_number() over (
                Partition by Memo.memo_ban, Memo.memo_subscriber, Memo.resume_date
                Order by soc_seq_no desc, promo_soc_seq_no desc
            ) as rnk
        From work.base_equation_kpis_work_resume_prepared as memo
        Join work.base_equation_product_work_sa_product as sa_product 
            on Memo.memo_ban = sa_product.ban 
            and Memo.memo_subscriber = sa_product.subscriber_no 
            and sa_product.effective_date < memo.resume_date
    )  x
    Where Rnk = 1
),

/*
    ○ Get subscribed_product
    ○ Join it with memo enriched of subscribed_id
*/

sa_product_memo as (
    Select *
    From (
        Select sa_product.*,
            Nvl(
                Memo_subid.resume_date,
                Cast('9999-12-31 00:00:00' as timestamp)
            ) as resume_date,
            Row_number() over (
                Partition by sa_product.soc, sa_product.soc_seq_no, sa_product.soc_ver_no,
                    sa_product.promo_soc, sa_product.promo_soc_seq_no, sa_product.promo_soc_ver_no
                Order by Memo_subid.resume_date asc
            ) as rnk
        from work.base_equation_product_work_sa_product as sa_product
        Left outer join memo_subid 
            on Memo_subid.subscriber_id = sa_product.s_subscriber_id 
            and sa_product.effective_date < memo_subid.resume_date
    ) x
    Where Rnk = 1
),
/*
    ○ Find churns as last product over partition by subscriber_id, resume date
*/
Churn_kpi as (
    Select *
    From (
        Select Expiration_date as churn_date, sa_product_memo.*,
            Row_number() over (
                Partition by s_Subscriber_id, Resume_date
                Order by Expiration_date desc, soc_seq_no desc, promo_soc_seq_no desc
            ) as churn_rnk,
            min(effective_date) over (
                Partition by s_Subscriber_id, Resume_date
            ) as intake_date   
        From sa_product_memo
    ) x
    Where x.churn_rnk = 1 
        and x.churn_date < now()
),
/*
    ○ Here should be the final select providing churn_kpis: 
        ○ select * from churn_kpi
    ○ Below are other queries used for testing - leaving it here for inspiration
*/

to_be as (
    Select *
    from churn_kpi 
    where churn_date = cast('2019-05-06 00:00:00' as TIMESTAMP) 
        and datediff(churn_date, intake_date) >= 30
),
as_is as (
    select *
    from  analytics.prod_abt_churn_kpi
    where churn_date = cast('2019-05-06 00:00:00' as TIMESTAMP)
)
select to_be.s_subscriber_id as to_be, as_is.subscriber_id as as_is
from to_be
full outer join as_is 
    on as_is.subscriber_id = to_be.s_subscriber_id
where as_is.subscriber_id is null
    or to_be.s_subscriber_id is null;

with
subid_change as (
select s_subscriber_id as subscriber_id, subscriber_no, ban, effective_date as change_date
from work.base_equation_product_work_sa_product
union select s_subscriber_id as subscriber_id, subscriber_no, ban, expiration_date as change_date
from work.base_equation_product_work_sa_product

union select subscriber_id, subscriber_no, customer_id as ban, effective_date as change_date
from work.base_equation_product_work_subscriber_union
union select subscriber_id, subscriber_no, customer_id as ban, 
    nvl(expiration_date + interval 1 second, cast('9999-12-31 00:00:00' as timestamp)) as change_date
from work.base_equation_product_work_subscriber_union
),

subno_change as (
select subscriber_no, customer_id as ban, effective_date as change_date
from base.import_fokus_base_physical_device
where device_type in ('E','H')
union select subscriber_no, customer_id as ban, expiration_date as change_date
from base.import_fokus_base_physical_device
where device_type in ('E','H')

union select subscriber_no, customer_id as ban, effective_date as change_date
from base.import_fokus_base_address_name_link
where link_type in ('U')
union select subscriber_no, customer_id as ban, expiration_date as change_date
from base.import_fokus_base_address_name_link
where link_type in ('U')
),

subscriber_change as (
select y.*,
    case when start_date = end_date then 'N' else 'Y' end as last_row_in_start_date
from (
select x.*, x.ban as customer_id, change_date as start_date, 
    coalesce (
        lead(change_date, 1) over (
            partition by subscriber_id
            order by change_date asc, soc_seq_no, promo_soc_seq_no
        ),
        x.expiration_date
    ) as end_date,
    row_number() over (
        partition by subscriber_id, change_date
        order by soc_seq_no, promo_soc_seq_no
    ) as start_date_rank
from (
select sa_product.s_subscriber_id as subscriber_id, sa_product.ban, sa_product.subscriber_no, 
    change_date, sa_product.effective_date, sa_product.expiration_date,
    sa_product.soc, sa_product.soc_seq_no, sa_product.soc_ver_no,
    sa_product.promo_soc, sa_product.promo_soc_seq_no, sa_product.promo_soc_ver_no
from subid_change
join work.base_equation_product_work_sa_product sa_product
on subid_change.subscriber_id = sa_product.s_subscriber_id
and subid_change.ban = sa_product.ban
and subid_change.subscriber_no = sa_product.subscriber_no
and sa_product.effective_date <= subid_change.change_date
and (
    subid_change.change_date < sa_product.expiration_date
    or subid_change.change_date = sa_product.expiration_date
    and sa_product.expiration_date = sa_product.effective_date
)

union select sa_product.s_subscriber_id as subscriber_id, sa_product.ban, sa_product.subscriber_no, 
    change_date, sa_product.effective_date, sa_product.expiration_date,
    sa_product.soc, sa_product.soc_seq_no, sa_product.soc_ver_no,
    sa_product.promo_soc, sa_product.promo_soc_seq_no, sa_product.promo_soc_ver_no
from subno_change
join work.base_equation_product_work_sa_product sa_product
on subno_change.ban = sa_product.ban
and subno_change.subscriber_no = sa_product.subscriber_no
and sa_product.effective_date <= subno_change.change_date
and (
    subno_change.change_date < sa_product.expiration_date
    or subno_change.change_date = sa_product.expiration_date
    and sa_product.expiration_date = sa_product.effective_date
)
) x
) y
),

subscriber_history as (
select *
from (
select sc.subscriber_id, sc.ban, sc.subscriber_no, 
    sc.start_date, sc.start_date_rank, sc.last_row_in_start_date, sc.end_date,
    sa_product.product_desc, sa_product.soc_seq_no, sa_product.promo_soc_seq_no,
    subscriber_union.sub_status, subscriber_union.sub_status_date, 
    subscriber_union.ctn_seq_no, subscriber_union.dealer_code, 
    sim.phd_seq_no sim,
    imei.phd_seq_no imei,
    
    row_number() over (
        partition by sc.subscriber_id, sc.change_date, 
            sc.soc_seq_no, sc.promo_soc_seq_no,
            sc.soc, sc.promo_soc,
            sc.soc_ver_no, sc.promo_soc_ver_no
        order by 
            case when subscriber_union.sub_status = 'C' then 1 else 0 end, subscriber_union.ctn_seq_no asc,
            sim.effective_date desc, sim.phd_seq_no desc,
            imei.effective_date desc, imei.phd_seq_no desc
    ) as rnk

from subscriber_change sc
join work.base_equation_product_work_sa_product sa_product
    on sc.subscriber_id = sa_product.s_subscriber_id
    and sc.ban = sa_product.ban
    and sc.subscriber_no = sa_product.subscriber_no
    and sc.soc = sa_product.soc
    and sc.soc_seq_no = sa_product.soc_seq_no
    and sc.soc_ver_no = sa_product.soc_ver_no
    and nvl(sc.promo_soc,'') = nvl(sa_product.promo_soc,'')
    and nvl(sc.promo_soc_seq_no,-1) = nvl(sa_product.promo_soc_seq_no,-1)
    and nvl(sc.promo_soc_ver_no,-1) = nvl(sa_product.promo_soc_ver_no,-1)
left outer join work.base_equation_product_work_subscriber_union subscriber_union
    on sc.subscriber_id = subscriber_union.subscriber_id
    and sc.customer_id = subscriber_union.customer_id
    and sc.subscriber_no = subscriber_union.subscriber_no
    and subscriber_union.effective_date <= change_date
    and change_date < nvl(subscriber_union.expiration_date + interval 1 second, cast('9999-12-31 00:00:00' as timestamp)) 
left outer join base.import_fokus_base_physical_device as sim
    on sc.ban = sim.ban
    and sc.subscriber_no = sim.subscriber_no
    and sim.effective_date <= change_date
    and change_date < sim.expiration_date 
    and sim.device_type in ('E')
    and sim.equipment_level = 1
left outer join base.import_fokus_base_physical_device as imei
    on sc.ban = imei.ban
    and sc.subscriber_no = imei.subscriber_no
    and imei.effective_date <= change_date
    and change_date < imei.expiration_date 
    and imei.device_type in ('H')

) x
where rnk = 1
)

select * from subscriber_history 
where subscriber_id = 14303577
    and last_row_in_start_date = 'Y'
order by start_date, start_date_rank
limit 100;


select subscriber_id, customer_id, subscriber_no, sub_status, sub_status_date, effective_date, expiration_date, *
from work.base_equation_product_work_subscriber_union subscriber_union
where subscriber_id = 16361218
order by effective_date;

select *
from work.base_equation_product_work_sa_product sa_product
where s_subscriber_id = 16361218
order by soc_seq_no, promo_soc_seq_no;

select *
from base.import_fokus_base_physical_device
where subscriber_no = 'GSM04540346801' and ban = 505740019
order by effective_date;

set REQUEST_POOL=big;

select ban, ordered_subscriber_no, ordered_price_plan, created_timestamp
from bpm_b2c_data_work_b2c_subscriptions_last_product_dedup 
where order_line_status = 'Order Completed' 
and first_product_soc_seq_no is null
Limit 100;

select *
from work.base_equation_product_work_sa_product
where 1=1
and subscriber_no like '%3030959%'
--and soc = 'CMFRIEU02'
;

select *
from base.import_fokus_base_subscriber
where 9=9
--and customer_id = 488150210
and subscriber_no like '%309593'
;

with
operator_desc as (
select *
from (
select np_operator_cd, operator_desc,
    row_number() over (
        partition by np_operator_cd
        order by effective_date desc
    ) as rnk
from base.import_fokus_base_np_operator_codes
) x
where rnk = 1
),

np as (
select subscriber_id, port_number, 
    curr_serv_oper, 
    cso.operator_desc as cso_desc,
    recip_serv_operator, 
    rso.operator_desc as rso_desc,
    curr_net_oper, 
    cno.operator_desc as cno_desc,
    recip_net_oper, 
    rno.operator_desc as rno_desc
from (
select subscriber_id, port_number, 
    donor_service_operator as curr_serv_oper, 
    rec_service_operator recip_serv_operator, 
    donor_net_operator curr_net_oper, 
    rec_net_operator recip_net_oper,
    sys_creation_date
from work.base_equation_kpis_fat_work_np_joined_windows
) x
left outer join operator_desc as cso
    on x.curr_serv_oper = cso.np_operator_cd
left outer join operator_desc as rso
    on x.recip_serv_operator = rso.np_operator_cd
left outer join operator_desc as cno
    on x.curr_net_oper = cno.np_operator_cd
left outer join operator_desc as rno
    on x.recip_net_oper = rno.np_operator_cd
),

kpi_np as (
select kpi.subscriber_id, kpi.intake_date, cso_desc, rso_desc, cno_desc, rno_desc
from work.base_equation_kpis_tbt_intake_kpi as kpi
left outer join np
    on np.subscriber_id = kpi.subscriber_id
where np.subscriber_id is not null
)
/*
select rno_desc, count(distinct subscriber_id)
from kpi_np
group by rno_desc
limit 100
*/
/*
select cno_desc, count(distinct subscriber_id)
from kpi_np
group by cno_desc
limit 100
*/
select rec_net_operator, operator_desc, sum(cnt)
from (
select 
    case when cnt > 100 then rec_net_operator else 'Others' end as rec_net_operator,
    case when cnt > 100 then operator_desc else 'Others' end as operator_desc,
    cnt
from (
select np.rec_net_operator, rno.operator_desc, count(distinct kpi.subscriber_id) cnt
from work.base_equation_kpis_tbt_intake_kpi as kpi
join work.base_equation_kpis_fat_work_np_joined_windows as np
    on np.subscriber_id = kpi.subscriber_id
left outer join operator_desc as rno
    on rec_net_operator = rno.np_operator_cd
group by np.rec_net_operator, rno.operator_desc
) x
) y
group by rec_net_operator, operator_desc
limit 100
;
select *
from analytics.abt_number_porting 
where port_ind is null
order by effective_date;

select count(*)
from analytics.prod_abt_number_porting 
where port_ind is null;

select count(*)
from base.import_fokus_base_np_number_info
where port_ind is null
    --and number_type <> 'A'
    --and effective_date >= cast('2018-01-01 00:00:00' as timestamp)
;
    
select count(*)
from adhoc_reporting_work_np_joined
where port_ind is null;


select count (*)
from (
SELECT 
    `base_np_number_info`.`port_number` AS `port_number`,
    `base_np_number_info`.`effective_date` AS `effective_date`,
    `base_np_number_info`.`sys_creation_date` AS `sys_creation_date`,
    `base_np_number_info`.`int_order_id` AS `int_order_id`,
    `base_np_number_info`.`port_ind` AS `port_ind`,
    `base_np_number_info`.`number_type` AS `number_type`,
    `base_np_number_info`.`org_operator` AS `org_operator`,
    `base_np_number_info`.`subscriber_id` AS `subscriber_id`,
    `base_np_number_info`.`last_int_ord_id` AS `last_int_ord_id`,
    `base_np_order_data`.`application_id` AS `application_id`,
    `base_np_order_data`.`order_status` AS `order_status`,
    `base_np_order_data`.`last_sts_date` AS `last_sts_date`,
    `base_np_trx_detail`.`int_trx_seq` AS `int_trx_seq`,
    `base_np_trx_detail`.`ext_order_id` AS `och`,
    `base_np_trx_detail`.`number_type` AS `n_type`,
    `base_np_trx_detail`.`request_exec_date` AS `request_date`,
    `base_np_trx_detail`.`conf_exec_date` AS `confirm_date`,
    `base_np_trx_detail`.`curr_serv_oper` AS `donor_service_operator`,
    `base_np_trx_detail`.`recip_serv_oper` AS `rec_service_operator`,
    `base_np_trx_detail`.`curr_net_oper` AS `donor_net_operator`,
    `base_np_trx_detail`.`recip_net_oper` AS `rec_net_operator`,
    `base_np_trx_detail`.`icc` AS `icc`
  FROM (
    SELECT `base_np_number_info`.*
      FROM base.import_fokus_base_np_number_info `base_np_number_info`
      WHERE `effective_date` >= CAST(concat('2018-01-01 00:00:00', '+00') AS TIMESTAMP) 
      and `number_type` != 'A'
      -- AND (`number_type` != 'A' OR `number_type` IS NULL AND 'A' IS NOT NULL OR `number_type` IS NOT NULL AND 'A' IS NULL)
    ) `base_np_number_info`
  INNER JOIN base.import_fokus_base_np_order_data `base_np_order_data`
    ON `base_np_number_info`.`int_order_id` = `base_np_order_data`.`int_order_id`
  INNER JOIN base.import_fokus_base_np_trx_detail `base_np_trx_detail`
    ON `base_np_number_info`.`int_order_id` = `base_np_trx_detail`.`int_order_id`
) x
where port_ind is null;


select count(*) from (
select a.subscriber_id as churn_subscriber_id,
    b.subscriber_id as abt_subscriber_id,
    a.churn_date as churn_churn_date,
    b.churn_date as abt_churn_date
from analytics.prod_abt_churn_kpi a
left outer join (
    select *
    from analytics.prod_abt_subscriber_history
    where churn_date is not null
) b
    on a.subscriber_id = b.subscriber_id
    and a.churn_date = b.churn_date
where a.subscriber_id is null 
    or b.subscriber_id is null
) x
;

select * from (
select a.subscriber_id as churn_subscriber_id,
    b.subscriber_id as abt_subscriber_id,
    a.churn_date as churn_churn_date,
    b.churn_date as abt_churn_date
from analytics.prod_abt_churn_kpi a
left outer join (
    select *
    from analytics.prod_abt_subscriber_history
    where churn_date is not null
) b
    on a.subscriber_id = b.subscriber_id
    and a.churn_date = b.churn_date
where a.subscriber_id is null 
    or b.subscriber_id is null
) x
;

select churn_date, * from analytics.prod_abt_subscriber_history where subscriber_id = 7659101;

select churn_date, * from analytics.prod_abt_churn_kpi where subscriber_id = 7659101;

select effective_date, expiration_date, * from work.base_equation_product_work_sa_product where s_subscriber_id = 7659101; 

select effective_date, expiration_date, subscriber_id, sub_status, sub_status_date, ctn_seq_no, *
from work.base_equation_product_work_subscriber_union
where subscriber_id = 7659101
order by effective_date, expiration_date, ctn_seq_no;

select product_desc, * 
from analytics.prod_abt_gruppetrafik 
where subscriber_no = 'GSM04560111131' 
and cycle_run_year = 2019 
and cycle_run_month = 8 
and country_code='ITA';

select *
from analytics.prod_abt_product
where soc = 'CORFRI';

select *
from analytics.prod_abt_product
where product_desc in ('Corporate Fri tale EU', 'Mobiz Flatrate 1000 Norden');

select effective_date, expiration_date, * from work.base_equation_product_work_sa_product 
where subscriber_no = 'GSM04560111131'; 

select effective_date, expiration_date, * from base.import_fokus_base_service_agreement 
where subscriber_no = 'GSM04560111131'
    and service_type in ('P','M','N')
order by soc_seq_no; 

select *
from work.base_equation_other_tbt_subscriber_imei_history 
where msisdn = '28107330';

select * 
from analytics.abt_subscriber_history
where subscriber_id = 2263;

SELECT 
    tbt_subscriber_imei_history.start_date AS start_date,
    tbt_subscriber_imei_history.tac AS tac,
    tbt_subscriber_imei_history.prev_tac AS prev_tac,
    tbt_subscriber_imei_history.msisdn AS msisdn,
    tbt_subscriber_imei_history.imei14 AS imei14,
    tbt_subscriber_imei_history.prev_imei14 AS prev_imei14,
    tbt_subscriber_imei_history.end_date AS end_date,
    tbt_subscriber_imei_history.active_record_flag AS active_record_flag,
    tbt_subscriber_imei_history.subscriber_id AS subscriber_id,
    tbt_subscriber_imei_history.source AS source,
    abt_subscriber_history.subscriber_no AS subscriber_no,
    abt_subscriber_history.customer_id AS customer_id
  FROM (
    SELECT 
        customer_id AS customer_id,
        subscriber_no AS subscriber_no,
        start_date AS start_date,
        tac AS tac,
        prev_tac AS prev_tac,
        msisdn AS msisdn,
        imei14 AS imei14,
        prev_imei14 AS prev_imei14,
        end_date AS end_date,
        active_record_flag AS active_record_flag,
        subscriber_id AS subscriber_id,
        source AS source
        --least(now(),date_trunc(end_date,'dd')) AS lowest_date
      FROM (
        SELECT *
          FROM work.base_equation_other_tbt_subscriber_imei_history tbt_subscriber_imei_history
        ) withoutcomputedcols_query
    ) tbt_subscriber_imei_history
  LEFT JOIN analytics.abt_subscriber_history
    ON (tbt_subscriber_imei_history.start_date >= abt_subscriber_history.start_date)
   -- ON (trunc(tbt_subscriber_imei_history.start_date,'dd') >= abt_subscriber_history.start_date)
      AND (tbt_subscriber_imei_history.subscriber_id = abt_subscriber_history.subscriber_id)
    AND (tbt_subscriber_imei_history.start_date < abt_subscriber_history.end_date)
    --  AND (trunc(tbt_subscriber_imei_history.start_date,'dd') <= abt_subscriber_history.end_date)
  LEFT JOIN base.import_other_sources_base_tac base_tac
    ON tbt_subscriber_imei_history.tac = base_tac.tac
  LEFT JOIN base.import_other_sources_base_tac base_tac_2
    ON tbt_subscriber_imei_history.prev_tac = base_tac_2.tac
    where tbt_subscriber_imei_history.msisdn='28107330';


SELECT * FROM base.import_consent_db_base_consents LIMIT 100; 
SELECT * FROM base.import_consent_db_base_channels LIMIT 100; 
SELECT * FROM base.import_consent_db_base_brands LIMIT 100; 
SELECT * FROM base.import_consent_db_base_events LIMIT 100; 
SELECT * FROM base.import_consent_db_base_reference_types LIMIT 100;
SELECT * FROM base.import_consent_db_base_systems LIMIT 100; 
SELECT * FROM base.import_consent_db_base_consent_channels LIMIT 100; 
SELECT * FROM base.import_consent_db_base_consent_purposes LIMIT 100; 
SELECT * FROM base.import_consent_db_base_customer_consents LIMIT 100; 
SELECT * FROM base.import_consent_db_base_customer_entities LIMIT 100; 
SELECT * FROM base.import_consent_db_base_customer_consent_states LIMIT 100;
SELECT * FROM base.import_consent_db_base_customer_consents LIMIT 100; 
SELECT * FROM base.import_consent_db_base_customer_consent_channels LIMIT 100; 
SELECT * FROM base.import_consent_db_base_events order by customer_consent_id LIMIT 100; 
SELECT * FROM base.import_consent_db_base_sales_agents LIMIT 100; 
SELECT * FROM base.import_consent_db_base_events LIMIT 100;
SELECT * FROM base.import_consent_db_base_consent_reference_types LIMIT 100;