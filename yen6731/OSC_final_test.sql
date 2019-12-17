-- almost final -data OK
select * from base_equation_work_optional_service_container_counted where subscriber_id=14293145; --subscriber_no='GSM04521671517';

-- FINAL dataset with crapy data
select * from base_equation_work_optional_service_container where subscriber_id=14293145; --subscriber_no='GSM04521671517';


-- original (SERVICE AGREEMENT) dataset
select * --subscriber_no, soc, effective_date, service_type, expiration_date
from base_equation_work_service_agreement_subscr_joined
where subscriber_id=14293145 --subscriber_no='GSM04521671517'
    and substr(soc,1,2)='OS'
    order by effective_date desc;