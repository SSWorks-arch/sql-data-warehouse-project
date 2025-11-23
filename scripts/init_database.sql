/* 
=============================================================
Create DataWarehouse Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'DataWarehouse'.
    If the database exists, it is dropped and recreated (destructive version).
    After creation, it sets up three schemas: 'bronze', 'silver', and 'gold'.

WARNING:
    Running this script will drop the entire 'DataWarehouse' database if it exists.
    All data in the database will be permanently deleted. Proceed with caution.
*/

USE master; 
GO

-- Drop and recreate the 'DataWarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
END;
GO

-- Create the 'DataWarehouse' database
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

-- Create Schemas 
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO 

CREATE SCHEMA gold;
GO

PRINT 'DataWarehouse database and schemas (bronze, silver, gold) created successfully.';
GO


/* 
=============================================================
SAFE VERSION — Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a database named 'DataWarehouse' ONLY if it does not already exist.
    It will NOT drop or overwrite an existing database.
    After creation, it ensures the 'bronze', 'silver', and 'gold' schemas exist.
*/

USE master;
GO

-- Check if the database already exists
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    PRINT 'Database ''DataWarehouse'' already exists. No action taken.';
    RETURN;   -- Stop the script safely
END;
GO

-- Create the 'DataWarehouse' database
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

-- Create schemas safely
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'bronze')
    EXEC('CREATE SCHEMA bronze');

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'silver')
    EXEC('CREATE SCHEMA silver');

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'gold')
    EXEC('CREATE SCHEMA gold');

PRINT 'DataWarehouse created successfully with bronze, silver, and gold schemas.';
GO
