select * from analytics.abt_self_service_profiles where sub_profile_days < 0 order by sub_profile_days asc;
select * from analytics.abt_self_service_profiles where ban_profile_days < 0 order by sub_profile_days asc; --8602

select  datecreated, count(*) from analytics.abt_self_service_profiles where sub_profile_days < 0 group by datecreated order by 2 desc;

select * from analytics.abt_self_service_profiles where ban_profile_days is null and ghost=false and id not in (select userid from base.import_self_service_base_user_ban);

select count(*) from analytics.abt_self_service_profiles where sub_profile_days < 0;
select count(*) from analytics.abt_self_service_profiles where sub_profile_days is null;
select * from analytics.abt_self_service_profiles where sub_profile_days is null;
select * from analytics.abt_self_service_profiles where id=1378;
select count(*) from analytics.abt_self_service_profiles;
select count(*) from analytics.abt_self_service_profiles where ban_profile_days is null and ghost = false; -- 75.000 vs 35.212 (false ghost)
select count(*) from analytics.abt_self_service_profiles where ban_profile_days < 0; -- 8.818

select * from analytics.abt_self_service_profiles where id=1232;
select start_service_date from analytics.abt_customer_current where customer_id=476319207;

SELECT
        DISTINCT
        usr.id as USER_id,
        usr.datecreated as USER_datecreated_in_switchr,
        subdates.subscriber_date as subscriber_id_creation_date_in_fokus,
        subdates.u_sub_datecreated as subscriber_id_created_in_switchr,
        datediff(usr.datecreated, subdates.subscriber_date) sub_profile_days,gf
        datediff(subdates.u_sub_datecreated, subdates.subscriber_date) new_profile_days
       -- subdates.last_churn_date
   FROM
    -- user entity
    base.import_self_service_base_user usr
 
   LEFT JOIN
     (
    -- getting the first subscription and last churned day
    SELECT usub.userid AS subdate_usr_id,
    usub.datecreated as u_sub_datecreated,
              /*first_value*/last_value(suc.subscriber_id_activation_date) OVER (PARTITION BY usub.userid ORDER BY suc.subscriber_id_activation_date ASC) AS subscriber_date
              first_value(suc.subscriber_id_activation_date) OVER (PARTITION BY usub.userid ORDER BY suc.subscriber_id_activation_date ASC) AS subscriber_date_
             -- /*last_value*/last_value(suc.churn_date) OVER (PARTITION BY usub.userid ORDER BY suc.churn_date ASC) AS last_churn_date
               
      FROM base.import_self_service_base_user_subscription usub,
           analytics.abt_subscriber_history suc
      WHERE usub.subscriptionid = suc.subscriber_id
      --and suc.subscriber_id=1377970
      -- GROUP BY usub.userid
      ) subdates ON usr.id = subdates.subdate_usr_id
   WHERE 
   usr.id=14150
   or usr.id=6003
   ORDER BY usr.datecreated DESC;
    
    select count(*) from base.import_self_service_base_user where contactmsisdn is not null;
    
    select * from work.self_service_data_user_subscriber_join where id in (14150, 6003) order by id, start_date asc;
        select * from work.self_service_data_work_user_sub_current_userid_window where userid in (14150, 6003);
    
select distinct userid from work.self_service_data_work_user_sub_current_userid_window order by userid asc;

    
    select id, datecreated as switchr_datecreated, subscription_start_date, sub_profile_days from analytics.abt_self_service_profiles where id in (14150, 6003, 7761) order by id asc;
    
--    select * from base.import_self_service_base_user where id=14150;
--    select * from base.import_self_service_base_user where id=6003;
   
    select * from base.import_self_service_base_user where id=7761;
    
    select * from base.import_self_service_base_user where id=344349;
    select * from base.import_self_service_base_user_subscription where id=344349;
     select customer_cpr_no,adr_email,subscriber_id_activation_date,* from analytics.abt_subscriber_history where subscriber_id=15972222 order by start_date asc;
    
    select * from analytics.abt_self_service_profiles where id=344349;
    select * from analytics.abt_self_service_profiles where sub_profile_days=0;
    
    select count(*) from base.import_self_service_base_user where contactmsisdn is null; -- 48707
    select count(*) from base.import_self_service_base_user where contactmsisdn is not null; -- 48707
    
    select id, datecreated as switchr_datecreated, subscription_start_date, sub_profile_days from analytics.abt_self_service_profiles where id in (14150, 6003, 7761) order by id asc;
    
    select * from base.import_self_service_base_user where id=1378;
    
