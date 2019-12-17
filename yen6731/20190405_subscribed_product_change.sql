SELECT *
  FROM (
    SELECT 
        ban AS ban,
        subscriber_no AS subscriber_no,
        subscriber_id AS subscriber_id,
        soc AS soc,
        campaign AS campaign,
        product_id AS product_id,
        effective_date AS effective_date,
        promotion AS promotion,
        LAG(soc, 1) OVER (PARTITION BY ban, subscriber_no ORDER BY effective_date ASC) AS soc_lag,
        LAG(campaign, 1) OVER (PARTITION BY ban, subscriber_no ORDER BY effective_date ASC) AS campaign_lag,
        LAG(product_id, 1) OVER (PARTITION BY ban, subscriber_no ORDER BY effective_date ASC) AS product_id_lag,
        LAG(promotion, 1) OVER (PARTITION BY ban, subscriber_no ORDER BY effective_date ASC) AS promotion_lag
      FROM work.base_equation_product_tbt_subscribed_product_history where ban in (851037119) and subscriber_no='GSM04520192324' --979932217
    ) unfiltered_query
  WHERE (product_id != product_id_lag OR product_id IS NULL AND product_id_lag IS NOT NULL OR product_id IS NOT NULL AND product_id_lag IS NULL) AND (product_id_lag != '' OR product_id_lag IS NULL AND '' IS NOT NULL OR product_id_lag IS NOT NULL AND '' IS NULL) AND product_id_lag IS NOT NULL