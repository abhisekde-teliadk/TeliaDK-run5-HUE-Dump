SELECT distinct 
       subscriber_id,
       effective_date,
       sub_status,
       * 
FROM raw.import_fokus_raw_subscriber 
where subscriber_id = '49876'
order by subscriber_id,
         effective_date
;