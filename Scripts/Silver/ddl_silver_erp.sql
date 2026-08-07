if object_id('silver.erp_cust_az12','U') is not null
	drop table silver.erp_cust_az12;
create table silver.erp_cust_az12(
	cid varchar(50),
	bdate date,
	gen varchar(50),
	dwh_create_date datetime2 default getdate()
);
go 

if object_id('silver.erp_loc_a101','U') is not null
	drop table silver.erp_loc_a101;

create table silver.erp_loc_a101(
	cid varchar(50),
	cntry varchar(50),
	dwh_create_date datetime2 default getdate()
);
go

if object_id('silver.erp_px_cat_g1v2','U') is not null
	drop table silver.erp_px_cat_g1v2;

create table silver.erp_px_cat_g1v2(
	id varchar(50),
	cat varchar(50),
	subcat varchar(50),
	maintenance varchar(50),
	dwh_create_date datetime2 default getdate()
);
go