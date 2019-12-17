
describe analytics.abt_subscriber_history;

1   start_date	                    ?	
2	end_date	                    ?	
3	active_record_flag	            ?	
4	subscriber_id	                ?	
5	subscriber_no	                ?	
6	customer_id	                    ?	
7	origin	                        OK - hardcoded ???	
8	prolonging_event	             	
9	prol_duration	                 	
10	tree_level	                    error       test 30	
11	future_cancellation_date	     	
12	future_cancellation_code	     	
13	cycle_code	                    error       test 32 remove field	
14	commit_end_date	                ?	
15	from_account_type_id	         	
16	account_type_id	                error       test 31 remove field	
17	churn_date	                    ?           test 24
18	act_date	                    rename field	
19	init_act_date	                rename field	
20	sales_date	                     	
21	first_dealer_code               ?
22	dealer_code	                    ?
23	imei	                        string	
24	sim	                            string	
25	msisdn	                        ?           test 20	
26	status	                        ?	
27	fokus_status	                ?	
28	status_reason	                ?           test 20	
29	dual_sim_master	bigint	
30	master_subscriber_id	string	
31	since_date	timestamp	
32	additional_title	            ?	
33	robinson	                    ?	
34	accommodation_type	string	
35	contact_phone_no	bigint	
36	analysis_date	string	
37	analysis	string	
38	marketing_date	string	
39	marketing	string	
40	adr_co_name	                    ?
41	adr_district	                ?   	
42	adr_email	                    ?	
43	adr_door_no	                    ?	
44	adr_story	                    ?	
45	adr_house_letter	            ?	
46	adr_country	                    ?	
47	adr_pob	                        ?	
48	adr_direction	                ?	
49	adr_street_name	                ?	
50	adr_house_no	                ?	
51	adr_zip	                        ?	
52	adr_city	                ?	
53	adr_primary_ln	            ?	
54	adr_secondary_ln	        ?	
55	identify	                ?	
56	gender	                    ?	
57	birth_date	                ?	
58	middle_initial	            ?	
59	first_name	                ?	
60	last_business_name	        ?	
61	price_plan	string	
62	campaign	string	
63	promotion	string	
64	recipient_operator	string	
65	equation_group	string	
66	reason_desc	string	
67	internal_circuit_id	string	
68	imsi	bigint	
69	customer_start_date         OK
70	customer_end_date           OK
71	customer_origin             OK
72	customer_cvr_no             OK
73	customer_cpr_no             OK
74	customer_organization_name  OK
75	customer_identify           OK
76	customer_root_customer_id   OK
77	customer_root_cvr_no	    ERROR should not be defined as bigint	
78	customer_root_cpr_no        OK
79	customer_root_organization_name     OK
80	customer_root_identify      OK
81	customer_cycle_code         OK
82	customer_tree_level         OK
83	customer_agncy_code         OK
84	customer_ar_balance         OK
85	customer_delinq_status      OK
86	customer_delinq_sts_date    OK
87	customer_credit_class       OK
88	customer_account_type_id    OK
89	customer_ban_status         OK
90	customer_payment_method_id  OK
91	customer_payment_sub_method_id      OK
92	customer_customer_telno     OK
93	customer_print_category     OK
94	customer_employment_type    OK
95	customer_start_service_date OK
96	customer_status_last_date   OK
97	customer_bl_due_day         OK
98	customer_since_date         OK
99	customer_additional_title   OK
100	customer_robinson           OK ? robinson
101	customer_accommodation_type OK
102	customer_contact_phone_no   OK
103	customer_analysis_date      OK
104	customer_analysis           OK
105	customer_marketing_date     OK
106	customer_marketing          OK
107	customer_adr_co_name        OK
108	customer_adr_district       OK
109	customer_adr_email          OK
110	customer_adr_door_no        OK
111	customer_adr_story          OK
112	customer_adr_house_letter   OK
113	customer_adr_country        OK
114	customer_adr_pob            OK
115	customer_adr_direction      OK
116	customer_adr_street_name    OK
117	customer_adr_house_no       OK
118	customer_adr_zip            OK
119	customer_adr_city           OK
120	customer_adr_primary_ln     OK
121	customer_adr_secondary_ln   OK
122	customer_gender             OK
123	customer_birth_date         OK
124	customer_middle_initial     OK
125	customer_first_name         OK
126	customer_last_business_name OK
127	from_product_product_id
128	from_product_soc
129	from_product_campaign
130	from_product_service_soc	string	
131	from_product_product_code	string	
132	from_product_product_desc	string	
133	from_product_product_lt	string	
134	from_product_rated_soc	string	
135	from_product_rated_soc_description	string	
136	from_product_rated_service_type	string	
137	from_product_product_type	string	
138	from_product_product_line	string	
139	from_product_product_group	string	
140	from_product_product_subgroup	string	
141	from_product_budget_product	string	
142	from_product_budget_product_group	string	
143	from_product_service_provider	string	
144	from_product_prim_acc_type	string	
145	from_product_mdu_mbb	string	
146	from_product_roaming_segment	string	
147	from_product_nonstd	string	
148	from_product_ca_upgrade	bigint	
149	from_product_price	double	
150	from_product_free_voice_dk	string	
151	from_product_free_sms	string	
152	from_product_free_mms	string	
153	from_product_data_mb_incl	double	
154	from_product_dk_data	double	
155	from_product_eu_data	double	
156	from_product_ww_data	double	
157	from_product_total_data	double	
158	from_product_service_incl	string	
159	from_product_service_duration	string	
160	from_product_extra_datacard	string	
161	from_product_extra_user	string	
162	from_product_campaign_desc	string	
163	from_product_pp_service_type	string	
164	from_product_pp_soc_description	string	
165	from_product_promo_service_type	string	
166	from_product_promo_soc_description	string	
167	product_product_id	string	
168	product_soc	string	
169	product_campaign	string	
170	product_service_soc	string	
171	product_product_code	string	
172	product_product_desc	string	
173	product_product_lt	string	
174	product_rated_soc	string	
175	product_rated_soc_description	string	
176	product_rated_service_type	string	
177	product_product_type	string	
178	product_product_line	string	
179	product_product_group	string	
180	product_product_subgroup	string	
181	product_budget_product	string	
182	product_budget_product_group	string	
183	product_service_provider	string	
184	product_prim_acc_type	string	
185	product_mdu_mbb	string	
186	product_roaming_segment	string	
187	product_nonstd	string	
188	product_ca_upgrade	bigint	
189	product_price	double	
190	product_free_voice_dk	string	
191	product_free_sms	string	
192	product_free_mms	string	
193	product_data_mb_incl	double	
194	product_dk_data	double	
195	product_eu_data	double	
196	product_ww_data	double	
197	product_total_data	double	
198	product_service_incl	string	
199	product_service_duration	string	
200	product_extra_datacard	string	
201	product_extra_user	string	
202	product_campaign_desc	string	
203	product_pp_service_type	string	
204	product_pp_soc_description	string	
205	product_promo_service_type	string	
206	product_promo_soc_description	string	
207	handset_manufacturer	string	
208	handset_model	string	
209	account_type_description	string	
210	status_desc	string	
211	fokus_status_desc	string	
;

