-- Data Import Validation

SELECT 'dim_customer' AS TableName, COUNT(*) AS RowCounts FROM dbo.dim_customer
UNION ALL
SELECT 'dim_product', COUNT(*) FROM dbo.dim_product
UNION ALL
SELECT 'dim_location', COUNT(*) FROM dbo.dim_location
UNION ALL
SELECT 'fact_orders', COUNT(*) FROM dbo.fact_orders
UNION ALL
SELECT 'fact_order_details', COUNT(*) FROM dbo.fact_order_details
UNION ALL
SELECT 'incidents', COUNT(*) FROM dbo.incidents;