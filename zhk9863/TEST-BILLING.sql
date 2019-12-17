SELECT count(*) 
FROM work.base_equation_work_subscribed_product_id 
WHERE 
    p1_product_id is null 
    and p2_product_id is null 
    and p3_product_id is null 
    and p4_product_id is null
    and product_id is null
LIMIT 100;