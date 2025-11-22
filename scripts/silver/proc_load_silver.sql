/*
===============================================================================
Stored Procedure: Load Silver Layer (Bronze -> Silver)
===============================================================================
Script Purpose:
    Loads data from Bronze tables into the Silver schema tables.
    - Truncates each Silver table before loading.
    - Uses INSERT INTO ... SELECT ... to populate Silver tables from Bronze tables.
    - Tracks load duration per table and for the entire batch.
    - Logs errors including the table that failed to load.

Parameters:
    None. 
    This procedure does not accept any parameters or return any values.

Usage Example:
    EXEC silver.load_silver;

Notes:
    - Table-specific load duration is printed in minutes and seconds.
    - If a load fails, the error message, number, state, and table name are printed.
===============================================================================
*/
CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN
    -- Declare variables to track load times and current table
    DECLARE 
        @start_time DATETIME,        -- Start time for individual table load
        @end_time DATETIME,          -- End time for individual table load
        @batch_start_time DATETIME,  -- Start time for entire batch
        @batch_end_time DATETIME,    -- End time for entire batch
        @current_table NVARCHAR(128);  -- Name of the table currently being loaded

    -- Start batch timer
    SET @batch_start_time = GETDATE();

    BEGIN TRY
        PRINT '=================================';
        PRINT 'Starting Silver Layer Load';
        PRINT '=================================';

        -----------------------------------------
        -- Example Silver Tables
        -----------------------------------------
        -- Adjust table names and logic as needed

        -- silver.crm_cust_info_silver
        SET @current_table = 'silver.crm_cust_info_silver';
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: ' + @current_table;
        TRUNCATE TABLE silver.crm_cust_info_silver;
        PRINT '>> Inserting Data into: ' + @current_table;
        INSERT INTO silver.crm_cust_info_silver
        SELECT * FROM bronze.crm_cust_info;
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' 
            + CAST(DATEDIFF(MINUTE, @start_time, @end_time) AS NVARCHAR) + ' minutes, '
            + CAST(DATEDIFF(SECOND, @start_time, @end_time) % 60 AS NVARCHAR) + ' seconds';
        PRINT '>>------------';

        -- silver.crm_prd_info_silver
        SET @current_table = 'silver.crm_prd_info_silver';
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: ' + @current_table;
        TRUNCATE TABLE silver.crm_prd_info_silver;
        PRINT '>> Inserting Data into: ' + @current_table;
        INSERT INTO silver.crm_prd_info_silver
        SELECT * FROM bronze.crm_prd_info;
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' 
            + CAST(DATEDIFF(MINUTE, @start_time, @end_time) AS NVARCHAR) + ' minutes, '
            + CAST(DATEDIFF(SECOND, @start_time, @end_time) % 60 AS NVARCHAR) + ' seconds';
        PRINT '>>------------';

        -- Add more Silver tables here following the same pattern

        -- End batch timer and print total load duration
        SET @batch_end_time = GETDATE();
        PRINT '=================================';
        PRINT 'Loading Silver Layer is Completed';
        PRINT ' - Total Load Duration: ' 
            + CAST(DATEDIFF(MINUTE, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' minutes, '
            + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) % 60 AS NVARCHAR) + ' seconds';
        PRINT '=================================';

    END TRY
    BEGIN CATCH
        -- Catch errors and log them, including the table that failed
        PRINT '=================================';
        PRINT 'ERROR OCCURRED DURING LOADING SILVER LAYER';
        PRINT 'Error occurred on table: ' + ISNULL(@current_table, 'UNKNOWN');
        PRINT 'Error Message: ' + ERROR_MESSAGE();
        PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Error State: ' + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT '=================================';
    END CATCH
END
