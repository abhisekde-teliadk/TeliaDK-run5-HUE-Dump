select * from work.base_equation_kpis_tbt_churn_kpi where customer_id = 597776111 
and subscriber_no = 'FIX04588626769'; --product id: a1823de362fa10871f2979b3eb716418
--churn_date 2019-05-06

select * from analytics.abt_product where product_id = '4881a55a718e3bc44234d29d1a51dc0d';

select * from analytics.abt_subscribed_product_history where 
ban = 597776111 
and subscriber_no = 'FIX04588626769';

select * from work.base_equation_product_tbt_subscribed_product_history where 
subscriber_no = 'GSM04528276703' and ban = 100634763; 

select * from work.base_equation_kpis_tbt_churn_kpi where subscriber_id = 39801;

select * from work.base_equation_kpis_work_subscribed_product_rank where subscriber_id = 39801;

select * from work.base_equation_product_work_subscribed_product_id where subscriber_id = 39801;

select 
*
from work.base_equation_kpis_tbt_churn_kpi
where 
soc is null
order by churn_date desc
; --5039 

select * from work.base_equation_kpis_tbt_churn_kpi where soc is null;

select * from work.base_equation_kpis_tbt_churn_kpi where 
subscriber_no = 'GSM04526772107' and customer_id = 548147016;

select * from work.base_equation_kpis_work_subscribed_product_rank where 
subscriber_no = 'GSM04526772107' and ban = 548147016;

select * from work.base_equation_kpis_work_churn_and_annulment where 
subscriber_no = 'GSM04527832031' and customer_id = 512598111;

select count(*) from work.base_equation_kpis_work_churn_and_annulment; 
--5 247 896
--5 251 251

--2016-09-14 00:00:00

--4 844 160

select effective_date, expiration_date, * from base.import_fokus_base_service_agreement where
subscriber_no in( 'GSM04527832031', 'GSM04528518141') and customer_id = 512598111
and service_type in ('P','M', 'N');

select effective_date, expiration_date, * from base.import_fokus_base_service_agreement where
subscriber_no = 'PBX04544859088' and customer_id = 692065113
and service_type in ('P','M', 'N');

set request_pool = big;
select * from work.base_equation_kpis_tbt_churn_kpi c
left outer join base.import_fokus_base_service_agreement a 
on c.subscriber_no = a.subscriber_no and
c.customer_id = a.ban
where c.soc is null and churn_date between a.effective_date and a.expiration_date;

GSM04526772107	548147016

select sa_effective_date, sa_expiration_date, * from work.base_equation_product_tbt_subscribed_product_history
where subscriber_no = 'GSM04528518141' and ban = 548147016;

--2018-05-01 00:00:00	

select * from work.base_equation_product_work_service_agreement_subscr_joined
where subscriber_no in ( 'GSM04526772107' )  and ban = 548147016;

select subscriber_no, customer_id, sub_status, sub_status_date,
effective_date, expiration_date from temp.base_equation_sub_tmp_subscriber_history 
where subscriber_no in ( 'GSM04527832031', 'GSM04528518141' )  and customer_id = 512598111;;

select effective_date, expiration_date, * from work.base_equation_product_work_service_agreement_prepared
where subscriber_no = 'GSM04527111715' and ban = 782565600;
--2007-11-15 -≥ 2010-06-14

select effective_date, expiration_date, subscriber_id, * from work.base_equation_product_work_subscriber_union
where subscriber_no = 'GSM04527111715' and customer_id = 782565600;

select * from work.base_equation_sub_tbt_subscriber_history 
where
subscriber_no = 'GSM04527111715' and customer_id = 782565600;

select * from work.base_equation_product_tbt_subscribed_product_history
where subscriber_no = 'GSM04527832031' and ban = 512598111;

select * from work.base_equation_product_work_subscribed_product
where subscriber_no = 'GSM04527832031' and ban = 512598111;

select subscriber_id, effective_date, expiration_date, subscriber_no, soc_seq_no, *
from work.base_equation_product_work_subscribed_product_filter_dup
where subscriber_id = 15413763;

select * from work.base_equation_product_work_max_subscribed_product
where subscriber_no = 'GSM04527832031' and ban = 512598111;

select * from work.base_equation_kpis_work_subscribed_product_src where subscriber_id = 15413763;

select count(*) from work.base_equation_kpis_work_subscribed_product_src;

select count(*) from work.base_equation_product_work_subscribed_product_id;
--15 891 768
--15 819 156

15 819 156



set request_pool = big;

