
SELECT    sum(no_of_subs)
        , count(customer_id)
        , (sum(no_of_subs) / count(customer_id) ) as average_churned_subs_per_ban

FROM        (
               SELECT      count(subscriber_id) as no_of_subs
                       ,    customer_id

               FROM sandbox.churn_prevention_one_apply_filters_prepared
               
               WHERE       product_group = 'Postpaid BtC'
                       and budget_product IN ('ONE', 'ONE MORE')
--                       and product_life_time < 180
               GROUP BY        customer_id
            ) as q
            
;


select *
FROM prod_abt_intake_kpi
where cust_adr_primary_ln LIKE ('Dalstrøget 147, 01. tv.')
;