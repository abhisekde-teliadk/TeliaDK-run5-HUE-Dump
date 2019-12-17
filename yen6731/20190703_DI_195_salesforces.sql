select distinct year, month from work.salesforce_kpis_work_revenue_per_cvr order by year , month desc;

SELECT 
    customer_cvr_no AS customer_cvr_no,
    year AS year,
    month AS month,
    product_category AS product_category,
    amount_sum_sum AS amount
  FROM (
    SELECT 
        customer_cvr_no AS customer_cvr_no,
        year AS year,
        month AS month,
        product_category AS product_category,
        SUM(amount_sum) AS amount_sum_sum
      FROM (
        SELECT 
            customer_cvr_no,
            product_category,
            amount_sum,
            year,
            month,
            start_of_month,
            end_of_month
          FROM work.salesforce_kpis_work_sap_finance_calendar
          WHERE --end_of_month between now() - interval 13 months and now() - interval 1 months
end_of_month >= now() - interval 12 months and start_of_month <= now() - interval 1 month
        ) dku__beforegrouping
      GROUP BY customer_cvr_no, year, month, product_category
    ) pristine_query
    
where customer_cvr_no='29209472'   ;

select distinct product_category from work.salesforce_kpis_work_revenue_per_cvr_tmp_filtered;
select * from work.salesforce_kpis_work_monthly_extra_subs_grouped where customer_cvr_no='10541603' and year=date_part('year',now()) and month=date_part('month',add_months(now(), -2));


select * from work.salesforce_kpis_work_revenue_per_cvr where customer_cvr_no='36366869';

select concat ('Active_SIM_Cards_', case sim_Category when 'DATA' then 'MBB' else 'Voice' end , '__c') from work.salesforce_kpis_work_monthly_extra_subs_grouped;
--select case sim_Category when 'DATA' then 'MBB' else 'Voice' end from work.salesforce_kpis_work_monthly_extra_subs_grouped;
select sim_category from work.salesforce_kpis_work_monthly_extra_subs_grouped;

update  work.salesforce_kpis_work_revenue_per_cvr set product_category='IMO' where product_category='INTERNET, MPLS, Other';
 from  work.salesforce_kpis_work_revenue_per_cvr  where product_category='INTERNET, MPLS, Other';

select distinct prodcat from base.IMPORT_OTHER_SOURCES_base_sap_finance_data_new;

select concat(Product_category,'__c')  from work.salesforce_kpis_work_revenue_per_cvr;

-- this will not work in January. Need to change. 
select date_part('year',to_timestamp('2019/07/05','yyyy/mm/dd')) as year, date_part('month',add_months(now(), -1)) as month;

select date_part('year',add_months(trunc(now(), 'MM'),-1)) as year, date_part('month',add_months(trunc(now(), 'MM'),-1)) as month;
select add_months(trunc(now(), 'MM'),-7);