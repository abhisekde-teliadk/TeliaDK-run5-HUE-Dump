select * from analytics.abt_consent_data_subscriber;

select distinct `3ec2e83c-ba64-4901-9cbf-56a6850f026d_channel_name_concat` from work.consent_work_consent_data_btc_pivot where `3ec2e83c-ba64-4901-9cbf-56a6850f026d_channel_name_concat` like '%E-Mail%';

select *
from (
select a.subscriber_id as report_subscriber_id,
b.subscriber_id as consent_subscriber_id,
case when a.dmc = 'given' then '3' 
when a.dmc = 'declined'then '1'
when a.dmc = 'unconfirmed'then '2'
when a.dmc = 'withdrawn' then '4'
else a.dmc 
end as report_dmc,
b.dmc as consent_dmc,
a.dmc_channel_email as report_dmc_channel_email,
case when b.dmc = '3' then 'Yes' else b.dmc_channel_email end as consent_dmc_channel_email,
a.dmc_channel_text_message as report_dmc_channel_text_message,
b.dmc_channel_text_message as consent_dmc_channel_text_message,
a.dmc_channel_phone_call as report_dmc_channel_phone_call,
b.dmc_channel_phone_call as consent_dmc_channel_phone_call,
a.dmc_channel_social_media as report_dmc_channel_social_media,
b.dmc_channel_social_media as consent_dmc_channel_social_media,
a.dmc_channel_notifications as report_dmc_channel_notifications,
b.dmc_channel_notifications as consent_dmc_channel_notifications,
a.dmc_date as report_dmc_date,
to_date(b.dmc_date) as consent_dmc_date,

a.claimed_by_self_service_id

from analytics.abt_consent_data_subscriber a

full outer join 
(select customer_id as subscriber_id,
count(*) as antal,

max(case when d.name = 'Direct Marketing Contact' then b.change_date end) as DMC_DATE,
max(case when d.name = 'Direct Marketing Contact' then b.state_id end) as DMC,
max(case when d.name = 'Direct Marketing Contact' then g.name end) as dmc_channel,
max(case when d.name = 'Direct Marketing Contact' and c.name = 'given' and lower(f.name) like '%e-mail%' then 'Yes' else 'No' end) as dmc_channel_email,
max(case when d.name = 'Direct Marketing Contact' and /*c.name = 'given' and*/ lower(f.name) like '%text message%' then 'Yes' else 'No' end) as dmc_channel_text_message,
max(case when d.name = 'Direct Marketing Contact' and c.name = 'given' and lower(f.name) like '%phone call%' then 'Yes' else 'No' end) as dmc_channel_phone_call,
max(case when d.name = 'Direct Marketing Contact' and c.name = 'given' and lower(f.name) like '%social media%' then 'Yes' else 'No' end) as dmc_channel_social_media,
max(case when d.name = 'Direct Marketing Contact' and c.name = 'given' and lower(f.name) like '%notifications%' then 'Yes' else 'No' end) as dmc_channel_notifications


from base.import_consent_db_base_customer_entities a,
base.import_consent_db_base_customer_consents b,
base.import_consent_db_base_customer_consent_states c,
base.import_consent_db_base_consents d
left outer join 
--base.import_consent_db_base_consent_channels e
base.import_consent_db_base_customer_consent_channels e  
   ON b.customer_consent_id = e.customer_consent_id 
left outer join
base.import_consent_db_base_channels f
on e.channel_id = f.channel_id
left outer join 
base.import_consent_db_base_systems g
on b.change_system_id = g.system_id

where a.reference_type_id='SUBSCRIPTION-ID'
and a.customer_id > 0
-- and a.customer_id = 16194625
and a.customer_entity_id = b.customer_entity_id 
and b.state_id = c.state_id
and b.consent_id = d.consent_id

group by 1

) b
on a.subscriber_id = b.subscriber_id
) x 
where 1=1
 and x.report_subscriber_id=15895030
