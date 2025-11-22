/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    Loads data from external CSV files into the 'bronze' schema tables.
    - Truncates each bronze table before loading.
    - Uses BULK INSERT to load data from CSV files.
    - Tracks load duration per table and for the entire batch.
    - Logs errors including the table that failed to load.

Parameters:
    None. 
    This procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;

Notes:
    - Table-specific load duration is printed in seconds.
    - If a load fails, the error message, number, state, and table name are printed.
===============================================================================
*/
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    -- Declare variables to track load times and current table
    DECLARE 
        @start_time DATETIME,        -- Start time for an individual table load
        @end_time DATETIME,          -- End time for an individual table load
        @batch_start_time DATETIME,  -- Start time for the entire batch
        @batch_end_time DATETIME,    -- End time for the entire batch
        @current_table NVARCHAR(128);  -- Name of the table currently being loaded

    -- Start the batch timer
    SET @batch_start_time = GETDATE();

    BEGIN TRY
        -- Header log for the batch
        PRINT '=================================';
        PRINT 'Starting Bronze Layer Load';
        PRINT '=================================';

        -----------------------------------------
        -- CRM TABLES
        -----------------------------------------
        PRINT '---------------------------------';
        PRINT 'Loading CRM Tables';
        PRINT '---------------------------------';

        -- crm_cust_info
        SET @current_table = 'bronze.crm_cust_info';         -- Keep track of current table
        SET @start_time = GETDATE();                         -- Start timer for this table
        PRINT '>> Truncating Table: ' + @current_table;       -- Log truncation
        TRUNCATE TABLE bronze.crm_cust_info;                -- Remove existing data
        PRINT '>> Inserting Data into: ' + @current_table;   -- Log insertion
        BULK INSERT bronze.crm_cust_info                     -- Load CSV file into table
        FROM 'C:\Users\Svyatoslav\Desktop\datasets\source_crm\cust_info.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
        SET @end_time = GETDATE();                           -- End timer for this table
        -- Print load duration in minutes and seconds
        PRINT '>> Load Duration: ' 
            + CAST(DATEDIFF(MINUTE, @start_time, @end_time) AS NVARCHAR) + ' minutes, '
            + CAST(DATEDIFF(SECOND, @start_time, @end_time) % 60 AS NVARCHAR) + ' seconds';
        PRINT '>>------------';

        -- crm_prd_info
        SET @current_table = 'bronze.crm_prd_info';
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: ' + @current_table;
        TRUNCATE TABLE bronze.crm_prd_info;
        PRINT '>> Inserting Data into: ' + @current_table;
        BULK INSERT bronze.crm_prd_info
        FROM 'C:\Users\Svyatoslav\Desktop\datasets\source_crm\prd_info.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' 
            + CAST(DATEDIFF(MINUTE, @start_time, @end_time) AS NVARCHAR) + ' minutes, '
            + CAST(DATEDIFF(SECOND, @start_time, @end_time) % 60 AS NVARCHAR) + ' seconds';
        PRINT '>>------------';

        -- crm_sales_details
        SET @current_table = 'bronze.crm_sales_details';
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: ' + @current_table;
        TRUNCATE TABLE bronze.crm_sales_details;
        PRINT '>> Inserting Data into: ' + @current_table;
        BULK INSERT bronze.crm_sales_details
        FROM 'C:\Users\Svyatoslav\Desktop\datasets\source_crm\sales_details.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' 
            + CAST(DATEDIFF(MINUTE, @start_time, @end_time) AS NVARCHAR) + ' minutes, '
            + CAST(DATEDIFF(SECOND, @start_time, @end_time) % 60 AS NVARCHAR) + ' seconds';
        PRINT '>>------------';

        -----------------------------------------
        -- ERP TABLES
        -----------------------------------------
        PRINT '---------------------------------';
        PRINT 'Loading ERP Tables';
        PRINT '---------------------------------';

        -- erp_cust_az12
        SET @current_table = 'bronze.erp_cust_az12';
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: ' + @current_table;
        TRUNCATE TABLE bronze.erp_cust_az12;
        PRINT '>> Inserting Data into: ' + @current_table;
        BULK INSERT bronze.erp_cust_az12
        FROM 'C:\Users\Svyatoslav\Desktop\datasets\source_erp\cust_az12.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' 
            + CAST(DATEDIFF(MINUTE, @start_time, @end_time) AS NVARCHAR) + ' minutes, '
            + CAST(DATEDIFF(SECOND, @start_time, @end_time) % 60 AS NVARCHAR) + ' seconds';
        PRINT '>>------------';

        -- erp_loc_a101
        SET @current_table = 'bronze.erp_loc_a101';
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: ' + @current_table;
        TRUNCATE TABLE bronze.erp_loc_a101;
        PRINT '>> Inserting Data into: ' + @current_table;
        BULK INSERT bronze.erp_loc_a101
        FROM 'C:\Users\Svyatoslav\Desktop\datasets\source_erp\loc_a101.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' 
            + CAST(DATEDIFF(MINUTE, @start_time, @end_time) AS NVARCHAR) + ' minutes, '
            + CAST(DATEDIFF(SECOND, @start_time, @end_time) % 60 AS NVARCHAR) + ' seconds';
        PRINT '>>------------';

        -- erp_px_cat_g1v2
        SET @current_table = 'bronze.erp_px_cat_g1v2';
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: ' + @current_table;
        TRUNCATE TABLE bronze.erp_px_cat_g1v2;
        PRINT '>> Inserting Data into: ' + @current_table;
        BULK INSERT bronze.erp_px_cat_g1v2
        FROM 'C:\Users\Svyatoslav\Desktop\datasets\source_erp\px_cat_g1v2.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' 
            + CAST(DATEDIFF(MINUTE, @start_time, @end_time) AS NVARCHAR) + ' minutes, '
            + CAST(DATEDIFF(SECOND, @start_time, @end_time) % 60 AS NVARCHAR) + ' seconds';
        PRINT '>>------------';

        -- End batch timer and print total load duration
        SET @batch_end_time = GETDATE();
        PRINT '=================================';
        PRINT 'Loading Bronze Layer is Completed';
        PRINT ' - Total Load Duration: ' 
            + CAST(DATEDIFF(MINUTE, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' minutes, '
            + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) % 60 AS NVARCHAR) + ' seconds';
        PRINT '=================================';

    END TRY
    BEGIN CATCH
        -- Catch errors and log them, including the table that failed
        PRINT '=================================';
        PRINT 'ERROR OCCURRED DURING LOADING BRONZE LAYER';
        PRINT 'Error occurred on table: ' + ISNULL(@current_table, 'UNKNOWN');
        PRINT 'Error Message: ' + ERROR_MESSAGE();
        PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Error State: ' + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT '=================================';
    END CATCH
END
