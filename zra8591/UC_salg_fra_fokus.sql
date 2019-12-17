create table sandbox.zra_temp_charge as 
SELECT * 
FROM base.import_fokus_base_charge_parquet 
where actv_bill_seq_no <> 0 
and bl_ignore_ind=false
and  chg_creation_date >='2018-07-01 00:00:00' and chg_creation_date <= '2019-08-31 00:00:00' 
;


create table sandbox.zra_temp_dt3 as
select a.*, b.feature_desc, c.ftr_category_desc
from 
sandbox.zra_temp_charge a 
left join raw.import_fokus_raw_feature b 
on a.feature_code=b.feature_code
left join raw.import_fokus_raw_feature_category c
on a.feature_category=c.ftr_category
;


create table sandbox.zra_temp_a as select root_ban,
    BAN,SOC,
    ACTV_BILL_SEQ_NO,
    SUBSCRIBER_NO,
    PRIOD_CVRG_ST_DATE,
    PRIOD_CVRG_ND_DATE,
    SUM(ACTV_AMT) as amount_inclvat,
    sum(duration) as duration,
    sum(num_of_calls) as antal,
    FTR_REVENUE_CODE,BILL_COMMENT,
    SUM(VAT_AMT) as amount_vat,
    INV_SEQ_NO,
    VAT_PERCENT_RATE,
    VAT_EXMP_IND,
    BL_IGNORE_IND,
    FEATURE_DESC,
    feature_code,
    BILL_RELEVANCE_IND,
    SUM(DISC_AMT) as DISC_AMT,
    SUM(DISC_VAT_AMT) as DISC_VAT_AMT,
    SUM(DISC_UTC_AMT) as DISC_UTC_AMT,
    SUM(DISC_UTC_VAT) as DISC_UTC_VAT
FROM sandbox.zra_temp_dt3
where BILL_RELEVANCE_IND = 'S' 
group by BAN,ACTV_BILL_SEQ_NO,SUBSCRIBER_NO,root_ban,PRIOD_CVRG_ST_DATE,PRIOD_CVRG_ND_DATE,FTR_REVENUE_CODE,
feature_code,INV_SEQ_NO,VAT_PERCENT_RATE,SOC,VAT_EXMP_IND,BL_IGNORE_IND,BILL_RELEVANCE_IND,FEATURE_DESC,BILL_COMMENT;

--kørt hertil --


-- select DISC_AMT (DOUBLE) ,DISC_VAT_AMT (DOUBLE)
-- from sandbox.zra_temp_a
-- ;



 CREATE TABLE sandbox.zra_temp_QUERY_FOR_A2 AS 
   SELECT t1.root_ban,t1.BAN, 
          t1.ACTV_BILL_SEQ_NO, 
          t1.SUBSCRIBER_NO, T1.SOC,
          t1.PRIOD_CVRG_ST_DATE, t1.BILL_COMMENT,
          t1.PRIOD_CVRG_ND_DATE, 
          t1.amount_inclvat, 
          t1.FTR_REVENUE_CODE, 
          t1.amount_vat, 
          t1.INV_SEQ_NO, 
          t1.VAT_PERCENT_RATE, 
          t1.VAT_EXMP_IND, 
          t1.BL_IGNORE_IND, 
          t1.FEATURE_DESC, 
          t1.FEATURE_CODE, 
          t1.BILL_RELEVANCE_IND, 
          t1.DISC_AMT, 
          t1.DISC_VAT_AMT, 
          t1.DISC_UTC_AMT, 
          t1.DISC_UTC_VAT, 
                     sum(t1.duration) as a,
sum(t1.antal) as b,

          /* rabat */
            (sum(t1.DISC_AMT- t1.DISC_VAT_AMT)) AS rabat, 
          /* amountexvatinklrabat */
            (SUM(t1.amount_inclvat-t1.amount_vat)) AS amountexvatinklrabat
      FROM sandbox.zra_temp_a AS t1
            group by 
            t1.root_ban,t1.BAN, 
          t1.ACTV_BILL_SEQ_NO, 
          t1.SUBSCRIBER_NO, 
          t1.PRIOD_CVRG_ST_DATE, 
          t1.PRIOD_CVRG_ND_DATE, 
          t1.amount_inclvat,  t1.BILL_COMMENT,
          t1.FTR_REVENUE_CODE, 
          t1.amount_vat, 
          t1.INV_SEQ_NO, 
          t1.VAT_PERCENT_RATE, T1.SOC,
          t1.VAT_EXMP_IND, 
          t1.BL_IGNORE_IND, 
          t1.FEATURE_DESC, 
          t1.FEATURE_CODE, 
          t1.BILL_RELEVANCE_IND, 
          t1.DISC_AMT, 
          t1.DISC_VAT_AMT, 
          t1.DISC_UTC_AMT, 
          t1.DISC_UTC_VAT
          ;

drop table sandbox.zra_temp_a;
drop table sandbox.zra_temp_QUERY_FOR_A2;
drop table sandbox.zra_temp_a;
drop table  sandbox.zra_temp_dt3;
drop table sandbox.zra_temp_charge;


