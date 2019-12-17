Select
*
from
(
    select
    call_month as period,
    'Grouped traffic' as source,
    sum(event_count) as event_count
    from
    analytics.prod_abt_gruppetrafik
    where ban = 649237807
    group by
    call_month
    union
    select
    cast(event_month as int) as period,
    'Traffic' as source,
    sum(event_count) as event_count
    from
    analytics.prod_abt_traffic
    where customer_id = 649237807
    group by
    event_month
) x
where    
period between 201901 and 201905
order by
period,
source;

--649237807
