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
--a.dmc as jakub_report_dmc,
b.dmc as consent_dmc,
a.dmc_date as report_dmc_date,
to_date(b.dmc_date) as consent_dmc_date,
a.dmc_channel as report_dmc_channel,
b.dmc_channel as consent_dmc_channel,
a.dmc_channel_email as report_dmc_channel_email,
--b.dmc_channel_email as Jakub_dmc_channel_email,
case when b.dmc = '3' then 'Yes' else b.dmc_channel_email end as consent_dmc_channel_email,
a.dmc_channel_text_message as report_dmc_channel_text_message,
b.dmc_channel_text_message as consent_dmc_channel_text_message,
a.dmc_channel_phone_call as report_dmc_channel_phone_call,
b.dmc_channel_phone_call as consent_dmc_channel_phone_call,
a.dmc_channel_social_media as report_dmc_channel_social_media,
b.dmc_channel_social_media as consent_dmc_channel_social_media,
a.dmc_channel_notifications as report_dmc_channel_notifications,
b.dmc_channel_notifications as consent_dmc_channel_notifications,

case when a.mtm = 'given' then '3' 
when a.mtm = 'declined'then '1'
when a.mtm = 'unconfirmed'then '2'
when a.mtm = 'withdrawn' then '4'
else a.mtm 
end as report_mtm,
b.mtm as consent_mtm,
a.mtm_date as report_mtm_date,
to_date(b.mtm_date) as consent_mtm_date,
a.mtm_channel as report_mtm_channel,
b.mtm_channel as consent_mtm_channel,

case when a.crm = 'given' then '3' 
when a.crm = 'declined'then '1'
when a.crm = 'unconfirmed'then '2'
when a.crm = 'withdrawn' then '4'
else a.crm 
end as report_crm,
b.crm as consent_crm,
a.crm_date as report_crm_date,
to_date(b.crm_DATE) as consent_crm_date,
a.crm_channel as report_crm_channel,
b.crm_channel as consent_crm_channel,

case when a.profiling = 'given' then '3' 
when a.profiling = 'declined'then '1'
when a.profiling = 'unconfirmed'then '2'
when a.profiling = 'withdrawn' then '4'
else a.profiling 
end as report_profiling,
b.profiling as consent_profiling,
a.profiling_date as report_profiling_date,
to_date(b.profiling_date) as consent_profiling_date,
a.profiling_channel as report_profiling_channel,
b.profiling_channel as consent_profiling_channel,

case when a.metadata_network_improvement = 'given' then '3' 
when a.metadata_network_improvement = 'declined'then '1'
when a.metadata_network_improvement = 'unconfirmed'then '2'
when a.metadata_network_improvement = 'withdrawn' then '4'
else a.metadata_network_improvement 
end as report_metadata_network_improvement,
b.metadata_network_improvement as consent_metadata_network_improvement,
a.metadata_network_improvement_date as report_metadata_network_improvement_date,
b.metadata_network_improvement_date as consent_metadata_network_improvement_date,
a.metadata_network_improvement_channel as report_metadata_network_improvement_channel,
b.metadata_network_improvement_channel as consent_metadata_network_improvement_channel,

case when a.Metadata_Testing = 'given' then '3' 
when a.Metadata_Testing = 'declined'then '1'
when a.metadata_testing = 'unconfirmed'then '2'
when a.Metadata_Testing = 'withdrawn' then '4'
else a.Metadata_Testing 
end as report_Metadata_Testing,
b.Metadata_Testing as consent_Metadata_Testing,
a.Metadata_Testing_date as report_Metadata_Testing_date,
b.Metadata_Testing_date as consent_Metadata_Testing_date,
a.Metadata_Testing_channel as report_Metadata_Testing_channel,
b.Metadata_Testing_channel as consent_Metadata_Testing_channel,

a.dmc_channel_available as report_dmc_channel_available,
case when b.dmc_channel is not null then 'Yes' end as consent_dmc_channel_available,

a.claimed_by_self_service_id

from analytics.abt_consent_data_subscriber a

