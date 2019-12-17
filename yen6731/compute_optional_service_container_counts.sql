select
 cp.*,
 nvl(cnt.cnt,0) as service_active,
 2*nvl(cnt.cnt,0) as used_points
  from base_equation_work_optional_service_container_prepared cp
  left outer join
  (
   select
   sx.ban,
   sx.subscriber_no,
   osc.soc,
   osc.change_date,
   count(*) as cnt
   from       
     base_equation_work_osc_change osc left outer join
     base_equation_work_service_agreement_subscr_joined sx on
       substr(sx.soc,1,3) = osc.soc and
	   sx.ban = osc.customer_id and 
	   sx.subscriber_no = osc.subscriber_no and
       sx.service_type in ('R','O','S') and
       sx.SOC NOT in (
      'OSCA', 'OSCB', 'OSCC', 'OSCD',
      'OSB1', 'OSB2', 'OSB3', 'OSB4') and
     osc.change_date between sx.effective_date and sx.expiration_date
   group by
     sx.ban,
     sx.subscriber_no,
     osc.soc,
     osc.change_date
   ) as cnt
   on
     cp.ban = cnt.ban and
     cp.subscriber_no = cnt.subscriber_no and
     substr(cp.soc,1,3) = cnt.soc and
     trunc(cp.oscc_change_date,'dd')=trunc(cnt.change_date,'dd')