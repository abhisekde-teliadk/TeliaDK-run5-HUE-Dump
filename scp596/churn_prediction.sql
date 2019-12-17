select * from analytics.abt_subscriber_history where ((product_product_type = 'GSM' and product_product_line = 'Mobile' and product_product_group like '%BtC%') or 
(from_product_product_type = 'GSM' and from_product_product_line = 'Mobile' and from_product_product_group like '%BtC%')) and
 (
    (start_date <= to_timestamp('2018-01-01', 'yyyy-MM-dd') and end_date >= to_timestamp('2018-01-01', 'yyyy-MM-dd') and  end_date <= to_timestamp('2018-07-01', 'yyyy-MM-dd')) or 
    (start_date >= to_timestamp('2018-01-01', 'yyyy-MM-dd') and start_date <= to_timestamp('2018-07-01', 'yyyy-MM-dd'))
)
and subscriber_no = 'GSM04527123759' and customer_id = 388650707
;

select * from
(select * from analytics.abt_subscriber_history where product_product_type = 'GSM' and product_product_line = 'Mobile' and product_product_group like '%BtC%'
and (
    (start_date <= to_timestamp('2018-01-01', 'yyyy-MM-dd') and end_date >= to_timestamp('2018-01-01', 'yyyy-MM-dd') and  end_date <= to_timestamp('2018-07-01', 'yyyy-MM-dd')) or 
    (start_date >= to_timestamp('2018-01-01', 'yyyy-MM-dd') and start_date <= to_timestamp('2018-07-01', 'yyyy-MM-dd'))
)) A
left outer join
(
select * from analytics.abt_churn_kpi where product_line = 'Mobile' and 
    product_subgroup like '%BtC%' and 
    churn_date >= to_timestamp('2018-01-01', 'yyyy-MM-dd') and
    churn_date <= to_timestamp('2018-06-01', 'yyyy-MM-dd')
) B
on 
 a.customer_id = b.customer_id and
 a.subscriber_no = b.subscriber_no and
 a.start_date <= b.churn_date and
 a.end_date > = b.churn_date 
where b.churn_date is not null;

select * from sandbox.sandbox_sobotik_sb_churn_base where churn_date is not null;