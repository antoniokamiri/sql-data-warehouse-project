/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'DataWarehouse' after checking if it already exists. 
    If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas 
    within the database: 'bronze', 'silver', and 'gold'.
	
WARNING:
    Running this script will drop the entire 'DataWarehouse' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/

-- create database warehouse

use master;
 go

 -- Drop and recreate the datawarehouse database
 
 if EXISTS(select 1 from sys.databases where name = 'DataWarehouse')
 BEGIN
	ALter database DataWarehouse set single_user with rollback immediate;
	Drop database DataWarehouse;
 END;
 go
 
 -- create databse
 create Database DataWarehouse;
 go

 use DataWarehouse;
 go

 -- create schema
 Create schema bronze;
 go

 Create schema silver;
 go

 Create schema gold;
 go
