SELECT * FROM analytics.prod_abt_35608409_history
where subscriber_no = 'GSM04540346801'
order by start_date
;

SELECT a.*
FROM   analytics.prod_abt_subscriber_imei_history a
          left outer join
       base.manual_files_base_tac b
          on a.tac = b.tac
where  a.subscriber_no = 'GSM04540346801'
order by a.start_date
; 

SELECT * FROM base.manual_files_base_tac LIMIT 100;