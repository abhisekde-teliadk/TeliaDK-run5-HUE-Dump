Select *
/*	count(*),
			max(difference),
			avg(difference),
			appx_median(difference)*/
			from
			(
			Select
			month,
			product_id,
			product_desc,
			closing_stock as as_is,
			(openning_stock +   activations + product_change_to - annulments - churn_excl_annulments - product_change_from) as to_be,
			(openning_stock +   activations + product_change_to - annulments - churn_excl_annulments - product_change_from - closing_stock) as difference
			From
			(
			select
			Cs.Month,
			Cs.Product_id,
			Cs.Product_desc,
			Cs.Closing_stock,
			Cs.activations,
			Cs.product_change_to,
			Cs.annulments,
			Cs.churn_excl_annulments,
			Cs.product_change_from,
			LAG(cs.closing_stock, 1) OVER (ORDER BY cs.month asc) AS openning_stock
			--Coalesce(os.closing_stock, 0) as Openning_stock
			From
			Analytics.Abt_stock_report as cs
		/*	Left outer join analytics.Abt_stock_report as os on
				Cs.Month = cast( (cast (os.month as int) + 1) as char(6)) and
				Cs.product_id = os.product_id*/
			Where
			1=1
			--and Cs.month = '201905'
			) x
			Where
			1=1
			) y 
			where
difference <> 0
--product_id in ('68f8e98192e883f681ac9ad9dd5abc6e')
order by difference desc
;


select
year, month,stock_product_id,
closing_stock,
opening_stock,
new_in_month,
should_be,
(closing_stock-should_be) as dif
from
(
select 
year, month, closing_stock, stock_product_id,

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
stock_product_id in ('8fb3925b925ecd12626e414ea47d48f3'/*'0c26a4e7fe639273f0648597bbcc2ef5','68f8e98192e883f681ac9ad9dd5abc6e','ec11b7c96c041a5b388aa1977a953db6','6f6c39adbc42636a5d3b07248ae8aa84'*/)
--stock_product_id in ('6f6c39adbc42636a5d3b07248ae8aa84')
--and year=2019 and month=5
order by stock.year, stock.month asc
) x
) diff
where (closing_stock-should_be) <> 0
;

(openning_stock +   activations + product_change_to - annulments - churn_excl_annulments - product_change_from)

--3717 + 501 + 42 - 14 - 144 - 38  =  4.064 is expected value, we have only 4031 in closing_stock
--14638 + 41 + 17 - 1  - 280 - 334 = 14.081


;

select * from

(SELECT 
    work_sa_product.effective_date,
    work_sa_product.expiration_date,
    work_sa_product.ban AS customer_id,
    work_sa_product.subscriber_no AS subscriber_no,
    work_sa_product.soc AS soc,
    work_sa_product.s_subscriber_id AS subscriber_id,
    work_sa_product.product_id AS product_id,
    base_man_d_calendar.date_as_date AS date_as_date
  FROM work.base_equation_product_work_sa_product work_sa_product
  INNER JOIN (
    SELECT base_man_d_calendar.*
      FROM base.manual_files_base_man_d_calendar base_man_d_calendar
      WHERE date_as_date between '2018-01-01' and now()
    ) base_man_d_calendar
    ON (work_sa_product.effective_date <= base_man_d_calendar.date_as_date)
      AND (work_sa_product.expiration_date > base_man_d_calendar.date_as_date)
      )x
      where x.product_id='8fb3925b925ecd12626e414ea47d48f3'
      and x.date_as_date >=to_timestamp('2018-02-01','yyyy-MM-dd')
      and x.date_as_date<=to_timestamp('2018-02-28','yyyy-MM-dd')
      --and x.date_as_date=to_timestamp('2018-01-31','yyyy-MM-dd')
      order by effective_date asc;

SELECT 
    work_sa_product.effective_date,
    work_sa_product.expiration_date,
    work_sa_product.ban AS customer_id,
    work_sa_product.subscriber_no AS subscriber_no,
    work_sa_product.soc AS soc,
    work_sa_product.s_subscriber_id AS subscriber_id,
    work_sa_product.product_id AS product_id
FROM work.base_equation_product_work_sa_product work_sa_product
  where product_id='8fb3925b925ecd12626e414ea47d48f3'
  and expiration_date >=to_timestamp('2018-02-01','yyyy-MM-dd')
      and effective_date<=to_timestamp('2018-02-28','yyyy-MM-dd')
      order by effective_date asc;
  

select * from work.BASE_EQUATION_KPIS_tbt_stock_kpi
where 
product_id='e34eaf87f89e23de2ab447d1dfb46a0e'
and stock_date between to_timestamp('2018-02-01','yyyy-MM-dd') and to_timestamp('2018-02-28','yyyy-MM-dd')
order by stock_date desc;

select		Cs.Month,
			to_timestamp(concat(Cs.Month,'01'), 'yyyyMMdd') as new_date,
			add_months(to_timestamp(concat(Cs.Month,'01'), 'yyyyMMdd'),-1) as last_month,
			LAG(cs.closing_stock, 1) OVER (ORDER BY cs.month asc) AS opening_stock_new,
			Cs.Product_id,
			Cs.Product_desc,
			Cs.Closing_stock,
			--Coalesce(os.closing_stock, 0) as Openning_stock,
			Cs.activations,
			Cs.product_change_to,
			Cs.annulments,
			Cs.churn_excl_annulments,
			Cs.product_change_from
			From
			Analytics.Abt_stock_report as cs
			Where
			cs.product_id in ('8fb3925b925ecd12626e414ea47d48f3')
			order by Cs.Month asc
			;
			
select
month, product_id,closing_stock, activations,product_change_to, product_change_from, migration_netto, annulments, activations_minus_annulments, churn_excl_annulments
from analytics.abt_stock_report
where product_id='8fb3925b925ecd12626e414ea47d48f3'
--and month='201802'
order by month asc;

select distinct month from analytics.abt_stock_report order by month desc; 			