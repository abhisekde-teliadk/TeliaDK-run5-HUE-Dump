

describe  analytics.abt_consent_event_subscriber;

1	subscriber_id	            OK test1    20190826    ERROR   test1A  test1B
2	event	                    OK test2    20190826	
3	event_date	                OK test2    20190826
4	channel	                    OK test2    20190826
5	subscription_start_date	    OK test6    20190826
6	ban_start_date	            ERROR   test6   20190826
7	subscription_status 	    ERROR   test6   20190826	
8	churn_date	                OK test6    20190826
9	dealer_code	                ERROR   test6   20190826 	
10	dealer_id	                ERROR   test7   20190826	
11	dealer_name	                ERROR   test7   20190826	
12	dealer_no	                ERROR   test7   20190826	
13	dealer_address	            ERROR   test7   20190826	
14	dealer_city	                ERROR   test7   20190826	
15	dealer_contact_name	        ERROR   test7   20190826	
16	dealer_group                ERROR   test7   20190826
;

-- test1
-- subscriber_id's in subscriber_event table, but not in subscriber_current table
-- should be 0
select a.subscriber_id
from   analytics.abt_consent_event_subscriber a
          left outer join 
       analytics.abt_subscriber_history b
          on a.subscriber_id = b.subscriber_id
where  b.subscriber_id is null
;
-- 0 records : OK
       


-- test 1A
-- is there any consents without any events
-- expected row count = 0
select a.*
from   analytics.abt_consent_data_subscriber a
          left outer join 
       analytics.abt_consent_event_subscriber b
          on a.subscriber_id = b.subscriber_id
where  b.subscriber_id is null
;
-- why are there records here

-- test 1B
-- is there any events without any consents
-- expected row count = 0
select a.*
from   analytics.abt_consent_event_subscriber a
          left outer join 
       analytics.abt_consent_data_subscriber b
          on a.subscriber_id = b.subscriber_id
where  b.subscriber_id is null
;
-- why are there records here



-- test2
-- create total event table
drop table   sandbox.ole_consents_history;
create table sandbox.ole_consents_history as 
select customer_consent_id,
       customer_entity_id,
       consent_id,
       consent_version,
       state_id,
       change_date,
       change_system_id,
       change_order_id,
       change_media_id,
       sales_agent_id
from   base.import_consent_db_base_customer_consents_history
union all
select customer_consent_id,
       customer_entity_id,
       consent_id,
       consent_version,
       state_id,
       change_date,
       change_system_id,
       change_order_id,
       change_media_id,
       sales_agent_id
from   base.import_consent_db_base_customer_consents
;

