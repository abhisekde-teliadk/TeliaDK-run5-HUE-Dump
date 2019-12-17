-- UAT af : 	Abt_customer_history, abt_customer_current - 8h

set request_pool=big;

-- Test 0 - preview
select *
from   analytics.abt_customer_current a
;



-- Test 1 - count
select count(*) as antal
from   analytics.prod_abt_customer_current a
;
-- 3729245 rows - OK passer med repdb + cmrepdb




-- Test 2 - start_date
select a.customer_id,
       a.start_date,
       count(*) as antal
from   analytics.prod_abt_customer_history a
group by 1,2
having count(*) > 1
;
-- 0 rows - OK - ikke to start date er de samme

-- Test 3 - customer_id perioder
select a.customer_id,
       a.start_date
from   analytics.prod_abt_customer_history a,
       analytics.prod_abt_customer_history b
where  a.customer_id = b.customer_id
and    a.start_date between b.start_date and b.end_date
and    a.start_date <> b.start_date
order by 1,2
;
-- 0 rows : OK - ikke periode overlap

--------------    CURRENT tested fields ------------------------------------;

   start_date num               OK
   end_date num                 OK
   active_record_flag           OK
   customer_id                  OK
   origin                       OK Altid Amdocs
   cvr_no                       OK
   cpr_no                       Skal være NULL hvis længden ikke er 10
   organization_name            OK
   identify                     OK
   root_customer_id             OK
   root_cvr_no                  ERROR - kun test af enkelt numre
   root_cpr_no                  OK - kun test af enkelt numre
   root_organization_name       OK - kun test af enkelt numre
   root_identify                OK - kun test af enkelt numre
   cycle_code                   OK
   tree_level                   OK
   agncy_code                   OK
   ar_balance                   OK
   delinq_status                OK
   delinq_sts_date              OK
   credit_class                 OK
   account_type_id              OK
   ban_status                   OK
   payment_method_id            ERROR, forkert vælges ml GT og DD (PBS) 
   payment_sub_method_id        ERROR, forkert vælges ml GT og DD (PBS) 
   customer_telno               OK
   print_category               OK
   employment_type              OK
   start_service_date           OK
   status_last_date             OK
   bl_due_day                   OK
   since_date                   OK
   additional_title             OK LEGAL
   
   robinson                     ?
   
   accommodation_type           OK
   contact_phone_no             OK
   
   analysis_date                OK BTB consent tabellen
   analysis                     OK BTB consent tabellen
   marketing_date               OK BTB consent tabellen
   marketing                    OK BTB consent tabellen
   
   adr_co_name                  OK
   adr_district                 OK
   adr_email                    OK
   adr_door_no                  OK
   adr_story                    OK
   adr_house_letter             OK
   adr_country                  OK
   adr_pob                      OK
   adr_direction                OK
   adr_street_name              OK
   adr_house_no                 OK
   adr_zip                      OK
   adr_city                     OK
   adr_primary_ln               OK
   adr_secondary_ln             OK
   gender                       ERROR - definition ændres MOD11
   birth_date                   ERROR - calculation is wrong
   middle_initial               OK
   first_name                   OK
   last_business_name           OK
   payment_method_description   OK
   segment_type                 OK
   segment_group                OK
   segment_subgroup             OK
   segment_name                 OK
   segment_desc                 OK
   segment_origin               OK
   segment_remark               OK
   telia_customer               OK
; 
--------------    CURRENT testes ------------------------------------;

-- Test 4 - count
select b.*
from   analytics.prod_abt_customer_current a
          full outer join
       base.import_fokus_base_customer  b
          on a.customer_id = cast(b.customer_id as bigint)
where b.customer_id is null
or    a.customer_id is null
;
-- 503 rows - i RAW tabellen er ikke med i ABT tabellen - alle rækker er helt nye - OK
-- 0 records tested OK  20190417


-- Test 5 - felt tjek
select a.customer_id,
       b.sys_update_date,
       a.EMPLOYMENT_TYPE,
       b.EMPLOYMENT_TYPE as raw_EMPLOYMENT_TYPE,
       a.contact_phone_no,
       b.work_telno as raw_contact_phone_no,
       a.customer_telno,
       b.customer_telno as raw_customer_telno