set request_pool=big;

-- Test 0 - preview
select *
from   analytics.prod_abt_subscriber_current a
;
-- rows 3739534 


-- Test 1 - count
select count(*) as antal
from   analytics.prod_abt_subscriber_current a
;
-- rows 3739534 

-- Test 2 - count
select fokus_status,
       count(*) as antal
from   analytics.prod_abt_subscriber_current
where  fokus_status in ('A','S')
group by 1
order by 1
;

-- Test 3 - count
select count(distinct subscriber_id) as antal
from   analytics.prod_abt_subscriber_current
where  fokus_status in ('A','S')
;
-- 1433452

-- Test 4 - RAW count
select count(distinct subscriber_id) as antal
from   raw.import_fokus_raw_subscriber
where  sub_status in ('A','S')
;
-- 1505441

-- Test 5 - missing rows from RAW to BASE
select a.*
from    (-- find all active subscriber_id i BASE
         select distinct subscriber_id as raw_subscriber_id
         from   raw.import_fokus_raw_subscriber 
         where  sub_status in ('A','S')) a
            left outer join 
        (-- find all active subscriber_id in ANALYTICS
         select distinct subscriber_id as subscriber_id
         from   analytics.prod_abt_subscriber_current
         where  fokus_status in ('A','S')) b
            on cast(a.raw_subscriber_id as bigint) = b.subscriber_id
