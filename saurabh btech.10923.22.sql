SQL Test (Vetty)
 Vetty SQL Test — Answers
Used MYSQL for solving the given questions
   Name: Saurabh Raj
   Date: 2025-12-05
   Roll: BTECH/10923/22

1. What is the count of purchases per month (excluding refunded purchases)? 


SELECT
     DATE_FORMAT(purchase_time, '%Y-%m') as  month_start_date,
    COUNT(*) AS purchase_count
FROM transactions
WHERE refund_item IS NULL        
-- exclude refunded purchases

GROUP BY DATE_FORMAT(purchase_time, '%Y-%m')
ORDER BY month_start_date;

EXPLANATION : We want to know how many actual purchases happened each month.
Filter out refunded transactions, group the remaining purchases by month, and count them.

2. How many stores receive at least 5 orders in October 2020?

WITH store_orders AS (
    SELECT
        store_id,
        COUNT(*) AS order_count
    FROM transactions
    WHERE purchase_time >= '2020-10-01'
      AND purchase_time <  '2020-11-01'  
 -- all of October 2020

    GROUP BY store_id
)
SELECT
    COUNT(*) AS num_stores_with_5plus_orders
FROM store_orders
WHERE order_count >= 5;

EXPLANATION:  Select transactions from October 2020, count orders per store, 
and return how many stores reached at least five orders.


3.  For each store, what is the shortest interval (in min) from purchase to refund time? 

SELECT
    store_id,
    MIN(
        TIMESTAMPDIFF(MINUTE, purchase_time, refund_item)
    ) AS min_refund_interval_minutes  
 -- shortest interval

FROM transactions
WHERE refund_item IS NOT NULL 
 -- only refunded orders

GROUP BY store_id;

EXPLANATION: Calculate the time difference between purchase and refund for refunded transactions,
 then pick the minimum value for each store.

4.  What is the gross_transaction_value of every store’s first order? 

SELECT t1.store_id,
       t1.buyer_id,
       t1.purchase_time AS first_order_time,
       t1.gross_transaction_value AS first_order_gross_value
FROM transactions t1
JOIN (
    SELECT store_id, MIN(purchase_time) AS first_purchase_time
    FROM transactions
    GROUP BY store_id
) t2
ON t1.store_id = t2.store_id
AND t1.purchase_time = t2.first_purchase_time
ORDER BY t1.store_id;

EXPLANATION: Identify the earliest transaction for each store using ordering then return its gross transaction value.

5. What is the most popular item name that buyers order on their first purchase? 

SELECT i.item_name, COUNT(*) AS times_ordered_as_first_purchase
FROM (
    SELECT buyer_id, store_id, item_id
    FROM (
        SELECT t.*, ROW_NUMBER() OVER (PARTITION BY buyer_id ORDER BY purchase_time) AS r
        FROM transactions t
    ) x
    WHERE r = 1
) fp
JOIN items i
  ON i.store_id = fp.store_id AND i.item_id = fp.item_id
GROUP BY i.item_name
ORDER BY times_ordered_as_first_purchase DESC, i.item_name
LIMIT 1;

EXPLANATION: Find each buyer’s first transaction, list the items from those orders, and count which item appears most frequently.

6. Create a flag in the transaction items table indicating whether the refund can be processed or not. The condition for a refund to be processed is that it has to happen within 72 of Purchase time?

SELECT
    t.*,
    CASE
        WHEN t.refund_item IS NOT NULL
             AND TIMESTAMPDIFF(HOUR, t.purchase_time, t.refund_item) <= 72
        THEN 'True'        -- refund can be processed
        ELSE 'False'    -- too late or missing
    END AS refund_processable
FROM transactions t;

EXPLANATION:Compare refund time with purchase time and mark the transaction as eligible if the refund occurred within 72 hrs.

7. Create a rank by buyer_id column in the transaction items table and filter for only the second purchase per buyer?

SELECT *
FROM (
    SELECT t.*, ROW_NUMBER() OVER (PARTITION BY buyer_id ORDER BY purchase_time) AS r
    FROM transactions t
) x
WHERE r = 2
ORDER BY buyer_id, purchase_time;

EXPLANATION: Remove refunded transactions, rank each buyer’s valid purchases by time, and select the one ranked second.

8. 
SELECT buyer_id, purchase_time AS second_purchase_time
FROM (
    SELECT buyer_id, purchase_time,
           ROW_NUMBER() OVER (PARTITION BY buyer_id ORDER BY purchase_time) AS r
    FROM transactions
) x
WHERE r = 2
ORDER BY buyer_id;

EXPKLANATION : Sort transactions per buyer by time, assign row numbers, and return the timestamp of the row ranked second.






























































































