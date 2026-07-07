-- 2) Product Sales YoY Analysis

WITH yearly_product_sales AS (
    SELECT
        YEAR(o.OrderDate) AS order_year,
        p.ProductID,
        p.ProductName,
        p.Category,
        p.SubCategory,
        SUM(d.Sales) AS current_sales
    FROM dbo.fact_orders o
    INNER JOIN dbo.fact_order_details d
        ON o.OrderID = d.OrderID
    INNER JOIN dbo.dim_product p
        ON d.ProductID = p.ProductID
    WHERE o.OrderDate IS NOT NULL
    GROUP BY
        YEAR(o.OrderDate),
        p.ProductID,
        p.ProductName,
        p.Category,
        p.SubCategory
),

product_sales_comparison AS (
    SELECT
        order_year,
        ProductID,
        ProductName,
        Category,
        SubCategory,
        current_sales,
        AVG(current_sales) OVER(PARTITION BY ProductID) AS avg_sales,
        current_sales - AVG(current_sales) OVER(PARTITION BY ProductID) AS diff_avg,
        LAG(current_sales) OVER(PARTITION BY ProductID  ORDER BY order_year) AS previous_year_sales
    FROM yearly_product_sales
)

SELECT
    order_year,
    ProductID,
    ProductName,
    Category,
    SubCategory,
    current_sales,
    avg_sales,
    diff_avg,

    CASE
        WHEN diff_avg > 0 THEN 'Above Avg'
        WHEN diff_avg < 0 THEN 'Below Avg'
        ELSE 'Avg'
    END AS avg_change,
    previous_year_sales,
    current_sales - previous_year_sales AS diff_previous_year,

    CASE
        WHEN previous_year_sales IS NULL THEN 'No Previous Year'
        WHEN current_sales - previous_year_sales > 0 THEN 'Increase'
        WHEN current_sales - previous_year_sales < 0 THEN 'Decrease'
        ELSE 'No Change'
    END AS previous_year_change

FROM product_sales_comparison
ORDER BY    ProductName, order_year;