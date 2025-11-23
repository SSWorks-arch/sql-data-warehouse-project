/*
===============================================================================
DDL Script: Create Silver Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'silver' schema, dropping existing tables 
    if they already exist.
    All tables include a timestamp column `dwh_create_date` which records the 
    exact date and time when a record is loaded into the Silver layer of the 
    Data Warehouse (DWH).
		Run this script to re-define the DDL structure of 'bronze' Tables
===============================================================================

*/

-- =========================================
-- CRM Tables
-- =========================================

-- -----------------------------------------
-- crm_cust_info table
-- -----------------------------------------
IF OBJECT_ID('silver.crm_cust_info', 'U') IS NOT NULL
    DROP TABLE silver.crm_cust_info;
GO

CREATE TABLE silver.crm_cust_info (
    cst_id INT,
    cst_key NVARCHAR(50),
    cst_firstname NVARCHAR(50),
    cst_lastname NVARCHAR(50),
    cst_marital_status NVARCHAR(50),
    cst_gndr NVARCHAR(50),
    cst_create_date DATE,
    dwh_create_date DATETIME2 Default getdate() -- Automatically records the date & time when the row is inserted into Silver
);
GO

-- -----------------------------------------
-- crm_prd_info table
-- -----------------------------------------
IF OBJECT_ID('silver.crm_prd_info', 'U') IS NOT NULL
    DROP TABLE silver.crm_prd_info;
GO

CREATE TABLE silver.crm_prd_info (
    prd_id INT,
    prd_key NVARCHAR(50),
    prd_nm NVARCHAR(50),
    prd_cost INT,
    prd_line NVARCHAR(50),
    prd_start_dt DATETIME,
    prd_end_dt DATETIME,
    dwh_create_date DATETIME2 Default getdate() -- Automatically records the date & time when the row is inserted into Silver
);
GO

-- -----------------------------------------
-- crm_sales_details table
-- -----------------------------------------
IF OBJECT_ID('silver.crm_sales_details', 'U') IS NOT NULL
    DROP TABLE silver.crm_sales_details;
GO

CREATE TABLE silver.crm_sales_details (
    sls_ord_num NVARCHAR(50),
    sls_prd_key NVARCHAR(50),
    sls_cust_id INT,
    sls_order_dt INT,
    sls_ship_dt INT,
    sls_due_dt INT,
    sls_sales INT,
    sls_quantity INT,
    sls_price INT,
    dwh_create_date DATETIME2 Default getdate() -- Automatically records the date & time when the row is inserted into Silver
);
GO

-- =========================================
-- ERP Tables
-- =========================================

-- -----------------------------------------
-- erp_loc_a101 table
-- -----------------------------------------
IF OBJECT_ID('silver.erp_loc_a101', 'U') IS NOT NULL
    DROP TABLE silver.erp_loc_a101;
GO

CREATE TABLE silver.erp_loc_a101 (
    cid NVARCHAR(50),
    cntry NVARCHAR(50),
    dwh_create_date DATETIME2 Default getdate() -- Automatically records the date & time when the row is inserted into Silver
);
GO

-- -----------------------------------------
-- erp_cust_az12 table
-- -----------------------------------------
IF OBJECT_ID('silver.erp_cust_az12', 'U') IS NOT NULL
    DROP TABLE silver.erp_cust_az12;
GO

CREATE TABLE silver.erp_cust_az12 (
    cid NVARCHAR(50),
    bdate DATE,
    gen NVARCHAR(50),
    dwh_create_date DATETIME2 Default getdate() -- Automatically records the date & time when the row is inserted into Silver
);
GO

-- -----------------------------------------
-- erp_px_cat_g1v2 table
-- -----------------------------------------
IF OBJECT_ID('silver.erp_px_cat_g1v2', 'U') IS NOT NULL
    DROP TABLE silver.erp_px_cat_g1v2;
GO

CREATE TABLE silver.erp_px_cat_g1v2 (
    id NVARCHAR(50),
    cat NVARCHAR(50),
    subcat NVARCHAR(50),
    maintenance NVARCHAR(50),
    dwh_create_date DATETIME2 Default getdate() -- Automatically records the date & time when the row is inserted into Silver
);
GO

