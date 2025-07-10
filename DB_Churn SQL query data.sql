CREATE TABLE customer (
    Customer_ID VARCHAR(50) PRIMARY KEY,
    Gender VARCHAR(10),
    Age INT,
    Married BOOLEAN,
    State VARCHAR(50),
    Number_of_Referrals INT,
    Tenure_in_Months INT,
    Value_Deal VARCHAR(30),
    Phone_Service BOOLEAN,
    Multiple_Lines BOOLEAN,
    Internet_Service BOOLEAN,
    Internet_Type VARCHAR(30),
    Online_Security BOOLEAN,
    Online_Backup BOOLEAN,
    Device_Protection_Plan BOOLEAN,
    Premium_Support BOOLEAN,
    Streaming_TV BOOLEAN,
    Streaming_Movies BOOLEAN,
    Streaming_Music BOOLEAN,
    Unlimited_Data BOOLEAN,
    Contract VARCHAR(30),
    Paperless_Billing BOOLEAN,
    Payment_Method VARCHAR(50),
    Monthly_Charge NUMERIC(10,2),
    Total_Charges NUMERIC(12,2),
    Total_Refunds NUMERIC(12,2),
    Total_Extra_Data_Charges NUMERIC(12,2),
    Total_Long_Distance_Charges NUMERIC(12,2),
    Total_Revenue NUMERIC(14,2),
    Customer_Status VARCHAR(20),
    Churn_Category VARCHAR(50),
    Churn_Reason VARCHAR(100)
);

Select * from customer;

COPY customer
FROM 'F:\DWL\Power BI Projects\Customer Churn Analysis Porject 1\Data & Resources\Data\Customer_Data.csv'
WITH (FORMAT csv, HEADER true);

CREATE TEMP TABLE temp_customers (...);
COPY temp_customers FROM 'F:\DWL\Power BI Projects\Customer Churn Analysis Porject 1\Data & Resources\Data\Customer_Data.csv' WITH (FORMAT csv, HEADER true);
-- Validate and transform as needed, then insert into your main table.

ALTER TABLE DB_STG_Churn
RENAME TO STG_Churn;

Select * from STG_Churn;

select gender, count(gender) as totatlcount,
count(gender)*100.0 /(select count(*) from stg_churn) as percentage
from stg_churn
group by gender

select Contract, count(Contract) as totatlcount,
count(Contract)*100.0 /(select count(*) from stg_churn) as percentage
from stg_churn
group by Contract

SELECT Customer_Status, Count(Customer_Status) as TotalCount, Sum(Total_Revenue) as TotalRev,
Sum(Total_Revenue) / (Select sum(Total_Revenue) from stg_Churn) * 100  as RevPercentage
from stg_Churn
Group by Customer_Status

SELECT State, Count(State) as TotalCount,
Count(State) * 1.0 / (Select Count(*) from stg_Churn)  as Percentage
from stg_Churn
Group by State
Order by Percentage desc

Select distinct Internet_type  
from stg_churn

