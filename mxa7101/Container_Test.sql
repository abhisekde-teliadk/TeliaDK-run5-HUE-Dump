-- OSC Change Table --
SELECT *
FROM work.base_equation_work_osc_change;

-- First Join --
SELECT *
FROM work.base_equation_work_osc_change AS OSC_NEXT_CHANGE
INNER JOIN work.base_equation_work_optional_service_container_filtered AS OSC_CHANGE
ON OSC_NEXT_CHANGE.subscriber_no = OSC_CHANGE.subscriber_no
AND OSC_NEXT_CHANGE.customer_id = OSC_CHANGE.BAN
AND OSC_NEXT_CHANGE.change_date >= OSC_CHANGE.effective_date
AND OSC_NEXT_CHANGE.change_date <= OSC_CHANGE.expiration_date
WHERE OSC_CHANGE.service_type IN ('R', 'O', 'S')
AND substr(OSC_CHANGE.soc, 1, 3) = OSC_NEXT_CHANGE.soc
AND OSC_CHANGE.soc IN (
      'OSCA', 'OSCB', 'OSCC', 'OSCD',
      'OSB1', 'OSB2', 'OSB3', 'OSB4');

select
CP.*,
nvl(CNT.cnt,0) as service_active,
2*nvl(CNT.cnt,0) as used_points
FROM work.base_equation_work_optional_service_container_prepared AS CP   
LEFT outer join (
SELECT
   SX.ban,
   SX.subscriber_no,
   OSC.soc,
   OSC.change_date,
   count(*) as cnt
FROM work.base_equation_work_osc_change AS OSC
INNER JOIN work.base_equation_work_service_agreement_subscr_joined AS SX
ON 
substr(SX.soc,1,3) = OSC.soc 
AND SX.ban = OSC.customer_id
AND SX.subscriber_no = OSC.subscriber_no
AND SX.service_type IN ('R','O','S')
AND SX.SOC NOT IN (
      'OSCA', 'OSCB', 'OSCC', 'OSCD',
      'OSB1', 'OSB2', 'OSB3', 'OSB4') 
AND OSC.change_date BETWEEN SX.effective_date AND SX.expiration_date
GROUP BY
SX.ban,
SX.subscriber_no,
OSC.soc,
OSC.change_date) AS CNT
ON
    CP.ban = cnt.ban 
    AND
    CP.subscriber_no = CNT.subscriber_no 
    AND
    substr(CP.soc,1,3) = CNT.soc 
    AND
    trunc(CP.oscc_change_date,'dd')=trunc(CNT.change_date,'dd');



      

