--SOC = SIMBTB2 does not exist
select p.product_line, p.product_group, p.product_desc, p.soc, kpi.* 
from analytics.abt_intake_kpi kpi join analytics.abt_d_product p
on kpi.product_id = p.product_id
where
--`date` >= to_timestamp('2018-09-01', 'yyyy-MM-dd' )
--and `date` <= to_timestamp('2018-09-30', 'yyyy-MM-dd' )
-- product_desc = 'Dual SIM BtB'
--and p.product_group = 'Postpaid BtB'
--and product_line = 'Mobile'
and soc = 'SIMBTB2'
;

select * from analytics.abt_d_product where soc = 'SIMBTB2';

select * from work.base_equation_work_subscribed_product_id where SOC = 'SIMBTB2';

select * from work.base_equation_work_subscribed_product_filter_dup where SOC = 'SIMBTB2';

select * from work.base_equation_work_subscribed_product where SOC = 'SIMBTB2';

select * from work.base_equation_work_sub_product_filtered where SOC = 'SIMBTB2';

select * from work.base_equation_work_service_agreement_subscr_joined where SOC = 'SIMBTB2';

select distinct service_type from work.base_equation_work_service_agreement_subscr_joined where SOC = 'CMSIMMBC3';

--SOC = CMTALE2T = OK, number correspond to report
select p.product_line, p.product_group, p.product_desc, p.soc, kpi.* 
from analytics.abt_intake_kpi kpi join analytics.abt_d_product p
on kpi.product_id = p.product_id
where
`date` >= to_timestamp('2018-09-01', 'yyyy-MM-dd' )
and `date` <= to_timestamp('2018-09-30', 'yyyy-MM-dd' )
and product_desc = 'EU Tale 2 timer'
and p.product_group = 'Call Me Postpaid BtC'
and product_line = 'Mobile'
and soc = 'CMTALE2T'
;

--SOC = GPMBBS, report = 63, dss = 61
select p.product_line, p.product_group, p.product_desc, p.soc, kpi.* 
from analytics.abt_intake_kpi kpi join analytics.abt_d_product p
on kpi.product_id = p.product_id
where
`date` >= to_timestamp('2018-09-01', 'yyyy-MM-dd' )
and `date` <= to_timestamp('2018-09-30', 'yyyy-MM-dd' )
--and product_desc = 'EU Tale 2 timer'
--and p.product_group = 'Call Me Postpaid BtC'
--and product_line = 'Mobile'
and soc = 'GPMBBS'
;

--SOC = MOBFLUSA, report = 63, dss = 55
select p.product_line, p.product_group, p.product_desc, p.soc, kpi.* 
from analytics.abt_intake_kpi kpi join analytics.abt_d_product p
on kpi.product_id = p.product_id
where
`date` >= to_timestamp('2018-09-01', 'yyyy-MM-dd' )
and `date` <= to_timestamp('2018-09-30', 'yyyy-MM-dd' )
--and product_desc = 'EU Tale 2 timer'
--and p.product_group = 'Call Me Postpaid BtC'
--and product_line = 'Mobile'
and soc = 'MOBFLUSA'
;

--SOC = SPTELAMBB, report = 56, dss = 57
select p.product_line, p.product_group, p.product_desc, p.soc, kpi.* 
from analytics.abt_intake_kpi kpi join analytics.abt_d_product p
on kpi.product_id = p.product_id
where
`date` >= to_timestamp('2018-09-01', 'yyyy-MM-dd' )
and `date` <= to_timestamp('2018-09-30', 'yyyy-MM-dd' )
--and product_desc = 'EU Tale 2 timer'
--and p.product_group = 'Call Me Postpaid BtC'
--and product_line = 'Mobile'
and soc = 'SPTELAMBB'
;

--SOC = TPFFBGOF, report = 16, dss = 6
select p.product_line, p.product_group, p.product_desc, p.soc, kpi.* 
from analytics.abt_intake_kpi kpi join analytics.abt_d_product p
on kpi.product_id = p.product_id
where
`date` >= to_timestamp('2018-09-01', 'yyyy-MM-dd' )
and `date` <= to_timestamp('2018-09-30', 'yyyy-MM-dd' )
--and product_desc = 'EU Tale 2 timer'
--and p.product_group = 'Call Me Postpaid BtC'
--and product_line = 'Mobile'
and soc = 'TPFFBGOF';

--SOC = TPSCOMPND, report = 55, dss = 56
select p.product_line, p.product_group, p.product_desc, p.soc, kpi.* 
from analytics.abt_intake_kpi kpi join analytics.abt_d_product p
on kpi.product_id = p.product_id
where
`date` >= to_timestamp('2018-09-01', 'yyyy-MM-dd' )
and `date` <= to_timestamp('2018-09-30', 'yyyy-MM-dd' )
--and product_desc = 'EU Tale 2 timer'
--and p.product_group = 'Call Me Postpaid BtC'
--and product_line = 'Mobile'
and soc = 'TPSCOMPND'
;