from   analytics.prod_abt_customer_current a,
       base.import_fokus_base_customer b
where  a.customer_id = cast(b.customer_id as bigint)
and    (
      a.EMPLOYMENT_TYPE <> b.EMPLOYMENT_TYPE
or    a.CONTACT_PHONE_NO <> b.customer_telno
or    a.customer_telno <> b.customer_telno
      )
;
-- 0 rows - OK - tidligere test : 8 alle med ny cyc_creation_date


-- Test 5 billing_account felter tjek
select a.customer_id,
       b.sys_update_date,
       a.ban_status,
       b.ban_status as raw_ban_status
from   analytics.prod_abt_customer_current a,
       base.import_fokus_base_billing_account b
where  a.customer_id = cast(b.ban as bigint)
and   not (
       (a.ban_status = 'Open' and b.ban_status = 'O') or 
       (a.ban_status = 'Closed' and b.ban_status = 'C') or 
       (a.ban_status = 'Cancelled' and b.ban_status = 'N') or
       (a.ban_status = 'Tentative' and b.ban_status = 'T') or 
       (a.ban_status <> 'Suspended' and b.ban_status = 'S')
       )
order by 2
;
-- 0 OK
-- 69 rows - OK - alle med ny cyc_creation_date
-- 0 records - tested   20190417
 
-- Test 6 billing_account felter tjek
select a.customer_id,
       b.sys_update_date,
       a.bl_due_day,
       b.bl_due_day as raw_bl_due_day,
       a.status_last_date,
       b.status_last_date as raw_status_last_date,
       a.start_service_date,
       b.start_service_date as raw_start_service_date,
       a.print_category,
       b.bl_prt_category as raw_bl_prt_category,
       a.credit_class,
       b.credit_class as raw_credit_class,
       a.delinq_status,
       b.col_delinq_status,
       a.delinq_sts_date,
       b.col_delinq_sts_date,
       a.ar_balance,
       b.ar_balance as rwa_ar_balance,
       a.cycle_code,
       b.bill_cycle as raw_bill_cycle,
       a.agncy_code,
       b.col_agncy_code as raw_col_agncy_code,
       a.account_type_id,
       concat(b.account_type , '-' , b.account_sub_type) as raw_account_type_id,
       a.segment_type,
       c.segment_type as raw_segment_type,
       a.segment_group,
       c.segment_group as raw_segment_group,
       a.segment_subgroup,
       c.segment_subgroup as raw_segment_subgroup,
       a.segment_name,
       c.segment_name as raw_segment_name,
       a.segment_desc,
       c.segment_desc as taw_segment_desc,
       a.segment_origin,
       c.segment_origin as raw_segment_origin,
       a.segment_remark,
       c.segment_remark as raw_segment_remark,
       a.telia_customer,
       c.telia_customer as raw_telia_customer
from   analytics.prod_abt_customer_current a,
       base.import_fokus_base_billing_account b
          left outer join 
       base.manual_files_base_d_segment c
          on a.account_type_id = c.account_type_id
where  a.customer_id = cast(b.ban as bigint)
and    (a.cycle_code <> cast(b.bill_cycle as int)
or      a.agncy_code <> b.col_agncy_code
or      a.ar_balance <> cast(b.ar_balance as bigint)
or      a.delinq_status <> b.col_delinq_status
or      a.delinq_sts_date <> b.col_delinq_sts_date
or      a.credit_class <> b.credit_class
or      a.print_category <> b.bl_prt_category
or      a.start_service_date <> b.start_service_date
or      a.status_last_date <> b.status_last_date
or      cast(a.bl_due_day as bigint) <> b.bl_due_day
or      a.account_type_id <> concat(b.account_type , '-' , b.account_sub_type)
or      a.segment_group <> c.segment_group
or      a.segment_subgroup <> c.segment_subgroup
or      a.segment_name <> c.segment_name
or      a.segment_desc <> c.segment_desc
or      a.segment_origin <> c.segment_origin
or      a.segment_remark <> c.segment_remark
or      a.telia_customer <> c.telia_customer
)
order by 2
;
-- 0 rows - OK - alle med ny cyc_creation_date
-- 0 records - tested   20190417





