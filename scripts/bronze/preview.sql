/*
===============================================================================
Preview Queries: Top 1000 Rows from Bronze Layer Tables
===============================================================================
-- This script previews the top 1000 rows from each table in the bronze layer
-- grouped by CRM and ERP tables.
*/

/* ===========================================================
   CRM Tables - Preview Top 1000 Rows
   =========================================================== */
   SELECT TOP 1000 * FROM bronze.crm_cust_info;
   SELECT TOP 1000 * FROM bronze.crm_prd_info;
   SELECT TOP 1000 * FROM bronze.crm_sales_details;

/* ===========================================================
   ERP Tables - Preview Top 1000 Rows
   =========================================================== */

SELECT TOP 1000 * FROM bronze.erp_cust_az12;
SELECT TOP 1000 * FROM bronze.erp_loc_a101;
SELECT TOP 1000 * FROM bronze.erp_px_cat_g1v2;