--SOC = CMSIMMBC3 - no rows in dss
select p.product_line, p.product_group, p.product_desc, p.soc, kpi.* 
from analytics.abt_intake_kpi kpi join analytics.abt_d_product p
on kpi.product_id = p.product_id
where
`date` >= to_timestamp('2018-09-01', 'yyyy-MM-dd' )
and `date` <= to_timestamp('2018-09-30', 'yyyy-MM-dd' )
--and product_desc = 'EU Tale 2 timer'
--and p.product_group = 'Call Me Postpaid BtC'
--and product_line = 'Mobile'
and soc = 'CMSIMMBC3'
;


--SOC = M1000NM, report = 22, dss = 21
select p.product_line, p.product_group, p.product_desc, p.soc, kpi.* 
from analytics.abt_intake_kpi kpi join analytics.abt_d_product p
on kpi.product_id = p.product_id
where
`date` >= to_timestamp('2018-09-01', 'yyyy-MM-dd' )
and `date` <= to_timestamp('2018-09-30', 'yyyy-MM-dd' )
--and product_desc = 'EU Tale 2 timer'
--and p.product_group = 'Call Me Postpaid BtC'
--and product_line = 'Mobile'
and soc = 'M1000NM'
;

--SOC = M3000NM = OK, report = 21, dss = 21
select p.product_line, p.product_group, p.product_desc, p.soc, kpi.* 
from analytics.abt_intake_kpi kpi join analytics.abt_d_product p
on kpi.product_id = p.product_id
where
`date` >= to_timestamp('2018-09-01', 'yyyy-MM-dd' )
and `date` <= to_timestamp('2018-09-30', 'yyyy-MM-dd' )
--and product_desc = 'EU Tale 2 timer'
--and p.product_group = 'Call Me Postpaid BtC'
--and product_line = 'Mobile'
and soc = 'M3000NM'
;

--SOC = 4YOU5 = OK, report = 23, dss = 23
select p.product_line, p.product_group, p.product_desc, p.soc, kpi.* 
from analytics.abt_intake_kpi kpi join analytics.abt_d_product p
on kpi.product_id = p.product_id
where
`date` >= to_timestamp('2018-09-01', 'yyyy-MM-dd' )
and `date` <= to_timestamp('2018-09-30', 'yyyy-MM-dd' )
--and product_desc = 'EU Tale 2 timer'
--and p.product_group = 'Call Me Postpaid BtC'
--and product_line = 'Mobile'
and soc = '4YOU5'
;


select * from analytics.abt_d_product where soc = 'CMSIMMBC3';

select count(*) /*c.sales_date, c.customer_id, c.subscriber_no, c.subscriber_id, d.product_id, c.first_dealer_code, c.dealer_code */
from analytics.abt_subscriber_current c
left outer join
(
select p.ban ban, p.subscriber_no subscriber_no, p.product_id product_id from analytics.abt_subscribed_product_history p join 
(
select ban, subscriber_no, min(effective_date) effective_date from analytics.abt_subscribed_product_history 
--where subscriber_no = 'GSM04526129886' and ban = 970077608
group by ban, subscriber_no) b
on
p.subscriber_no = b.subscriber_no and 
p.ban = b.ban and
p.effective_date = b.effective_date) d 
on c.subscriber_no = d.subscriber_no
and c.customer_id = d.ban
where c.sales_date is not null
and d.product_id = '4184ca2815e88ebde1c49dc7456fc510'
--and c.customer_id = 970077608
--and c.subscriber_no = 'GSM04526129886'
;


select * from analytics.abt_sales_kpi where customer_id = 970077608 and subscriber_no = 'GSM04526129886';

select count(*) from analytics.abt_sales_kpi where product_id = '4184ca2815e88ebde1c49dc7456fc510'; --32137

2ba5898a24f584679f18d8e061b14e93: 32137 ok
4184ca2815e88ebde1c49dc7456fc510: 157 ok
;
--each customer_id, subscriber_no should be here only once: OK
select customer_id, subscriber_no, count(*) from analytics.abt_sales_kpi 
group by customer_id, subscriber_no
having count(*) > 1;

--each customer_id, subscriber_no should be here only once: OK
select customer_id, subscriber_no, count(*) from analytics.abt_intake_kpi 
group by customer_id, subscriber_no
having count(*) > 1;


select count(*) /*c.sales_date, c.customer_id, c.subscriber_no, c.subscriber_id, d.product_id, c.first_dealer_code, c.dealer_code */
from analytics.abt_subscriber_current c
left outer join
(
select p.ban ban, p.subscriber_no subscriber_no, p.product_id product_id from analytics.abt_subscribed_product_history p join 
(
select ban, subscriber_no, min(effective_date) effective_date from analytics.abt_subscribed_product_history 
--where subscriber_no = 'GSM04526129886' and ban = 970077608
group by ban, subscriber_no) b
on
p.subscriber_no = b.subscriber_no and 
p.ban = b.ban and
p.effective_date = b.effective_date) d 
on c.subscriber_no = d.subscriber_no
and c.customer_id = d.ban
where c.act_date_id is not null
and d.product_id = '7ebffdb2aa8c076f5fb4cc05067458fe'
--and c.customer_id = 970077608
--and c.subscriber_no = 'GSM04526129886'
;

select * from analytics.abt_intake_kpi;

select count(*) from analytics.abt_intake_kpi where product_id = '7ebffdb2aa8c076f5fb4cc05067458fe'; --896

5be01aa95671efa25d975021d1bce500: 896 OK
7ebffdb2aa8c076f5fb4cc05067458fe: 14805 OK