--    select trunc(datecreated,'dd'), count(*) from base.import_self_service_base_user group by trunc(datecreated,'dd') order by 1 asc;
    
--    select datecreated,* from base.import_self_service_base_user where ssn='1907902206'; -- 14150
--    select datecreated,* from base.import_self_service_base_user where ssn='0603721063'; -- 6003
--    select datecreated,* from base.import_self_service_base_user where ssn='0708752088'; -- 7761
    
--    select * from base.import_self_service_base_user_subscription where userid=14150; --subscriptionid='16448742'
--    select * from base.import_self_service_base_user_subscription where userid=6003; -- subscriptionid='1377970'
    select * from base.import_self_service_base_user_subscription where userid=7761; -- subscriptionid='16445749'
    select * from base.import_self_service_base_user_subscription where userid=1378; -- no subscription
    
    select u.id, u.name, u.lastname, u.email, u.ssn, u.datecreated, us.datecreated as subscriptionid_datecreated, us.subscriptionid from base.import_self_service_base_user u
    left join base.import_self_service_base_user_subscription us
    ON u.id=us.userid
    where u.id in (7761,1378);
    
    select 
    count(*)
    --u.id, u.name, u.lastname, u.email, u.ssn, u.datecreated, us.datecreated as subscriptionid_datecreated, us.subscriptionid
    from base.import_self_service_base_user u
    left join base.import_self_service_base_user_subscription us
    ON u.id=us.userid
    where us.subscriptionid is null;
    
    select count(*) from base.import_self_service_base_user_subscription where subscriptionid is null;
    
/*    select * from base.import_self_service_base_subscription where id=16448742; -- 14150
    select * from base.import_self_service_base_subscription where subscriptionnumber='GSM04528970987'; -- 14150
    select * from base.import_self_service_base_subscription where id=1377970; -- 6003
    select * from base.import_self_service_base_subscription where subscriptionnumber='GSM04528964003'; -- 6003*/
    ;
    select * from base.import_self_service_base_subscription where id=16445749; -- 7761
    select * from base.import_self_service_base_subscription where subscriptionnumber='GSM04527269802'; -- 7761
    
    select * from base.import_self_service_base_user_subscription where subscriptionid=13338413; -- 1378
    
    select * from base.import_self_service_base_subscription where subscriptionnumber='GSM04527128563'; -- 1378?
    select * from base.import_self_service_base_subscription where subscriptionnumber='GSM04542787863'; -- 1378?
    
/*    select customer_cpr_no,adr_email,subscriber_id_activation_date,* from analytics.abt_subscriber_history where customer_cpr_no='1907902206' order by start_date asc;
    select customer_cpr_no,adr_email,subscriber_id_activation_date,* from analytics.abt_subscriber_history where subscriber_id=16448742;

    select customer_cpr_no,adr_email,subscriber_id_activation_date,* from analytics.abt_subscriber_history where customer_cpr_no='0603721063'; --6003
    select customer_cpr_no,adr_email,subscriber_id_activation_date,* from analytics.abt_subscriber_history where subscriber_id=1377970 order by start_date asc;*/
    ;
    select customer_cpr_no,adr_email,subscriber_id_activation_date,* from analytics.abt_subscriber_history where customer_cpr_no='0708752088'; --7761 0 founded
    select customer_cpr_no,adr_email,subscriber_id_activation_date,* from analytics.abt_subscriber_history where subscriber_id=16445749 order by start_date asc;
    select customer_cpr_no,adr_email,subscriber_id_activation_date,* from analytics.abt_subscriber_history where customer_id=833934219;
    
    select customer_cpr_no,adr_email,subscriber_id_activation_date,* from analytics.abt_subscriber_history where adr_email='christapuch@gmail.com';
    
    select customer_cpr_no,adr_email,subscriber_id_activation_date,* from analytics.abt_subscriber_history where customer_cpr_no='0507841546';-- 1378 - not found
    
    select customer_cpr_no,adr_email,subscriber_id_activation_date,* from analytics.abt_subscriber_history where subscriber_no='GSM04527269802' order by start_date asc;
     select customer_cpr_no,adr_email,subscriber_id_activation_date,* from analytics.abt_subscriber_history where adr_email='ditte.rahbek@gmail.com';
    
    select * from analytics.abt_subscriber_history where customer_cpr_no='1907902206';
    
    select * from analytics.abt_self_service_profiles where id=6003;
    
    select datecreated,* from base.import_self_service_base_user_subscription where userid=6003;
    
   SELECT usub.userid AS subdate_usr_id,
          usub.subscriptionid,
          suc.subscriber_id_activation_date,
          usub.datecreated
      FROM base.import_self_service_base_user_subscription usub,
           analytics.abt_subscriber_current suc
      WHERE usub.subscriptionid = suc.subscriber_id
      --and usub.userid=14150;
      and usub.userid=6003;
      
    select * FROM base.import_self_service_base_user_subscription where userid=14150;
    select customer_id, subscriber_no, start_date, end_date, subscriber_id_activation_date from analytics.abt_subscriber_history where subscriber_id=1377970 order by start_date asc;
    select distinct customer_id, subscriber_no from analytics.abt_subscriber_history where subscriber_id=1377970;

