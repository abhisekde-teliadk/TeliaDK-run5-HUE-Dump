Select * from (
    select
	        month,
			product_id,
			product_desc,
			closing_stock as as_is,
			openning_stock,
			(openning_stock +   activations + product_change_to - annulments - churn_excl_annulments - product_change_from) as to_be,
			(openning_stock +   activations + product_change_to - annulments - churn_excl_annulments - product_change_from - closing_stock) as difference,
			activations,
			product_change_to,
			annulments,
			churn_excl_annulments,
			product_change_from
			From
			(
    			select
    			Cs.Month,
    			Cs.Product_id,
    			Cs.Product_desc,
    			Cs.Closing_stock,
    			LAG(cs.closing_stock, 1) OVER (ORDER BY cs.product_id,cs.month asc) AS openning_stock,
    			coalesce(Cs.activations,0) as activations,
    			coalesce(Cs.product_change_to,0) as product_change_to,
    			coalesce(Cs.annulments,0) as annulments,
    			coalesce(Cs.churn_excl_annulments,0) as churn_excl_annulments,
    			coalesce(Cs.product_change_from,0) as product_change_from
    			From
    			Analytics.Abt_stock_report as cs
			) x
	) y
where
--difference <> 0
--and
product_id in ('8fb3925b925ecd12626e414ea47d48f3')
--and as_is < 20 and as_is > 5
--and month!='201801'
order by month asc
;

201906;


--7
select
*
--count(*)
from work.base_equation_kpis_work_subscribed_product_by_day
where product_id in ('8fb3925b925ecd12626e414ea47d48f3')
and date_as_date=to_timestamp('2018-02-28','yyyy-MM-dd');

--4161
select
*
--count(*)
from work.base_equation_kpis_work_subscribed_product_day_active
where product in ('8fb3925b925ecd12626e414ea47d48f3')
and date_as_date=to_timestamp('2018-02-28','yyyy-MM-dd');

	select
			Cs.Month,
			Cs.Product_id,
			Cs.Product_desc,
			Cs.Closing_stock,
			LAG(cs.closing_stock, 1) OVER (ORDER BY cs.month asc) AS openning_stock,
			Cs.activations,
			Cs.product_change_to,
			Cs.annulments,
			Cs.churn_excl_annulments,
			Cs.product_change_from
			--Coalesce(os.closing_stock, 0) as Openning_stock
			From
			Analytics.Abt_stock_report as cs
		/*	Left outer join analytics.Abt_stock_report as os on
				Cs.Month = cast( (cast (os.month as int) + 1) as char(6)) and
				Cs.product_id = os.product_id*/
			Where
			
product_id in ('8fb3925b925ecd12626e414ea47d48f3');

--example to check:

8fb3925b925ecd12626e414ea47d48f3