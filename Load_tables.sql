CREATE TABLE volume_data (
    id SERIAL PRIMARY KEY,
    period VARCHAR(10),
    europe_sales INT,
    china_sales INT,
    us_sales INT,
    other_sales INT,
    total_sales INT,
    electrified_vehicles INT,
    bev_vehicles INT,
    phev_vehicles INT,
    electrified_share DECIMAL(5,2),
    bev_share DECIMAL(5,2),
    wholesales INT,
    production_volume INT
);

COPY volume_data (period, europe_sales, china_sales, us_sales, other_sales, total_sales, electrified_vehicles, bev_vehicles, phev_vehicles, electrified_share, bev_share, wholesales, production_volume)
FROM 'C:\Users\alexa\Desktop\DataAnalyst_Portfolio\Volvo_analytics\data\Volume_dataset.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ';');

CREATE TABLE model_data (
    id SERIAL PRIMARY KEY,
    period VARCHAR(10),
    ex40_xc40_bev INT,
    ec40_xc40 INT,
    ex30 INT,
    ex90 INT,
    em90 INT,
    xc60 INT,
    xc40_phev_ice INT,
    xc90 INT,
    s90 INT,
    v60_v60 INT,
    s60_s60 INT,
    v90_v90 INT,
    v40_v40 INT,
    total INT,
    FOREIGN KEY (id) REFERENCES public.volume_data(id)
);


COPY model_data (period, ex40_xc40_bev, ec40_xc40, ex30, ex90, em90, xc60, xc40_phev_ice, xc90, s90, v60_v60, s60_s60, v90_v90, v40_v40, total)
FROM 'C:\Users\alexa\Desktop\DataAnalyst_Portfolio\Volvo_analytics\data\Model_volume_dataset.csv' 
WITH (FORMAT csv, HEADER true, DELIMITER ';');




CREATE TABLE revenue_data (
    id SERIAL PRIMARY KEY,
    period VARCHAR(20),

    net_rev DECIMAL(15, 2),
    cost_sales DECIMAL(15, 2),
    gross_inc DECIMAL(15, 2),

    rd_exp DECIMAL(15, 2),
    sell_exp DECIMAL(15, 2),
    admin_exp DECIMAL(15, 2),
    other_op_inc_exp DECIMAL(15, 2),
    joint_ventures_inc DECIMAL(15, 2),
    op_inc DECIMAL(15, 2),

    int_inc DECIMAL(15, 2),
    int_exp DECIMAL(15, 2),
    other_fin_inc_exp DECIMAL(15, 2),

    pre_tax_inc DECIMAL(15, 2),
    income_tax DECIMAL(15, 2),
    net_inc DECIMAL(15, 2),

    net_attr DECIMAL(15, 2),
    parent_owners DECIMAL(15, 2),
    non_ctrl_int DECIMAL(15, 2),
    ebit_margin DECIMAL(15,2),
    FOREIGN KEY (id) REFERENCES public.volume_data(id)
);


COPY revenue_data (period, net_rev, cost_sales, gross_inc, rd_exp, sell_exp, admin_exp, other_op_inc_exp, joint_ventures_inc, op_inc,
    int_inc, int_exp, other_fin_inc_exp,
    pre_tax_inc, income_tax, net_inc,
    net_attr, parent_owners, non_ctrl_int, ebit_margin
)
FROM 'C:\Users\alexa\Desktop\DataAnalyst_Portfolio\Volvo_analytics\data\Finance_dataset.csv'
WITH (FORMAT csv, HEADER true,DELIMITER ';');





CREATE TABLE sales_distribution (
    id SERIAL PRIMARY KEY,
    period TEXT,
    year INT,
    china INT,
    us INT,
    eu INT,
    other INT,
    FOREIGN KEY (id) REFERENCES public.volume_data(id)
);


COPY sales_distribution (period, year, china, us, eu,other)
FROM 'C:\Users\alexa\Desktop\DataAnalyst_Portfolio\Volvo_analytics\data\Region_finance_dataset.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ';');




CREATE OR REPLACE VIEW model_data_unpivoted AS
SELECT id, period, 'ex40_xc40_bev' AS model, ex40_xc40_bev AS units_sold FROM model_data
UNION ALL
SELECT id, period, 'ec40_xc40', ec40_xc40 FROM model_data
UNION ALL
SELECT id, period, 'ex30', ex30 FROM model_data
UNION ALL
SELECT id, period, 'ex90', ex90 FROM model_data
UNION ALL
SELECT id, period, 'em90', em90 FROM model_data
UNION ALL
SELECT id, period, 'xc60', xc60 FROM model_data
UNION ALL
SELECT id, period, 'xc40_phev_ice', xc40_phev_ice FROM model_data
UNION ALL
SELECT id, period, 'xc90', xc90 FROM model_data
UNION ALL
SELECT id, period, 's90', s90 FROM model_data
UNION ALL
SELECT id, period, 'v60_v60', v60_v60 FROM model_data
UNION ALL
SELECT id, period, 's60_s60', s60_s60 FROM model_data
UNION ALL
SELECT id, period, 'v90_v90', v90_v90 FROM model_data
UNION ALL
SELECT id, period, 'v40_v40', v40_v40 FROM model_data;



SELECT * from volume_data;
SELECT * from model_data;
SELECT * from revenue_data;
SELECT * from sales_distribution;
SELECT * from model_data_unpivoted;