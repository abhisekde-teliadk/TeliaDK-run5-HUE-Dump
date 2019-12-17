select round(sum(outst_1_90), 2) total_outstandigs_incl_vat, round(sum(outst_1_90)*0.2,2) total_vat
from finance.bad_debt_abt_kisbi_bad_debt
;

-- look at history of one account_num
select customer_ref, account_num, type, bill_paym_dat, amount, outstanding
from base.import_other_sources_base_kisbi where account_num = '10357184'
;

-- look at our dataset
select * 
from finance.bad_debt_abt_kisbi_bad_debt
where kisbi_id = 2079884
;

-- choose recent datasets with not so many rows
select * from (
select account_num, count(*) as c
from import_other_sources_base_kisbi
where strleft(cast(bill_paym_dat  as string),4) in ('2018', '2019')
group by account_num
order by c desc) bdc
where bdc.c <20
order by bdc.c desc
limit 100;



select customer_type_name, count(*) c
from import_other_sources_base_kisbi
where customer_type_name like '%mom%'
group by customer_type_name
limit 100;