where   b.subscriber_id is null
;
-- 18933 rows

-- find all rows on 10 subscriber_id : ex. rows from above query
select subscriber_id,
       effective_date,
       sub_status,
       *
from   raw.import_fokus_raw_subscriber 
where  subscriber_id in 
(15624376,
12258486,
15826837,
15888521,
13284839,
16313694,
15293988,
14948113,
16273191,
15614561)
order by subscriber_id,
         effective_date
;
 

-- Test 6 - count of distinct subscriber_id
select count(distinct subscriber_id) as antal_unique_subscriber_ids
from   raw.import_fokus_raw_subscriber
;
-- 6533899 rows : missing compared to repdb - undersøg igen

select count(distinct subscriber_id) as antal_unique_subscriber_ids
from   analytics.prod_abt_subscriber_history
;
-- 6509381 rows : missing subscriber_id's from BASE to ANALYTICS


-- Test 8 - start_date
select a.subscriber_id,
       a.start_date,
       count(*) as antal
from   analytics.prod_abt_subscriber_history a
group by 1,2
having count(*) > 1
;
-- 247 rows - error - subscriber_id can't have two entries on same start_date

select a.subscriber_id,
       a.start_date,
       count(*) as antal
from   analytics.prod_abt_subscriber_current a
group by 1,2
having count(*) > 1
;
-- 0 rows - OK

-- Test 9
select *
from   analytics.prod_abt_subscriber_history
where start_date > end_date
;
-- 13 rows - ERROR - start date > end_date dont give any meaning


-- test 10 find parrent 
select a.subscriber_id,
       a.customer_id,
       a.subscriber_no
from   analytics.prod_abt_subscriber_current a
          left outer join 
       analytics.prod_abt_customer_current b 
          on a.customer_id = b.customer_id
where  b.customer_id is null
;

---------------------  TEST of fields
-- test 20
select a.subscriber_id,
       b.subscriber_id as base_subscriber_id,
       a.status,
       b.sub_status as base_status,
       a.subscriber_no,
       b.subscriber_no as base_subscriber_no,
       a.customer_id,
       b.customer_id as base_customer_id,
       a.init_act_date,
       b.init_activation_date as raw_init_activation_date,
       a.act_date,
       b.original_init_date as raw_original_init_date,
       a.commit_end_date,
       b.commit_end_date as raw_commit_end_date,
       a.status_reason,
       concat(b.sub_status_last_act ,' - ', b.sub_status_rsn_code) as raw_status_reason,
       a.msisdn,
       substr(b.subscriber_no,7,8) as raw_msisdn,
       a.*
from   analytics.abt_subscriber_current a
          left outer join
       --base.import_fokus_base_subscriber b 
       raw.import_fokus_raw_subscriber b
          on a.subscriber_id = cast(b.subscriber_id as bigint)
          and b.sub_status in ('A','S')
where  a.active_record_flag = 1
--and    a.subscriber_id in (16265967,16265966,16213199,14783037,14740152)
and    a.status in ('a','s')
and   (
           a.status <> lower(b.sub_status) 
        or a.subscriber_no <> b.subscriber_no 
        or a.customer_id <> cast(b.customer_id as bigint) 
        or a.first_dealer_code <> b.org_dealer_code
        or a.dealer_code <> b.dealer_code
        or a.init_act_date <> b.init_activation_date /* ban start_date */
        or a.act_date <> b.original_init_date /* subscriber_start_date */
        or a.commit_end_date <> b.commit_end_date
        or a.status_reason <> concat(b.sub_status_last_act ,' - ', b.sub_status_rsn_code)
        or a.msisdn <> substr(b.subscriber_no,7,8)
      )

order by subscriber_id
;
-- 3739534 records
-- 78 rows where sub_status changes from base to analytics


select subscriber_id,  
       status,
       *
from   analytics.abt_subscriber_current
where  subscriber_id in (16265967,16265966,16213199,14783037,14740152)
order by subscriber_id
;

