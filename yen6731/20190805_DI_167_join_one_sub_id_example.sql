select a.customer_entity_id,
a.customer_id as subscriber_id,
b.change_date,
b.state_id,
g.name as consent_system,
ROW_NUMBER() OVER (PARTITION BY /*a.customer_entity_id */ a.customer_id ORDER BY b.change_date desc) as rank

from base.import_consent_db_base_customer_entities a
left join base.import_consent_db_base_customer_consents_history b
 on a.customer_entity_id = b.customer_entity_id
left join base.import_consent_db_base_customer_consent_states c
 on b.state_id = c.state_id
left join base.import_consent_db_base_consents d
 on b.consent_id = d.consent_id
left join 
--base.import_consent_db_base_consent_channels e
--on d.consent_id = e.consent_id
base.import_consent_db_base_customer_consent_channels e  
   ON b.customer_consent_id = e.customer_consent_id 
left join base.import_consent_db_base_channels f
    ON e.channel_id = f.channel_id
left join base.import_consent_db_base_systems g
 on b.change_system_id = g.system_id

where 1=1 
-- and a.reference_type_id='SUBSCRIPTION-ID'
and a.customer_id > 0
and a.customer_id = 10041277 --14157391
--and a.customer_entity_id = 101070395
;

select signup_time,*  from analytics.abt_consent_data_subscriber where subscriber_id = 20054;

select * from base.import_consent_db_base_customer_entities where customer_id=10041277;
select * from base.import_consent_db_base_customer_consents_history where customer_entity_id=101291176;