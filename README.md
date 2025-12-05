# Vetty-SQL-Test_-BTECH-10923-22-


1. What is the count of purchases per month (excluding refunded purchases)? 

EXPLANATION : We want to know how many actual purchases happened each month.
Filter out refunded transactions, group the remaining purchases by month, and count them.

2. How many stores receive at least 5 orders in October 2020?


EXPLANATION:  Select transactions from October 2020, count orders per store, 
and return how many stores reached at least five orders.

3.  For each store, what is the shortest interval (in min) from purchase to refund time? 

EXPLANATION: Calculate the time difference between purchase and refund for refunded transactions,
 then pick the minimum value for each store.

4.  What is the gross_transaction_value of every store’s first order? 
EXPLANATION: Identify the earliest transaction for each store using ordering then return its gross transaction value.

5. What is the most popular item name that buyers order on their first purchase? 
EXPLANATION: Find each buyer’s first transaction, list the items from those orders, and count which item appears most frequently.

6. Create a flag in the transaction items table indicating whether the refund can be processed or not. The condition for a refund to be processed is that it has to happen within 72 of Purchase time?
EXPLANATION:Compare refund time with purchase time and mark the transaction as eligible if the refund occurred within 72 hrs.


7. Create a rank by buyer_id column in the transaction items table and filter for only the second purchase per buyer?
EXPLANATION: Remove refunded transactions, rank each buyer’s valid purchases by time, and select the one ranked second.

8.How will you find the second transaction time per buyer (don’t use min/max; assume there were more transactions per buyer in the table) Expected Output: Only the second purchase of buyer_id along with a timestamp 
EXPKLANATION : Sort transactions per buyer by time, assign row numbers, and return the timestamp of the row ranked second.
