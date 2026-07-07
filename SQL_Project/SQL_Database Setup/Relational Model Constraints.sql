-- Relational Model Constraints

-- Primary Keys

ALTER TABLE dbo.dim_customer
ADD CONSTRAINT PK_dim_customer
PRIMARY KEY (CustomerID);

ALTER TABLE dbo.dim_location
ADD CONSTRAINT PK_dim_location
PRIMARY KEY (LocationID);

ALTER TABLE dbo.dim_product
ADD CONSTRAINT PK_dim_product
PRIMARY KEY (ProductID);

ALTER TABLE dbo.fact_orders
ADD CONSTRAINT PK_fact_orders
PRIMARY KEY (OrderID);

ALTER TABLE dbo.fact_order_details
ADD CONSTRAINT PK_fact_order_details
PRIMARY KEY (RowID);

ALTER TABLE dbo.incidents
ADD CONSTRAINT PK_incidents
PRIMARY KEY (IncidentID);

-- Foreign Keys

ALTER TABLE dbo.fact_orders
ADD CONSTRAINT FK_fact_orders_dim_customer
FOREIGN KEY (CustomerID)
REFERENCES dbo.dim_customer(CustomerID);

ALTER TABLE dbo.fact_orders
ADD CONSTRAINT FK_fact_orders_dim_location
FOREIGN KEY (LocationID)
REFERENCES dbo.dim_location(LocationID);

ALTER TABLE dbo.fact_order_details
ADD CONSTRAINT FK_fact_order_details_fact_orders
FOREIGN KEY (OrderID)
REFERENCES dbo.fact_orders(OrderID);

ALTER TABLE dbo.fact_order_details
ADD CONSTRAINT FK_fact_order_details_dim_product
FOREIGN KEY (ProductID)
REFERENCES dbo.dim_product(ProductID);

ALTER TABLE dbo.incidents
ADD CONSTRAINT FK_incidents_fact_orders
FOREIGN KEY (OrderID)
REFERENCES dbo.fact_orders(OrderID);

ALTER TABLE dbo.incidents
ADD CONSTRAINT FK_incidents_dim_customer
FOREIGN KEY (CustomerID)
REFERENCES dbo.dim_customer(CustomerID);