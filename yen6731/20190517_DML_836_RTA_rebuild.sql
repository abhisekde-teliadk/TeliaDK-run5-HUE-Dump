select distinct reporting_month from analytics.abt_international_roaming order by reporting_month asc;

select distinct reporting_month from analytics.prod_abt_international_roaming order by reporting_month asc;

select distinct event_month from work.base_equation_other_tbt_traffic order by event_month asc;

select count(*) from work.base_equation_other_tbt_traffic where event_month='201801'; -- 147449147
select count(*) from work.base_equation_other_tbt_traffic where event_month='201807'; -- 146335379
select count(*) from work.base_equation_other_tbt_traffic where event_month='201810'; -- 144947374
select count(*) from work.base_equation_other_tbt_traffic where event_month='201904'; -- 143114308

select count(*) from analytics.abt_international_roaming where reporting_month='201801'; -- 1676
select count(*) from analytics.abt_international_roaming where reporting_month='201810'; -- 1601
select count(*) from analytics.abt_international_roaming where reporting_month='201811'; -- 1548
select count(*) from analytics.prod_abt_international_roaming where reporting_month='201812'; --855
select count(*) from analytics.abt_international_roaming where reporting_month='201901'; --1614
select count(*) from analytics.abt_international_roaming where reporting_month='201904'; --1597



select * from analytics.Abt_subscriptions_per_region;

select distinct reporting_month from work.reporting_to_authorities_work_traffic_subscriber order by reporting_month asc;
Abt_subscriptions_per_region_for_last_3_months;

