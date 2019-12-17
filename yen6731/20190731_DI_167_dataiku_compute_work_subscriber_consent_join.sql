SELECT DISTINCT *
  FROM (
    SELECT 
        subscriber_id AS subscriber_id,
        customer_id AS customer_id,
        status AS status,
        customer_consent_id AS customer_consent_id,
        state_id AS state_id,
        
        consent_id AS consent_id,
        name AS name,
        ccs_name AS ccs_name,
        channel_id AS channel_id,
        channel_name AS channel_name
      FROM (
        SELECT 
            tbt_subscriber_current.subscriber_id AS subscriber_id,
            tbt_subscriber_current.customer_id AS customer_id,
            
            tbt_subscriber_current.status AS status,
            
            base_customer_entities.customer_entity_id AS customer_entity_id,
            
            base_customer_consents.customer_consent_id AS customer_consent_id,
            base_customer_consents.state_id AS state_id,
            base_customer_consents.change_date AS change_date,
            base_consents.consent_id AS consent_id,
            base_consents.name AS name,
            base_customer_consent_states.name AS ccs_name,
            base_customer_entity_group_entities.customer_entity_group_id AS customer_entity_group_id,
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
          LEFT JOIN base.import_consent_db_base_customer_entity_group_entities base_customer_entity_group_entities
            ON base_customer_entities.customer_entity_id = base_customer_entity_group_entities.customer_entity_id
          LEFT JOIN base.import_consent_db_base_customer_consent_channels base_customer_consent_channels
            ON base_customer_consents.customer_consent_id = base_customer_consent_channels.customer_consent_id
          LEFT JOIN base.import_consent_db_base_channels base_channels
            ON base_customer_consent_channels.channel_id = base_channels.channel_id
          LEFT JOIN base.import_consent_db_base_sales_agents base_sales_agents
            ON base_customer_consents.sales_agent_id = base_sales_agents.id
        ) withoutcomputedcols_query
    ) unfiltered_query
  WHERE /*(reference_type_id != '' OR reference_type_id IS NULL AND '' IS NOT NULL OR reference_type_id IS NOT NULL AND '' IS NULL) AND reference_type_id IS NOT NULL and*/ subscriber_id=12870734 and status='A';

select base_consents.name,
base_customer_consent_states.name AS ccs_name
--            base_channels.name AS channel_name
        --    from 
  --work.base_equation_sub_tbt_subscriber_current tbt_subscriber_current
    --      LEFT JOIN (
      --      SELECT base_customer_entities.*
              FROM base.import_consent_db_base_customer_entities base_customer_entities
          --    WHERE reference_type_id = 'SUBSCRIPTION-ID'
        --    ) base_customer_entities
        --    ON tbt_subscriber_current.subscriber_id = base_customer_entities.customer_id
          LEFT JOIN base.import_consent_db_base_customer_consents base_customer_consents
            ON base_customer_entities.customer_entity_id = base_customer_consents.customer_entity_id
         
          LEFT JOIN base.import_consent_db_base_consents base_consents
            ON base_customer_consents.consent_id = base_consents.consent_id
          
          LEFT JOIN base.import_consent_db_base_customer_consent_states base_customer_consent_states
            ON base_customer_consents.state_id = base_customer_consent_states.state_id
          /*  
            
          LEFT JOIN base.import_consent_db_base_customer_consent_channels base_customer_consent_channels
            ON base_customer_consents.customer_consent_id = base_customer_consent_channels.customer_consent_id    
          
          LEFT JOIN base.import_consent_db_base_channels base_channels
            ON base_customer_consent_channels.channel_id = base_channels.channel_id*/
            
            
            where 
            --reference_type_id = 'SUBSCRIPTION-ID' and

            base_customer_entities.customer_id=12870734;
  