-- and x.consent_subscriber_id=12870734
and ( 1=2
--or report_dmc <> consent_dmc
--or report_dmc_channel_email <> consent_dmc_channel_email
/*or report_dmc_channel_text_message <> consent_dmc_channel_text_message
or report_dmc_channel_phone_call <> consent_dmc_channel_phone_call
or report_dmc_channel_social_media <> consent_dmc_channel_social_media
or report_dmc_channel_notifications <> consent_dmc_channel_notifications
*/
)
;

select

d.name as dname,
c.name as cname,
f.name as fname


from base.import_consent_db_base_customer_entities a,
base.import_consent_db_base_customer_consents b,
base.import_consent_db_base_customer_consent_states c,
base.import_consent_db_base_consents d
left outer join 
base.import_consent_db_base_customer_consent_channels e
on b.customer_consent_id = e.customer_consent_id
left outer join
base.import_consent_db_base_channels f
on e.channel_id = f.channel_id
left outer join 
base.import_consent_db_base_systems g
on b.change_system_id = g.system_id

where a.reference_type_id='SUBSCRIPTION-ID'
and a.customer_id > 0
and a.customer_id = 15895030
and a.customer_entity_id = b.customer_entity_id 
and b.state_id = c.state_id
and b.consent_id = d.consent_id

--where 1=1
 --and x.report_subscriber_id=12870734
;

select

base_consents.name as dname,
base_customer_consent_states.name as cname,
base_channels.name as fname


from base.import_consent_db_base_customer_entities base_customer_entities
left join base.import_consent_db_base_customer_consents base_customer_consents
    on base_customer_entities.customer_entity_id = base_customer_consents.customer_entity_id

left join base.import_consent_db_base_consents base_consents
    on base_customer_consents.consent_id = base_consents.consent_id
    
left join base.import_consent_db_base_customer_consent_states base_customer_consent_states
    on base_customer_consents.state_id = base_customer_consent_states.state_id 


-- OLE use base_consent_channels
--left join base.import_consent_db_base_consent_channels base_consent_channels
   -- on base_consents.consent_id = base_consent_channels.consent_id

--we use base_customer_consent_channels
LEFT JOIN base.import_consent_db_base_customer_consent_channels base_customer_consent_channels  
   ON base_customer_consents.customer_consent_id = base_customer_consent_channels.customer_consent_id 

--left join base.import_consent_db_base_channels base_channels
  --  on base_consent_channels.channel_id = base_channels.channel_id
    
LEFT JOIN base.import_consent_db_base_channels base_channels
            ON base_customer_consent_channels.channel_id = base_channels.channel_id
                
    
    
where base_customer_entities.reference_type_id='SUBSCRIPTION-ID'
and base_customer_entities.customer_id = 13790444
;

select on_what_type."name", here_is_name_of_chanel."name", what_status.name  from 
base.import_consent_db_base_customer_entities customer
left join base.import_consent_db_base_customer_consents what_gave_customer on what_gave_customer.customer_entity_id = customer.customer_entity_id
left join base.import_consent_db_base_customer_consent_states what_status on what_status.state_id = what_gave_customer.state_id
left join base.import_consent_db_base_consents on_what_type on on_what_type.consent_id = what_gave_customer.consent_id
left join base.import_consent_db_base_consent_channels on_which_chanel_he_agrees on on_which_chanel_he_agrees.consent_id = what_gave_customer.consent_id
left join base.import_consent_db_base_channels here_is_name_of_chanel on here_is_name_of_chanel.channel_id = on_which_chanel_he_agrees.channel_id limit 10;


select on_what_type."name", here_is_name_of_chanel."name", what_status.name  from 
consentdb_st.customer_entities customer
left join consentdb_st.customer_consents what_gave_customer on what_gave_customer.customer_entity_id = customer.customer_entity_id
left join consentdb_st.customer_consent_states what_status on what_status.state_id = what_gave_customer.state_id
left join consentdb_st.consents on_what_type on on_what_type.consent_id = what_gave_customer.consent_id
left join consentdb_st.consent_channels on_which_chanel_he_agrees on on_which_chanel_he_agrees.consent_id = what_gave_customer.consent_id
left join consentdb_st.channels here_is_name_of_chanel on here_is_name_of_chanel.channel_id = on_which_chanel_he_agrees.channel_id limit 10;

