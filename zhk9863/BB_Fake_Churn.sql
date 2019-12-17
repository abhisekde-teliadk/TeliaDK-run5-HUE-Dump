SELECT distinct product_type FROM manual_files_base_d_product
WHERE product_type <> 'GSM'
;


SELECT sub1.customer_id, 

        sub1.subscriber_no s1, 
        sub1.subscriber_id sid1,
        sub2.subscriber_no s2, 
        sub2.subscriber_id sid2,
        sub1.sales_date s1_sales,
        sub1.churn_date s1_churn,
        sub2.sales_date s2_sales,
        datediff(sub2.sales_date, sub1.churn_date) diff

FROM 
analytics.abt_subscriber_current sub1,
analytics.abt_subscriber_current sub2

WHERE 
    sub1.status = 'd' 
    and sub2.status in ('a', 'r')
    -- and sub1.customer_id = sub2.customer_id
    and sub1.customer_id = sub2.customer_id
    -- and sub1.subscriber_no like 'LL%'
    -- and sub2.subscriber_no like 'LL%'
    and strleft( sub1.subscriber_no, 3) <> 'GSM'

    and strleft( sub1.subscriber_no, 3) = strleft( sub2.subscriber_no, 3)


    -- and datediff(sub1.churn_date, sub1.sales_date) > 0 
    and datediff(sub1.churn_date, sub1.sales_date) < 20
    
    and datediff(sub2.sales_date, sub1.churn_date) < 90
    and datediff(sub2.sales_date, sub1.sales_date) >0
    
ORDER BY sub2.sales_date DESC
;