/* 
=============================================================
Create DataBase and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'DataWarehouse' after checking if it already exists.
    If the data exists, it is dropped and recreated. Additionaly, the script sets up three schemas 
    within the database: 'bronze', 'silver', and 'gold'.

WARNING:
  Running this script will drop the entire 'DataWarehouse' database if it exists.
  All data in the database will be permanently deleted. Proceed with caution
  and ensure you have proper backups running this script.
*/

USE master; 
GO

-- Drop and recreate the 'DataWarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
  ALTER DATABASE DataWarehoues SET SINGLE_USER with ROLLBACK IMMEDIATE;
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


/* 
=============================================================
SAFE VERSION — Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a database named 'DataWarehouse' ONLY if it does not already exist.
    It will NOT drop or overwrite an existing database.
    After creation, it sets up the 'bronze', 'silver', and 'gold' schemas.

Safety:
    If the 'DataWarehouse' database already exists, the script prints a message
    and exits without making changes.
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

-- Create schemas only in the newly created database
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO

PRINT 'DataWarehouse created successfully with bronze, silver, and gold schemas.';
    
