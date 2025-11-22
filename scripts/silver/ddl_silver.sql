/*
===============================================================================
DDL Script: Create Silver Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'silver' schema, dropping existing tables 
    if they already exist.
	  Run this script to re-define the DDL structure of 'bronze' Tables
===============================================================================
*/

-- Drop and recreate table silver.crm_cust_info if it exists
IF OBJECT_ID('silver.crm_cust_info', 'U') IS NOT NULL
    DROP TABLE silver.crm_cust_info;  -- Drop the table if it already exists to avoid errors

CREATE TABLE silver.crm_cust_info (
    cst_id INT,                  -- Customer ID (primary identifier from source)
    cst_key NVARCHAR(50),        -- Customer Key (business key or external ID)
    cst_firstname NVARCHAR(50),  -- Customer First Name
    cst_lastname NVARCHAR(50),   -- Customer Last Name
    cst_material_status NVARCHAR(50), -- Marital Status of customer
    cst_gndr NVARCHAR(50),       -- Gender of customer
    cst_create_date DATE,        -- Original creation date from source system
    dwh_create_date DATETIME2 DEFAULT GETDATE() -- Timestamp when the record is inserted into DWH (captures load time)
);

-- Drop and recreate table silver.crm_prd_info if it exists
IF OBJECT_ID('silver.crm_prd_info', 'U') IS NOT NULL
    DROP TABLE silver.crm_prd_info;  -- Drop existing table if exists

CREATE TABLE silver.crm_prd_info (
    prd_id INT,                  -- Product ID from source
    prd_key NVARCHAR(50),        -- Product Key (business key)
    prd_nm NVARCHAR(50),         -- Product Name
    prd_cost INT,                -- Product Cost
    prd_line NVARCHAR(50),       -- Product Line / category
    prd_start_dt DATETIME,       -- Product Start Date in source
    prd_end_dt DATETIME,         -- Product End Date in source
    dwh_create_date DATETIME2 DEFAULT GETDATE() -- Timestamp when record inserted into DWH
);

-- Drop and recreate table silver.crm_sales_details if it exists
IF OBJECT_ID('silver.crm_sales_details', 'U') IS NOT NULL
    DROP TABLE silver.crm_sales_details;  -- Drop existing table if exists

CREATE TABLE silver.crm_sales_details (
    sls_ord_num NVARCHAR(50),    -- Sales Order Number
    sls_prod_key NVARCHAR(50),   -- Product Key
    sls_cust_id INT,             -- Customer ID
    sls_order_dt INT,            -- Order Date (in YYYYMMDD format)
    sls_ship_dt INT,             -- Ship Date
    sls_due_dt INT,              -- Due Date
    sls_sales INT,               -- Sales Amount
    sls_quantity INT,            -- Quantity Sold
    sls_price INT,               -- Unit Price
    dwh_create_date DATETIME2 DEFAULT GETDATE() -- DWH load timestamp
);

-- Drop and recreate table silver.erp_cust_az12 if it exists
IF OBJECT_ID('silver.erp_cust_az12', 'U') IS NOT NULL
    DROP TABLE silver.erp_cust_az12;  -- Drop existing table if exists

CREATE TABLE silver.erp_cust_az12 (
    cid NVARCHAR(50),            -- Customer ID from ERP system
    bdate DATE,                  -- Birth Date
    gen NVARCHAR(50),            -- Gender
    dwh_create_date DATETIME2 DEFAULT GETDATE() -- Timestamp when record loaded into DWH
);

-- Drop and recreate table silver.erp_loc_a101 if it exists
IF OBJECT_ID('silver.erp_loc_a101', 'U') IS NOT NULL
    DROP TABLE silver.erp_loc_a101;  -- Drop existing table if exists

CREATE TABLE silver.erp_loc_a101 (
    cid NVARCHAR(50),            -- Customer ID from ERP
    cntry NVARCHAR(50),          -- Customer Country
    dwh_create_date DATETIME2 DEFAULT GETDATE() -- Timestamp when record loaded into DWH
);

-- Drop and recreate table silver.erp_px_cat_g1v2 if it exists
IF OBJECT_ID('silver.erp_px_cat_g1v2', 'U') IS NOT NULL
    DROP TABLE silver.erp_px_cat_g1v2;  -- Drop existing table if exists

CREATE TABLE silver.erp_px_cat_g1v2 (
    id NVARCHAR(50),             -- Product or Item ID
    cat NVARCHAR(50),            -- Category
    subcat NVARCHAR(50),         -- Subcategory
    maintenance NVARCHAR(50),    -- Maintenance info
    dwh_create_date DATETIME2 DEFAULT GETDATE() -- Timestamp when record loaded into DWH
);

