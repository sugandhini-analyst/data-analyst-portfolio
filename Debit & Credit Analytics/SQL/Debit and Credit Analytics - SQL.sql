select * from dcbank;
SHOW TABLES ;
DESCRIBE dcbank;
SHOW COLUMNS FROM dcbank;
select amount from dcbank;

#1. Total Credit Amount  127603386.4

select sum(Amount) as Total_Credit_Amount
FROM dcbank 
Where `Transaction Type`="Credit";

#2. Total Debit Amount    127285269.2

SELECT SUM(Amount) AS Total_Debit_Amount 
FROM dcbank
WHERE `Transaction Type` = 'Debit';

#3. Credit to Debit Ratio
SELECT 
    (SUM(CASE WHEN `Transaction Type` = 'Credit' THEN Amount ELSE 0 END) / 
     NULLIF(SUM(CASE WHEN `Transaction Type` = 'Debit' THEN Amount ELSE 0 END), 0)) 
    AS Credit_to_Debit_Ratio
FROM dcbank;

#4. Net Transaction Amount

SELECT 
    SUM(CASE WHEN `Transaction Type` = 'Credit' THEN Amount ELSE 0 END) - 
    SUM(CASE WHEN `Transaction Type` = 'Debit' THEN Amount ELSE 0 END) 
    AS Net_Transaction_Amount
FROM dcbank;

#5. Account Activity Ratio

SELECT 
   `Account Number`,
    COUNT(*) / NULLIF(AVG(Balance), 0) AS Account_Activity_Ratio
FROM dcbank 
GROUP BY `Account Number`;

#6. Transactions per Day/Week/Month
#Transactions per Day

SELECT `Transaction Date`, COUNT(*) AS Transactions_Per_Day
FROM dcbank
GROUP BY `Transaction Date`;

#Transactions per Week

SELECT  WEEK(`Transaction Date`) AS Week, COUNT(*) AS Transactions_Per_Week
FROM dcbank
GROUP BY WEEK(`Transaction Date`);

#Transactions per Month

SELECT YEAR(`Transaction Date`) AS Year, MONTH(`Transaction Date`) AS Month, COUNT(*) AS Transactions_Per_Month
FROM dcbank
GROUP BY YEAR(`Transaction Date`), MONTH(`Transaction Date`);

#7. Total Transaction Amount by Branch

SELECT Branch, SUM(Amount) AS Total_Transaction_Amount
FROM dcbank
GROUP BY Branch;

#8. Transaction Volume by Bank

SELECT `Bank Name`, SUM(Amount) AS Total_Transaction_Amount
FROM dcbank
GROUP BY `Bank Name`;

#10. Branch Transaction Growth

SELECT Branch, 
       SUM(Amount) AS Total_Transactions,
       SUM(Amount) * 100 / NULLIF(SUM(Amount), 0) AS Growth_Percentage
FROM dcbank
GROUP BY Branch;


#11. High-Risk Transaction Flag

SELECT  `Account Number`, Amount, 
       CASE WHEN Amount > 4000 THEN 'High-Risk' ELSE 'Normal' END AS Risk_Flag
FROM dcbank;

#12. Suspicious Transaction Frequency

SELECT COUNT(*) AS Suspicious_Transactions
FROM dcbank
WHERE Amount > 4000; 