-- Test 7 ban_pym_mtd tjek
select a.customer_id,
       b.sys_creation_date,
       b.sys_update_date,
       a.payment_method_id,
       b.payment_method as raw_payment_method,
       a.payment_sub_method_id,
       b.payment_sub_method as raw_payment_sub_method,
       a.payment_method_description,
       c.method_desc as raw_payment_method_description
 
from   analytics.prod_abt_customer_current a,
       (select *,
               row_number() over (partition by ban order by expiration_date desc, sys_creation_date desc) row_no
        from  base.import_fokus_base_ban_pym_mtd 
        where expiration_date is not null
        and cast(effective_date as timestamp) < current_timestamp()) b
           left outer join
        base.import_fokus_base_payment_method c
           on a.payment_method_id = c.pym_method
           and a.payment_sub_method_id = c.pym_sub_method
where  a.customer_id = cast(b.ban as bigint)
and    b.row_no=1
and    (a.payment_method_id <> b.payment_method
or      a.payment_sub_method_id <> b.payment_sub_method
or      a.payment_method_description <> c.method_desc
)
order by 2
;
-- 0 rows - OK
-- 0 records - tested 20190417

select a.ban,
       row_number() over (partition by ban order by expiration_date desc, sys_creation_date desc) row_no,
       a.*
from   raw.import_fokus_raw_ban_pym_mtd a
where ban = '833842214'
and   expiration_date is not null
--and   cast(expiration_date as timestamp) > current_timestamp()
;
--GR
select *
from  analytics.prod_abt_customer_current
where customer_id = 110178659
; 
-- den skifter betalings metode over tid


-- Test 8 ban_hier_tree tjek
select a.customer_id,
       b.sys_creation_date,
       b.sys_update_date,
       a.root_customer_id,
       b.tree_root_ban as raw_root_customer_id,
       a.tree_level,
       b.tree_level as raw_tree_level
       
from   analytics.prod_abt_customer_current a,
       (select *,
               row_number() over (partition by ban order by expiration_date desc, sys_creation_date desc) row_no
        from   raw.import_fokus_raw_ban_hierarchy_tree 
        where cast(effective_date as timestamp) < current_timestamp()) b
where  a.customer_id = cast(b.ban as bigint)
and    b.row_no=1
and    (a.root_customer_id <> cast(b.tree_root_ban as bigint)
or      a.tree_level <> cast(b.tree_level as int)


)
order by 2
;
-- 0 rows - OK




-- Test 10 ban_hier_tree ROOT tjek
select a.customer_id,
       a.root_customer_id,
       a.root_cvr_no,
       b.cvr_no,
       b.root_cvr_no
       
from   analytics.prod_abt_customer_current a,
       analytics.prod_abt_customer_current b
where  a.root_customer_id = b.customer_id
and    (cast(a.root_cvr_no as bigint) <> cast(b.cvr_no as bigint))
order by 2
;
-- 38 records with cvr_root diff

select customer_id,
       root_customer_id,
       cvr_no,
       root_cvr_no,
       start_date,
       end_date
from   analytics.prod_abt_customer_current
where  customer_id in (580968501,340161207)
;

select customer_id,
       root_customer_id,
       cvr_no,
       root_cvr_no,
       start_date,
       end_date
from   analytics.prod_abt_customer_current
where  customer_id=340161207
;
 

-- 0 rows - OK



