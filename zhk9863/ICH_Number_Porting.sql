
SELECT count(*) 
FROM 
sensitive_porting.ich_number_porting_raw_ich_np_transactions ich
WHERE strleft(ich.sentdate,4) = '2017' AND ich.oldnumbertype <> 'GSM' 
-- AND ich.details --LIKE 'OTHER%' 
-- AND ich.currentnumbertype = 'FIXED'
AND ich.recipientserviceoperator =  '01010' --'08023'
;



SELECT *
FROM 
sensitive_porting.ich_number_porting_raw_ich_np_transactions ich
LIMIT 100
;


select 'Empty recipient_networkop_cps_Ondrej' as col, count(*) 
from sandbox_sensitive_omi_ich_map where recipient_networkoperator_cps=''
union
select 'Null recipient_networkop_cps_Jakub' as col,count(*) 
from base.manual_files_base_man_ich_map where recipient_networkoperator_cps is null;


SELECT * FROM sensitive_porting.ich_number_porting_abt_number_porting_email
WHERE year_month = '201902'

LIMIT 600;


SELECT 
concat(
cast(

                date_part('year', 
                                        add_months(now(), -1)
                ) 
            as STRING)

,
strleft(

        concat('0', 
            cast(

                date_part('month', 
                                        add_months(now(), -1)
                ) 
            as STRING)
        ),  2)
)
;

SELECT 
        strleft(sentdate,6) month_created,

        -- donors
        nvl(d_map.l3, concat(ich.donornetworkoperator, '/',ich.donorserviceoperator )) d3,
        nvl(d_map.l2, concat(ich.donornetworkoperator, '/',ich.donorserviceoperator )) d2,
        nvl(d_map.l1, concat(ich.donornetworkoperator, '/',ich.donorserviceoperator )) d1,

        -- recipients
        nvl(r_map.l3, concat(ich.currentnetworkoperator, '/',ich.currentserviceoperator )) r3,
        nvl(r_map.l2, concat(ich.currentnetworkoperator, '/',ich.currentserviceoperator )) r2,
        nvl(r_map.l1, concat(ich.currentnetworkoperator, '/',ich.currentserviceoperator )) r1,

        count(*) counts

FROM 
-- sensitive_porting.sandbox_sensitive_omi_ich ich
sensitive_porting.ich_number_porting_raw_ich_np_transactions ich

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

WHERE 

    strleft(sentdate,6)= concat(
                                cast(date_part('year', add_months(now(), -1)) as STRING) -- take year of the previous month
                                ,
                                strleft(concat('0', -- take month number of the previous month
                                            cast(date_part('month',add_months(now(), -1)) as STRING)),
                                        2) 
                                )
AND ich.oldnumbertype <> 'FIXED'
AND ich.details LIKE 'OTHER%'

GROUP BY 
        strleft(sentdate,6),

        -- donors
        nvl(d_map.l3, concat(ich.donornetworkoperator, '/',ich.donorserviceoperator )),
        nvl(d_map.l2, concat(ich.donornetworkoperator, '/',ich.donorserviceoperator )),
        nvl(d_map.l1, concat(ich.donornetworkoperator, '/',ich.donorserviceoperator )),

        -- recipients
        nvl(r_map.l3, concat(ich.currentnetworkoperator, '/',ich.currentserviceoperator )),
        nvl(r_map.l2, concat(ich.currentnetworkoperator, '/',ich.currentserviceoperator )),
        nvl(r_map.l1, concat(ich.currentnetworkoperator, '/',ich.currentserviceoperator ))

        
ORDER BY d3, d2, d1, r3, r2, r1

;


-----------------------------------------------------------
--
-- confirmed on a call with Heine on March 1st, 2019 13:30
--
-----------------------------------------------------------
SELECT 
        strleft(sentdate,6) month_created,
        d_map.l3 d3,
        d_map.l2 d2,
        d_map.l1 d1,
        r_map.l3 r3,
        r_map.l2 r2,
        r_map.l1 r1,
        count(*) counts

FROM 
-- sensitive_porting.sandbox_sensitive_omi_ich ich
sensitive_porting.ich_number_porting_raw_ich_np_transactions ich

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

AND ich.oldnumbertype <> 'FIXED'
AND ich.details LIKE 'OTHER%'

GROUP BY 
        strleft(sentdate,6),
        d_map.l3,
        d_map.l2,
        d_map.l1,
        r_map.l3,
        r_map.l2,
        r_map.l1
        
ORDER BY d_map.l3, d_map.l2, d_map.l1,  r_map.l3, r_map.l2, r_map.l1

;












SELECT strleft(sentdate,6), count(*) 
FROM sensitive_porting.sandbox_sensitive_omi_ich 
GROUP BY strleft(sentdate,6)
;

-- 84132 whole february 2019, 78697 february up to day 25, 79360 for January
SELECT count(*) FROM sensitive_porting.sandbox_sensitive_omi_ich ich
WHERE strleft(sentdate,6)='201901' and ich.currentnumbertype='GSM' --and cast(strright(sentdate,2) as INT) < 26
;

SELECT * FROM sensitive_porting.sandbox_sensitive_omi_ich LIMIT 100; 

SELECT * FROM sensitive_porting.sandbox_sensitive_omi_ich_map LIMIT 100;