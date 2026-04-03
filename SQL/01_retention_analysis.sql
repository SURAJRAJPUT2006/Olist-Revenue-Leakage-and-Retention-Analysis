/*
═══════════════════════════════════════════════════════════════════
OLIST RETENTION ANALYSIS
═══════════════════════════════════════════════════════════════════

Business Question: 
How does first-order delivery experience impact customer retention?

Key Findings:
- Only 3.1% of customers make repeat purchases
- First-order delays reduce repeat rate from 3.44% to 2.79%
- Revenue opportunity: $3.17M if retention matched industry benchmarks

Author: Suraj Rajput
Date: April 2025
═══════════════════════════════════════════════════════════════════
*/

-- ═══════════════════════════════════════════════════════════════
-- STEP 1: Identify first order for each customer
-- ═══════════════════════════════════════════════════════════════

WITH customer_first_orders AS (
    SELECT 
        customer_unique_id,
        order_id,
        order_purchase_timestamp,
        is_delayed,
        total_payment_value,
        -- Use window function to rank orders by date
        ROW_NUMBER() OVER (
            PARTITION BY customer_unique_id 
            ORDER BY order_purchase_timestamp
        ) AS order_sequence
    FROM order_level
    WHERE order_status = 'delivered'
),

-- ═══════════════════════════════════════════════════════════════
-- STEP 2: Extracted first-order experience metrics
-- ═══════════════════════════════════════════════════════════════

first_order_experience AS (
    SELECT 
        customer_unique_id,
        is_delayed AS first_order_delayed,
        total_payment_value AS first_order_value
    FROM customer_first_orders
    WHERE order_sequence = 1  -- Only first order per customer
),

-- ═══════════════════════════════════════════════════════════════
-- STEP 3: Join with customer lifetime metrics
-- ═══════════════════════════════════════════════════════════════

customer_retention_analysis AS (
    SELECT 
        c.customer_unique_id,
        c.total_orders,
        c.total_revenue,
        f.first_order_delayed,
        f.first_order_value,
        -- Create retention flag
        CASE 
            WHEN c.total_orders > 1 THEN TRUE 
            ELSE FALSE 
        END AS is_repeat_customer
    FROM customer_level c
    LEFT JOIN first_order_experience f 
        ON c.customer_unique_id = f.customer_unique_id
)

-- ═══════════════════════════════════════════════════════════════
-- FINAL: Retention metrics by first-order delay status
-- ═══════════════════════════════════════════════════════════════

SELECT 
    first_order_delayed,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN is_repeat_customer THEN 1 ELSE 0 END) AS repeat_customers,
    ROUND(
        100.0 * SUM(CASE WHEN is_repeat_customer THEN 1 ELSE 0 END) / COUNT(*), 
        2
    ) AS repeat_rate_pct,
    ROUND(AVG(total_orders), 2) AS avg_orders_per_customer,
    ROUND(AVG(total_revenue), 2) AS avg_customer_ltv
FROM customer_retention_analysis
GROUP BY first_order_delayed
ORDER BY first_order_delayed;

/*
═══════════════════════════════════════════════════════════════════
BUSINESS INSIGHTS:
═══════════════════════════════════════════════════════════════════

1. RETENTION CRISIS IDENTIFIED
   - Overall repeat rate: 3.1% (vs. industry benchmark 15-20%)
   - This represents 11,436 lost repeat customers
   - Revenue opportunity: $3.17M

2. FIRST-ORDER DELAY IMPACT
   - Delays reduce repeat rate by 0.65 percentage points
   - Direct impact: 41 lost customers = $11,467
   - However, this is only 0.4% of total opportunity

3. ROOT CAUSE ANALYSIS
   - Delays are NOT the primary retention driver
   - Both delayed and on-time orders have poor retention
   - Real issue: No post-purchase engagement strategy

4. STRATEGIC RECOMMENDATION
   Priority 1: Implement retention programs (email, loyalty, win-backs)
   Priority 2: THEN optimize delivery performance
   
   Expected ROI: 30-50x in Year 1
═══════════════════════════════════════════════════════════════════
*/



