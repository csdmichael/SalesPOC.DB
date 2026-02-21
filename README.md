# SalesPOC.DB

## Main project

- SalesPOC UI: https://github.com/csdmichael/SalesPOC.UI

This repository contains sample data sources used by the SalesPOC solution.

## Data sources

### Blob storage documents
Folder: `BlobStoarage_Semiconductor_Product_Documents/`

Contains unstructured product and sales collateral documents grouped by use case:
- `Engineering Datasheets/`
- `Marketing Briefs/`
- `Sales One Pagers/`

These files are intended for document search, retrieval, and AI grounding scenarios.

### Cosmos DB seed data
Folder: `CosmosDB/`

Contains scripts and dependencies used to seed product data in Azure Cosmos DB:
- `seed-products.js`
- `package.json`
- `install dependency.txt`

Use this source for JSON-style product catalog records.

### Azure SQL scripts
Folder: `SqlAzure/`

Contains ordered SQL scripts for creating and loading a relational sales dataset:
- `01. Create Tables.sql`
- `02. Insert_Customers.sql`
- `03. Insert_Products.sql`
- `04. Insert_Sales_Reps.sql`
- `05. Insert_Sales_Orders.sql`
- `06. Insert_Order_Line_Items.sql`
- `07. Update_Order_Totals.sql`
- `08. View_FactSales.sql`
- `09. Cleanup_Customers_Products.sql`

Use this source for structured transactional and reporting scenarios.


