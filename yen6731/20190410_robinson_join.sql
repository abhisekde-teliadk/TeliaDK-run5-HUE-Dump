SELECT 
    /*start_date AS start_date,
    end_date AS end_date,
    adr_link_seq_no AS adr_link_seq_no,
    adr_expiration_date AS adr_expiration_date,
    adr_effective_date AS adr_effective_date,*/
    adr_secondary_ln AS adr_secondary_ln,
    adr_primary_ln AS adr_primary_ln,
    adr_street_name_join AS adr_street_name_join,
   /* adr_city AS adr_city,
    adr_zip AS adr_zip,
    adr_house_no AS adr_house_no,
    adr_street_name AS adr_street_name,
    adr_direction AS adr_direction,
    adr_pob AS adr_pob,
    adr_country AS adr_country,
    adr_house_letter AS adr_house_letter,
    adr_story AS adr_story,
    adr_door_no AS adr_door_no,
    adr_email AS adr_email,
    since_date AS since_date,
    adr_district AS adr_district,
    accommodation_type AS accommodation_type,
    adr_co_name AS adr_co_name,*/
    last_business_name AS last_business_name,
    first_name AS first_name,
   /* additional_title AS additional_title,
    birth_date AS birth_date,
    identify AS identify,
    cvr_no AS cvr_no,
    middle_initial AS middle_initial,
    gender AS gender,
    tree_root_ban AS tree_root_ban,
    hier_effective_date AS hier_effective_date,
    hier_sys_creation_date AS hier_sys_creation_date,
    tree_level AS tree_level,
    hier_expiration_date AS hier_expiration_date,
    ban_entry_seq_no AS ban_entry_seq_no,
    payment_method AS payment_method,
    payment_sub_method_id AS payment_sub_method_id,
    pym_effective_date AS pym_effective_date,
    pym_expiration_date AS pym_expiration_date,
    ban AS ban,
    ar_balance AS ar_balance,
    ban_status AS ban_status,
    status_last_date AS status_last_date,
    start_service_date AS start_service_date,
    col_delinq_status AS col_delinq_status,
    col_delinq_sts_date AS col_delinq_sts_date,
    col_agncy_code AS col_agncy_code,
    credit_class AS credit_class,
    bill_cycle AS bill_cycle,
    bl_prt_category AS bl_prt_category,
    bl_due_day AS bl_due_day,
    customer_id AS customer_id,
    customer_telno AS customer_telno,
    employment_type AS employment_type,
    marketing_state_id AS marketing_state_id,
    marketing_change_date AS marketing_change_date,
    profiling_state_id AS profiling_state_id,
    profiling_change_date AS profiling_change_date,
    organization_name AS organization_name,
    account_type_id AS account_type_id,
    cpr_no AS cpr_no,
    surname AS surname,
    firstname AS firstname,
    city AS city,*/
    street AS street,
   /* postcode AS postcode,
    root_last_business_name AS root_last_business_name,
    root_identify AS root_identify,
    root_cvr_no AS root_cvr_no,
    root_middle_initial AS root_middle_initial,*/
    case when (street is not null ) then 1 else 0 end AS robinson,
    case when root_cvr_no is null or root_middle_initial is not null 
then 
    root_identify
else
    null
end AS root_cpr_no,
    nvl(root_middle_initial, root_last_business_name) AS root_organization_name,
    case 
when cpr_no is null or
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
               cast(substr(cast(cpr_no as string),10,1) as int) *1 ), 11) = 0 then 'OK' else 'ERROR'
               end    
   else 'ERROR'         
