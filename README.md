## Sales, Customers and Incidents Analytics Project

## Project Overview, Business Context and Objectives

This project presents an end-to-end data analytics workflow focused on sales, customers, products, orders, locations and operational incidents.
The original dataset was provided as a flat CSV file containing commercial and operational information. The main goal of the project is to transform this raw dataset into a structured analytical solution using Python, SQL Server and Power BI.
The project simulates a business reporting scenario where a company needs to monitor sales performance, profitability, customer behavior, product performance and operational efficiency. To enrich the analysis, a synthetic incidents table was created to represent operational issues linked to customer orders.
The workflow covers the full data analytics process: data cleaning, quality checks, relational data modeling, SQL-based validation and business analysis, Power BI data modeling, DAX measure creation and dashboard development.

## Tools and Technologies

The project uses the following tools and technologies:

* **Python / pandas**: used for data loading, cleaning, quality checks, data type conversion, text cleaning, synthetic incident generation and relational table creation.
* **Jupyter Notebook / VS Code**: used as the main development environment for the Python data preparation process.
* **SQL Server / SSMS**: used to import the processed CSV files, validate the relational model and run business analysis queries.
* **Power BI**: used to build the analytical model, define relationships and create the final interactive dashboard.
* **Power Query**: used for final data type checks, model preparation and reporting-specific transformations.
* **DAX**: used to create dynamic measures, KPIs, ratios, rankings and time intelligence calculations.
* **GitHub**: used to organize, document and present the complete project as a professional portfolio repository.

## Dataset Description

The original dataset was a Global Superstore-style CSV file with approximately 50,000 rows. It contained sales, orders, customers, products, locations, shipping and date-related fields in a single flat table.

## Repository Structure
Sales-Customers-and-Incidents-Analytics-Project/
├── data/
│   ├── raw/
│   │   └── Raw_superstore.csv
│   └── processed/
│       ├── dim_customer.csv
│       ├── dim_product.csv
│       ├── dim_location.csv
│       ├── fact_orders.csv
│       ├── fact_order_details.csv
│       └── incidents.csv
├── notebooks/
│   └── Project_Python.ipynb
├── powerbi/
│   └── Project_PowerBI.pbix
├── sql/
│   ├── database_setup/
│   │   ├── Data_Import_Validation.sql
│   │   ├── Performance_Indexing_Setup.sql
│   │   └── Relational_Model_Constraints.sql
│   └── business_queries/
│       ├── 1.Monthly_Sales_Trend_Analysis.sql
│       ├── 2.Product_Sales_YoY_Analysis.sql
│       ├── 3.Category_Sales_Contribution_Analysis.sql
│       ├── 4.Customer_Value_Segmentation_Analysis.sql
│       └── 5.Location_Incident_Analysis.sql
├── .gitignore
├── LICENSE
├── README.md
└── requirements.txt

## End-to-End Workflow
Raw CSV Dataset ↦ Python Data Cleaning and Quality Checks ↦ Relational Table Generation ↦ SQL Server Import ↦ SQL Data Validation and Business Analysis ↦ Power BI Data Model ↦ DAX Measures and Dashboard ↦ Business Insights

## Data Cleaning and Preparation with Python

Python was used to perform the initial cleaning and preparation of the dataset. The main steps included:

* Loading the original CSV file.
* Checking null values, duplicates and data types.
* Renaming columns.
* Converting date and numeric columns.
* Cleaning text fields.
* Reviewing inconsistencies.
* Creating a synthetic `incidents` table entirely with Python to simulate operational issues and enrich both the SQL analysis and the Power BI visuals.
* Splitting the original flat table into clean relational tables.
* Exporting the final tables as CSV files.

## Relational Data Model

<img width="977" height="476" alt="image" src="https://github.com/user-attachments/assets/0d79dd56-c5a0-4dd1-acab-a9a853e3cc85" />

