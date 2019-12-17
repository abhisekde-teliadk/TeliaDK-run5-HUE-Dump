with
cal as (
    select distinct
        year,
        month,
        start_of_month,
        end_of_month
    from
        base.manual_files_base_man_d_calendar
    ),
stock_product_change_to as (
    select 
        year,
		month,
        KPI.to_product_id as product_id,
        count ( distinct KPI.Subscriber_id) as number_of_subscriptions
    from
      cal join
      analytics.abt_migration_kpi as KPI on
        KPI.migration_date>=cal.start_of_month and 
        KPI.migration_date<=cal.end_of_month
         group by year, month, KPI.to_product_id
    ),
stock_product_change_from as (
    select 
        year, month,
        KPI.from_product_id as product_id,
        count ( distinct KPI.Subscriber_id) as number_of_subscriptions
    from
      cal join
      analytics.abt_migration_kpi as KPI on
        KPI.migration_date>=cal.start_of_month and 
        KPI.migration_date<=cal.end_of_month
         group by year, month, KPI.from_product_id
    ),    
stock_activations as (
    select 
        year, month,
        KPI.Product_ID as product_id,
        count ( distinct KPI.Subscriber_id) as number_of_subscriptions
    from
      cal join
      analytics.abt_intake_kpi as KPI on
        KPI.`date`>=cal.start_of_month and 
        KPI.`date`<=cal.end_of_month
         group by year, month, KPI.product_id
    ),
stock_closing_stock as (
    select 
        year, month,
        KPI.Product_ID as product_id,
        sum(KPI.subs_qty) as number_of_subscriptions
    from
      cal join
      analytics.abt_stock_kpi as KPI on
        KPI.stock_date=trunc(cal.end_of_month,'dd')
         group by year, month, KPI.product_id
    ),
stock_annulments as (
    select 
        year, month,
        KPI.Product_ID as product_id,
        count ( distinct KPI.Subscriber_id) as number_of_subscriptions
    from
      cal join
      analytics.abt_annulment_kpi as KPI on
        KPI.annulment_date>=cal.start_of_month and 
        KPI.annulment_date<=cal.end_of_month
         group by year, month, KPI.product_id
    ),
stock_churn as (
    select 
        year, month,
        KPI.Product_ID as product_id,
        count ( distinct KPI.Subscriber_id) as number_of_subscriptions
    from
      cal join
      analytics.abt_churn_kpi as KPI on
        KPI.churn_date>=cal.start_of_month and 
        KPI.churn_date<=cal.end_of_month
         group by year, month, KPI.product_id
    ),
res as (
    select 
        --toString(cal.year)+if(length(toString(cal.month))==1,'0'+toString(cal.month),toString(cal.month)) as month,
        --if(length(cast (cal.month as string))==1)
        concat(cast (cal.year as string),decode(cast (cal.month as string), "1", "01", "2", "02", "3", "03", "4", "04", "5", "05", "6", "06", "7", "07", "8", "08", "9", "09", cast (cal.month as string))) as month,
        --, concat('0',(cast (cal.month as string))) as tmpmonth
        --concat(cast (cal.year as string), if(length(cast (cal.month as string))==1, concat('0',(cast (cal.month as string))))) as month,
        --cal.month,
        product.product_id,
        product.product_line,
        product.product_group,
        product.product_subgroup,
        product.product_desc,
        product.soc,
        product.budget_product,
        coalesce(scs.number_of_subscriptions,0) as closing_stock,
        coalesce(sa.number_of_subscriptions,0) as activations,
        coalesce(spct.number_of_subscriptions,0) as product_change_to,
        coalesce(spcf.number_of_subscriptions,0) as product_change_from,
        coalesce(spct.number_of_subscriptions,0) - coalesce(spcf.number_of_subscriptions,0) as migration_netto,
        coalesce(san.number_of_subscriptions,0) as annulments,
        coalesce(sa.number_of_subscriptions,0) - coalesce(san.number_of_subscriptions,0) as activations_annulments,
        coalesce(sc.number_of_subscriptions,0) - coalesce(san.number_of_subscriptions,0) as churn_excl_annulments
    from
        cal cross join
        analytics.abt_d_product as product
        left outer join stock_product_change_to as spct on
            spct.year = cal.year and
			spct.month = cal.month and
            spct.product_id = product.product_id
        left outer join stock_product_change_from as spcf on
            spcf.year = cal.year and
			spcf.month = cal.month and
            spcf.product_id = product.product_id
        left outer join stock_activations as sa on
            sa.year = cal.year and
			sa.month = cal.month and
            sa.product_id = product.product_id
        left outer join stock_closing_stock as scs on
            scs.year = cal.year and
			scs.month = cal.month and
            scs.product_id = product.product_id
        left outer join stock_annulments as san on
            san.year = cal.year and
			san.month = cal.month and
            san.product_id = product.product_id
        left outer join stock_churn as sc on
            sc.year = cal.year and
			sc.month = cal.month and
            sc.product_id = product.product_id   
        where
  spct.product_id is not null or
  spcf.product_id is not null or
  sa.product_id is not null or
  scs.product_id is not null or
  sa.product_id is not null or
  sc.product_id is not null
)
/*
*** MINUS operator to get SOC that are not present in abt_stock_report ***
*/
select res.soc from res 
left outer join (
    select soc, 1 as isRowPresent from analytics.abt_stock_report) abt on
(res.soc = abt.soc)
where /*res.month='201809' and*/ abt.isRowPresent is null;