select * from bronze.crm_cust_info
--checking for duplicates
select cst_id,count(*)
from bronze.crm_cust_info
group by cst_id
having count(*)>1

--checking for null values
select * from bronze.crm_cust_info
where cst_id is null

--checking unique values
select distinct cst_marital_status
from bronze.crm_cust_info;
select distinct cst_gndr 
from bronze.crm_cust_info;

--to check the split of product key
select prd_key,
	substring(prd_key,1,5) as cat_id,
	substring(prd_key,7,len(prd_key)) as final_prd_key 
from bronze.crm_prd_info 

--to check null or negative values in prd_cost
select * from bronze.crm_prd_info 
where prd_cost is null or prd_cost < 0

--to check distinct values prd_line 
select distinct prd_line from bronze.crm_prd_info 

--to check end dates earlier than start dates 
select * from bronze.crm_prd_info 
where prd_end_dt < prd_start_dt

--to check the shipping date earlier than order date 
select * from bronze.crm_sales_details 
where sls_order_dt > sls_ship_dt 

--to check product key in sales but not in prd_info 
select distinct sls_prd_key from bronze.crm_sales_details 
where sls_prd_key not in (select prd_key from silver.crm_prd_info)

--to check null or inconsistencies in price,quantity & sales
select sls_price,sls_quantity,sls_sales from bronze.crm_sales_details 
where sls_sales is null or sls_sales<=0 
or sls_sales != sls_quantity * abs(sls_price)
or sls_price is null or sls_price<=0
or sls_quantity is null or sls_quantity <=0

--to check presence of NAS in cid
select * from bronze.erp_cust_az12 
where cid like '%NAS%'

--to cheeck people with invalid bdate
select * from bronze.erp_cust_az12
where bdate > getdate()

--to check distinct values in gender
select distinct gen from bronze.erp_cust_az12 

--to check distinct countries in a101 
select distinct cntry from bronze.erp_loc_a101 

--to check distinct values in all columns of px_cat
select distinct id from bronze.erp_px_cat_g1v2;
select distinct cat from bronze.erp_px_cat_g1v2;
select distinct subcat from bronze.erp_px_cat_g1v2;
select distinct maintenance from bronze.erp_px_cat_g1v2;