select *
from (
select 'subscriber' as source_table,
       subscriber_id,  
       sub_status,
       effective_date,
       cast('' as timestamp) as expiration_date
from   base.import_fokus_base_subscriber
where  subscriber_id in (16265967,16265966,16213199,14783037,14740152)

union all

select 'subscriber_history' as source_table,
       subscriber_id,  
       sub_status,
       effective_date,
       expiration_date
from   base.import_fokus_base_subscriber_history
where  subscriber_id in (16265967,16265966,16213199,14783037,14740152)
) x
order by subscriber_id,
      effective_date desc,
      source_table
;

select *
from  (

select subscriber_id,
       customer_id,
	   subscriber_no,
	   effective_date,
	   INIT_ACTIVATION_DATE,
	   ORIGINAL_INIT_DATE 
from   raw.import_fokus_raw_subscriber 
where  cast(subscriber_id as bigint) =1047

union all 

select subscriber_id,
       customer_id,
	   subscriber_no,
	   effective_date,
	   INIT_ACTIVATION_DATE,
	   ORIGINAL_INIT_DATE 
from   raw.import_fokus_raw_subscriber_history 
where  cast(subscriber_id as bigint) =1047
) as xx
order by effective_date
;


-- test 21
select  *
        
from   base.import_fokus_base_subscriber b
where  sub_status in ('A','S')

select a.subscriber_id,
       b.subscriber_id as base_subscriber_id,
       --a.status,
       --b.sub_status as base_status,
       a.subscriber_no,
       b.subscriber_no as base_subscriber_no,
       a.customer_id,
       b.customer_id as base_customer_id,
       a.*
from   analytics.abt_subscriber_current a
          left outer join
       base.import_fokus_base_subscriber b
          on a.subscriber_id = b.subscriber_id
          and b.sub_status in ('A','S')
where  a.active_record_flag = 1
and    a.status in ('a','s')
and   (
       --   a.status <> lower(b.sub_status) 
          a.subscriber_no <> b.subscriber_no 
       or a.customer_id <> b.customer_id
      )
order by subscriber_id
;
-- 3739534 records
-- 78 rows where sub_status changes from base to analytics


select subscriber_id,  
       customer_id,
       subscriber_no,
       *
from   analytics.abt_subscriber_current
where  subscriber_id in (49876,13826246,14131391,14133226,14675002)
order by subscriber_id
;

select *
from (
select 'subscriber' as source_table,
       subscriber_id,  
       sub_status,
       customer_id,
       subscriber_no,
       effective_date,
       cast('' as timestamp) as expiration_date
from   base.import_fokus_base_subscriber
where  subscriber_id in (49876,13826246,14131391,14133226,14675002)

union all

select 'subscriber_history' as source_table,
       subscriber_id,  
       sub_status,
       customer_id,
       subscriber_no,
       effective_date,
       expiration_date
from   base.import_fokus_base_subscriber_history
where  subscriber_id in (49876,13826246,14131391,14133226,14675002)
) x
order by subscriber_id,
      effective_date desc,
      source_table
;

select subscriber_id,
       effective_date,
       sub_status,
       *
from   base.import_fokus_base_subscriber
where  subscriber_id = 49876
order by subscriber_id,   
         effective_date

;

--------------------------- TEST CUSTOMER fields :
-- test 22
69  customer_start_date	timestamp	
70	customer_end_date	timestamp	
71	customer_origin	string	
72	customer_cvr_no	string	
73	customer_cpr_no	string	
74	customer_organization_name	string	
75	customer_identify	string	
76	customer_root_customer_id	bigint	
77	customer_root_cvr_no	bigint	
78	customer_root_cpr_no	string	
79	customer_root_organization_name	string	
80	customer_root_identify	bigint	
81	customer_cycle_code	bigint	
82	customer_tree_level	bigint	
83	customer_agncy_code	string	
84	customer_ar_balance	double	
85	customer_delinq_status	string	
86	customer_delinq_sts_date	timestamp	
87	customer_credit_class	string	
88	customer_account_type_id	string	
89	customer_ban_status	string	
90	customer_payment_method_id	string	
91	customer_payment_sub_method_id	string	
92	customer_customer_telno	string	
93	customer_print_category	string	
94	customer_employment_type	string	
95	customer_start_service_date	timestamp	
96	customer_status_last_date	timestamp	
97	customer_bl_due_day	string	
98	customer_since_date	string	
99	customer_additional_title	string	
100	customer_robinson	bigint	
101	customer_accommodation_type	string	
102	customer_contact_phone_no	string	
103	customer_analysis_date	timestamp	
104	customer_analysis	string	
105	customer_marketing_date	timestamp	
106	customer_marketing	string	
107	customer_adr_co_name	string	
108	customer_adr_district	string	
109	customer_adr_email	string	
110	customer_adr_door_no	string	
111	customer_adr_story	string	
112	customer_adr_house_letter	string	
113	customer_adr_country	string	
114	customer_adr_pob	string	
115	customer_adr_direction	string	
116	customer_adr_street_name	string	
117	customer_adr_house_no	string	
118	customer_adr_zip	string	
119	customer_adr_city	string	
120	customer_adr_primary_ln	string	
121	customer_adr_secondary_ln	string	
122	customer_gender	string	
123	customer_birth_date	timestamp	
124	customer_middle_initial	string	
125	customer_first_name	string	
126	customer_last_business_name	string	
;

