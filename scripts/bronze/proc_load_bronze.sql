/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    Loads data from external CSV files into the 'bronze' schema tables.
    - Truncates each bronze table before loading.
    - Uses BULK INSERT to load data from CSV files.
    - Tracks load duration per table and for the entire batch in **total seconds**.
    - Logs errors including the table that failed to load.

Parameters:
    None. 
    This procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;

Notes:
    - Table-specific load duration is printed in total seconds.
    - Total batch duration is printed in total seconds.
    - Minutes-and-seconds formatting can be enabled if desired.
    - If a load fails, the error message, number, state, and table name are printed.
===============================================================================

*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    -- Declare variables to track load times and the table being loaded
    DECLARE 
        @start_time DATETIME,        -- Start time for individual table load
        @end_time DATETIME,          -- End time for individual table load
        @batch_start_time DATETIME,  -- Start time for entire batch
        @batch_end_time DATETIME,    -- End time for entire batch
        @current_table NVARCHAR(128); -- Current table being processed

    -- Start timer for the entire batch
    SET @batch_start_time = GETDATE();

    BEGIN TRY
        -- Print header for batch start
        PRINT '=================================';
        PRINT 'Starting Bronze Layer Load';
        PRINT '=================================';

        -----------------------------------------
        -- CRM TABLES
        -----------------------------------------
        PRINT '---------------------------------';
        PRINT 'Loading CRM Tables';
        PRINT '---------------------------------';

        -- Load crm_cust_info table
        SET @current_table = 'bronze.crm_cust_info';        -- Set current table
        SET @start_time = GETDATE();                        -- Start timer for this table
        TRUNCATE TABLE bronze.crm_cust_info;               -- Clear existing data
        BULK INSERT bronze.crm_cust_info                   -- Load CSV data into table
        FROM 'C:\Users\Svyatoslav\Desktop\datasets\source_crm\cust_info.csv'
        WITH (
            FIRSTROW = 2,                                  -- Skip header row
            FIELDTERMINATOR = ',',                          -- Column separator
            TABLOCK                                        -- Optimize bulk insert with table-level lock
        );
        SET @end_time = GETDATE();                          -- End timer for this table
        PRINT '>> ' + @current_table + ' Load Duration: ' 
            + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>>------------';

        -- Load crm_prd_info table
        SET @current_table = 'bronze.crm_prd_info';
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.crm_prd_info;
        BULK INSERT bronze.crm_prd_info
        FROM 'C:\Users\Svyatoslav\Desktop\datasets\source_crm\prd_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> ' + @current_table + ' Load Duration: ' 
            + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>>------------';

        -- Load crm_sales_details table
        SET @current_table = 'bronze.crm_sales_details';
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.crm_sales_details;
        BULK INSERT bronze.crm_sales_details
        FROM 'C:\Users\Svyatoslav\Desktop\datasets\source_crm\sales_details.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> ' + @current_table + ' Load Duration: ' 
            + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>>------------';

        -----------------------------------------
        -- ERP TABLES
        -----------------------------------------
        PRINT '---------------------------------';
        PRINT 'Loading ERP Tables';
        PRINT '---------------------------------';

        -- Load erp_cust_az12 table
        SET @current_table = 'bronze.erp_cust_az12';
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.erp_cust_az12;
        BULK INSERT bronze.erp_cust_az12
        FROM 'C:\Users\Svyatoslav\Desktop\datasets\source_erp\cust_az12.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> ' + @current_table + ' Load Duration: ' 
            + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>>------------';

        -- Load erp_loc_a101 table
        SET @current_table = 'bronze.erp_loc_a101';
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.erp_loc_a101;
        BULK INSERT bronze.erp_loc_a101
        FROM 'C:\Users\Svyatoslav\Desktop\datasets\source_erp\loc_a101.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> ' + @current_table + ' Load Duration: ' 
            + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>>------------';

        -- Load erp_px_cat_g1v2 table
        SET @current_table = 'bronze.erp_px_cat_g1v2';
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.erp_px_cat_g1v2;
        BULK INSERT bronze.erp_px_cat_g1v2
        FROM 'C:\Users\Svyatoslav\Desktop\datasets\source_erp\px_cat_g1v2.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> ' + @current_table + ' Load Duration: ' 
            + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>>------------';

        -- Print total batch duration
        SET @batch_end_time = GETDATE();
        PRINT '=================================';
        PRINT 'Loading Bronze Layer Completed';
        PRINT ' - Total Load Duration: ' 
            + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
        PRINT '=================================';

    END TRY
    BEGIN CATCH
        -- Error handling block
        PRINT '=================================';
        PRINT 'ERROR OCCURRED DURING LOADING BRONZE LAYER';
        PRINT 'Error occurred on table: ' + ISNULL(@current_table, 'UNKNOWN');  -- Table that failed
        PRINT 'Error Message: ' + ERROR_MESSAGE();                                -- Error details
        PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR);               -- SQL error number
        PRINT 'Error State: ' + CAST(ERROR_STATE() AS NVARCHAR);                 -- SQL error state
        PRINT '=================================';
    END CATCH
END
