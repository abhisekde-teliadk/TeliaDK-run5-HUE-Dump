SELECT DISTINCT *
  FROM (
    SELECT 
        base_detail_usage.call_type AS call_type,
        base_detail_usage.at_feature_code AS at_feature_code,
        base_man_feature_translation.at_feature_code AS ft_at_feature_code,
        base_detail_usage.product_type AS product_type,
        base_detail_usage.call_characteristic_cd AS call_characteristic_cd
      FROM base.import_fokus_base_detail_usage base_detail_usage
      LEFT JOIN base.manual_files_base_man_feature_translation base_man_feature_translation
        ON (coalesce(base_detail_usage.call_type,'xyz!abc') = coalesce(base_man_feature_translation.call_type,'xyz!abc'))
          AND (coalesce(base_detail_usage.at_feature_code,'xyz!abc') = coalesce(base_man_feature_translation.at_feature_code,'xyz!abc'))
          AND (coalesce(base_detail_usage.product_type,'xyz!abc') = coalesce(base_man_feature_translation.product_type,'xyz!abc'))
          AND (coalesce(base_detail_usage.call_characteristic_cd,'xyz!abc') = coalesce(base_man_feature_translation.call_characteristic_cd,'xyz!abc'))
    ) unfiltered_query
  WHERE at_feature_code IS NULL;

select distinct at_feature_code from base.manual_files_base_man_feature_translation order by at_feature_code asc;

select distinct base_detail_usage.call_type AS call_type,
        base_detail_usage.at_feature_code AS at_feature_code,
        --base_man_feature_translation.at_feature_code AS ft_at_feature_code,
        base_detail_usage.product_type AS product_type,
        base_detail_usage.call_characteristic_cd AS call_characteristic_cd FROM base.import_fokus_base_detail_usage base_detail_usage where call_type='D' and base_detail_usage.product_type='GSM' and base_detail_usage.call_characteristic_cd='GPI';
        
        


select * from analytics.abt_missing_feature_translation_info;