select a.customer_id,
       a.subscriber_no,
       a.subscriber_id,
       a.customer_start_date,
       b.start_date as C_customer_start_date
from   analytics.prod_abt_subscriber_current a
          left outer join
       analytics.prod_abt_customer_current b
          on a.customer_id = b.customer_id
where  b.customer_id is null
or    (
       a.customer_start_date <> b.start_date or
       a.customer_end_date <> b.end_date or
       a.customer_origin <> b.origin or
       a.customer_cvr_no <> b.cvr_no or
       a.customer_cpr_no <> b.cpr_no or
       a.customer_organization_name <> b.organization_name or
       a.customer_identify <> b.identify or
       a.customer_root_customer_id <> b.root_customer_id or
       a.customer_root_cvr_no <> cast(b.root_cvr_no as bigint) or 
       a.customer_root_cpr_no <> b.root_cpr_no or
       a.customer_root_organization_name <> b.root_organization_name or
       a.customer_root_identify	<> b.root_identify or
       a.customer_cycle_code <> b.cycle_code or
       a.customer_tree_level <> b.tree_level or
       a.customer_agncy_code <> b.agncy_code or
       a.customer_ar_balance <> b.ar_balance or
       a.customer_delinq_status <> b.delinq_status or
       a.customer_delinq_sts_date <> b.delinq_sts_date or
       a.customer_credit_class <> b.credit_class or
       a.customer_account_type_id <> b.account_type_id or
       a.customer_ban_status <> b.ban_status or
       a.customer_payment_method_id <> b.payment_method_id or
       a.customer_payment_sub_method_id <> b.payment_sub_method_id or
       a.customer_customer_telno <> b.customer_telno or
       a.customer_print_category <> b.print_category or
       a.customer_employment_type <> b.employment_type or
       a.customer_start_service_date <> b.start_service_date or
       a.customer_status_last_date <> b.status_last_date or
       a.customer_bl_due_day <> b.bl_due_day or
       a.customer_since_date <> b.since_date or
       a.customer_additional_title <> b.additional_title or
       a.customer_robinson  <> b.robinson or
       a.customer_accommodation_type <> b.accommodation_type or
       a.customer_contact_phone_no	<> b.contact_phone_no or
       a.customer_analysis_date <> b.analysis_date or
       a.customer_analysis <> b.analysis or
       a.customer_marketing_date <> b.marketing_date or
       a.customer_marketing	<> b.marketing or
       a.customer_adr_co_name <> b.adr_co_name or
       a.customer_adr_district <> b.adr_district or
       a.customer_adr_email <> b.adr_email or
       a.customer_adr_door_no <> b.adr_door_no or
       a.customer_adr_story	<> b.adr_story or
       a.customer_adr_house_letter <> b.adr_house_letter or
       a.customer_adr_country <> b.adr_country or
       a.customer_adr_pob <> b.adr_pob or
       a.customer_adr_direction <> b.adr_direction or
       a.customer_adr_street_name <> b.adr_street_name or
       a.customer_adr_house_no <> b.adr_house_no or
       a.customer_adr_zip <> b.adr_zip or
       a.customer_adr_city <> b.adr_city or
       a.customer_adr_primary_ln <> b.adr_primary_ln or	
       a.customer_adr_secondary_ln <> b.adr_secondary_ln or
       a.customer_gender <> b.gender or
       a.customer_birth_date <> b.birth_date or
       a.customer_middle_initial <> b.middle_initial or
       a.customer_first_name <> b.first_name or
       a.customer_last_business_name <> b.last_business_name	
      )