-- test fields : from consent tables :
-- event
-- event_date
-- channel
select * from (
select a.subscriber_id as report_subscriber_id,
       b.subscriber_id as consent_subscriber_id,
       a.event as report_event,
       b.consent_event,
       a.event_date as report_dato,
       b.consent_dato,
       a.channel as report_channel,
       b.consent_channel
from   analytics.abt_consent_event_subscriber a
          full outer join 
       (select distinct 
               a.customer_id as subscriber_id,
      --       a.customer_entity_id,
               case when b.consent_id='f2225250-2b6d-4d8a-96d1-24155326282e' and b.state_id='1' then 'MTM declined'
                    when b.consent_id='f2225250-2b6d-4d8a-96d1-24155326282e' and b.state_id='2' then 'MTM unconfirmed'
                    when b.consent_id='f2225250-2b6d-4d8a-96d1-24155326282e' and b.state_id='3' then 'MTM given'
                    when b.consent_id='f2225250-2b6d-4d8a-96d1-24155326282e' and b.state_id='4' then 'MTM withdrawn'
                    when b.consent_id='3ec2e83c-ba64-4901-9cbf-56a6850f026d' and b.state_id='1' then 'DMC declined'
                    when b.consent_id='3ec2e83c-ba64-4901-9cbf-56a6850f026d' and b.state_id='2' then 'DMC unconfirmed'
                    when b.consent_id='3ec2e83c-ba64-4901-9cbf-56a6850f026d' and b.state_id='3' then 'DMC given'
                    when b.consent_id='3ec2e83c-ba64-4901-9cbf-56a6850f026d' and b.state_id='4' then 'DMC withdrawn'
                    when b.consent_id='0577fa06-9b71-4cea-ab43-0be4cc9aeadd' and b.state_id='1' then 'CRM declined'
                    when b.consent_id='0577fa06-9b71-4cea-ab43-0be4cc9aeadd' and b.state_id='2' then 'CRM unconfirmed'
                    when b.consent_id='0577fa06-9b71-4cea-ab43-0be4cc9aeadd' and b.state_id='3' then 'CRM given'
                    when b.consent_id='0577fa06-9b71-4cea-ab43-0be4cc9aeadd' and b.state_id='4' then 'CRM withdrawn'
                    when b.consent_id='45a8b98e-1505-4a95-ae93-df709fe6a699' and b.state_id='1' then 'Profiling declined'
                    when b.consent_id='45a8b98e-1505-4a95-ae93-df709fe6a699' and b.state_id='2' then 'Profiling unconfirmed'
                    when b.consent_id='45a8b98e-1505-4a95-ae93-df709fe6a699' and b.state_id='3' then 'Profiling given'
                    when b.consent_id='45a8b98e-1505-4a95-ae93-df709fe6a699' and b.state_id='4' then 'Profiling withdrawn'
                    else 'NA' 
               end as consent_event,
               to_date(b.change_date) as consent_dato,
               g.name as consent_channel
       
        
        from   base.import_consent_db_base_customer_entities a,
               sandbox.ole_consents_history  b,
               base.import_consent_db_base_customer_consent_states c,
               base.import_consent_db_base_consents d
                  left outer join 
               base.import_consent_db_base_consent_channels e
                  on d.consent_id = e.consent_id
                  left outer join
               base.import_consent_db_base_channels f
                  on e.channel_id = f.channel_id
                  left outer join 
               base.import_consent_db_base_systems g
                  on b.change_system_id = g.system_id
                  
        where  a.reference_type_id='SUBSCRIPTION-ID'
        and    a.customer_entity_id = b.customer_entity_id 
        and    b.state_id = c.state_id
        and    b.consent_id = d.consent_id) b
        
           on a.subscriber_id = b.subscriber_id
               and a.event = b.consent_event
               and a.event_date = b.consent_dato
               and a.channel = b.consent_channel
   

) x
where  x.report_subscriber_id > 0 
and   
(      1=1
--or     x.report_subscriber_id is null
--or     x.consent_subscriber_id is null
or     x.report_event <> x.consent_event
or     x.report_dato <> x.consent_dato
or     x.report_channel <> x.consent_channel
)
order by 1,2,3,4
;
-- expected 0 records

-- test 3

-- test 4


-- test 5

-- test 6 test remaining fields - should be set accouting to status on event_date :
--	subscription_start_date
--	ban_start_date
--  subscription_status
--	churn_date
--	dealer_code


select * from (
select a.subscriber_id,
       a.event,
       to_timestamp(a.event_date, 'yyyy-MM-dd')  as event_timestamp,
       b.start_date,
       b.end_date,
       a.channel,
       a.customer_id as event_customer_id,
       b.customer_id as sub_customer_id,
       
       a.subscription_start_date as event_subscription_start_date,
       to_date(b.subscriber_id_activation_date) as sub_subscriber_id_activation_date,
       
       a.ban_start_date as event_ban_start_date,
       to_date(b.customer_start_service_date) as sub_ban_start_date,

       a.subscription_status as event_subscription_status,
       case when b.status ='A' then 'active'
            when b.status ='S' then 'suspended'
            else b.status
       end  as sub_status,
       
       a.churn_date as event_churn_date,
       to_date(b.churn_date) as sub_churn_date,
       
       a.dealer_code as event_dealer_code,
       b.dealer_code as sub_dealer_code
       
from   analytics.abt_consent_event_subscriber a
          left outer join 
       analytics.abt_subscriber_history b
          on a.subscriber_id = b.subscriber_id
          and microseconds_sub(adddate(to_timestamp(event_date, 'yyyy-MM-dd'),1),1) between b.start_date and  b.end_date
          and b.status in ('A','S')
          
where  1=1 
and    a.subscriber_id > 0
--and    a.subscriber_id in (4313,15200901)
) x
where  1=2
or     x.event_customer_id <> x.sub_customer_id
or     x.event_subscription_start_date <> x.sub_subscriber_id_activation_date
or     x.event_ban_start_date <> x.sub_ban_start_date
or     x.event_subscription_status <> x.sub_status
or     x.event_churn_date <> x.sub_churn_date
or     x.event_dealer_code <> x.sub_dealer_code

