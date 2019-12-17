-- let's have a look at duplicity lists
select * from finance.abt_circuit_otf where data_quality>1 order by invoice_number, invoice_line;
select * from finance.abt_edi_accounting where data_quality>1 order by invoice_number, invoice_line;
select * from finance.abt_circuit_recon_summary where data_quality>1;

-- let's pick one of the duplicity circuits from accounting report and see how it looks in circuit bridge
select * from finance.abt_circuit_bridge where foreign_circuit = 'EB590259'; -- we found just one record with Telia circuit TN-326363

-- let's have a look to customer bridge
select * from finance.abt_circuit_customer_bridge where telia_circuit_id = 'TN-326363'; -- we see there are two customer numbers for the same TN number in Geneva 2731990 and 1683461

-- let's have a look to Geneva Product and Event source view based on Telia number
select * from base.import_other_sources_base_geneva_product where event_source = 'TN-326363';
select * from base.import_other_sources_base_geneva_event_source where event_source = 'TN-326363';

select * from base.import_other_sources_base_geneva_product where customer_ref in (2731990, 1683461);
select * from base.import_other_sources_base_geneva_event_source where customer_ref in (2731990, 1683461);




select * from finance.abt_edi_accounting where telia_circuit_id = 'TN-326363';

select * from base.import_other_sources_base_edi_extract where tdc_circuit_id = 'EB590259';
select distinct source_billing, segment  from analytics.abt_circuit_customer_bridge  order by source_billing;




select ban, ch.subscriber_no, actv_date, bill_comment, su.internal_circuit_id, su.start_date
from base.import_fokus_base_charge_parquet ch, analytics.abt_subscriber_current su
where ch.subscriber_no = su.subscriber_no and ch.ban = su.customer_id 
and ch.bill_comment <> su.internal_circuit_id
and
(
bill_comment like '%TN-%' 
or bill_comment like '%FB-%'
or bill_comment like '%YB-%'
or bill_comment like '%TR-%'
or bill_comment like '%TF-%'
or bill_comment like '%TD-%'
or bill_comment like '%TC-%'
or bill_comment like '%TB-%'
or bill_comment like '%LLN%'
or bill_comment like '%LLF%'
or bill_comment like '%HX-%'
or bill_comment like '%HN-%'
or bill_comment like '%HK-%'
or bill_comment like '%HE-%'
or bill_comment like '%EB-%'
or bill_comment like '%CO-%'

)
order by su.start_date desc
;





--

select * from work.contr_obligations_tdc_tbt_circuit_tnid_speeds;


select speeds.technology, speeds.speed_down_category, speeds.speed_up_category,
speeds.foreign_circuit, cb.telia_circuit_id, cb.segment_full
from 
finance.abt_circuit_customer_bridge cb
full join 
work.contr_obligations_tdc_tbt_circuit_tnid_speeds speeds
on (cb.telia_circuit_id = speeds.telia_circuit_id)

;


-- heath check: how fresh are our datasets
select * from base.admin_datasets_s3_dates where project_key='CONTR_OBLIGATIONS_TDC' and dataset='abt_circuit_otf' order by last_modified
;

select * from import_neo_base_ddb_dealer;
select * from import_neo_base_sales_agent;


select sa.id sales_agent_id, sa.dealer_id, sa.email, d.dealer_group,d.dealer_name
-- select * 
from import_neo_base_sales_agent sa LEFT JOIN import_neo_base_ddb_dealer d
on sa.dealer_id = d.id ;



select * from base.admin_datasets_s3_dates 
where project_key='BAD_DEBT' and dataset='abt_kisbi_bad_debt_clean' order by last_modified
;


-- 1.1. PSTN - we take counts of unique circuit_ids from EDI with product code 011000
SELECT
--*
 count(*) 
FROM base.import_other_sources_base_edi_extract 
WHERE tdc_product_code = 110000
and account_name NOT LIKE 'DLG%'

;

-- 1.2 ISDN2 - we take counts of unique circuit_ids from EDI  with ISDN2 product names (TDC product codes: 0134200 and 0134700)
SELECT count(distinct tdc_circuit_id) FROM base.import_other_sources_base_edi_extract WHERE tdc_product_code IN (134200, 134700)
and account_name NOT LIKE 'DLG%'
;

-- 1.3 We look for unique subscriptions in in KISBI-Geneva with ISDN30 product.
-- KISBI GENEVA
select * from base.import_other_sources_base_geneva_product;

SELECT count(distinct customer_ref) from base.import_other_sources_base_geneva_product WHERE 
--- product_name LIKE '%ISDN30%'
product_id IN (312, 739, 1430, 1555, 1556, 1557, 1558, 1602, 1604, 1605, 1606, 1607, 1608, 2640) ;
-- TODO: we need to add info from wholeasale providers which is troed in SAP, contact: Lene Damgaard
-- FOKUS to be counted? Question for Lene
SELECT count(distinct customer_id) from analytics.abt_subscriber_current where product_product_desc like '%ISDN 30%' OR product_product_desc like '%ISDN30%'
;

-- 1.4 FlexISDN we take counts of unique numbers from Kisbi/Geneva database
SELECT count(distinct customer_ref) from base.import_other_sources_base_geneva_product WHERE 
-- product_name LIKE '%FlexiISDN%'
product_id IN (1458)

;
-- 1.5 FlexISDN we take counts of unique numbers from Kisbi/Geneva database
SELECT count(distinct customer_ref) from base.import_other_sources_base_geneva_product WHERE 
product_id IN (1799, 1800, 1801, 1802)
;


-- 1.6 abonnementslinjer FLEX ISDN

-- 1.6. The total amount is given by calculation specified in Telestatistikken Excel

-- I would not recommend this approach as it is only a loose estimate. Instead you should count each number underlaying number under each main subscription.