;
-- a.customer_root_cvr_no should be defined as STRING


-- Test 23 navn og address info
40	adr_co_name	string	
41	adr_district	string	
42	adr_email	string	
43	adr_door_no	string	
44	adr_story	string	
45	adr_house_letter	string	
46	adr_country	string	
47	adr_pob	string	
48	adr_direction	string	
49	adr_street_name	string	
50	adr_house_no	string	
51	adr_zip	string	
52	adr_city	string	
53	adr_primary_ln	string	
54	adr_secondary_ln	string	
55	identify            Error : 2 rows
;
select a.customer_id,
       a.subscriber_no,
       a.subscriber_id,
       
       b.name_id,
       b.address_id,
       
       a.IDENTIFY,
       c.IDENTIFY as raw_IDENTIFY,
       
       --a.gender,
       --c.gender as raw_gender,

       --a.birth_date,
       --c.birth_date as raw_birth_date,
       --a.middle_initial,
       --c.middle_initial as raw_middle_initial,
       --a.first_name,
       --c.first_name as raw_first_name,
       --a.last_business_name,
       --c.last_business_name as raw_last_business_name,
       
       a.ADR_CO_NAME,
       d.ADR_CO_NAME as raw_ADR_CO_NAME,
       a.adr_district,
       d.adr_district as raw_adr_district,
       a.adr_email,
       d.adr_email as raw_email,
       a.adr_door_no,
       d.adr_door_no as raw_adr_door_no,
       a.adr_story,
       d.adr_story as raw_adr_story,
       a.adr_house_letter,
       d.adr_house_letter as raw_adr_house_letter,
       a.adr_country,
       d.adr_country as raw_adr_country,
       a.adr_pob,
       d.adr_pob as raw_adr_pob,
       a.adr_direction,
       d.adr_direction as raw_adr_direction,
       a.adr_street_name,
       d.adr_street_name as raw_adr_street_name,
       a.adr_house_no,
       d.adr_house_no as raw_adr_house_no,
       a.adr_zip,
       d.adr_zip as raw_adr_zip,
       a.adr_city,
       d.adr_city as raw_adr_city,
       a.adr_primary_ln,
       d.adr_primary_ln as raw_adr_primary_ln,
       a.adr_secondary_ln,
       d.adr_secondary_ln as raw_adr_secondary_ln
       
       --a.IDENTIFY,
       --c.IDENTIFY as raw_IDENTIFY,
       -- a.organization_name,
       --case when c.middle_initial is not null then c.middle_initial else c.last_business_name end as raw_organization_name,
       --a.cvr_no,
       --c.comp_reg_id as raw_cvr_no,
       --c.middle_initial ,
       --a.cpr_no,
       --c.identify as raw_identify,
       -- a.since_date,
       -- d.since_date as raw_since_date,
       -- a.additional_title,
       -- c.additional_title as raw_additional_title,
       -- a.ACCOMMODATION_TYPE,
       -- d.ACCOMMODATION_TYPE as raw_ACCOMMODATION_TYPE

 
       
from   analytics.prod_abt_subscriber_current a,
       raw.import_fokus_raw_address_name_link b,
       raw.import_fokus_raw_name_data c,
       raw.import_fokus_raw_address_data d
where  a.customer_id = cast(b.customer_id as bigint)
and    a.subscriber_no = b.subscriber_no
-- and    a.subscriber_no = 'GSM04540346801'
and    b.link_type = 'U'
and    (cast(b.expiration_date as timestamp) > current_timestamp() or  b.expiration_date is null)
and    b.name_id = c.name_id
and    b.address_id = d.address_id