select /*

kpi.subscriber_id, 

kpi.customer_id, 

kpi.subscriber_no, 

kpi.churn_date, 

kpi.soc pp_as_is, 

sa.soc pp_to_be 

--kpi.campaign campaign_as_is, 

--sa.campaign campaign_to_be 
*/
count(*)
from 

--analytics.prod_abt_churn_kpi kpi 

work.base_equation_kpis_tbt_churn_kpi kpi

left outer join base.import_fokus_base_service_agreement sa on 

    sa.service_type in ('P','M') and 

    sa.subscriber_no = kpi.subscriber_no and 

    sa.customer_id = kpi.customer_id and 

    kpi.churn_date between sa.effective_date and nvl(sa.expiration_date,kpi.churn_date) 

where 

kpi.soc is null and sa.soc is not null and

--kpi.subscriber_id = 9032292 and 

1=1 



; 

--sub id: 395064
--pp: DLMBMI

select * from work.base_equation_kpis_tbt_churn_kpi where subscriber_id = 395064;

select * from work.base_equation_product_work_subscribed_product_id where subscriber_id = 395064;

select * from work.base_equation_product_work_service_agreement_subscr_joined 
where subscriber_no = 'GSM04528790035' and ban = 645886706;

select effective_date, expiration_date, * from work.base_equation_product_work_service_agreement_prepared
where subscriber_no = 'GSM04528790035' and ban = 645886706;
--2007-11-15 -≥ 2010-06-14

select effective_date, expiration_date, subscriber_id, * from work.base_equation_product_work_subscriber_union
where subscriber_no = 'GSM04528790035' and customer_id = 645886706;

select subscriber_no, customer_id, churn_date, count(*)
from work.base_equation_kpis_work_churn_join_date
group by subscriber_no, customer_id, churn_date
having count(*) > 1;

select * from
work.base_equation_kpis_work_churn_join_date
where subscriber_no = 'GSM04551241727' and customer_id = 562517011;

select count(*) from
work.base_equation_kpis_work_churn_join_date where churn_date != join_date;

select * from work.base_equation_kpis_work_subscriber_churn_date
where subscriber_no = 'GSM04551241727' and customer_id = 562517011;

select count(*) from work.base_equation_kpis_fat_work_all_kpis;

select count(*) from work.base_equation_kpis_fat_work_correct_join_date;

--churn: 4 837 096

--annulment: 280 080



--5 171 144
--5 131 907

/*
2007-11-15 00:00:00	NULL
2010-06-15 00:00:00	NULL

*/

/* 2007-11-15 < 9999
    2010-06-14 > 2007 nebo 2010-06-15
*/

select count(*) from analytics.abt_gruppetrafik where cycle_run_year = 2019 and cycle_run_month = 4;

select count(*) from sandbox.sandbox_fejtek_sb_churn_test where ref_soc != soc;

--18 010 747

select * from work.base_equation_product_tbt_subscribed_product_history;

--2002-11-13 00:00:00	2004-01-20 23:59:59

select effective_date, expiration_date, * from base.import_fokus_base_service_agreement where ban = 210222931
and subscriber_no = 'GSM04528750162' and soc = 'SKIERHPLU';

select * from work.base_equation_product_work_service_agreement_prepared 
where subscriber_no = 'GSM04528750162' and soc = 'SKIERHPLU';

set request_pool = big;

select * from work.base_equation_product_tbt_subscribed_product_history p 
left outer join
base.import_fokus_base_service_agreement s 
on 
p.subscriber_no = s.subscriber_no and
p.ban = s.ban and 
p.sa_effective_date = s.effective_date and
p.sa_expiration_date = s.expiration_date
where
s.subscriber_no is null;

select count(*) from work.base_equation_kpis_work_churn_and_annulment where soc is null;
--82931 null soc
--10 811 012 total count

--4 837 096 churn
--290 115 annulment


select a.customer_id,

       a.root_customer_id,

       a.root_cvr_no,

       b.cvr_no,

       b.root_cvr_no

      

from   analytics.abt_customer_current a,

       analytics.abt_customer_current b

where  a.root_customer_id = b.customer_id

and    (cast(a.root_cvr_no as bigint) <> cast(b.cvr_no as bigint))

order by 2

;

-- 38 records with cvr_root diff

 

select customer_id,

       root_customer_id,

       cvr_no,

       root_cvr_no,

       start_date,

      end_date

from   analytics.abt_customer_current

where  customer_id in (580968501,340161207)

;

