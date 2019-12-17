SELECT * FROM (
-- SELECT COUNT(*) FROM (

SELECT A.CUSTOMER_ID AS BASE_CUSTOMER_ID,
       B.CUSTOMER_ID AS HIST_CUSTOMER_ID,
       A.SUBSCRIBER_NO AS BASE_SUBSCRIBER_NO,
       B.SUBSCRIBER_NO AS HIST_SUBSCRIBER_NO,
       A.PRICEPLAN AS BASE_PRICEPLAN,
       B.PRICEPLAN as HIST_PRICEPLAN
       
FROM   (SELECT CUSTOMER_ID,
               SUBSCRIBER_NO,
               SOC AS PRICEPLAN
       
        FROM   SANDBOX.YOGESH_MANUAL_TEST2
        WHERE  1=1 
        -- AND    SUBSCRIBER_NO IN ('GSM04560133851','GSM04526280377','GSM04560168401') 
        --AND       PRICEPLAN IN ='INSURCP'

        ) A
        
          FULL OUTER JOIN 
          
       (SELECT CUSTOMER_ID,
              SUBSCRIBER_NO,
               SOC as PRICEPLAN
               
       
        FROM   SANDBOX.YOGESH_HIST_TEST4 
        WHERE  1=1
        -- AND    SUBSCRIBER_NO IN ('GSM04560133851','GSM04526280377','GSM04560168401')
        --AND       PRICEPLAN IN ='INSURCP'
        ) B
        
          ON A.CUSTOMER_ID = B.CUSTOMER_ID
          AND A.SUBSCRIBER_NO = B.SUBSCRIBER_NO
          and a.PRICEPLAN=b.PRICEPLAN
          ) X
WHERE   X.BASE_CUSTOMER_ID IS NULL 
OR      X.HIST_CUSTOMER_ID IS NULL
OR      X.BASE_PRICEPLAN <> X.HIST_PRICEPLAN

;