and    (
--        a.IDENTIFY <> c.IDENTIFY -- ERROR 2 rows
--or      a.organization_name <> case when c.middle_initial is not null then c.middle_initial else c.last_business_name end
--or      a.cvr_no <> c.comp_reg_id
--or      a.cpr_no <> c.identify
--or      (a.since_date <> d.since_date and a.since_date is not null)
--or      a.additional_title <> c.additional_title
--or      a.ACCOMMODATION_TYPE <>  d.ACCOMMODATION_TYPE
        (a.ADR_CO_NAME <> d.ADR_CO_NAME and a.ADR_CO_NAME is not null)
or      a.adr_district <> d.adr_district
or      a.adr_email <> d.adr_email
or      a.adr_door_no <> d.adr_door_no
or      a.adr_story <> d.adr_story
or      a.adr_house_letter <> d.adr_house_letter
or      a.adr_country <> d.adr_country
or      a.adr_pob <> d.adr_pob
or      a.adr_direction <> d.adr_direction
or      a.adr_street_name <> d.adr_street_name
or      a.adr_house_no <> d.adr_house_no
or      a.adr_zip <> d.adr_zip
or      a.adr_city <> d.adr_city 
or      a.adr_primary_ln <> d.adr_primary_ln
or      a.adr_secondary_ln <> d.adr_secondary_ln
-- or      substr(a.gender,1,1) <> c.gender
--or      a.birth_date <> c.birth_date
--or      a.middle_initial <> c.middle_initial
--or      a.first_name <> c.first_name
--or      a.last_business_name <> c.last_business_name
       
)
order by 2
;
-- 

select identify,
       *
from   analytics.prod_abt_subscriber_current 
where  subscriber_id in (3346209,3506535)
;

select a.customer_id, 
       a.subscriber_no,
       a.name_id,
       a.expiration_date,
       c.identify
from   raw.import_fokus_raw_address_name_link a,
       raw.import_fokus_raw_name_data c

where  a.subscriber_no = 'GSM04520403493'
and    a.customer_id = '905360103'
and    a.link_type = 'U'
and    (cast(a.expiration_date as timestamp) > current_timestamp() or  a.expiration_date is null)
and    a.name_id = c.name_id
;



-- TEST 24 - test churn date / information
select a.*
from (select cast(a.subscriber_id as bigint) as subscriber_id,
             max(a.effective_date) as churn_date
        from   raw.import_fokus_raw_subscriber a
        where  upper(sub_status) = 'C'
        and    sub_status_last_act in ('CAN','MCN')
        group by 1
        ) as a

left outer join 

        (select distinct 
             a.subscriber_id,
            a.churn_date,
            a.status_reason
        from   analytics.prod_abt_subscriber_current a
        where  a.churn_date is not null
        ) as b

on a.subscriber_id = b.subscriber_id
        
where b.subscriber_id is null
and   a.churn_date < adddate(now(), -5)
order by a.subscriber_id
;

select *
from   raw.import_fokus_raw_subscriber
where subscriber_id ='156202'
;
select *
from   analytics.prod_abt_subscriber_current
where subscriber_id =156202
;


-- test 25 - test consent
36	analysis_date	string	
37	analysis	string	
38	marketing_date	string	
39	marketing	string	
;

select a.subscriber_id,
       a.customer_id,
       a.subscriber_no,
       a.analysis_date,
       a.analysis,
       a.marketing_date,
       b.crm_date,
       a.marketing,
       b.*
       
from   analytics.prod_abt_subscriber_current a
          left outer join 
       analytics.prod_abt_consent_data_btc b
          on a.subscriber_id = b.subscriber_id
where  a.analysis_date is not null
and    a.marketing_date is not null
and    to_date(a.analysis_date) <> to_date(a.marketing_date)
--and a.subscriber_id =13367840
;


select *
from   analytics.prod_abt_consent_data_btc
where subscriber_id = 15693087
;

-- 
-- select count(*) as antal from (
select a.subscriber_id, 
       'Stock' as report_type,
       extract(cast('2019-01-01' as timestamp), 'date') as dato,
       b.churn_date
from   analytics.prod_abt_subscriber_current a
          left outer join 
       analytics.prod_abt_churn_kpi b
          on a.subscriber_id = b.subscriber_id
where  a.start_date <= cast('2019-01-01' as timestamp)
and    a.end_date > cast('2019-01-01' as timestamp)
and    a.status in ('a','s')
and    a.product_brand = 'Telia'
and    a.product_product_group = 'Postpaid BtC'
-- ) as x
;


-- test 30 tree_level <> customer_tree_level ??
select subscriber_id,
       customer_id,
       subscriber_no,
       tree_level,
       customer_tree_level
