select *
from   analytics.prod_abt_consent_data_btb 
where  customer_id=660149204
;

select *
from   raw.import_consent_db_raw_customer_entities 
where customer_id = '660149204'
;


select *
from   raw.import_consent_db_raw_customer_consents
where  customer_consent_id = '101299644'
;

select *
from   raw.import_consent_db_raw_customer_consent_states 
where  state_id = '1'
;






select *
from   raw.import_consent_db_raw_behaviour_terms limit 1000;

select *
from   raw.import_consent_db_raw_brands limit 1000;


select *
from   raw.import_consent_db_raw_channel_text_resources limit 1000;

select *
from   raw.import_consent_db_raw_channels limit 1000;

select *
from   raw.import_consent_db_raw_consent_channels limit 1000;

select *
from   raw.import_consent_db_raw_consent_purposes limit 1000;

select *
from   raw.import_consent_db_raw_consent_reference_types limit 1000;

select *
from   raw.import_consent_db_raw_consent_relations limit 1000;

select *
from   raw.import_consent_db_raw_consent_systems limit 1000;

select *
from   raw.import_consent_db_raw_consent_text_resources limit 1000;

select *
from   raw.import_consent_db_raw_consents 
where  consent_id = '43760673-09b9-4885-b543-cac720d7ea1f'
;

select *
from   raw.import_consent_db_raw_customer_consent_channels limit 1000;



 

select *
from   raw.import_consent_db_raw_customer_consents_history 
where  customer_consent_id = '101299644'
;



select *
from   raw.import_consent_db_raw_customer_entity_group_entities limit 1000;

select *
from   raw.import_consent_db_raw_customer_entity_groups limit 1000;

select *
from   raw.import_consent_db_raw_events limit 1000;

select *
from   raw.import_consent_db_raw_reference_type_systems limit 1000;

select *
from   raw.import_consent_db_raw_reference_types limit 1000;

select *
from   raw.import_consent_db_raw_related_customers limit 1000;

select *
from   raw.import_consent_db_raw_sales_agents limit 1000;

select *
from   raw.import_consent_db_raw_systems limit 1000;