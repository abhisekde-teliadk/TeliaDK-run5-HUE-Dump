select * from base.IMPORT_SELF_SERVICE_base_user where id=171; -- 478.262

select * from work.consent_tbt_consent_switchr_bridge where switchr_id=171--customer_entity_id=101024787;

--select count(*) from (
    SELECT 
        id AS id,
        datecreated AS datecreated,
        switchr_id AS switchr_id,
        customer_entity_id AS customer_entity_id,
        state_id AS state_id,
        change_date_min AS change_date_min,
        abs(datediff(change_date_min, datecreated)) < 1 and state_id = '2' AS clicked_yes,
        abs(datediff(change_date_min, datecreated)) < 1 and state_id = '1' AS clicked_no,
        coalesce(
    case (abs(datediff(change_date_min, datecreated)) < 1 and state_id = '2')
    when true then 'YES' 
end,
case (abs(datediff(change_date_min, datecreated)) < 1 and state_id = '1')
 when true then 'NO' 
end, 'N/A') AS clicked
      FROM (
        SELECT 
            base_user.id AS id,
            base_user.datecreated AS datecreated,
            tbt_consent_switchr_bridge.switchr_id AS switchr_id,
            base_customer_entities.customer_entity_id AS customer_entity_id,
            work_customer_consent_grouped.state_id AS state_id,
            work_customer_consent_grouped.change_date_min AS change_date_min
          FROM base.import_self_service_base_user base_user
          LEFT JOIN work.consent_tbt_consent_switchr_bridge tbt_consent_switchr_bridge
            ON base_user.id = tbt_consent_switchr_bridge.switchr_id
          LEFT JOIN base.import_consent_db_base_customer_entities base_customer_entities
            ON tbt_consent_switchr_bridge.consent_entity_id = base_customer_entities.customer_entity_id
          LEFT JOIN work.self_service_data_work_customer_consent_grouped work_customer_consent_grouped
            ON base_customer_entities.customer_entity_id = work_customer_consent_grouped.customer_entity_id
        ) withoutcomputedcols_query
--) tmp;
;

-- example where we need to rank on change_date_min
select * from work.self_service_data_user_consent_join_grouped where id=343544;
select * from work.self_service_data_user_consent_join_ranked where id=343544;
select * from work.self_service_data_user_consent_join_windows where id=343544;
select * from work.self_service_data_work_user_main_join where id=343544;

select * from work.self_service_data_user_consent_join_grouped where id=171;
select * from work.self_service_data_user_consent_join_ranked where id=171;
select * from work.self_service_data_user_consent_join_windows where id=171;
select * from work.self_service_data_work_user_main_join where id=171;

-- DUPLICITY on PROD
select * from work.self_service_data_user_consent_join_grouped where id=184;
select * from work.self_service_data_user_consent_join_ranked where id=184;
select * from work.self_service_data_user_consent_join_windows where id=184;
select * from work.self_service_data_work_user_main_join where id=184;

select * from analytics.abt_self_service_profiles where id=151657;
select * from analytics.abt_self_service_profiles where id=151657;

select id, count(*) from analytics.abt_self_service_profiles group by id having count(*)>1;


-- those id that have different state (YES/NO) for same
select id, count(distinct clicked) from work.self_service_data_user_consent_join where clicked!='N/A' group by id having count(distinct clicked)>1;

select * from work.self_service_data_user_consent_join order by id limit 100;