from   analytics.prod_abt_subscriber_current
where  tree_level <> customer_tree_level
;
-- test 31 account_type_id <> customer_account_type_id ??
select subscriber_id,
       customer_id,
       subscriber_no,
       account_type_id,
       customer_account_type_id
from   analytics.prod_abt_subscriber_current
where  account_type_id <> customer_account_type_id
;
-- test 32 cycle_code <> customer_cycle_code ??
select subscriber_id,
       customer_id,
       subscriber_no,
       cycle_code,
       customer_cycle_code
from   analytics.prod_abt_subscriber_current
where  cycle_code <> customer_cycle_code
;

-- TEst 40 - physical device
select *
from (
select a.subscriber_id,
       a.customer_id,
       a.subscriber_no,
       a.status,
 --      a.sim,
       a.imei,
       b.customer_id as prev_customer_id,
       b.subscriber_no as prev_subscriber_no,
       c.EQUIPMENT_NO,
       case when c.EFFECTIVE_DATE is null then '1900-01-01' else c.EFFECTIVE_DATE end as EFFECTIVE_DATE,
       ROW_NUMBER() OVER (PARTITION BY a.subscriber_id ORDER BY case when c.EFFECTIVE_DATE is null then '1900-01-01' else c.EFFECTIVE_DATE end desc) as rank
from   analytics.prod_abt_subscriber_current a,
       (select distinct 
               subscriber_id, 
               customer_id,
               subscriber_no
 
        from   prod_abt_subscriber_history ) b
        
            left outer join 
        raw.import_fokus_raw_physical_device c
            on b.customer_id = cast(c.customer_id as bigint)
            and b.subscriber_no = c.subscriber_no
            and c.device_type = 'H'
            and c.effective_date is not null

where   a.active_record_flag=1
and     a.subscriber_id = b.subscriber_id
--and     a.subscriber_no = 'GSM04540346801'
and     a.subscriber_id = 298567
) as x
where 1=1
and   x.rank=1
and   x.imei <> x.EQUIPMENT_NO
;



-- TEst 41 - physical device
select *
from (
select a.subscriber_id,
       a.customer_id,
       a.subscriber_no,
       a.status,
       a.sim,
 --      a.imei,
       b.customer_id as prev_customer_id,
       b.subscriber_no as prev_subscriber_no,
       c.EQUIPMENT_NO,
       c.effective_date,
       case when c.expiration_date is null then '9999-12-21' else c.expiration_date end as expiration_date,
       ROW_NUMBER() OVER (PARTITION BY a.subscriber_id ORDER BY case when c.expiration_date is null then '9999-12-31' else c.expiration_date end desc , effective_date desc) as rank
from   analytics.prod_abt_subscriber_current a,
       (select distinct 
               subscriber_id, 
               customer_id,
               subscriber_no
 
        from   prod_abt_subscriber_history ) b
        
            left outer join 
        raw.import_fokus_raw_physical_device c
            on b.customer_id = cast(c.customer_id as bigint)
            and b.subscriber_no = c.subscriber_no
            and c.device_type = 'E'
            and c.EQUIPMENT_LEVEL = '1'
            and c.effective_date is not null

where   a.active_record_flag=1
and     a.subscriber_id = b.subscriber_id
--and     a.subscriber_no = 'GSM04540346801'
and     a.subscriber_id = 	1211816
) as x
where 1=1
--and   x.rank=1
--and   x.sim <> x.EQUIPMENT_NO
;


-- test 50 product_id
select a.subscriber_id,
       a.customer_id,
       a.subscriber_no,
       a.start_date,
       a.end_date,
       a.product_product_id,
       a.from_product_product_id,
       a.product_soc,
       a.from_product_soc,
       a.product_campaign,
       a.from_product_campaign,
       a.product_service_soc,
       a.from_product_service_soc
from   analytics.prod_abt_subscriber_current a
          left outer join 
       base.import_fokus_base_service_agreement b
          on a.customer_no = b.substomer_no
          and a.subscriber_no = b.subscriber_no
          and b.service_type = 'P'
where  a.status in ('a','s')
and    a.active_record_flag = 1
and    a.subscriber_id in (15220103,11879944)
;














