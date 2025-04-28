SELECT 
    right(v.period, 4) AS year,
    SUM(v.total_sales) AS retail_sales,
    r.total_revenue AS revenue
FROM 
    volume_data v
INNER JOIN 
    (
        SELECT 
            right(period, 4) AS year,
            SUM(net_rev) AS total_revenue
        FROM revenue_data
        GROUP BY right(period, 4)
    ) r ON right(v.period, 4) = r.year
GROUP BY 
    right(v.period, 4), r.total_revenue
ORDER BY 
    year DESC;