The original dataset was provided as a single flat table. During the preparation process, it was transformed into a relational model with dimension and fact tables. The model includes three main dimensions: dim_customer, dim_product and dim_location. These tables store descriptive information about customers, products and geographic areas.The fact tables store the transactional and operational data: fact_orders contains order-level information, fact_order_details contains product-level sales metrics, and incidents contains synthetic operational issues generated with Python.

The main relationships are:
* dim_customer[CustomerID] → fact_orders[CustomerID]
* dim_location[LocationID] → fact_orders[LocationID]
* fact_orders[OrderID] → fact_order_details[OrderID]
* dim_product[ProductID] → fact_order_details[ProductID]
* fact_orders[OrderID] → incidents[OrderID]

This structure reduces data duplication, keeps the model consistent and allows sales, customer, product, location and incident analysis within the same Power BI model.

## SQL Server Analysis

SQL Server was used to validate the processed tables, define the relational structure and perform business analysis on top of the cleaned dataset. The SQL work was divided into two stages: database preparation and analytical querying.

Before the analysis, three preparation scripts were created. These scripts helped ensure that the data was complete, consistent and ready for analysis:
* Data Import Validation: checks that all processed CSV files were correctly imported into SQL Server.
* Relational Model Constraints: defines primary keys and foreign keys between dimension and fact tables.
* Performance Indexing Setup: creates indexes on columns commonly used in joins, filters and date-based queries.

Five main SQL queries were developed:
* Monthly Sales Trend Analysis: analyzes monthly sales, profit, orders, cumulative sales, moving averages and month-over-month variation.
* Product Sales YoY Analysis: compares product sales by year and identifies whether performance increased, decreased or remained stable.
* Category Sales Contribution Analysis: calculates how much each product category contributes to total sales.
* Location Incident Analysis: analyzes incidents by market, region and country, including incident rate, resolution time and location risk ranking.
* Customer Value Segmentation Analysis: segments customers using sales, profit, order behavior, recency, lifespan and average order value.

<img width="1871" height="828" alt="image" src="https://github.com/user-attachments/assets/fd501611-ecb3-4256-bddf-e0739ea305ff" />

The SQL analysis demonstrates practical use of:

* Data import validation.
* Primary key and foreign key constraints.
* Index creation for performance optimization.
* Joins between fact and dimension tables.
* Aggregations with GROUP BY.
* Filtering grouped results with HAVING.
* Conditional logic with CASE WHEN.
* Common Table Expressions.
* Subqueries and CTEs.
* Window functions.
* Business metrics related to sales, profit, customers, products, locations and incidents.

## Power Query transformations

In Power BI, Power Query was used to perform final model preparation before building the dashboard. Since the main data cleaning had already been completed in Python, Power Query was mainly used for reporting-oriented transformations. The following transformations were added:

* Final validation of data types for dates, numeric fields and IDs.
* Creation of a `ShippingDays` column in `fact_orders`, calculated as the difference between `ShipDate` and `OrderDate`.
* Creation of a `ShippingSpeedCategory` field to classify orders by delivery speed.
* Creation of a `DimDate` calendar table using Power Query, including year, quarter, month, year-month, sorting fields and day/week attributes.
  
These transformations helped adapt the cleaned dataset to an analytical Power BI model, without duplicating the heavy cleaning process already performed in Python.

## DAX Measures

DAX was used to create dynamic measures for the Power BI dashboard. These measures allow the report to calculate KPIs, ratios, rankings, time intelligence metrics and incident-related indicators.
The main DAX measures can be grouped into the following areas:

* Core Business KPIs: basic measures were created to summarize the main business performance indicators, including total sales, total profit, total quantity, total orders, total customers, average order value and profit margin. These measures provide the foundation for the dashboard and are reused across multiple visuals.

* Incident and Operational Metrics: additional measures were created to analyze operational performance, including total incidents, resolved incidents, resolved incidents percentage, average resolution days, orders with incidents and percentage of orders affected by incidents. These metrics make it possible to connect sales performance with operational issues.

