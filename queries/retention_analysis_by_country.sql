-- ============================================
-- Retention Analysis by Country
-- Project: Conversion Funnel & User Retention Analysis
-- Author: Jorge Arenas
-- Description:
-- This query analyzes user retention rates
-- by country for D7, D14, D21, and D28 periods.
-- ============================================

SELECT
  country,
  ROUND(100.0 * COUNT(DISTINCT CASE WHEN day_after_signup >= 7  AND active = 1 THEN user_id END) / 
    NULLIF(COUNT(DISTINCT user_id), 0), 1)  AS retention_d7_pct,
  ROUND(100.0 * COUNT(DISTINCT CASE WHEN day_after_signup >= 14 AND active = 1 THEN user_id END) / 
    NULLIF(COUNT(DISTINCT user_id), 0), 1)  AS retention_d14_pct,
  ROUND(100.0 * COUNT(DISTINCT CASE WHEN day_after_signup >= 21 AND active = 1 THEN user_id END) / 
    NULLIF(COUNT(DISTINCT user_id), 0), 1)  AS retention_d21_pct,
  ROUND(100.0 * COUNT(DISTINCT CASE WHEN day_after_signup >= 28 AND active = 1 THEN user_id END) / 
    NULLIF(COUNT(DISTINCT user_id), 0), 1)  AS retention_d28_pct
FROM mercadolibre_retention
WHERE activity_date BETWEEN '2025-01-01' AND '2025-08-31'
GROUP BY country
ORDER BY country;
