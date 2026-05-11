-- ============================================
-- Retention Cohort Analysis
-- Project: Conversion Funnel & User Retention Analysis
-- Author: Jorge Arenas
-- Description:
-- This query calculates user retention rates
-- by cohort for D7, D14, D21, and D28 periods
-- in an e-commerce environment.
-- ============================================

WITH cohort AS (
SELECT
user_id,
TO_CHAR(DATE_TRUNC('month', MIN(signup_date)), 'YYYY-MM') AS cohort
FROM mercadolibre_retention
GROUP BY user_id
),
activity AS (
    SELECT 
        mr.user_id,
        c.cohort,
        mr.day_after_signup,
        mr.active
    FROM mercadolibre_retention mr
    LEFT JOIN cohort c ON mr.user_id = c.user_id
    WHERE mr.activity_date BETWEEN '2025-01-01' AND '2025-08-31'        
)
SELECT 
    cohort,
    ROUND(100.0 * COUNT(DISTINCT CASE WHEN day_after_signup >= 7 AND active = 1 THEN user_id END) 
        / NULLIF(COUNT(DISTINCT user_id),0),1) AS retention_d7_pct,
    ROUND(100.0 * COUNT(DISTINCT CASE WHEN day_after_signup >= 14 AND active = 1 THEN user_id END)
        / NULLIF(COUNT(DISTINCT user_id),0),1) AS retention_d14_pct,
    ROUND(100.0 * COUNT(DISTINCT CASE WHEN day_after_signup >= 21 AND active = 1 THEN user_id END)
       / NULLIF(COUNT(DISTINCT user_id),0),1) AS retention_d21_pct,
    ROUND(100.0 * COUNT(DISTINCT CASE WHEN day_after_signup >= 28 AND active = 1 THEN user_id END)
        / NULLIF(COUNT(DISTINCT user_id),0),1) AS retention_d28_pct
FROM activity
GROUP BY cohort
ORDER BY cohort;