-- Test 9 navn og address info
select a.customer_id,
       --b.sys_creation_date,
       --b.sys_update_date,
       --b.link_type,
       b.name_id,
       b.address_id,
       
       a.gender,
       c.gender as raw_gender,
       a.cpr_no,
       
       a.birth_date,
       c.birth_date as raw_birth_date,
       a.middle_initial,
       c.middle_initial as raw_middle_initial,
       a.first_name,
       c.first_name as raw_first_name,
       a.last_business_name,
       c.last_business_name as raw_last_business_name,
       
       a.ADR_CO_NAME,
       d.ADR_CO_NAME as raw_ADR_CO_NAME,
       a.adr_district,
       d.adr_district as raw_adr_district,
       a.adr_email,
       d.adr_email as raw_email,
       a.adr_door_no,
       d.adr_door_no as raw_adr_door_no,
       a.adr_story,
       d.adr_story as raw_adr_story,
       a.adr_house_letter,
       d.adr_house_letter as raw_adr_house_letter,
       a.adr_country,
       d.adr_country as raw_adr_country,
       a.adr_pob,
       d.adr_pob as raw_adr_pob,
       a.adr_direction,
       d.adr_direction as raw_adr_direction,
       a.adr_street_name,
       d.adr_street_name as raw_adr_street_name,
       a.adr_house_no,
       d.adr_house_no as raw_adr_house_no,
       a.adr_zip,
       d.adr_zip as raw_adr_zip,
       a.adr_city,
       d.adr_city as raw_adr_city,
       a.adr_primary_ln,
       d.adr_primary_ln as raw_adr_primary_ln,
       a.adr_secondary_ln,
       d.adr_secondary_ln as raw_adr_secondary_ln,
       
       a.IDENTIFY,
       c.IDENTIFY as raw_IDENTIFY,
       a.organization_name,
       case when c.middle_initial is not null then c.middle_initial else c.last_business_name end as raw_organization_name,
       a.cvr_no,
       c.comp_reg_id as raw_cvr_no,
       c.middle_initial ,
       a.cpr_no,
       c.identify as raw_identify,
       a.since_date,
       d.since_date as raw_since_date,
       a.additional_title,
       c.additional_title as raw_additional_title,
       a.ACCOMMODATION_TYPE,
       d.ACCOMMODATION_TYPE as raw_ACCOMMODATION_TYPE,
       a.analysis_date,
       a.analysis,
       a.marketing_date,
       a.marketing
 
       
from   analytics.abt_customer_current a,
       raw.import_fokus_raw_address_name_link b,
       raw.import_fokus_raw_name_data c,
       raw.import_fokus_raw_address_data d
where  a.customer_id = cast(b.customer_id as bigint)
and    b.link_type = 'L'
and    (cast(b.expiration_date as timestamp) > current_timestamp() or  b.expiration_date is null)
and    b.name_id = c.name_id
and    b.address_id = d.address_id

and    (a.IDENTIFY <> c.IDENTIFY
or      a.organization_name <> case when c.middle_initial is not null then c.middle_initial else c.last_business_name end
or      a.cvr_no <> c.comp_reg_id
or      a.cpr_no <> c.identify
or      (a.since_date <> d.since_date and a.since_date is not null)
or      a.additional_title <> c.additional_title
or      a.ACCOMMODATION_TYPE <>  d.ACCOMMODATION_TYPE
or      (a.ADR_CO_NAME <> d.ADR_CO_NAME and a.ADR_CO_NAME is not null)
or      a.adr_district <> d.adr_district
or      a.adr_email <> d.adr_email
or      a.adr_door_no <> d.adr_door_no
or      a.adr_story <> d.adr_story
or      a.adr_house_letter <> d.adr_house_letter
or      a.adr_country <> d.adr_country
or      a.adr_pob <> d.adr_pob
or      a.adr_direction <> d.adr_direction
or      a.adr_street_name <> d.adr_street_name
or      a.adr_house_no <> d.adr_house_no
or      a.adr_zip <> d.adr_zip
or      a.adr_city <> d.adr_city 
or      a.adr_primary_ln <> d.adr_primary_ln
or      a.adr_secondary_ln <> d.adr_secondary_ln
-- or      substr(a.gender,1,1) <> c.gender
-- or      a.birth_date <> c.birth_date
or      a.middle_initial <> c.middle_initial
or      a.first_name <> c.first_name
or      a.last_business_name <> c.last_business_name
       
)
order by 2
;
-- 0 rows - OK

