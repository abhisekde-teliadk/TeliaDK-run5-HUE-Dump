select
year, month,
closing_stock,
opening_stock,
new_in_month,
should_be,
(closing_stock-should_be) as dif
from
(
select 
year, month, closing_stock,

LAG(closing_stock, 1) OVER (ORDER BY year, month asc) AS opening_stock,
coalesce((activations+product_change_to-annulment-churn_excl_annul-product_change_from),0) as new_in_month,
LAG(closing_stock, 1) OVER (ORDER BY year, month asc) + coalesce((activations+product_change_to-annulment-churn_excl_annul-product_change_from),0) as should_be
FROM (

select stock.year, stock.month, stock_product_id, stock.stock_subs_qty_sum as closing_stock, 
coalesce(activ.subscriber_id_distinct,0) as activations,
coalesce(product_to.subscriber_id_distinct,0) as product_change_to,
coalesce(annul.subscriber_id_distinct,0) as annulment,
coalesce(churn.subscriber_id_distinct,0) as churn_excl_annul,
coalesce(product_from.subscriber_id_distinct,0) as product_change_from

from temp.reporting_to_authorities_tmp_month_stock_sum stock

left join temp.reporting_to_authorities_tmp_month_intake_sum activ
on stock.year=activ.year
and stock.month=activ.month
and stock.stock_product_id=activ.product_id

left join temp.reporting_to_authorities_tmp_month_migration_to_sum product_to
on stock.year=product_to.year
and stock.month=product_to.month
and stock.stock_product_id=product_to.to_product_id

left join temp.reporting_to_authorities_tmp_month_annulment_sum annul
on stock.year=annul.year
and stock.month=annul.month
and stock.stock_product_id=annul.product_id

left join temp.reporting_to_authorities_tmp_month_churn_sum churn
on stock.year=churn.year
and stock.month=churn.month
and stock.stock_product_id=churn.product_id

left join temp.reporting_to_authorities_tmp_month_migration_from_sum product_from
on stock.year=product_from.year
and stock.month=product_from.month
and stock.stock_product_id=product_from.from_product_id

where 
stock_product_id in ('68f8e98192e883f681ac9ad9dd5abc6e'/*,'ec11b7c96c041a5b388aa1977a953db6'*/)
--and year=2019 and month=5
order by stock.year, stock.month asc
) x
) diff
;

select sum(stock_subs_qty), stock_product_id from temp.reporting_to_authorities_tmp_month_stock
where stock_product_id in (/*'0c26a4e7fe639273f0648597bbcc2ef5',*/'ec11b7c96c041a5b388aa1977a953db6')
--and stock_date between to_timestamp('2019-05-01','yyyy-MM-dd') and to_timestamp('2019-05-31','yyyy-MM-dd')
and year=2018 and month=3
group by stock_product_id;

select 
--SUM(subs_qty), product_id
*
from work.base_equation_kpis_tbt_stock_kpi
where product_id in (/*'0c26a4e7fe639273f0648597bbcc2ef5','68f8e98192e883f681ac9ad9dd5abc6e',*/'ec11b7c96c041a5b388aa1977a953db6')
and stock_date between to_timestamp('2018-03-01','yyyy-MM-dd') and to_timestamp('2018-03-31','yyyy-MM-dd')
and active_traffic='Y'
group by product_id;