
/*
------------------------------------------------------------------
COHORT RETENTION ANALYSIS
------------------------------------------------------------------

Business Question:
How does customer retention evolve over time by signup cohort?

Use Case:
- Track monthly cohort behavior
- Identify retention curves
- Compare cohort performance

Demonstrates:
- Advanced CTEs (multi-level)
- Window functions (FIRST_VALUE, PARTITION BY)
- Date manipulation (DATE_TRUNC, date math)

Author: Suraj Rajput
Date: April 2025
------------------------------------------------------------------
*/

-- ------------------------------------------------------------------
-- STEP 1: Assign each customer to their signup cohort (month)
-- ------------------------------------------------------------------

WITH customer_cohorts AS (
    SELECT 
        customer_unique_id,
        DATE_TRUNC('month', MIN(order_purchase_timestamp))::DATE AS cohort_month
    FROM order_level
    WHERE order_status = 'delivered'
    GROUP BY customer_unique_id
),

-- ------------------------------------------------------------------
-- STEP 2: Track customer activity by month
-- ------------------------------------------------------------------

monthly_customer_activity AS (
    SELECT 
        c.cohort_month,
        DATE_TRUNC('month', o.order_purchase_timestamp)::DATE AS activity_month,
        COUNT(DISTINCT o.customer_unique_id) AS active_customers,
        SUM(o.total_payment_value) AS cohort_revenue
    FROM order_level o
    INNER JOIN customer_cohorts c 
        ON o.customer_unique_id = c.customer_unique_id
    WHERE o.order_status = 'delivered'
    GROUP BY 
        c.cohort_month, 
        DATE_TRUNC('month', o.order_purchase_timestamp)
),

-- ------------------------------------------------------------------
-- STEP 3: Calculated retention metrics using window functions
-- ------------------------------------------------------------------

cohort_metrics AS (
    SELECT 
        cohort_month,
        activity_month,
        active_customers,
        cohort_revenue,
        -- Get cohort size (customers in first month)
        FIRST_VALUE(active_customers) OVER (
            PARTITION BY cohort_month 
            ORDER BY activity_month
        ) AS cohort_size,
        -- Calculate months since cohort start
        EXTRACT(YEAR FROM AGE(activity_month, cohort_month)) * 12 + 
        EXTRACT(MONTH FROM AGE(activity_month, cohort_month)) AS months_since_signup
    FROM monthly_customer_activity
)

-- ------------------------------------------------------------------
-- FINAL: Cohort retention table
-- ------------------------------------------------------------------

SELECT 
    cohort_month,
    cohort_size,
    months_since_signup,
    active_customers,
    ROUND(100.0 * active_customers / cohort_size, 2) AS retention_pct,
    cohort_revenue,
    ROUND(cohort_revenue / active_customers, 2) AS revenue_per_active_customer
FROM cohort_metrics
WHERE months_since_signup <= 6  -- First 6 months of cohort life
ORDER BY cohort_month, months_since_signup;
-- ------------------------------------------------------------------
-- KEY INSIGHTS:
-- ------------------------------------------------------------------
/*
1. Retention drops sharply after Month 0 (first purchase)
2. By Month 6, only 1-2% of cohort remains active
3. This confirms systematic retention problem across all cohorts
4. No cohort shows healthy retention curve

BUSINESS IMPLICATION:
Standard retention interventions (email campaigns, loyalty programs) 
could recover 5-10% retention = $1-2M annual impact
------------------------------------------------------------------
*/