end AS cpr_no_status
  FROM (
    SELECT 
        work_customer_hist.start_date AS start_date,
        work_customer_hist.end_date AS end_date,
        work_customer_hist.adr_link_seq_no AS adr_link_seq_no,
        work_customer_hist.adr_expiration_date AS adr_expiration_date,
        work_customer_hist.adr_effective_date AS adr_effective_date,
        work_customer_hist.adr_secondary_ln AS adr_secondary_ln,
        work_customer_hist.adr_primary_ln AS adr_primary_ln,
        work_customer_hist.adr_city AS adr_city,
        work_customer_hist.adr_zip AS adr_zip,
        work_customer_hist.adr_house_no AS adr_house_no,
        work_customer_hist.adr_street_name AS adr_street_name,
        work_customer_hist.adr_direction AS adr_direction,
        work_customer_hist.adr_pob AS adr_pob,
        work_customer_hist.adr_country AS adr_country,
        work_customer_hist.adr_house_letter AS adr_house_letter,
        work_customer_hist.adr_story AS adr_story,
        work_customer_hist.adr_door_no AS adr_door_no,
        work_customer_hist.adr_email AS adr_email,
        work_customer_hist.since_date AS since_date,
        work_customer_hist.adr_district AS adr_district,
        work_customer_hist.accommodation_type AS accommodation_type,
        work_customer_hist.adr_co_name AS adr_co_name,
        work_customer_hist.last_business_name AS last_business_name,
        work_customer_hist.first_name AS first_name,
        work_customer_hist.additional_title AS additional_title,
        work_customer_hist.birth_date AS birth_date,
        work_customer_hist.identify AS identify,
        work_customer_hist.cvr_no AS cvr_no,
        work_customer_hist.middle_initial AS middle_initial,
        work_customer_hist.gender AS gender,
        work_customer_hist.tree_root_ban AS tree_root_ban,
        work_customer_hist.hier_effective_date AS hier_effective_date,
        work_customer_hist.hier_sys_creation_date AS hier_sys_creation_date,
        work_customer_hist.tree_level AS tree_level,
        work_customer_hist.hier_expiration_date AS hier_expiration_date,
        work_customer_hist.ban_entry_seq_no AS ban_entry_seq_no,
        work_customer_hist.payment_method AS payment_method,
        work_customer_hist.payment_sub_method AS payment_sub_method_id,
        work_customer_hist.pym_effective_date AS pym_effective_date,
        work_customer_hist.pym_expiration_date AS pym_expiration_date,
        work_customer_hist.ban AS ban,
        work_customer_hist.ar_balance AS ar_balance,
        work_customer_hist.ban_status AS ban_status,
        work_customer_hist.status_last_date AS status_last_date,
        work_customer_hist.start_service_date AS start_service_date,
        work_customer_hist.col_delinq_status AS col_delinq_status,
        work_customer_hist.col_delinq_sts_date AS col_delinq_sts_date,
        work_customer_hist.col_agncy_code AS col_agncy_code,
        work_customer_hist.credit_class AS credit_class,
        work_customer_hist.bill_cycle AS bill_cycle,
        work_customer_hist.bl_prt_category AS bl_prt_category,
        work_customer_hist.bl_due_day AS bl_due_day,
        work_customer_hist.customer_id AS customer_id,
        work_customer_hist.customer_telno AS customer_telno,
        work_customer_hist.employment_type AS employment_type,
        work_customer_hist.marketing_state_id AS marketing_state_id,
        work_customer_hist.marketing_change_date AS marketing_change_date,
        work_customer_hist.profiling_state_id AS profiling_state_id,
        work_customer_hist.profiling_change_date AS profiling_change_date,
        work_customer_hist.organization_name AS organization_name,
        work_customer_hist.account_type_id AS account_type_id,
        work_customer_hist.adr_street_name_join AS adr_street_name_join,
        work_customer_hist.cpr_no_clean AS cpr_no,
        
        work_robinson_deduplicated.street AS street,
       
        work_robinson_deduplicated.postcode AS postcode,
        work_address.last_business_name AS root_last_business_name,
        work_address.identify AS root_identify,
        work_address.comp_reg_id AS root_cvr_no,
        work_address.middle_initial AS root_middle_initial
      FROM (
        SELECT 
            start_date AS start_date,
            end_date AS end_date,
            adr_link_seq_no AS adr_link_seq_no,
            adr_expiration_date AS adr_expiration_date,
            adr_effective_date AS adr_effective_date,
            adr_secondary_ln AS adr_secondary_ln,
            adr_primary_ln AS adr_primary_ln,
            adr_city AS adr_city,
            adr_zip AS adr_zip,
            adr_house_no AS adr_house_no,
            adr_street_name AS adr_street_name,
            adr_direction AS adr_direction,
            adr_pob AS adr_pob,
            adr_country AS adr_country,
            adr_house_letter AS adr_house_letter,
            adr_story AS adr_story,
            adr_door_no AS adr_door_no,
            adr_email AS adr_email,
            since_date AS since_date,
            adr_district AS adr_district,
            accommodation_type AS accommodation_type,
            adr_co_name AS adr_co_name,
            last_business_name AS last_business_name,
            first_name AS first_name,
            additional_title AS additional_title,
            birth_date AS birth_date,
            identify AS identify,
            cvr_no AS cvr_no,
            middle_initial AS middle_initial,
            gender AS gender,
            tree_root_ban AS tree_root_ban,
            hier_effective_date AS hier_effective_date,
            hier_sys_creation_date AS hier_sys_creation_date,
            tree_level AS tree_level,
            hier_expiration_date AS hier_expiration_date,
            ban_entry_seq_no AS ban_entry_seq_no,
            payment_method AS payment_method,
            payment_sub_method AS payment_sub_method,
            pym_effective_date AS pym_effective_date,
            pym_expiration_date AS pym_expiration_date,
            ban AS ban,
            account_type AS account_type,
            account_sub_type AS account_sub_type,
            ar_balance AS ar_balance,
            ban_status AS ban_status,
            status_last_date AS status_last_date,
            start_service_date AS start_service_date,
            col_delinq_status AS col_delinq_status,
            col_delinq_sts_date AS col_delinq_sts_date,
            col_agncy_code AS col_agncy_code,
            credit_class AS credit_class,
            bill_cycle AS bill_cycle,
            bl_prt_category AS bl_prt_category,
            bl_due_day AS bl_due_day,
            customer_id AS customer_id,
            customer_telno AS customer_telno,
            employment_type AS employment_type,
            marketing_state_id AS marketing_state_id,
            marketing_change_date AS marketing_change_date,
            profiling_state_id AS profiling_state_id,
            profiling_change_date AS profiling_change_date,
            cpr_no AS cpr_no,
            organization_name AS organization_name,
            account_type_id AS account_type_id,
            concat(concat(adr_street_name, ' '),adr_house_no) AS adr_street_name_join,
            regexp_replace(cpr_no, " ", "") AS cpr_no_clean
          FROM (
            SELECT *
              FROM work.base_equation_sub_work_customer_hist work_customer_hist
            ) withoutcomputedcols_query
        ) work_customer_hist
      LEFT JOIN work.base_equation_sub_work_robinson_deduplicated work_robinson_deduplicated
        ON --(work_customer_hist.first_name = work_robinson_deduplicated.firstname)
          --AND (work_customer_hist.last_business_name = work_robinson_deduplicated.surname)
          (lower(work_customer_hist.adr_street_name_join) = lower(work_robinson_deduplicated.street))
          AND (work_customer_hist.adr_zip = work_robinson_deduplicated.postcode)
      LEFT JOIN (
        SELECT work_address.*
          FROM work.base_equation_sub_work_address work_address
          WHERE link_type = 'L'
        ) work_address
        ON (work_customer_hist.tree_root_ban = work_address.customer_id)
          AND (work_customer_hist.start_date >= work_address.adr_effective_date_join)
          AND (work_customer_hist.start_date <= work_address.adr_expiration_date_join)
    ) withoutcomputedcols_query
    where lower(adr_primary_ln) = lower('lundtoftevej 150'); -- not in robinson => should be set to 0
   --where lower(adr_primary_ln) = lower('Dr Sells Vej 29'); -- is in robinson => should be set to 1