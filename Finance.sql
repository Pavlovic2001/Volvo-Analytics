
-- KPI

SELECT 
    SUM(CASE WHEN r.period = 'Y2023' THEN r.net_rev ELSE 0 END) AS net_rev_2023,
    SUM(CASE WHEN r.period = 'Y2024' THEN r.net_rev ELSE 0 END) AS net_rev_2024,
    SUM(CASE WHEN r.period = 'Y2023' THEN r.ebit_margin ELSE 0 END) AS ebit_margin_2023,
    SUM(CASE WHEN r.period = 'Y2024' THEN r.ebit_margin ELSE 0 END) AS ebit_margin_2024,
    SUM(CASE WHEN r.period = 'Y2023' THEN r.op_inc ELSE 0 END) AS operation_income_2023,
    SUM(CASE WHEN r.period = 'Y2024' THEN r.op_inc ELSE 0 END) AS operation_income_2024


FROM 
    revenue_data r
WHERE 
    r.period IN ('Y2023', 'Y2024');




-- Finance timeline


SELECT RIGHT(r.period, 4) AS year,
SUM(r.net_rev) AS revenue,
SUM(r.ebit_margin) AS ebit_margin,
SUM(r.op_inc) AS operating_income
FROM revenue_data r
GROUP BY year;


-- Region revenue


SELECT s.year AS year,
SUM(s.eu) AS europe_revenue,
SUM(s.china) AS china_revenue,
SUM(s.us) AS us_revenue,
SUM(s.other) AS other_revenue
FROM sales_distribution s
GROUP BY year;