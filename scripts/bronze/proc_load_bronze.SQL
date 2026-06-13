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


exec bronze.load_bronze

create or alter procedure bronze.load_bronze as
begin

declare @start_time datetime, @end_time datetime, @batch_start_time datetime, @batch_end_time datetime;
begin try
print '===============================================';
print  'loading bronze layer';
print '===============================================';

print '-----------------------------------------------';
print ' loading crm tables';
print '-----------------------------------------------';


set @start_time  = GETDATE();
print '>> truncating table: bronze.crm_cust_info';
truncate table bronze.crm_cust_info;

print '>> inserting data into table: bronze.crm_cust_info';
BULK INSERT bronze.crm_cust_info
FROM "D:\Barra subfiles\cust_info.csv"
WITH (
    FIRSTROW = 2,               
    FIELDTERMINATOR = ',',      
    TABLOCK                     
);
set @end_time  = GETDATE();
print '>> load duartion: ' + cast(datediff(second,@start_time,@end_time) as nvarchar) + 'seconds';
print '>> ---------------';


set @start_time  = GETDATE();
print '>> truncating table: bronze.crm_prd_info';
truncate table bronze.crm_prd_info;

print '>> inserting data into table: bronze.crm_prd_info';
BULK INSERT bronze.crm_prd_info
FROM "D:\Barra subfiles\prd_info.csv"
WITH (
    FIRSTROW = 2,               
    FIELDTERMINATOR = ',',      
    TABLOCK                     
);
set @end_time  = GETDATE();
print '>> load duartion: ' + cast(datediff(second,@start_time,@end_time) as nvarchar) + 'seconds';
print '>> ---------------';


set @start_time  = GETDATE();
print '>> truncating table: bronze.crm_sales_details';
truncate table bronze.crm_sales_details;

print '>> inserting data into table: bronze.crm_sales_details';
BULK INSERT bronze.crm_sales_details
FROM "D:\Barra subfiles\sales_details.csv"
WITH (
    FIRSTROW = 2,               
    FIELDTERMINATOR = ',',      
    TABLOCK                     
);
set @end_time  = GETDATE();
print '>> load duartion: ' + cast(datediff(second,@start_time,@end_time) as nvarchar) + 'seconds';
print '>> ---------------';


print '-----------------------------------------------';
print ' loading erp tables';
print '-----------------------------------------------';


set @start_time  = GETDATE();
print '>> truncating table: bronze.erp_cust_az12';
truncate table bronze.erp_cust_az12;

print '>> inserting data into table: bronze.erp_cust_az12';
BULK INSERT bronze.erp_cust_az12
FROM "D:\Barra subfiles\CUST_AZ12.csv"
WITH (
    FIRSTROW = 2,               
    FIELDTERMINATOR = ',',      
    TABLOCK                     
);
set @end_time  = GETDATE();
print '>> load duartion: ' + cast(datediff(second,@start_time,@end_time) as nvarchar) + 'seconds';
print '>> ---------------';


set @start_time  = GETDATE();
print '>> truncating table: bronze.erp_loc_a101';
truncate table bronze.erp_loc_a101;

print '>> inserting data into table: bronze.erp_loc_a101';
BULK INSERT bronze.erp_loc_a101
FROM "D:\Barra subfiles\LOC_A101.csv"
WITH (
    FIRSTROW = 2,               
    FIELDTERMINATOR = ',',      
    TABLOCK                     
);
set @end_time  = GETDATE();
print '>> load duartion: ' + cast(datediff(second,@start_time,@end_time) as nvarchar) + 'seconds';
print '>> ---------------';


set @start_time  = GETDATE();
print '>> truncating table: bronze.erp_px_cat_g1v2';
truncate table bronze.erp_px_cat_g1v2;

print '>> inserting data into table: bronze.erp_px_cat_g1v2';
BULK INSERT bronze.erp_px_cat_g1v2
FROM "D:\Barra subfiles\PX_CAT_G1V2.csv"
WITH (
    FIRSTROW = 2,               
    FIELDTERMINATOR = ',',      
    TABLOCK                     
);
set @end_time  = GETDATE();
print '>> load duartion: ' + cast(datediff(second,@start_time,@end_time) as nvarchar) + 'seconds';
print '>> ---------------';

SET @batch_end_time = GETDATE();
		PRINT '=========================================='
		PRINT 'Loading Bronze Layer is Completed';
        PRINT '   - Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT '=========================================='

end try
begin catch
    print '=============================================';
    print 'error occured during loading bronze layer';
    print 'error message' + error_message();
    print 'error message' + cast(error_number() as nvarchar);
    print 'error message' + cast(error_state() as nvarchar);
    print '=============================================';
end catch
end