-- 1.7, we take unique circuit numbers from Bruce that has VOIP included in the subscription talk to Michael Kristensen about it. I have a way to do it, but it might not be the smartest.
-- TODO: Count from Bruce and Fokus

-- 1.8.  Ignore 1.8 as there are only a fex handful with out QoS.

-- 1.9 - Dialup internet (no info)

-- 1.10 - Number porting - I will get in touch with Bo for further specification
-- I met with Bo and it seems we can get it from ICH numberporting dataset, still needs validation
;
select count(*) from sensitive_porting.ich_number_porting_raw_ich_np_transactions 
where oldnumbertype = 'FIXED' 
and strleft(sentdate,6) in ('201901', '201902', '201903','201904', '201905', '201906')
-- and donornetworkoperator = '..code for Telia.. ' -- Telia?
;


select * from base.import_bpm_base_techinfodb_coax;


select * from base.import_bpm_base_techinfodb_datanet;
;
select * from base.import_other_sources_base_tnid_extract
;


    select strleft(forreign_circuit,2) technology,
    case
        when (cast(speed_down as int) / 1024) >= 0.144 AND (cast(speed_down as int) / 1024) < 2 then 'speed_144_2'
        when (cast(speed_down as int) / 1024) >= 2 AND (cast(speed_down as int) / 1024) < 10 then 'speed_2_10'
        when (cast(speed_down as int) / 1024) >= 10 AND (cast(speed_down as int) / 1024) < 30 then 'speed_10_30'
        when (cast(speed_down as int) / 1024) >= 30 AND (cast(speed_down as int) / 1024) < 50 then 'speed_30_50'
        when (cast(speed_down as int) / 1024) >= 50 AND (cast(speed_down as int) / 1024) < 100 then 'speed_50_100'
        when (cast(speed_down as int) / 1024) >= 100 AND (cast(speed_down as int) / 1024) < 300 then 'speed_100_300'
        when (cast(speed_down as int) / 1024) >= 300 AND (cast(speed_down as int) / 1024) < 500 then 'speed_300_500'
        when (cast(speed_down as int) / 1024) >= 500 AND (cast(speed_down as int) / 1024) < 1024 then 'speed_500_1Gb'
        when (cast(speed_down as int) / 1024) >= 1024 then 'speed_1Gb_plus'
        when (cast(speed_down as int) / 1024) is null then 'speed_undefined'
    end as speed_down_category,
    
    case
        when (cast(speed_up as int) / 1024) >= 0.144 AND (cast(speed_up as int) / 1024) < 2 then 'speed_144_2'
        when (cast(speed_up as int) / 1024) >= 2 AND (cast(speed_up as int) / 1024) < 10 then 'speed_2_10'
        when (cast(speed_up as int) / 1024) >= 10 AND (cast(speed_up as int) / 1024) < 30 then 'speed_10_30'
        when (cast(speed_up as int) / 1024) >= 30 AND (cast(speed_up as int) / 1024) < 50 then 'speed_30_50'
        when (cast(speed_up as int) / 1024) >= 50 AND (cast(speed_up as int) / 1024) < 100 then 'speed_50_100'
        when (cast(speed_up as int) / 1024) >= 100 AND (cast(speed_up as int) / 1024) < 300 then 'speed_100_300'
        when (cast(speed_up as int) / 1024) >= 300 AND (cast(speed_up as int) / 1024) < 500 then 'speed_300_500'
        when (cast(speed_up as int) / 1024) >= 500 AND (cast(speed_up as int) / 1024) < 1024 then 'speed_500_1Gb'
        when (cast(speed_up as int) / 1024) >= 1024 then 'speed_1Gb_plus'
        when (cast(speed_up as int) / 1024) is null then 'speed_undefined'
    end as speed_up_category,
    
    *
    
    from
    
        (
        select
            telia_circuit_id,
            forreign_circuit,
            if(profile_down_speed<>'undef', profile_down_speed,if(access_down_speed<>'undef',access_down_speed,actual_down_speed )) speed_down,
            if(profile_up_speed<>'undef', profile_up_speed,if(access_up_speed<>'undef',access_up_speed,actual_up_speed )) speed_up
        --    nvl(nvl(profile_up_speed,access_up_speed ), actual_up_speed) speed_up
        
            from    
            (
            select 
            tnid_circuit_number telia_circuit_id,
            tnid_foreign_reference forreign_circuit,
            tnid_profile_speed, -- what was provided or sold, this is the highest priority, then access then actual
            tnid_access_speed, -- flex related speed
            tnid_actual_speed, -- what was measured
            
            strleft(tnid_profile_speed, instr(tnid_profile_speed, '/')-1)  profile_down_speed, 
            strright(tnid_profile_speed,length(tnid_profile_speed) -  instr(tnid_profile_speed, '/')) profile_up_speed,
            
            
            strleft(tnid_access_speed, instr(tnid_access_speed, '/')-1) access_down_speed, 
            strright(tnid_access_speed,length(tnid_access_speed) -  instr(tnid_access_speed, '/')) access_up_speed,
            
            
            strleft(tnid_actual_speed, instr(tnid_actual_speed, '/')-1) actual_down_speed, 
            strright(tnid_actual_speed,length(tnid_actual_speed) -  instr(tnid_actual_speed, '/')) actual_up_speed
            
            from base.import_other_sources_base_tnid_extract
            ) priority_speed
        ) clean_speed


-- where technology = 'CN'
;


select *
from base.import_other_sources_base_tnid_extract

where strleft(tnid_circuit_number,2) = 'YB'
;

select count(*) --, count(tnid_access_speed is null)
from base.import_other_sources_base_tnid_extract
where tnid_access_speed not like '%undef%'
;