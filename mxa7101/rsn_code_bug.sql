	SELECT 
	    kpi.subscriber_id,
	    kpi.subscriber_no,
	    kpi.customer_id,
	    kpi.churn_date,
	    kpi.churn_reason_desc,
	    kpi.churn_reason_group as_is,
	    ar.equation_group to_be
	    FROM 
	        analytics.abt_churn_kpi kpi
	        join base.manual_files_base_man_activity_reason ar on
	            ar.reason_desc = kpi.churn_reason_desc
	        LIMIT 100;
	        
	        
	SELECT 
	    kpi.subscriber_id,
	    kpi.subscriber_no,
	    kpi.customer_id,
	    kpi.churn_date,
	    kpi.churn_reason_desc,
	    kpi.recipient_operator as_is,
	    td.recip_serv_oper to_be
	    FROM 
	        analytics.abt_churn_kpi kpi
	        join base.import_fokus_base_np_number_info ni on
	            ni.subscriber_id = kpi.subscriber_id and
	            ni.port_number = substr(kpi.subscriber_no,7,8)
	        join base.import_fokus_base_np_trx_detail td on
	            td.trx_source = 'EXT' and
	            td.trx_code = '1' and
	            td.int_order_id = ni.int_order_id
	            where kpi.recipient_operator != td.recip_serv_oper
        --LIMIT 100
        
        ;
        
select sub.start_date, sub.subscriber_id, sub.port_number --, ni.effective_date, ni.expiration_date, trx.recip_serv_oper, sub.sub_status_rsn_code
from work.base_equation_sub_work_subscriber_history_all sub
where sub.subscriber_id = 15452296;

        
        
        
select sub.start_date, sub.subscriber_id, sub.port_number, ni.effective_date, ni.expiration_date, trx.recip_serv_oper, sub.sub_status_rsn_code
from work.base_equation_sub_work_subscriber_history_all sub
left join base.import_fokus_base_np_number_info ni
on
sub.subscriber_id = ni.subscriber_id
and
				sub.port_number = ni.port_number
				and
				(sub.start_date between 
					ni.effective_date and
					ni.expiration_date)
left join base.import_fokus_base_np_trx_detail trx
on trx.int_order_id = ni.int_order_id

inner join base.import_fokus_base_billing_account ba
on sub.customer_id = ba.ban

					
where sub.subscriber_id = 15574130
and sub.port_number = '21192860'
;
        
        
select  
    subscriber_id,
    port_number,
    effective_date,
    expiration_date,
    int_order_id,
    base.import_fokus_base_np_number_info.*
    from
        base.import_fokus_base_np_number_info
        where
            subscriber_id = 15574130
            and port_number = '21192860';
            
select  
    int_order_id,
    trx_source,
    trx_code,
    recip_serv_oper,
    base.import_fokus_base_np_trx_detail.*
    from
        base.import_fokus_base_np_trx_detail
        where
            int_order_id in ( 14176906, 14050608);
        
select reason_code, reason_desc, recipient_operator, subscriber_no, customer_id, start_date
from work.base_equation_sub_tbt_subscriber_history
where reason_desc like '%Port Out%';

select sub_status_rsn_code, port_number, subscriber_id, subscriber_no, customer_id, start_date, recip_serv_oper
from work.base_equation_sub_work_subscriber_rest_data
where subscriber_id = 15452296
and port_number = '22271271'
;


select subscriber_id, port_number, start_date
from work.base_equation_sub_work_subscriber_history_all 
where subscriber_id = 15452296
and port_number = '22271271'
;

select subscriber_id, port_number, effective_date
from base.import_fokus_base_np_number_info
where subscriber_id = 15452296
and port_number = '22271271'
;



select reason_code, reason_desc, recipient_operator, subscriber_no, customer_id, start_date
from work.base_equation_sub_tbt_subscriber_history
where reason_desc like '%Port Out%'
and reason_code like '%PONO%';


select sub_status_rsn_code, port_number, subscriber_id, subscriber_no, customer_id, start_date, recip_serv_oper
from work.base_equation_sub_work_subscriber_deduplicated
where subscriber_id = 15574130
and port_number = '21192860';



select * from work.contr_obligations_tdc_edi_accounting_duplicate_count where invoice_number=3069446740411 and invoice_line=1066;

select * from finance.abt_circuit_bridge
where foreign_circuit = 'EV531803';

select * from finance.abt_circuit_customer_bridge
where telia_circuit_id = 'EV531803';

select *
from base.import_other_sources_base_edi_extract
where tdc_circuit_id = 'EV531803';