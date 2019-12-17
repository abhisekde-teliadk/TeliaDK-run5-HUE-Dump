strleft(sentdate, 6) = 
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
sensitive_porting.sandbox_sensitive_omi_ich ich

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

WHERE strleft(sentdate,6)='201901' -- AND  d_map.l3 <> 'Telia' AND d_map.l3 is NOT NULL  AND ich.currentnumbertype='GSM' 

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
        
ORDER BY d_map.l3, d_map.l2, d_map.l1,  r_map.l3, r_map.l2, r_map.l1;

select * from sensitive_porting.sandbox_sensitive_omi_ich;
select * from sandbox_sensitive_omi_ich_map;