SELECT 
    SUM(CASE WHEN Customer_ID IS NULL THEN 1 ELSE 0 END) AS Customer_ID_Null_Count,
    SUM(CASE WHEN Gender IS NULL THEN 1 ELSE 0 END) AS Gender_Null_Count,
    SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS Age_Null_Count,
    SUM(CASE WHEN Married IS NULL THEN 1 ELSE 0 END) AS Married_Null_Count,
    SUM(CASE WHEN State IS NULL THEN 1 ELSE 0 END) AS State_Null_Count,
    SUM(CASE WHEN Number_of_Referrals IS NULL THEN 1 ELSE 0 END) AS Number_of_Referrals_Null_Count,
    SUM(CASE WHEN Tenure_in_Months IS NULL THEN 1 ELSE 0 END) AS Tenure_in_Months_Null_Count,
    SUM(CASE WHEN Value_Deal IS NULL THEN 1 ELSE 0 END) AS Value_Deal_Null_Count,
    SUM(CASE WHEN Phone_Service IS NULL THEN 1 ELSE 0 END) AS Phone_Service_Null_Count,
    SUM(CASE WHEN Multiple_Lines IS NULL THEN 1 ELSE 0 END) AS Multiple_Lines_Null_Count,
    SUM(CASE WHEN Internet_Service IS NULL THEN 1 ELSE 0 END) AS Internet_Service_Null_Count,
    SUM(CASE WHEN Internet_Type IS NULL THEN 1 ELSE 0 END) AS Internet_Type_Null_Count,
    SUM(CASE WHEN Online_Security IS NULL THEN 1 ELSE 0 END) AS Online_Security_Null_Count,
    SUM(CASE WHEN Online_Backup IS NULL THEN 1 ELSE 0 END) AS Online_Backup_Null_Count,
    SUM(CASE WHEN Device_Protection_Plan IS NULL THEN 1 ELSE 0 END) AS Device_Protection_Plan_Null_Count,
    SUM(CASE WHEN Premium_Support IS NULL THEN 1 ELSE 0 END) AS Premium_Support_Null_Count,
    SUM(CASE WHEN Streaming_TV IS NULL THEN 1 ELSE 0 END) AS Streaming_TV_Null_Count,
    SUM(CASE WHEN Streaming_Movies IS NULL THEN 1 ELSE 0 END) AS Streaming_Movies_Null_Count,
    SUM(CASE WHEN Streaming_Music IS NULL THEN 1 ELSE 0 END) AS Streaming_Music_Null_Count,
    SUM(CASE WHEN Unlimited_Data IS NULL THEN 1 ELSE 0 END) AS Unlimited_Data_Null_Count,
    SUM(CASE WHEN Contract IS NULL THEN 1 ELSE 0 END) AS Contract_Null_Count,
    SUM(CASE WHEN Paperless_Billing IS NULL THEN 1 ELSE 0 END) AS Paperless_Billing_Null_Count,
    SUM(CASE WHEN Payment_Method IS NULL THEN 1 ELSE 0 END) AS Payment_Method_Null_Count,
    SUM(CASE WHEN Monthly_Charge IS NULL THEN 1 ELSE 0 END) AS Monthly_Charge_Null_Count,
    SUM(CASE WHEN Total_Charges IS NULL THEN 1 ELSE 0 END) AS Total_Charges_Null_Count,
    SUM(CASE WHEN Total_Refunds IS NULL THEN 1 ELSE 0 END) AS Total_Refunds_Null_Count,
    SUM(CASE WHEN Total_Extra_Data_Charges IS NULL THEN 1 ELSE 0 END) AS Total_Extra_Data_Charges_Null_Count,
    SUM(CASE WHEN Total_Long_Distance_Charges IS NULL THEN 1 ELSE 0 END) AS Total_Long_Distance_Charges_Null_Count,
    SUM(CASE WHEN Total_Revenue IS NULL THEN 1 ELSE 0 END) AS Total_Revenue_Null_Count,
    SUM(CASE WHEN Customer_Status IS NULL THEN 1 ELSE 0 END) AS Customer_Status_Null_Count,
    SUM(CASE WHEN Churn_Category IS NULL THEN 1 ELSE 0 END) AS Churn_Category_Null_Count,
    SUM(CASE WHEN Churn_Reason IS NULL THEN 1 ELSE 0 END) AS Churn_Reason_Null_Count
FROM stg_Churn;

Select * from STG_Churn;

CREATE TABLE prod_churn AS
WITH cte_name AS (
	SELECT Customer_ID,
    Gender,
    Age,
    Married,
    State,
    Number_of_Referrals,
    Tenure_in_Months,
    COALESCE(Value_Deal, 'None') AS Value_Deal,
    Phone_Service,
    COALESCE(Multiple_Lines, 'No') As Multiple_Lines,
    Internet_Service,
    COALESCE(Internet_Type, 'None') AS Internet_Type,
    COALESCE(Online_Security, 'No') AS Online_Security,
    COALESCE(Online_Backup, 'No') AS Online_Backup,
    COALESCE(Device_Protection_Plan, 'No') AS Device_Protection_Plan,
    COALESCE(Premium_Support, 'No') AS Premium_Support,
    COALESCE(Streaming_TV, 'No') AS Streaming_TV,
    COALESCE(Streaming_Movies, 'No') AS Streaming_Movies,
    COALESCE(Streaming_Music, 'No') AS Streaming_Music,
    COALESCE(Unlimited_Data, 'No') AS Unlimited_Data,
    Contract,
    Paperless_Billing,
    Payment_Method,
    Monthly_Charge,
    Total_Charges,
    Total_Refunds,
    Total_Extra_Data_Charges,
    Total_Long_Distance_Charges,
    Total_Revenue,
    Customer_Status,
    COALESCE(Churn_Category, 'Others') AS Churn_Category,
    COALESCE(Churn_Reason , 'Others') AS Churn_Reason
	from STG_Churn
)
Select * from cte_name;

Select * from STG_Churn;
Select * from prod_churn;
DROP TABLE temp_churn;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name NOT IN ('pg_catalog', 'information_schema');
SELECT datname FROM pg_database WHERE datistemplate = false;


Create View vw_ChurnData as
	select * from prod_Churn where Customer_Status In ('Churned', 'Stayed')
Create View vw_JoinData as
	select * from prod_Churn where Customer_Status = 'Joined'

SELECT current_database();
SELECT inet_server_addr();  -- Returns server IP address
SELECT inet_server_port();  -- Returns server port (usually 5432)
CREATE EXTENSION hostname;
SELECT current_server();




