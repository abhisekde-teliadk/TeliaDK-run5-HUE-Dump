select * from work.crt_customer

 where lower(street) = lower('Kvædehaven 10'); -- not in robinson => should be set to 0
 --  where lower(street) = lower('Dr Sells Vej 29'); -- is in robinson => should be set to 1
 
 select * from base.manual_files_base_robinson
 where lower(street) = lower('Kvædehaven 10');
 
 
 select * from base.manual_files_base_robinson where surname='Nielsen' and firstname like 'Hanne Mel%';
 
 SELECT 
    ban AS ban,
    account_start_date AS account_start_date,
    last_name AS last_name,
    first_name AS first_name,
    segment_name AS segment_name,
    eboks AS eboks,
    account_type AS account_type,
    name AS name,
    street AS street,
    postcode AS postcode,
    mob_flag AS mob_flag,
    bb_flag AS bb_flag,
    master_user_ban AS master_user_ban,
    extra_user_ban AS extra_user_ban,
    case when street is not null then 1 else 0 end AS robinson_legal,
    case when mob_flag is not null then 1 else 0 end AS hh_has_telia_bb,
    case when bb_flag is not null then 1 else 0 end AS hh_has_telia_mobile
  FROM (
    SELECT 
        customer1.ban AS ban,
        customer1.account_start_date AS account_start_date,
        customer1.last_business_name AS last_name,
        customer1.first_name AS first_name,
        customer1.segment_name AS segment_name,
        customer1.eboks AS eboks,
        customer1.account_type AS account_type,
        customer1.name AS name,
        work_robinson_deduplicated.street AS street,
        work_robinson_deduplicated.postcode AS postcode,
        work_customer_mob_bb_flag.flag AS mob_flag,
        work_customer_mob_bb_flag_2.flag AS bb_flag,
        work_customer_sa.master_user_pp_cnt AS master_user_ban,
        work_customer_sa.extra_user_ban AS extra_user_ban
      FROM (
        SELECT 
            ban AS ban,
            account_start_date AS account_start_date,
            credit_class AS credit_class,
            bl_prt_category AS bl_prt_category,
            account_type_id AS account_type_id,
            adr_primary_ln AS adr_primary_ln,
            adr_zip AS adr_zip,
            adr_house_no AS adr_house_no,
            adr_street_name AS adr_street_name,
            last_business_name AS last_business_name,
            first_name AS first_name,
            description AS description,
            segment_name AS segment_name,
            eboks AS eboks,
            account_type AS account_type,
            concat(coalesce(first_name,''),' ',coalesce(last_business_name,'')) AS name,
            concat(concat(adr_street_name, ' '),adr_house_no) AS street_name_house_no
          FROM (
            SELECT *
              FROM work.crt_customer1 customer1
            ) withoutcomputedcols_query
        ) customer1
      LEFT JOIN work.crt_work_robinson_deduplicated work_robinson_deduplicated
        ON (customer1.street_name_house_no = work_robinson_deduplicated.street)
          AND (customer1.adr_zip = work_robinson_deduplicated.postcode)
      LEFT JOIN (
        SELECT work_customer_mob_bb_flag.*
          FROM work.crt_work_customer_mob_bb_flag work_customer_mob_bb_flag
          WHERE type = 'mob'
        ) work_customer_mob_bb_flag
        ON customer1.ban = work_customer_mob_bb_flag.ban
      LEFT JOIN (
        SELECT work_customer_mob_bb_flag_2.*
          FROM work.crt_work_customer_mob_bb_flag work_customer_mob_bb_flag_2
          WHERE type = 'bb'
        ) work_customer_mob_bb_flag_2
        ON customer1.ban = work_customer_mob_bb_flag_2.ban
      LEFT JOIN (
        SELECT 
            ban AS ban,
            extra_user_pp_cnt AS extra_user_pp_cnt,
            master_user_pp_cnt AS master_user_pp_cnt,
            extra_user_soc_cnt AS extra_user_soc_cnt,
            extra_user_pp_cnt + extra_user_soc_cnt AS extra_user_ban
          FROM (
            SELECT *
              FROM work.crt_work_customer_sa work_customer_sa
            ) withoutcomputedcols_query
        ) work_customer_sa
        ON customer1.ban = work_customer_sa.ban
    ) withoutcomputedcols_query
    ;
    
 select * from work.crt_work_robinson_deduplicated where street='Nyborgvej 108';
 
 select street, count(*) from work.crt_customer group by street having count(*)>4 order by 2 asc;