select customer_cpr_no, subscriber_id, status, subscriber_no, start_date, end_date, subscriber_id_activation_date, adr_email
    from analytics.abt_subscriber_history
    where subscriber_id=16448742;

select customer_cpr_no, subscriber_id, status, subscriber_no, start_date, end_date, subscriber_id_activation_date, adr_email
    from analytics.abt_subscriber_history
    where customer_cpr_no='1907902206'
    order by start_date asc;

 select * from analytics.abt_subscriber_history where customer_cpr_no='1907902206' order by start_date desc;

select * from work.base_equation_product_work_sa_product where s_subscriber_id=16448742;

select count(*) from analytics.abt_subscriber_current where start_date > subscriber_id_activation_date;
-- 115 have start_date < activation_date
select count(*) from analytics.abt_subscriber_current where start_date < subscriber_id_activation_date;

select  * from work.self_service_data_user_subscriber_one_prep where subscriber_id=16448742;


select * from work.self_service_data_user_subscriber_data where id=1378;

select * from work.self_service_data_work_user_main_join where sub_profile_days<0;
select * from work.self_service_data_work_user_main_join where id=336016;

select * from analytics.abt_self_service_profiles where id in (336016,1378, 14150,7761,6003);

/*
 *** EXAMPLE nr.1 ***
*/

select * from analytics.abt_self_service_profiles where id in (14150,7761,6003);

select * from base.import_self_service_base_user where id=7761; -- SSN = 0708752088
select * from base.import_self_service_base_user_subscription where userid=7761; -- subscriptionid = '16445749'
select * from base.import_self_service_base_subscription where id=16445749; -- 7761 GSM04527269802

select customer_cpr_no,adr_email,subscriber_id_activation_date,* from analytics.abt_subscriber_history where customer_cpr_no='0708752088'; --7761 0 founded
select customer_cpr_no,adr_email,subscriber_id_activation_date,* from analytics.abt_subscriber_history where subscriber_id=16445749 order by start_date asc;
select customer_cpr_no,adr_email,subscriber_id_activation_date,* from analytics.abt_subscriber_history where customer_id=833934219;
    
select customer_cpr_no,adr_email,subscriber_id_activation_date,* from analytics.abt_subscriber_history where adr_email='christapuch@gmail.com';
select customer_cpr_no,adr_email,subscriber_id_activation_date,* from analytics.abt_subscriber_history where subscriber_no='GSM04527269802' order by start_date asc;


/*
 *** EXAMPLE nr.2 ***
*/

select * from analytics.abt_self_service_profiles where id in (14150,7761,6003,1378);

select * from base.import_self_service_base_user where id=1378; -- SSN = 0507841546
select * from base.import_self_service_base_user_subscription where userid=1378; -- NO subscription

select customer_cpr_no,adr_email,subscriber_id_activation_date,* from analytics.abt_subscriber_history where customer_cpr_no='0507841546'; --1378 0 founded
--select customer_cpr_no,adr_email,subscriber_id_activation_date,* from analytics.abt_subscriber_history where subscriber_id=16445749 order by start_date asc;
--select customer_cpr_no,adr_email,subscriber_id_activation_date,* from analytics.abt_subscriber_history where customer_id=833934219;
    
select customer_cpr_no,adr_email,subscriber_id_activation_date,* from analytics.abt_subscriber_history where adr_email='ditte.rahbek@gmail.com';
select customer_cpr_no,adr_email,subscriber_id_activation_date,* from analytics.abt_subscriber_history where customer_cpr_no='2701812967';
select customer_cpr_no,adr_email,subscriber_id_activation_date,* from analytics.abt_subscriber_history where subscriber_no='GSM04527269802' order by start_date asc;

  