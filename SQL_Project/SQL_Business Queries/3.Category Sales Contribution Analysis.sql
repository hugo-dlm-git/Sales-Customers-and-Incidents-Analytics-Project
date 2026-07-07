-- 3) Category Sales Contribution Analysis

WITH category_sales AS (
    SELECT
        p.Category,
        SUM(d.Sales) AS total_sales
    FROM dbo.fact_order_details d
    INNER JOIN dbo.dim_product p
        ON d.ProductID = p.ProductID
    GROUP BY  p.Category
)

SELECT
    Category,
    total_sales,
    SUM(total_sales) OVER() AS overall_sales,
    CONCAT(ROUND(CAST(total_sales AS FLOAT)/ NULLIF(SUM(total_sales) OVER (), 0) * 100, 2),'%') AS percentage_of_total
FROM category_sales
ORDER BY  total_sales DESC;