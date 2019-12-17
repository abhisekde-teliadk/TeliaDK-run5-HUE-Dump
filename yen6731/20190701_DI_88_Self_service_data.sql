select count(*)  from
(
select
switcher_id,
case clicked_yes
 when true then 'yes'
 --else 'n/a'
end as click,
case clicked_no
 when true then 'no'
 --else 'n/a'
end as click2,
nvl(case clicked_yes
 when true then 'yes'
 --else 'n/a'
end,
case clicked_no
 when true then 'no'
 --else 'n/a'
end) as 'YES'

from (
 --when (clicked_yes='true','yes',(if (clicked_no='true', 'no', 'n/a')) as 'YES'
 
select 
 distinct
    su.id switcher_id, 
    (
        abs(datediff(ch.min_change_date,su.datecreated)) < 1 
        and ch.state_id = '2' -- unconfirmed
    ) clicked_yes, 
    (
        abs(datediff(ch.min_change_date,su.datecreated)) < 1 
        and ch.state_id = '1' -- declined
    ) clicked_no 
    

from 
base.import_self_service_base_user su

left join
    work.consent_tbt_consent_switchr_bridge scb
    on su.id = scb.switchr_id

left join
    base.import_consent_db_base_customer_entities ce
    on scb.consent_entity_id = ce.customer_entity_id

left join

    (
    select customer_entity_id, state_id, min(change_date) min_change_date
    from
    base.import_consent_db_base_customer_consents_history
    where consent_id = 'f2225250-2b6d-4d8a-96d1-24155326282e' -- MTM
    group by customer_entity_id, state_id
    ) ch
    on ce.customer_entity_id = ch.customer_entity_id
) t
) m
;

select * from analytics.abt_self_service_profiles where id = 171;