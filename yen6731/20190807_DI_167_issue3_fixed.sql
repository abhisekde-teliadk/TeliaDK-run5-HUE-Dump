select a.subscriber_id,
a.last_mtm_unconfirmed_system,
*
from analytics.abt_consent_data_subscriber a
where subscriber_id = 408767
;
--Consent DB Telia B2C
;
select a.customer_entity_id,
a.customer_id as subscriber_id,
b.change_date,
b.state_id,
g.name as consent_system,
d.name as consent_name,
ROW_NUMBER() OVER (PARTITION BY a.customer_id ORDER BY b.change_date desc) as rank

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

where d.name = 'Mit Telia Match'
and reference_type_id = 'SUBSCRIPTION-ID'
and b.state_id = '2'
and a.customer_id = 408767
;

SELECT DISTINCT *
  FROM (
    SELECT 
        subscriber_id AS subscriber_id,
        customer_id AS customer_id,
        status AS status,
        customer_entity_id AS customer_entity_id,
        reference_type_id AS reference_type_id,
        customer_consent_id AS customer_consent_id,
        state_id AS state_id,
        change_date AS change_date,
        consent_id AS consent_id,
        name AS name,
        sys_name AS consent_system,
        ccs_name AS ccs_name,
        start_service_date AS start_service_date,
        channel_id AS channel_id,
        channel_name AS channel_name
      FROM (
        SELECT 
            tbt_subscriber_current.subscriber_id AS subscriber_id,
            tbt_subscriber_current.customer_id AS customer_id,
            tbt_subscriber_current.status AS status,
            base_customer_entities.customer_entity_id AS customer_entity_id,
            base_customer_entities.reference_type_id AS reference_type_id,
            base_customer_consents.customer_consent_id AS customer_consent_id,
            base_customer_consents.state_id AS state_id,
            base_customer_consents.change_date AS change_date,
            base_consents.consent_id AS consent_id,
            base_consents.name AS name,
            base_systems.name AS sys_name,
            base_customer_consent_states.name AS ccs_name,
            tbt_customer_current.start_service_date AS start_service_date,
            base_customer_consent_channels.channel_id AS channel_id,
            base_channels.name AS channel_name
          FROM work.base_equation_sub_tbt_subscriber_current tbt_subscriber_current
          LEFT JOIN (
            SELECT base_customer_entities.*
              FROM base.import_consent_db_base_customer_entities base_customer_entities
              WHERE reference_type_id = 'SUBSCRIPTION-ID'
            ) base_customer_entities
            ON tbt_subscriber_current.subscriber_id = base_customer_entities.customer_id
          LEFT JOIN base.import_consent_db_base_customer_consents base_customer_consents
            ON base_customer_entities.customer_entity_id = base_customer_consents.customer_entity_id
          LEFT JOIN base.import_consent_db_base_consents base_consents
            ON base_customer_consents.consent_id = base_consents.consent_id
          LEFT JOIN base.import_consent_db_base_systems base_systems
            ON base_customer_consents.change_system_id = base_systems.system_id
          LEFT JOIN base.import_consent_db_base_customer_consent_states base_customer_consent_states
            ON base_customer_consents.state_id = base_customer_consent_states.state_id
          LEFT JOIN work.base_equation_sub_tbt_customer_current tbt_customer_current
            ON tbt_subscriber_current.customer_id = tbt_customer_current.customer_id
          LEFT JOIN base.import_consent_db_base_customer_entity_group_entities base_customer_entity_group_entities
            ON base_customer_entities.customer_entity_id = base_customer_entity_group_entities.customer_entity_id
          LEFT JOIN base.import_consent_db_base_customer_consent_channels base_customer_consent_channels
            ON base_customer_consents.customer_consent_id = base_customer_consent_channels.customer_consent_id
          LEFT JOIN base.import_consent_db_base_channels base_channels
            ON base_customer_consent_channels.channel_id = base_channels.channel_id
          LEFT JOIN base.import_consent_db_base_sales_agents base_sales_agents
            ON base_customer_consents.sales_agent_id = base_sales_agents.id
          LEFT JOIN base.import_neo_base_sales_agent base_sales_agent
            ON base_sales_agents.external_id = base_sales_agent.id
        ) withoutcomputedcols_query
    ) unfiltered_query
  WHERE (reference_type_id != '' OR reference_type_id IS NULL AND '' IS NOT NULL OR reference_type_id IS NOT NULL AND '' IS NULL) AND reference_type_id IS NOT NULL
  --and subscriber_id=408767 
  --and name='Mit Telia Match'
  --and customer_entity_id=101642761; not exist
  and customer_entity_id=101624332;
  
select * from  work.base_equation_sub_tbt_subscriber_current;