select root_cvr_no, * from analytics.abt_customer_history where customer_id in (340161207);

select * from base.import_fokus_base_address_name_link where 
customer_id in (580968501,340161207
) and link_type = 'L';

select comp_reg_id, * from base.import_fokus_base_name_data where name_id in (
select name_id from base.import_fokus_base_address_name_link where 
customer_id in (340161207) and link_type = 'L'
) ;

select comp_reg_id, * from base.import_fokus_base_name_data 
where name_id in (210711582,256732571 ); --21: 58, 25: 34
/*
15609532 -≥ root_cvr_no for 580968501
11931901 -≥ root_cvr_no for 340161207
*/

select comp_reg_id, * from raw.import_fokus_raw_name_data 
where name_id in (210711582,256732571 ); 

select comp_reg_id, customer_id, * from 
base.import_fokus_base_address_name_link 
left outer join 
base.import_fokus_base_name_data 
on base.import_fokus_base_address_name_link.name_id = base.import_fokus_base_name_data.name_id
where 
base.import_fokus_base_address_name_link.link_type = 'L' and
base.import_fokus_base_address_name_link.customer_id in (580968501,340161207)
and base.import_fokus_base_address_name_link.expiration_date >= now();

select comp_reg_id, customer_id, * from 
raw.import_fokus_raw_address_name_link 
left outer join 
raw.import_fokus_raw_name_data 
on raw.import_fokus_raw_address_name_link.name_id = raw.import_fokus_raw_name_data.name_id
where 
raw.import_fokus_raw_address_name_link.link_type = 'L' and
raw.import_fokus_raw_address_name_link.customer_id in ('580968501','340161207')
and raw.import_fokus_raw_address_name_link.expiration_date >= now();

select * from base.import_fokus_base_ban_hierarchy_tree where ban in (580968501,340161207);

select * from work.base_equation_sub_work_customer_hist where customer_id = 580968501;

--start date: 2006-06-01, end_date null : 
--ten spravny ma start date 2017-03-11 00:00:00	

select customer_id, adr_effective_date_join, adr_expiration_date_join, *
from work.base_equation_sub_work_address where customer_id =340161207
and link_type = 'L';


select start_date, end_date, subscriber_no, customer_id, subscriber_id,
account_type_id, product_group, product_subgroup, product_desc, identify,
segment_desc, segment_group, segment_name, segment_remark, segment_subgroup, segment_type,
count(*)
from work.gruppetrafik_work_subscriber_segment
group by 
start_date, end_date, subscriber_no, customer_id, subscriber_id,
account_type_id, product_group, product_subgroup, product_desc, identify,
segment_desc, segment_group, segment_name, segment_remark, segment_subgroup, segment_type
;

select count(*) from base.import_fokus_base_fokus_dudetail_usage where country_code is null;

select count(*) from work.base_equation_kpis_tbt_churn_kpi where soc is null;

select length(translate(cpr_no,' ','')) as length,
count(*) as cnt
from work.base_equation_sub_tbt_customer_current
group by 1
order by 1;

set request_pool = big;
select * from raw.import_fokus_raw_fokus_detail_usage where bl_dsc_utc_tl_pct is not null;


Select 

kpi.subscriber_id, 

kpi.customer_id, 

kpi.subscriber_no, 

kpi.churn_date, 

kpi.vas_soc_spotify as_is, 

sf.soc to_be 

from 

analytics.abt_churn_kpi as kpi 

left outer join ( 

    select 

    sa.ban, 

    sa.subscriber_no, 

    sa.soc, 

    sa.service_type, 

    sa.effective_date, 

    sa.expiration_date 

    from 

    base.import_fokus_base_service_agreement sa 

    join base.manual_files_base_man_soc_groups sg on 

        sg.soc_group = 'Spotify' and 

        sg.soc = sa.soc 

) sf on 

    sf.ban = kpi.customer_id and 

    sf.subscriber_no = kpi.subscriber_no and 

    kpi.churn_date between sf.effective_date and nvl(sf.expiration_date, kpi.churn_date) 

where 

kpi.subscriber_id in  

    (763792, 875476, 9203501, 10601861, 11690468, 11713600, 12459532, 15389328,  

    15711933, 15965315, 8486855, 12063591, 12469595, 16070333, 16087589, 16116411); 
    
    /*
    8486855	806946604	GSM04528880866	2019-05-06 00:00:00	NULL	OSBSF2
    */
    
select * from work.vasdata_tbt_service_history where subscriber_no = 'GSM04528880866'
and customer_id = 806946604