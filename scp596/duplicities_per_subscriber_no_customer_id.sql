select subscriber_id, subscriber_no, customer_id as change_subscriber_id, change_date, next_change_date 
from 
(
select 
        subscriber_id, subscriber_no, customer_id, change_date, lag(change_date,1) over 
        (partition by subscriber_id order by change_date desc) as next_change_date
    from (
select distinct 
            subscriber_id, 
            trunc(change_date,'DD') + interval 1 day - interval 2 second as change_date,
            x.subscriber_no, x.customer_id
        from 
        (  
            --Subcriber_history effective date as change date    
            select 
                subscriber_no, customer_id, effective_date as change_date
            from  base.import_fokus_base_subscriber_history
            --where subscriber_no = 'GSM04526332284' and customer_id = 966679706
            
            union
            --Subcriber_history expiration date as change date 
            select 
                subscriber_no, customer_id, 
                case 
                    when expiration_date = cast('9999-12-31' as timestamp) then expiration_date
                else 
                    expiration_date + interval 1 day
                end    
                as change_date
            from  base.import_fokus_base_subscriber_history
            --where subscriber_no = 'GSM04526332284' and customer_id = 966679706
           /* 
            union
            
            --Service agreement effective date as change date
            select
                subscriber_no, ban as customer_id, effective_date as change_date
            from
                base.import_fokus_base_service_agreement
            where
                service_type in ('P', 'M', 'N')
            
            union
            
            --Service agreement expiration date as change date
            select
                subscriber_no, ban as customer_id, 
                case 
                    when expiration_date = cast('9999-12-31' as timestamp) then expiration_date
                else 
                    expiration_date + interval 1 day
                end    
                as change_date
            from
                base.import_fokus_base_service_agreement
            where
                service_type in ('P', 'M', 'N')
            
             union
            
            --Physical device effective date as change date
            select
                subscriber_no, customer_id, effective_date as change_date
            from
                base.import_fokus_base_physical_device
            where
                device_type in ('E', 'H')
            
            union
            
            --Physical device expiration date as change date
            select
                subscriber_no, customer_id, 
                case 
                    when expiration_date is null then cast('9999-12-31' as timestamp) 
                    when expiration_date = cast('9999-12-31' as timestamp) then cast(expiration_date as timestamp)
                    else
                        cast(expiration_date as timestamp) + interval 1 day
                end    
                as change_date
            
            from
                base.import_fokus_base_physical_device
            where
                device_type in ('E', 'H')
            
             union
            
            --Address effective date as change date
            select
                subscriber_no, customer_id, effective_date as change_date
            from
                base.import_fokus_base_address_name_link
            where
                link_type in ('U')
            
            union
            
            --Address expiration date as change date
            select
                subscriber_no, customer_id, 
                case 
                    when expiration_date is null then cast('9999-12-31' as timestamp) 
                    when expiration_date = cast('9999-12-31' as timestamp) then expiration_date
                    else
                        expiration_date + interval 1 day
                end    
                as change_date
            from
                base.import_fokus_base_address_name_link
            where
                link_type in ('U')
           
            union
            
            --BAN hierarchy effective date as change date
            select
                subscriber_no, customer_id, change_date
            from
                temp.base_equation_tmp_ban_hierarchy_tree_subs_effective  
            
            union
            
             --BAN hierarchy effective date as change date
            select
                subscriber_no, customer_id, change_date
            from
                temp.base_equation_tmp_ban_hierarchy_tree_subs_expiration
            
            */
        )x
        
        -- join with subscriber entity to get subscriber_id
        join 
            base.import_fokus_base_subscriber s
        on
            x.subscriber_no = s.subscriber_no and
            x.customer_id = s.customer_id
            
    --where s.subscriber_id = 10157292
    )y
    )z where change_date < now()
    and subscriber_id = 10157292;   
    
    select * from base.import_fokus_base_subscriber 
    where 
    subscriber_no = 'GSM04526332284' and customer_id = 966679706;
    
    select * from base.import_fokus_base_subscriber 
    where 
    subscriber_id = 11126499;
    
    select * from base.import_fokus_base_subscriber 
    where 
    subscriber_id = 10157292;
    
     select * from base.import_fokus_base_subscriber_history
    where 
    subscriber_no = 'GSM04526332284' and customer_id = 966679706;
    
    
    GSM04526332284 966679706
    GSM04526332284 966679706 
    
    select subscriber_id, subscriber_no, customer_id, * from (
    select * from base.import_fokus_base_subscriber 
    union
    select * from base.import_fokus_base_subscriber_history 
    ) x 
    where subscriber_id in (11126499,10157292);
    