select * from sandbox_sensitive_omi_ich_map;

-----------------------------------------------------------
--
-- March 11, 2019, correct count
--
-----------------------------------------------------------
SELECT 
        *
        /*strleft(sentdate,6) month_created,
        d_map.l3 d3,
        d_map.l2 d2,
        d_map.l1 d1,
        r_map.l3 r3,
        r_map.l2 r2,
        r_map.l1 r1,
        count(*) counts*/

FROM 
sensitive_porting.ich_number_porting_raw_ich_np_transactions ich
-- sensitive_porting.sandbox_sensitive_omi_ich ich

LEFT JOIN sandbox_sensitive_omi_ich_map r_map
    ON (
            ich.currentnetworkoperator = r_map.recipient_networkoperator_cps
            AND
            ich.currentserviceoperator = r_map.recipient_serviceoperator_cps
        )

LEFT JOIN sandbox_sensitive_omi_ich_map d_map
    ON (    
            ich.donornetworkoperator = d_map.recipient_networkoperator_cps
            AND
            ich.donorserviceoperator = d_map.recipient_serviceoperator_cps
            
        )

WHERE strleft(sentdate,6)='201902' -- AND  d_map.l3 <> 'Telia' AND d_map.l3 is NOT NULL  AND ich.currentnumbertype='GSM' 

and d_map.l3='Telenor' and d_map.l2='Telenor'
and r_map.l2='Telenor'

AND ich.oldnumbertype <> 'FIXED'
AND ich.details LIKE 'OTHER%'

/*GROUP BY 
        strleft(sentdate,6),
        d_map.l3,
        d_map.l2,
        d_map.l1,
        r_map.l3,
        r_map.l2,
        r_map.l1*/
        
--ORDER BY d_map.l3, d_map.l2, d_map.l1,  r_map.l3, r_map.l2, r_map.l1
;

select distinct sentdate
--distinct date_trunc('month', add_months(now(), -1)), date_trunc('month',now())
from sensitive_porting.ich_number_porting_raw_ich_np_transactions --order by sentdate desc
where sentdate >= date_trunc('month', add_months(now(), -1)) and sentdate< date_trunc('month',now());

select *
--distinct date_trunc('month', add_months(now(), -1)), date_trunc('month',now())
from sensitive_porting.ich_number_porting_number_porting_join
where d_map_l3='Telenor' and d_map_l2='Telenor'
and c_map_l2='Telenor'
and sentdate >= date_trunc('month', add_months(now(), -1)) and sentdate< date_trunc('month',now());;

select *
--distinct date_trunc('month', add_months(now(), -1)), date_trunc('month',now())
from sensitive_porting.ich_number_porting_number_porting_join
where d_map_l3='Telenor' and d_map_l2='Telenor'
and c_map_l2='Telenor'
and sentdate >= date_trunc('month', add_months(now(), -1)) and sentdate< date_trunc('month',now());


select 'Ondrej' as src,* from sandbox_sensitive_omi_ich_map where l3='Telenor' and l2='Telenor'
union all
select 'Jakub' as src, * from base.manual_files_base_man_ich_map where l3='Telenor' and l2='Telenor';

select 'Empty recipient_networkop_cps_Ondrej' as col, count(*) from sandbox_sensitive_omi_ich_map where recipient_networkoperator_cps=''
union
select 'Null recipient_networkop_cps_Jakub' as col,count(*) from base.manual_files_base_man_ich_map where recipient_networkoperator_cps is null;

select recipient_networkoperator_cps from sandbox_sensitive_omi_ich_map order by recipient_networkoperator_cps asc;