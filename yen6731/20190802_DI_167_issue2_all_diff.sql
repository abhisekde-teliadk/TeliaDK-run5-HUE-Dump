select *, (consent_signup_time - report_signup_time) as diff
from (
select a.subscriber_id as report_subscriber_id,
b.subscriber_id as consent_subscriber_id,

a.signup_time as report_signup_time,
datediff(now(),b.change_date) as consent_signup_time,
b.change_date

from analytics.prod_abt_consent_data_subscriber a
full outer join 
(select a.customer_entity_id,
a.customer_id as subscriber_id,
b.change_date,
g.name as consent_system,
ROW_NUMBER() OVER (PARTITION BY /*a.customer_entity_id*/ a.customer_id ORDER BY b.change_date DESC) as rank

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
--and a.customer_id = 14157391
--and a.customer_entity_id = 101070395
) b
on a.subscriber_id = b.subscriber_id
--on a.customer_entity_id = b.customer_entity_id
and b.rank=1
 and a.subscriber_id = 10041277
) x 
where 1=2
-- or 1=1
--or report_system <> consent_system
--or report_signup_time <> consent_signup_time
or (consent_signup_time - report_signup_time) > 15 -- 6707
order by diff desc
;

--report_signup_time 1337
--consent_signup_time 250

select a.customer_entity_id,
a.customer_id as subscriber_id,
b.change_date,
g.name as consent_system,
ROW_NUMBER() OVER (PARTITION BY a.customer_entity_id ORDER BY b.change_date DESC) as rank

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
and a.customer_id = 20054;
--and a.customer_entity_id = 101070395;
;

select signup_time,*  from analytics.abt_consent_data_subscriber where subscriber_id = 20054;
select signup_time,*  from analytics.prod_abt_consent_data_subscriber where subscriber_id = 10041277;