-- Performance Indexing Setup

CREATE INDEX IX_fact_orders_CustomerID
ON dbo.fact_orders(CustomerID);

CREATE INDEX IX_fact_orders_LocationID
ON dbo.fact_orders(LocationID);

CREATE INDEX IX_fact_orders_OrderDate
ON dbo.fact_orders(OrderDate);

CREATE INDEX IX_fact_order_details_OrderID
ON dbo.fact_order_details(OrderID);

CREATE INDEX IX_fact_order_details_ProductID
ON dbo.fact_order_details(ProductID);

CREATE INDEX IX_incidents_OrderID
ON dbo.incidents(OrderID);

CREATE INDEX IX_incidents_CustomerID
ON dbo.incidents(CustomerID);

CREATE INDEX IX_incidents_IncidentDate
ON dbo.incidents(IncidentDate);

CREATE INDEX IX_incidents_Status
ON dbo.incidents(Status);