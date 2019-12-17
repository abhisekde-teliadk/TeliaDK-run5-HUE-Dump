
select count(subscriber_id)
from analytics.prod_abt_migration_kpi
where from_priceplan in ('CM6T12GB','CMJHEU09')
and to_priceplan = 'CMJLHEU08'
and migration_date = '2019-03-10' ;