full outer join 
(select customer_id as subscriber_id,
count(*) as antal,

max(case when d.name = 'Direct Marketing Contact' then b.change_date end) as DMC_DATE,
max(case when d.name = 'Direct Marketing Contact' then b.state_id end) as DMC,
max(case when d.name = 'Direct Marketing Contact' then g.name end) as dmc_channel,
max(case when d.name = 'Direct Marketing Contact' /*and c.name = 'given'*/ and lower(f.name) like '%e-mail%' then 'Yes' else 'No' end) as dmc_channel_email,
max(case when d.name = 'Direct Marketing Contact' /*and c.name = 'given'*/ and lower(f.name) like '%text message%' then 'Yes' else 'No' end) as dmc_channel_text_message,
max(case when d.name = 'Direct Marketing Contact' /*and c.name = 'given'*/ and lower(f.name) like '%phone call%' then 'Yes' else 'No' end) as dmc_channel_phone_call,
max(case when d.name = 'Direct Marketing Contact' /*and c.name = 'given'*/ and lower(f.name) like '%social media%' then 'Yes' else 'No' end) as dmc_channel_social_media,
max(case when d.name = 'Direct Marketing Contact' /*and c.name = 'given'*/ and lower(f.name) like '%notifications%' then 'Yes' else 'No' end) as dmc_channel_notifications,

max(case when d.name = 'Metadata Marketing' then b.change_date end) as crm_DATE,
max(case when d.name = 'Metadata Marketing' then b.state_id end) as crm,
max(case when d.name = 'Metadata Marketing' then g.name end) as crm_channel,

max(case when d.name = 'Extensive Profiling' then b.change_date end) as profiling_DATE,
max(case when d.name = 'Extensive Profiling' then b.state_id end) as profiling,
max(case when d.name = 'Extensive Profiling' then g.name end) as profiling_channel,

max(case when d.name = 'Metadata Network Improvement' then b.change_date end) as metadata_network_Improvement_DATE,
max(case when d.name = 'Metadata Network Improvement' then b.state_id end) as metadata_network_Improvement,
max(case when d.name = 'Metadata Network Improvement' then g.name end) as metadata_network_Improvement_channel,

max(case when d.name = 'Metadata Testing' then b.change_date end) as Metadata_Testing_DATE,
max(case when d.name = 'Metadata Testing' then b.state_id end) as Metadata_Testing,
max(case when d.name = 'Metadata Testing' then g.name end) as Metadata_Testing_channel,

max(case when d.name = 'Mit Telia Match' then b.change_date end) as mtm_DATE,
max(case when d.name = 'Mit Telia Match' then b.state_id end) as mtm,
max(case when d.name = 'Mit Telia Match' then g.name end) as mtm_channel,

max(g.name) as system

from base.import_consent_db_base_customer_entities a,
base.import_consent_db_base_customer_consents b,
base.import_consent_db_base_customer_consent_states c,
base.import_consent_db_base_consents d
left outer join 
/*base.import_consent_db_base_consent_channels e
on d.consent_id = e.consent_id*/
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
-- and x.report_subscriber_id=13790444
-- and x.consent_subscriber_id=12870734
and ( 1=2
or report_dmc <> consent_dmc
or report_dmc_date <> consent_dmc_date
or report_dmc_channel <> consent_dmc_channel

or report_mtm <> consent_mtm
or report_mtm_date <> consent_mtm_date
or report_mtm_channel <> consent_mtm_channel

or report_crm <> consent_crm
or report_crm_date <> consent_crm_date
or report_crm_channel <> consent_crm_channel

or report_profiling <> consent_profiling
or report_profiling_date <> consent_profiling_date
or report_profiling_channel <> consent_profiling_channel

or report_metadata_network_improvement <> consent_metadata_network_improvement 
or report_metadata_network_improvement_date <> consent_metadata_network_improvement_date
or report_metadata_network_improvement_channel <> consent_metadata_network_improvement_channel

or report_Metadata_Testing <> consent_Metadata_Testing
or report_Metadata_Testing_date <> consent_Metadata_Testing_date
or report_Metadata_Testing_channel <> consent_Metadata_Testing_channel

or report_dmc_channel_available <> consent_dmc_channel_available

-- or report_system <> consent_system

or report_dmc_channel_email <> consent_dmc_channel_email

or report_dmc_channel_text_message <> consent_dmc_channel_text_message
or report_dmc_channel_phone_call <> consent_dmc_channel_phone_call
or report_dmc_channel_social_media <> consent_dmc_channel_social_media
or report_dmc_channel_notifications <> consent_dmc_channel_notifications

)
;