select customer_id,
       robinson,
       start_date,
       end_date,
       active_record_flag,
       first_name,
       last_business_name,
       ADR_CO_NAME,
       adr_district,
       adr_email,
       adr_door_no,
       adr_story,
       adr_house_letter,
       adr_country,
       adr_pob,
       adr_direction,
       adr_street_name,
       adr_house_no,
       adr_zip,
       adr_city,
       adr_primary_ln,
       adr_secondary_ln,*
       
from   analytics.abt_customer_current 
where    robinson=1
and     lower(adr_primary_ln) like 'dr s%'
and adr_house_no='40'
order by customer_id
;

-- MARCUS
SELECT *
FROM 
base.manual_files_base_robinson
where lower(street) like 'dr sells vej 29'
;

-- OLE 
select robinson,
       start_date,
       end_date,
       first_name,
       last_business_name,
       *
from   analytics.abt_customer_current 
where  lower(adr_primary_ln) like 'dr sells vej 29'
order by start_date
;


select distinct 
       a.customer_id ,
       a.robinson,
       a.adr_primary_ln,
       a.adr_city,
       a.adr_zip,
       b.his
from   analytics.abt_customer_current a
          left outer join 
       base.manual_files_base_robinson b
          on regexp_replace(a.adr_primary_ln , '[0-9\ ]', '') = regexp_replace(b.street , '[0-9\ ]', '')
          and a.adr_house_no = b.house
          and b.his is null
where  1=1 
and    lower(a.adr_primary_ln) like 'narvikvej 229'
and    a.robinson = 1
and    b.his is null
order by 1,2,3,4,5,6
;


SELECT customer_id,
       robinson,
       *
FROM 
analytics.abt_customer_current
where lower(adr_primary_ln) like 'narvikvej 229'
;


SELECT his,*
FROM 
base.manual_files_base_robinson
where lower(street) like 'narvikvej 229'
;


select  ban,
        effective_date,
        expiration_date,*
from    base.import_fokus_base_ban_pym_mtd a
where   ban in (110365975,210320838,377009501,405061219,405523218,407423219,409423217,409989118,413621210,414523217)
order by ban,
        effective_date,
        expiration_date
;
 
 
 select a.customer_id,
        a.adr_primary_ln,
        a.adr_secondary_ln,
        b.his,
        b.*
 from   analytics.abt_customer_current a,
        base.manual_files_base_robinson b 
 where  a.robinson=1
 and    regexp_replace(a.adr_primary_ln , '[0-9\ ]', '') = regexp_replace(street , '[0-9\ ]', '')
 and    a.adr_house_no = b.house
 and    a.adr_primary_ln = 'Aalborgvej 157'
 and    a.adr_secondary_ln = '9370 Hals, Denmark'
 order by 1,2,3
 ;
 
 select *
 from   analytics.abt_customer_current
 where  adr_primary_ln = 'Aalborgvej 157'
 and    adr_secondary_ln = '9370 Hals, Denmark'
 ;
 
	-- Is digit no 7 in (4,9) and YY greater than 36 then you are born in 19xx
	--Is digit no 7 in (4,9) and YY less than or equal to 36 then you are born in 20xx
	--Is digit no 7 in (5,6,7,8)  and YY less then or equal to 36 then  you are born in 2000
	--Is digit no 7 in (5,6,7,8)  and YY greater then or equal to 58 then  you are born in 18xx
	
 -- Test 20 CPR - find birthdate
select x.*,
       case when x.status = 'OK' then
       	    case when cast(substr(cast(cpr_no as string),7,1) as int) in (0,1,2,3) then cast(substr(cast(cpr_no as string),5,2) as int) + 1900
       	         when cast(substr(cast(cpr_no as string),7,1) as int) in (4,9) and 
       	              cast(substr(cast(cpr_no as string),5,2) as int) > 36 then cast(substr(cast(cpr_no as string),5,2) as int) + 1900
       	         when cast(substr(cast(cpr_no as string),7,1) as int) in (4,9) and 
       	              cast(substr(cast(cpr_no as string),5,2) as int) <= 36 then cast(substr(cast(cpr_no as string),5,2) as int) + 2000
       	         when cast(substr(cast(cpr_no as string),7,1) as int) in (5,6,7,8) and 
       	              cast(substr(cast(cpr_no as string),5,2) as int) <= 36 then cast(substr(cast(cpr_no as string),5,2) as int) + 2000
       	         when cast(substr(cast(cpr_no as string),7,1) as int) in (5,6,7,8) and 
       	              cast(substr(cast(cpr_no as string),5,2) as int) >= 58 then cast(substr(cast(cpr_no as string),5,2) as int) + 1800
	        end 
       end as cpr_birth_date_YEAR
