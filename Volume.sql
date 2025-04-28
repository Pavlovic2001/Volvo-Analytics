
-- KPI

SELECT 
    SUM(CASE WHEN RIGHT(v.period, 4) = '2023' THEN v.total_sales ELSE 0 END) AS total_sales_2023,
    SUM(CASE WHEN RIGHT(v.period, 4) = '2024' THEN v.total_sales ELSE 0 END) AS total_sales_2024,
    SUM(CASE WHEN RIGHT(v.period, 4) = '2023' THEN v.production_volume ELSE 0 END) AS total_productions_2023,
    SUM(CASE WHEN RIGHT(v.period, 4) = '2024' THEN v.production_volume ELSE 0 END) AS total_productions_2024,
    SUM(CASE WHEN RIGHT(v.period, 4) = '2023' THEN v.wholesales ELSE 0 END) AS total_whole_sales_2023,
    SUM(CASE WHEN RIGHT(v.period, 4) = '2024' THEN v.wholesales ELSE 0 END) AS total_whole_sales_2024,

    SUM(CASE WHEN RIGHT(v.period, 4) = '2024' THEN v.electrified_vehicles ELSE 0 END) AS total_electrical_sales_2024,
    SUM(CASE WHEN RIGHT(period, 4) = '2024' THEN total_sales - electrified_vehicles ELSE 0 END) AS total_fuel_sales_2024

FROM 
    volume_data v
WHERE 
    RIGHT(v.period, 4) IN ('2023', '2024');



-- Volume timeline

SELECT RIGHT(v.period, 4) AS year,
SUM(v.total_sales) AS retail_sales,
SUM(v.production_volume) AS production_volume,
SUM(v.wholesales) AS whole_sales
FROM volume_data v 
GROUP BY year;


-- Region sales

SELECT RIGHT(v.period, 4) AS year,
SUM(v.europe_sales) AS europe_sales,
SUM(v.china_sales) AS china_sales,
SUM(v.us_sales) AS us_sales,
SUM(v.other_sales) AS other_sales
FROM volume_data v 
GROUP BY year;




-- Model sales

SELECT model, 
       SUM(units_sold) AS top_5_models_2024
FROM model_data_unpivoted
WHERE RIGHT(period, 4) IN ('2024')
GROUP BY model
HAVING SUM(units_sold) IS NOT NULL
ORDER BY top_5_models_2024 DESC
LIMIT 5;