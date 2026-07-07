-- 4) Customer Value Segmentation Analysis

WITH base_query AS (
    SELECT
        o.OrderID,
        o.OrderDate,
        d.ProductID,
        d.Sales,
        d.Profit,
        d.Quantity,
        c.CustomerID,
        c.CustomerName,
        c.Segment
    FROM dbo.fact_orders o
    INNER JOIN dbo.fact_order_details d
        ON o.OrderID = d.OrderID
    INNER JOIN dbo.dim_customer c
        ON o.CustomerID = c.CustomerID
    WHERE o.OrderDate IS NOT NULL
),

dataset_reference_date AS (
    SELECT
        MAX(OrderDate) AS max_order_date
    FROM dbo.fact_orders
    WHERE OrderDate IS NOT NULL
),

customer_aggregation AS (
    SELECT
        CustomerID,
        CustomerName,
        Segment,
        COUNT(DISTINCT OrderID) AS total_orders,
        SUM(Sales) AS total_sales,
        SUM(Profit) AS total_profit,
        SUM(Quantity) AS total_quantity,
        COUNT(DISTINCT ProductID) AS total_products,
        MIN(OrderDate) AS first_order_date,
        MAX(OrderDate) AS last_order_date,
        DATEDIFF(MONTH, MIN(OrderDate), MAX(OrderDate)) AS lifespan_months
    FROM base_query
    GROUP BY
        CustomerID,
        CustomerName,
        Segment
),

 customer_report AS (
    SELECT
        ca.CustomerID,
        ca.CustomerName,
        ca.Segment AS original_segment,
        ca.first_order_date,
        ca.last_order_date,
        ca.total_orders,
        ca.total_sales,
        ca.total_profit,
        ca.total_quantity,
        ca.total_products,
        ca.lifespan_months,
        DATEDIFF(MONTH, ca.last_order_date,drd.max_order_date) AS recency_months,
        ca.total_sales / NULLIF(ca.total_orders, 0) AS avg_order_value,
        ca.total_sales / NULLIF(ca.lifespan_months + 1, 0) AS avg_monthly_spend,
        ca.total_profit / NULLIF(ca.total_sales, 0) AS profit_margin,
        CASE
            WHEN ca.lifespan_months >= 12 AND ca.total_sales > 5000 THEN 'VIP'
            WHEN ca.lifespan_months >= 12 AND ca.total_sales <= 5000 THEN 'Regular'
            ELSE 'New'
        END AS customer_value_segment,
        CASE
            WHEN DATEDIFF(MONTH, ca.last_order_date, drd.max_order_date) <= 3 THEN 'Active'
            WHEN DATEDIFF(MONTH, ca.last_order_date, drd.max_order_date) <= 12 THEN 'At Risk'
            ELSE 'Inactive'
        END AS customer_activity_segment
    FROM customer_aggregation ca
    CROSS JOIN dataset_reference_date drd
)

SELECT
    CustomerID,
    CustomerName,
    original_segment,
    customer_value_segment,
    customer_activity_segment,
    first_order_date,
    last_order_date,
    lifespan_months,
    recency_months,
    total_orders,
    total_sales,
    total_profit,
    profit_margin,
    total_quantity,
    total_products,
    avg_order_value,
    avg_monthly_spend

FROM customer_report
ORDER BY
    total_sales DESC;