from (
 select a.customer_id,
       a.cpr_no,
       case when cpr_no is null or
                 cast(substr(cast(cpr_no as string),1,2) as int) = 0 or
                 cast(substr(cast(cpr_no as string),1,2) as int)  > 31 or
                 cast(substr(cast(cpr_no as string),3,2) as int) = 0 or
                 cast(substr(cast(cpr_no as string),3,2) as int) > 12
                    then 'ERROR'
            
            when length(cpr_no) = 10 then
            case when mod((cast(substr(cast(cpr_no as string),1,1) as int) *4 +
                   cast(substr(cast(cpr_no as string),2,1) as int) *3 +
                   cast(substr(cast(cpr_no as string),3,1) as int) *2 +
                   cast(substr(cast(cpr_no as string),4,1) as int) *7 +
                   cast(substr(cast(cpr_no as string),5,1) as int) *6 +
                   cast(substr(cast(cpr_no as string),6,1) as int) *5 +
                   cast(substr(cast(cpr_no as string),7,1) as int) *4 +
                   cast(substr(cast(cpr_no as string),8,1) as int) *3 +
                   cast(substr(cast(cpr_no as string),9,1) as int) *2 +
                   cast(substr(cast(cpr_no as string),10,1) as int) *1 ), 11) = 0 then 'OK' 
                 else 'ERROR' 
            end 
       end as status

from   analytics.abt_customer_current a
) x
where status  = 'OK'
order by 4 asc

;

-- test af consent felter

select a.customer_id,
       a.analysis_date,
       a.analysis,
       a.marketing_date,
       a.marketing
from   analytics.abt_customer_current a
where  customer_id = 505740019
;

select *
from   analytics.abt_subscriber_current
where  subscriber_no= 'GSM04540346801'
;

select a.customer_id,
       a.analysis_date,
       a.analysis,
       a.marketing_date,
       a.marketing,
       b.*
from   analytics.abt_customer_current a
          left outer join 
        (select a.customer_id,
                max(case when c.consent_id = '45a8b98e-1505-4a95-ae93-df709fe6a699' then b.change_date end) as raw_analysis_date,
                max(case when c.consent_id = '45a8b98e-1505-4a95-ae93-df709fe6a699' then b.state_id end) as raw_analysis,
                max(case when c.consent_id = '3ec2e83c-ba64-4901-9cbf-56a6850f026d' then b.change_date end) as raw_marketing_date,
                max(case when c.consent_id = '3ec2e83c-ba64-4901-9cbf-56a6850f026d' then b.state_id end) as raw_marketing
        --       b.customer_entity_id,
        --       b.customer_consent_id,
        --       b.state_id,
        --       b.change_date,
        --       c.consent_id,
        --       c.name
        from   raw.import_consent_db_raw_customer_entities a
                    inner join 
               raw.import_consent_db_raw_customer_consents b
                    on a.customer_entity_id = b.customer_entity_id
                    and b.consent_id in ('45a8b98e-1505-4a95-ae93-df709fe6a699','3ec2e83c-ba64-4901-9cbf-56a6850f026d')
                    inner join
               raw.import_consent_db_raw_consents c
                    on b.consent_id = c.consent_id
        group by 1
        ) b
            on a.customer_id = cast(b.customer_id as bigint)
where  1=1 
-- and    a.customer_id = 660149204
and    (a.analysis <> b.raw_analysis or
        a.marketing <> b.raw_marketing or 
        a.analysis_date <> b.raw_analysis_date or 
        a.marketing_date <> b.raw_marketing_date)
;
