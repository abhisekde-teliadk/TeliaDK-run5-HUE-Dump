SELECT 
--count(*)
/*Customer.Account_Type_id,
Account_type.Acc_type,
Account_type.acc_sub_type,
concat(Account_type.Acc_type,'-',Account_type.acc_sub_type),*/
memo.Memo_ban as Customer_number,
--customer.First_name ||' '|| customer.Last_business_name as Customer_full_name,
memo.Memo_subscriber as Subscriber_no,
substr(memo. Memo_subscriber, 7, 8) as MSISDN,
charge.Chg_creation_date as Charge_Creation_date,
charge.Actv_amt as Charge_activation_amount,
users.user_full_name as User_Full_Name,
Feature.Feature_Group as Feature_Group,
feature.Feature_desc as Feature_Description,
Feature. Feature_code as Feature_code,
adjustment_reason.adj_dsc as Adjustement_Description,
Memo.Memo_manual_txt as Mamo_manual_txt,
Memo. Memo_system_txt as Memo_system_txt,
Account_type.description as Brand
From
    base.import_fokus_samples_base_memo_sample as memo 
    JOIN base.import_fokus_base_charge as charge ON
        Charge.Memo_id = memo.Memo_id
    JOIN base.import_fokus_samples_base_users_sample as users ON
        Users.User_id = memo.operator_id 
       -- Users.User_full_name not in ('Callme - Athene', 'BATCH kørsler') 
    LEFT OUTER JOIN
    base.import_fokus_samples_base_feature_sample as feature ON
        Feature. Feature_code = charge. feature_code
    LEFT OUTER JOIN
    base.import_fokus_samples_base_adjustment_reason_sample as Adjustment_reason ON
        Adjustment_reason.Reason_code = charge.actv_reason_code
    LEFT OUTER JOIN
    work.base_equation_sub_tbt_customer_history as customer ON
        Customer.Customer_id = memo.Memo_ban AND
        Charge.Chg_creation_date between customer.Start_date and customer.End_date
    LEFT OUTER JOIN
    base.import_fokus_base_account_type as Account_type ON
 concat(Account_type.Acc_type,'-',Account_type.acc_sub_type) = Customer.Account_Type_id
where Charge.Actv_reason_code <> 'FTELCR'
AND  Users.User_full_name not in ('Callme - Athene', 'BATCH kørsler')
AND    memo.sys_creation_date >= date_sub(trunc(now(), 'month'), interval 3 months)
        --last_day_of_month (sysdate - 4 months) + 1 day and
AND    Charge.sys_creation_date >= date_sub(trunc(now(), 'month'), interval 3 months);
        --last_day_of_month (sysdate - 4 months) + 1 day and*/
    
--select * from base.import_fokus_samples_base_memo_sample;

select date_sub(trunc(now(), 'month'),  interval 3 months);