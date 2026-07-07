-- 1) Monthly Sales Trend Analysis
USE Project
GO

WITH MonthlySales AS (
    SELECT
        DATEFROMPARTS(YEAR(o.OrderDate), MONTH(o.OrderDate), 1) AS OrderMonth,
        SUM(d.Sales) AS TotalSales,
        SUM(d.Profit) AS TotalProfit,
        COUNT(DISTINCT o.OrderID) AS TotalOrders,
        AVG(d.Sales) AS AvgLineSales
    FROM dbo.fact_orders o
    JOIN dbo.fact_order_details d
        ON o.OrderID = d.OrderID
    WHERE o.OrderDate IS NOT NULL
    GROUP BY
        DATEFROMPARTS(YEAR(o.OrderDate), MONTH(o.OrderDate), 1)
)

SELECT
    OrderMonth,
    TotalSales,
    TotalProfit,
    TotalOrders,
    AvgLineSales,
    SUM(TotalSales) OVER(ORDER BY OrderMonth ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningTotalSales,
    AVG(TotalSales) OVER(ORDER BY OrderMonth ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS MovingAvgSales_3M,
    LAG(TotalSales) OVER(ORDER BY OrderMonth) AS PreviousMonthSales,
    TotalSales - LAG(TotalSales) OVER(ORDER BY OrderMonth) AS SalesVariation,
    CASE    WHEN LAG(TotalSales) OVER(ORDER BY OrderMonth) IS NULL THEN NULL
            ELSE CONCAT(FORMAT((TotalSales - LAG(TotalSales) OVER(ORDER BY OrderMonth)) * 1.0
            / NULLIF(LAG(TotalSales) OVER(ORDER BY OrderMonth), 0) * 100,'N2'),'%')
    END AS SalesVariationPct

FROM MonthlySales
ORDER BY OrderMonth;