order by x.subscriber_id,3
;
-- 11 records

-- test 7 test remaining fields - should be set accouting to status on event_date :
--	dealer_id
--	dealer_name
--	dealer_no
--	dealer_address
--	dealer_city
--	dealer_contact_name
--	dealer_group

select * from (
select a.subscriber_id,
       a.event,
       to_timestamp(a.event_date, 'yyyy-MM-dd')  as event_timestamp,
       a.channel,

       a.dealer_id as event_dealer_id,
       g.dealer_id as consent_dealer_id,
       
       a.dealer_name as event_dealer_name,
       h.dealer_name as consent_dealer_name,
       
       a.dealer_no as event_dealer_no,
       h.dealer_no as consent_daler_no,
       
       a.dealer_address as event_dealer_address,
       h.street_address as consent_address,
    
       
       a.dealer_city as event_dealer_city,
       h.street_postal_city as consent_dealer_city,
       
       a.dealer_contact_name as event_dealer_contact_name,
       h.dealer_contact_name as consent_dealer_contact_name,
       
       a.dealer_group as event_dealer_group,
       h.dealer_group as consent_dealer_group
       
       
from   analytics.abt_consent_event_subscriber a
          left outer join 
       base.import_consent_db_base_customer_entities b
          on a.subscriber_id = b.customer_id
          and b.reference_type_id = 'SUBSCRIPTION-ID'
          left outer join 
       base.import_consent_db_base_customer_consents c
          on b.customer_entity_id = c.customer_entity_id
          left outer join 
       base.import_consent_db_base_customer_consent_channels d
          on c.customer_entity_id = d.customer_consent_id
          left outer join
       base.import_consent_db_base_channels e
          on d.channel_id = e.channel_id
          left outer join 
       base.import_consent_db_base_sales_agents f
          on c.sales_agent_id = f.id
          left outer join 
       base.import_neo_base_sales_agent g
          on f.external_id = g.id
          left outer join 
       base.import_neo_base_ddb_dealer h
          on g.dealer_id = h.id
       
          
where  1=1 
and    a.subscriber_id > 0
--and    a.subscriber_id in (4313,15200901)
) x
where  1=2
or     event_dealer_id <> consent_dealer_id
or     event_dealer_name <> consent_dealer_name
or     event_dealer_no <> cast(consent_daler_no as int)
or     event_dealer_address <> consent_address
or     event_dealer_city <> consent_dealer_city
or     event_dealer_contact_name <> consent_dealer_contact_name
or     event_dealer_group <> consent_dealer_group

 
order by x.subscriber_id,3
;
-- 16 records


select * from   base.import_consent_db_base_customer_entities where customer_id =22666 and reference_type_id='SUBSCRIPTION-ID';
select * from   base.import_consent_db_base_customer_consents  where customer_entity_id =101275508;
select * from   analytics.abt_subscriber_current where subscriber_id = 81;
select * from   analytics.abt_consent_event_subscriber where dealer_id is not null;
select * from   analytics.abt_dealer where dealer_code in ('7292');
select * from   analytics.abt_d_dealer where fokus_dealer_code in ('DCNV','7292');
select * from   base.import_consent_db_base_customer_consents_history where customer_entity_id =101551749;
select * from   base.import_consent_db_base_customer_consent_states where state_id = '3';
select * from   base.import_consent_db_base_consents where consent_id = '3ec2e83c-ba64-4901-9cbf-56a6850f026d';
select * from   base.import_consent_db_base_systems;
select * from   base.import_consent_db_base_systems where system_id='d26970f9-2db0-404b-b0fe-710efef75187';
select * from   base.import_neo_base_neo_channels order by 1;
select * from   base.import_neo_base_neo_orders where order_id=51244946;
select * from   base.import_consent_db_base_channel_text_resources;
select * from   base.import_consent_db_base_channels;
select * from   base.import_consent_db_base_consent_channels;
select * from   base.import_consent_db_base_customer_consent_channels;
select * from   base.import_consent_db_base_consent_systems;
select * from   base.import_consent_db_base_behaviour_terms;
select * from   base.import_consent_db_base_reference_type_systems;

