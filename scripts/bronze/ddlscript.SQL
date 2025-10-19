GO
CREATE OR ALTER PROCEDURE bronze1.load_bronze AS
BEGIN
DECLARE @start_time AS DATETIME,@end_time AS DATETIME,@batch_start_time AS DATETIME,@batch_end_time AS DATETIME;

SET @batch_start_time=GETDATE();

	BEGIN TRY

		--INSERTING DATA INTO TABLES
	PRINT '.........................................................................';
	PRINT 'Truncating Tables';
	PRINT '.........................................................................';
	 TRUNCATE TABLE bronze1.crm_cust_info;

	PRINT '========================================================================='; 
	PRINT 'Loading Table bronze1.crm_cust_info';
	PRINT '=========================================================================';

SET @start_time=GETDATE();


		BULK INSERT bronze1.crm_cust_info
		FROM 'C:\TEMPSQL\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
		 FIRSTROW=2,
		 FIELDTERMINATOR = ',',
		 TABLOCK
		);   

	PRINT '.........................................................................';
	PRINT 'Truncating Tables';
	PRINT '.........................................................................';

SET @end_time = GETDATE();
PRINT '>> Load duration:'+ CAST(DATEDIFF(SECOND, @start_time, @end_time)AS NVARCHAR) + 'seconds';


SET @start_time=GETDATE();

    TRUNCATE TABLE bronze1.crm_prd_info;

	PRINT '=========================================================================' ;
	PRINT 'Loading Table bronze1.crm_prd_info';
	PRINT '=========================================================================';

		BULK INSERT bronze1.crm_prd_info
		FROM 'C:\TEMPSQL\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
		FIRSTROW=2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);   

	PRINT '.........................................................................';
	PRINT 'Truncating Tables';
	PRINT '.........................................................................';

SET @end_time = GETDATE();
PRINT '>> Load duration:'+ CAST(DATEDIFF(SECOND, @start_time, @end_time)AS NVARCHAR) + 'seconds';


SET @start_time=GETDATE();


		TRUNCATE TABLE bronze1.crm_sales_details;

	PRINT '=========================================================================' ;
	PRINT 'Loading Table bronze1.crm_sales_details ';
	PRINT '=========================================================================';

		BULK INSERT bronze1.crm_sales_details
		FROM 'C:\TEMPSQL\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
		FIRSTROW=2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);  
	
	PRINT '.........................................................................';
	PRINT 'Truncating Tables';
	PRINT '.........................................................................';

SET @end_time = GETDATE();
PRINT '>> Load duration:'+ CAST(DATEDIFF(SECOND, @start_time, @end_time)AS NVARCHAR) + 'seconds';



SET @start_time=GETDATE();


		TRUNCATE TABLE bronze1.erp_cust_az12;

	PRINT '========================================================================='; 
	PRINT 'Loading Table bronze1.erp_cust_az12 ';
	PRINT '=========================================================================';
		BULK INSERT bronze1.erp_cust_az12
		FROM 'C:\TEMPSQL\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
		FIRSTROW=2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);   

	PRINT '.........................................................................';
	PRINT 'Truncating Tables';
	PRINT '.........................................................................';

SET @end_time = GETDATE();
PRINT '>> Load duration:'+ CAST(DATEDIFF(SECOND, @start_time, @end_time)AS NVARCHAR) + 'seconds';

SET @start_time=GETDATE();

		TRUNCATE TABLE bronze1.erp_loc_a101;

	PRINT '=========================================================================' ;
	PRINT 'Loading Table bronze1.erp_loc_a101 ';
	PRINT '=========================================================================';
		BULK INSERT bronze1.erp_loc_a101
		FROM 'C:\TEMPSQL\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
		FIRSTROW=2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);   
SET @end_time = GETDATE();
PRINT '>> Load duration:'+ CAST(DATEDIFF(SECOND, @start_time, @end_time)AS NVARCHAR) + 'seconds';


SET @start_time=GETDATE();
	PRINT '.........................................................................';
	PRINT 'Truncating Tables';
	PRINT '.........................................................................';


		TRUNCATE TABLE bronze1.erp_px_cat_g1v2;

	PRINT '========================================================================='; 
	PRINT 'Loading Table  bronze1.erp_px_cat_g1v2 ';
	PRINT '=========================================================================';
		BULK INSERT bronze1.erp_px_cat_g1v2
		FROM 'C:\TEMPSQL\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
		FIRSTROW=2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);   
SET @end_time = GETDATE();
PRINT '>> Load duration:'+ CAST(DATEDIFF(SECOND, @start_time, @end_time)AS NVARCHAR) + 'seconds';

SET @batch_start_time=GETDATE();
PRINT'=========================================================================================================='
PRINT'Loading bronze layer is complete'
PRINT '>> Total Load duration:'+ CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time)AS NVARCHAR) + 'seconds';
PRINT'=========================================================================================================='

	END TRY
	BEGIN CATCH
	PRINT '==========================================================================='
	PRINT 'ERROR OCCURED DURING LOADIND BRONZE LAYER'
	PRINT 'Error Message:'+ ERROR_MESSAGE();
	PRINT 'Error Numder:'+ CAST (ERROR_NUMBER()AS NVARCHAR);
	PRINT 'Error State:'+ CAST (ERROR_STATE()AS NVARCHAR);
	PRINT '==========================================================================='
	END CATCH
END