SELECT 
    finance_call_direction AS finance_call_direction,
    soc_out AS soc,
    promotion_soc AS promotion_soc,
    soc AS traffic_soc,
    call_description AS call_description,
    product_group AS product_group,
    product_desc AS product_desc,
    product_line AS product_line,
    reporting_month AS reporting_month,
    voice_min_sum AS voice_min,
    voice_calls_sum AS voice_calls,
    call_attempts_sum AS call_attempts,
    sms_sum AS sms,
    mms_sum AS mms,
    data_mb_sum AS data_mb,
    premium_sms_sum AS premium_sms,
    premium_mms_sum AS premium_mms,
    data_min_sum AS data_min,
    fax_min_sum AS fax_min,
    high_speed_data_min_sum AS high_speed_data_min,
    other_events_sum AS other_events
  FROM (
    SELECT 
        finance_call_direction AS finance_call_direction,
        soc_out AS soc_out,
        promotion_soc AS promotion_soc,
        soc AS soc,
        call_description AS call_description,
        product_group AS product_group,
        product_desc AS product_desc,
        product_line AS product_line,
        reporting_month AS reporting_month,
        SUM(voice_min) AS voice_min_sum,
        SUM(voice_calls) AS voice_calls_sum,
        SUM(call_attempts) AS call_attempts_sum,
        SUM(sms) AS sms_sum,
        SUM(mms) AS mms_sum,
        SUM(data_mb) AS data_mb_sum,
        SUM(premium_sms) AS premium_sms_sum,
        SUM(premium_mms) AS premium_mms_sum,
        SUM(data_min) AS data_min_sum,
        SUM(fax_min) AS fax_min_sum,
        SUM(high_speed_data_min) AS high_speed_data_min_sum,
        SUM(other_events) AS other_events_sum
      FROM (
        SELECT 
            event_date AS event_date,
            event_month AS event_month,
            volume AS volume,
            price AS price,
            event_count AS event_count,
            subscriber_no AS subscriber_no,
            customer_id AS customer_id,
            other_party_operator_id AS other_party_operator_id,
            other_party_country_id AS other_party_country_id,
            roaming_operator_id AS roaming_operator_id,
            roaming_country_id AS roaming_country_id,
            peak_id AS peak_id,
            network_id AS network_id,
            traffic_type_id AS traffic_type_id,
            call_direction_id AS call_direction_id,
            feature_dest_code AS feature_dest_code,
            service_calc AS service_calc,
            product_id AS product_id,
            tac AS tac,
            cell_first_id AS cell_first_id,
            call_type_id AS call_type_id,
            call_description AS call_description,
            ip_volume AS ip_volume,
            du_at_feature_code AS du_at_feature_code,
            call_type AS call_type,
            call_characteristic_cd AS call_characteristic_cd,
            product_type AS product_type,
            call_attempt_ind AS call_attempt_ind,
            soc AS soc,
            promotion_soc AS promotion_soc,
            brand AS brand,
            product_line AS product_line,
            product_desc AS product_desc,
            product_group AS product_group,
            id AS id,
            name AS name,
            code AS code,
            language AS language,
            dial_out_code AS dial_out_code,
            region AS region,
            continent AS continent,
            eea AS eea,
            zone AS zone,
            roaming_region AS roaming_region,
            rlh_europe AS rlh_europe,
            roaming_operator_code AS roaming_operator_code,
            roaming_operator_name AS roaming_operator_name,
            roaming_operator_country_code AS roaming_operator_country_code,
            roaming_country_roaming_region AS roaming_country_roaming_region,
            coalesce(promotion_soc,soc) AS soc_out,
            trunc(current_timestamp(),'MM') AS reporting_month,
            case when call_direction_id = '2' then 'Incoming' else 'Outgoing' end AS finance_call_direction,
            case when nvl(call_attempt_ind, false) = false and traffic_type_id = '1' then volume/60 else 0 end AS voice_min,
            case when nvl(call_attempt_ind, false) = false and traffic_type_id = '1' then event_count else 0 end AS voice_calls,
            case when nvl(call_attempt_ind, false) = true or traffic_type_id = '8' then event_count else 0 end AS call_attempts,
            case when nvl(call_attempt_ind, false) = false and traffic_type_id = '2' then event_count else 0 end AS sms,
            case when nvl(call_attempt_ind, false) = false and traffic_type_id = '4' then event_count else 0 end AS mms,
            case when nvl(call_attempt_ind, false) = false and traffic_type_id = '5' then Volume / 1048576  else 0 end AS data_mb,
            case when nvl(call_attempt_ind, false) = false and traffic_type_id = '3' then event_count else 0 end AS premium_sms,
            case when nvl(call_attempt_ind, false) = false and traffic_type_id = '6' then event_count else 0 end AS premium_mms,
            case when nvl(call_attempt_ind, false) = false and traffic_type_id = '10' then volume/60 else 0 end AS data_min,
            case when nvl(call_attempt_ind, false) = false and traffic_type_id = '9' then volume/60 else 0 end AS fax_min,
            case when nvl(call_attempt_ind, false) = false and traffic_type_id = '11' then volume/60 else 0 end AS high_speed_data_min,
            case when nvl(call_attempt_ind, false) = false and traffic_type_id not in ('1', '2', '3', '4', '5', '6', '8', '9', '10', '11') then event_count else 0 end AS other_events
          FROM (
            SELECT 
                event_date,
                event_month,
                volume,
                price,
                event_count,
                subscriber_no,
                customer_id,
                other_party_operator_id,
                other_party_country_id,
                roaming_operator_id,
                roaming_country_id,
                peak_id,
                network_id,
                traffic_type_id,
                call_direction_id,
                feature_dest_code,
                service_calc,
                product_id,
                tac,
                cell_first_id,
                call_type_id,
                call_description,
                ip_volume,
                du_at_feature_code,
                call_type,
                call_characteristic_cd,
                product_type,
                call_attempt_ind,
                soc,
                promotion_soc,
                brand,
                product_line,
                product_desc,
                product_group,
                id,
                name,
                code,
                language,
                dial_out_code,
                region,
                continent,
                eea,
                zone,
                roaming_region,
                rlh_europe,
                roaming_operator_code,
                roaming_operator_name,
                roaming_operator_country_code,
                roaming_country_roaming_region
              FROM work.base_equation_other_tbt_traffic
              WHERE event_month >= from_timestamp(now(), 'yyyy')
            ) withoutcomputedcols_query
        ) dku__beforegrouping
      GROUP BY finance_call_direction, soc_out, promotion_soc, soc, call_description, product_group, product_desc, product_line, reporting_month
    ) pristine_query