/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/

Create or Alter Procedure bronze.load_bronze as
Begin
	Declare @start_bronze_time Datetime, @end_bronze_time Datetime, @start_time Datetime, @end_time Datetime; 

	Set @start_bronze_time = GETDATE();
	Begin try
		print '=============================================';
		print 'Loading Bronze layer';
		print '=============================================';

		print '---------------------------------------------';
		print 'Loading CRM table';
		print '---------------------------------------------';

		PRINT '>> Truncating table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;

		Set @start_time = GETDATE();

		PRINT '>> Inserting Data Into: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM '/var/opt/mssql/data/cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		Set @end_time = GETDATE();
		PRINT '>> Load duration: ' + Cast(DateDiff(second, @start_time, @end_time) as Nvarchar) + ' seconds';
		PRINT '>> -----------------';

		PRINT '>> Truncating table: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;

		Set @start_time = GETDATE();
		PRINT '>> Inserting Data Into: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM '/var/opt/mssql/data/prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		Set @end_time = GETDATE();
		PRINT '>> Load duration: ' + Cast(DateDiff(second, @start_time, @end_time) as Nvarchar) + ' seconds';
		PRINT '>> -----------------';


		PRINT '>> Truncating table: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;

		Set @start_time = GETDATE();
		PRINT '>> Inserting Data Into: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM '/var/opt/mssql/data/sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		Set @end_time = GETDATE();
		PRINT '>> Load duration: ' + Cast(DateDiff(second, @start_time, @end_time) as Nvarchar) + ' seconds';
		PRINT '>> -----------------';


		print '---------------------------------------------';
		print 'Loading ERP table';
		print '---------------------------------------------';

		PRINT '>> Truncating table: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;

		Set @start_time = GETDATE();
		PRINT '>> Inserting Data Into: bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM '/var/opt/mssql/data/LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		Set @end_time = GETDATE();
		PRINT '>> Load duration: ' + Cast(DateDiff(second, @start_time, @end_time) as Nvarchar) + ' seconds';
		PRINT '>> -----------------';


		PRINT '>> Truncating table: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;

		Set @start_time = GETDATE();
		PRINT '>> Inserting Data Into: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM '/var/opt/mssql/data/CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		Set @end_time = GETDATE();
		PRINT '>> Load duration: ' + Cast(DateDiff(second, @start_time, @end_time) as Nvarchar) + ' seconds';
		PRINT '>> -----------------';


		PRINT '>> Truncating table: bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		Set @start_time = GETDATE();
		PRINT '>> Inserting Data Into: bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM '/var/opt/mssql/data/PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		Set @end_time = GETDATE();
		PRINT '>> Load duration: ' + Cast(DateDiff(second, @start_time, @end_time) as Nvarchar) + ' seconds';
		PRINT '>> -----------------';

		Set @end_bronze_time = GETDATE();
		print '=============================================';
		PRINT '>> Bronze Layer is loaded successfully';
		PRINT '>> Bronze Layer Duration: ' + Cast(DateDiff(second, @start_bronze_time, @end_bronze_time) as Nvarchar) + ' seconds';
		print '=============================================';
	end try
	Begin Catch
		print '=============================================';
		print 'Error occured during loading bronze layer';
		print 'Error message' + Error_message();
		print 'Error message' + Cast(Error_Number() as Nvarchar);
		print 'Error message' + Cast(Error_State() as Nvarchar);
		print '=============================================';
	End Catch


end
