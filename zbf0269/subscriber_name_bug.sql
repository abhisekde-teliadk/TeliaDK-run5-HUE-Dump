set request_pool=big;
SELECT 
    --kpi.start_date, kpi.end_date,
    kpi.subscriber_id,
    kpi.subscriber_no,
    kpi.customer_id,
    kpi.churn_date,
    kpi.last_business_name,
    nd.last_business_name,
    cnd.last_business_name,
    kpi.first_name,
    nd.first_name,
    cnd.first_name,
    1
    --kpi.* 
    FROM 
        work.base_equation_kpis_work_churn_kpi_fat kpi
        join base.import_fokus_base_address_name_link anl on    
            anl.link_type = 'U' and
            anl.customer_id = kpi.customer_id and
            anl.subscriber_no = kpi.subscriber_no and
            kpi.churn_date between anl.adr_effective_date_join and nvl(anl.adr_expiration_date_join, kpi.churn_date)
        join base.import_fokus_base_name_data nd on
            nd.name_id = anl.name_id
        
        join base.import_fokus_base_address_name_link canl on    
            canl.link_type = 'L' and
            canl.customer_id = kpi.customer_id and
            kpi.churn_date between canl.effective_date and nvl(canl.expiration_date, kpi.churn_date)
        join base.import_fokus_base_name_data cnd on
            cnd.name_id = canl.name_id
        
        where   
            kpi.sub_first_name !=nd.first_name or kpi.sub_last_business_name!=nd.last_business_name
        LIMIT 100;

select * from work.base_equation_sub_tbt_subscriber_history where subs--13119866	GSM04528568853	492400015