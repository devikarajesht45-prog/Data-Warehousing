create or alter procedure bronze.load_bronze as 
begin
	declare @tstart datetime,@tend datetime,@pstart datetime,@pend datetime
	begin try
		set @pstart=getdate();
		print'========================';
		print'Loading Bronze Layer';
		print'========================';
		print'------------------------';
		print'Loading CRM Tables';
		set @tstart=getdate();
		truncate table bronze.crm_cust_info;
		bulk insert bronze.crm_cust_info
		from 'C:\Users\user\Downloads\CRM\cust_info.csv'
		with (
			firstrow=2,
			fieldterminator=',',
			tablock
		);
		set @tend=getdate();
		print'Load Duration:'+cast(datediff(second,@tstart,@tend)as varchar(50))+'seconds';
		print'------------------------';
		set @tstart=getdate();
		truncate table bronze.crm_prd_info;
		bulk insert bronze.crm_prd_info
		from 'C:\Users\user\Downloads\CRM\prd_info.csv'
		with (
			firstrow=2,
			fieldterminator=',',
			tablock
		);
		set @tend=getdate();
		print'Load Duration:'+cast(datediff(second,@tstart,@tend)as varchar(50))+'seconds';
		print'------------------------';
		set @tstart=getdate();
		truncate table bronze.crm_sales_details;
		bulk insert bronze.crm_sales_details
		from 'C:\Users\user\Downloads\CRM\sales_details.csv'
		with (
			firstrow=2,
			fieldterminator=',',
			tablock
		);
		set @tend=getdate();
		print'Load Duration:'+cast(datediff(second,@tstart,@tend)as varchar(50))+'seconds';
		print'------------------------';
		print'------------------------';
		print'Loading ERP Tables';
		print'------------------------';
		set @tstart=getdate();
		truncate table bronze.erp_cust_az12;
		bulk insert bronze.erp_cust_az12
		from 'C:\Users\user\Downloads\ERP\cust_az12.csv'
		with (
			firstrow=2,
			fieldterminator=',',
			tablock
		);
		set @tend=getdate();
		print'Load Duration:'+cast(datediff(second,@tstart,@tend)as varchar(50))+'seconds';
		print'------------------------';
		set @tstart=getdate();
		truncate table bronze.erp_loc_a101;
		bulk insert bronze.erp_loc_a101
		from 'C:\Users\user\Downloads\ERP\loc_a101.csv'
		with (
			firstrow=2,
			fieldterminator=',',
			tablock
		);
		set @tend=getdate();
		print'Load Duration:'+cast(datediff(second,@tstart,@tend)as varchar(50))+'seconds';
		print'------------------------';
		set @tstart=getdate();
		truncate table bronze.erp_px_cat_g1v2;
		bulk insert bronze.erp_px_cat_g1v2
		from 'C:\Users\user\Downloads\ERP\px_cat_g1v2.csv'
		with (
			firstrow=2,
			fieldterminator=',',
			tablock
		);
		set @tend=getdate();
		print'Load Duration:'+cast(datediff(second,@tstart,@tend)as varchar(50))+'seconds';
		print'------------------------';
		set @pend=getdate(); 
		print'Load Duration:'+cast(datediff(second,@pstart,@pend)as varchar(50))+'seconds';
		print'Bronze Layer Loaded Successfully'
		print'------------------------';
		print'========================';
	end try
	begin catch
		print'========================';
		print'Error Occured During Loading Bronze Layer'
		print 'Error Message:'+error_message();
		print 'Error Line:'+cast(error_line() as varchar(50));
		print 'Error Number:'+cast(error_number() as varchar(50));
		print 'Error State:'+cast(error_state() as varchar(50));
		print'========================';
	end catch
end;

--exec bronze.load_bronze