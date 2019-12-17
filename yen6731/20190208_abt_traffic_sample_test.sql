SELECT 
    finance_call_direction AS finance_call_direction,
    soc_out AS soc,
    --promotion_soc AS promotion,
    soc AS product_soc,
    call_description AS call_description,
    --product_group AS product_group,
    --product_desc AS product_desc,
    --product_line AS product_line,
    reporting_month AS reporting_month,
    voice_min_sum AS voice_min,
    voice_calls_sum AS voice_calls,
    call_attempts_sum AS call_attempts,
    sms_sum AS sms,
    --mms_sum AS mms,
    --data_mb_sum AS data_mb,
    --premium_sms_sum AS premium_sms,
    --premium_mms_sum AS premium_mms,
    --data_min_sum AS data_min,
    --fax_min_sum AS fax_min,
    --high_speed_data_min_sum AS high_speed_data_min,
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
            product_line AS product_line,
            product_desc AS product_desc,
            product_group AS product_group,
            operator_name AS operator_name,
            coalesce(promotion_soc,soc) AS soc_out,
            --trunc(current_date(),'MM')
trunc(to_utc_timestamp(event_date, 'PST'), 'MM') AS reporting_month,
            case when call_direction_id = '2' then 'Incoming' else 'Outgoing' end AS finance_call_direction,
            case when nvl(call_attempt_ind, False) = False and traffic_type_id = '1' then volume/60 else 0 end AS voice_min,
            case when nvl(call_attempt_ind, False) = False and traffic_type_id = '1' then event_count else 0 end AS voice_calls,
            case when nvl(call_attempt_ind, False) <> False or traffic_type_id = '8' then event_count else 0 end AS call_attempts,
            case when nvl(call_attempt_ind, False) = False and traffic_type_id = '2' then event_count else 0 end AS sms,
            case when nvl(call_attempt_ind, False) = False and traffic_type_id = '4' then event_count else 0 end AS mms,
            case when nvl(call_attempt_ind, False) = False and traffic_type_id = '5' then Volume / 1048576  else 0 end AS data_mb,
            case when nvl(call_attempt_ind, False) = False and traffic_type_id = '3' then event_count else 0 end AS premium_sms,
            case when nvl(call_attempt_ind, False) = False and traffic_type_id = '6' then event_count else 0 end AS premium_mms,
            case when nvl(call_attempt_ind, False) = False and traffic_type_id = '10' then volume/60 else 0 end AS data_min,
            case when nvl(call_attempt_ind, False) = False and traffic_type_id = '9' then volume/60 else 0 end AS fax_min,
            case when nvl(call_attempt_ind, False) = False and traffic_type_id = '11' then volume/60 else 0 end AS high_speed_data_min,
            case when nvl(call_attempt_ind, False) = False and traffic_type_id not in ('1', '2', '3', '4', '5', '6', '8', '9', '10', '11') then event_count else 0 end AS other_events
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
                product_line,
                product_desc,
                product_group,
                operator_name
              FROM analytics.abt_traffic
              WHERE event_month = '201801' and soc='SIMPLEBTB'
            ) withoutcomputedcols_query
        ) dku__beforegrouping
      GROUP BY finance_call_direction, soc_out, promotion_soc, soc, call_description, product_group, product_desc, product_line, reporting_month
    ) pristine_query;

--------------
select 
--distinct soc, event_month,
call_direction_id, soc, call_description,call_attempt_ind, traffic_type_id,
SUM(case when nvl(call_attempt_ind, False) = False and traffic_type_id = '1' then event_count else 0 end) AS voice_calls
FROM analytics.abt_traffic where soc='SIMPLEBTB' and event_month='201801' --and call_description='Fixed Network' 
group by
call_direction_id, soc, call_description, call_attempt_ind, traffic_type_id
order by 4 asc;

-------------------------------------
select *
FROM analytics.abt_traffic where soc='SIMPLEBTB' and event_month='201801' and traffic_type_id = '1' and call_description='Fixed Network' --and call_direction_id='2' 
order by call_description asc;

select *
FROM analytics.abt_traffic where soc='DLTLPR2' and event_month='201801' and traffic_type_id = '1' /*and call_description='Fixed Network'*/ --and call_direction_id='2' 
order by call_description asc;

-------------------------------------    
select *
--distinct soc, event_month,
--finance_call_direction, soc, call_description, calls
FROM work.analyst_sandbox_test_mobile_usage_original
where soc='SIMPLEBTB'  and call_description='Fixed Network' --and call_direction_id='2' 
order by 4 desc;  


select * FROM work.analyst_sandbox_test_mobile_usage_original;