* Incident Impact on Sales and Profit: some measures were designed to evaluate the business impact of incidents. These include sales and profit generated by orders with incidents, sales and profit from orders without incidents, and profit margin for affected orders. This allows the dashboard to compare normal commercial performance against orders affected by operational problems.

## Dashboard Design

The Power BI report was designed as a three-page dashboard focused on sales performance, customer and product analysis, and operational incident impact. The dashboard uses KPI cards, slicers, time-based visuals, category breakdowns, customer rankings, maps and incident analysis visuals. The main filters allow users to explore the data by year, market, category, customer segment, incident type, status and priority.

* Executive Overview: the first page provides a high-level summary of the business performance. It includes the main KPIs, such as total sales, total profit, profit margin, average order value, total orders and total incidents. This page also shows monthly sales and profit margin trends, sales distribution by customer segment, sales by category and subcategory, and sales by country. Its purpose is to give a quick overview of commercial performance across time, products, customer segments and geographic markets.

<img width="1301" height="723" alt="image" src="https://github.com/user-attachments/assets/00323a3b-f0b5-4ed9-aaa0-04eb11bfbadd" />

* Sales, Profit and Customers: the second page focuses on customer and product performance. It includes KPIs for sales, profit, margin, order volume and incidents, together with visuals for product performance, category sales over time and top customers by sales. This page helps identify which categories generate the highest sales and margins, how category performance changes over time, and which customers contribute the most to total revenue.

<img width="1302" height="732" alt="image" src="https://github.com/user-attachments/assets/f7fd7cb5-92e8-4b3a-a4c8-8c4c076f51d3" />

* Operations and Incident Impact: the third page focuses on operational incidents and their business impact. It includes incident-related KPIs such as total incidents, resolved incident percentage, average resolution days, orders with incidents, sales from orders with incidents and incident order profit margin. The visuals show incidents over time, incident volume by type and priority, and sales with versus without incidents. This allows operational issues to be analyzed not only as isolated events, but also in relation to sales and profitability.

<img width="1300" height="708" alt="image" src="https://github.com/user-attachments/assets/6fbf4e06-c5c9-4b08-b9bb-657eeb019a07" />


## Key Business Insights

## How to Reproduce the Project

To reproduce this project, follow these steps:

1. Clone this repository to your local machine.
2. Install the required Python dependencies listed in `requirements.txt`.
3. Open the data cleaning notebook located in the `notebooks/` folder.
4. Run the notebook to process the original raw CSV file.
5. Export the cleaned and transformed tables to the `data/processed/` folder.
6. Import the processed CSV files into SQL Server using SSMS.
7. Run the SQL scripts located in the `sql/` folder to validate the data and perform business analysis.
8. Open the Power BI file located in the `powerbi/` folder.
9. Check the relationships, Power Query transformations and DAX measures.
10. Refresh the Power BI model if needed.
11. Review the dashboard pages and business insights.

## What This Project Demonstrates

This project demonstrates the ability to complete a full data analytics workflow from raw data to business reporting.
It shows practical skills in:

* Cleaning and preparing data with Python.
* Performing data quality checks.
* Transforming a flat dataset into a relational model.
* Separating customers, products, locations, orders, order details and incidents into different analytical tables.
* Importing and validating data in SQL Server.
* Writing SQL queries for business analysis.
* Using joins, aggregations, CTEs, subqueries and window functions.
* Building a Power BI data model.
* Preparing data for reporting with Power Query.
* Creating DAX measures for KPIs, ratios, rankings and time-based analysis.
* Designing an interactive dashboard.
* Communicating business insights clearly.
* Structuring and documenting a data analytics project in GitHub.

Overall, this project reflects the core technical and analytical skills required for junior Data Analyst, BI Analyst, Reporting Analyst or Operations Analyst roles.



