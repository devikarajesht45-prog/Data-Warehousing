create view gold.dim_customers as 
	select
		row_number() over (order by ci.cst_id) as customer_key, 
		ci.cst_id as customer_id, 
		ci.cst_key as customer_number, 
		ci.cst_firstname as first_name, 
		ci.cst_lastname as last_name, 
		ci.cst_marital_status as marital_status, 
		ci.cst_gndr as gender, 
		cl.cntry as country, 
		cu.bdate as birth_date, 
		ci.cst_create_date as create_date 
	from silver.crm_cust_info ci
	left join silver.erp_cust_az12 cu 
	on ci.cst_key=cu.cid 
	left join silver.erp_loc_a101 cl 
	on ci.cst_key=cl.cid 

create view gold.dim_products as
	select 
		row_number() over (order by pr.prd_id) as product_key,
		pr.prd_id as product_id,  
		pr.prd_key as product_number, 
		pr.prd_nm as product_name, 
		pr.cat_id as category_id, 
		px.cat as category, 
		px.subcat as subcategory,
		px.maintenance as maintenance, 
		pr.prd_cost as product_cost, 
		pr.prd_line as product_line, 
		pr.prd_start_dt as start_date 
	from silver.crm_prd_info pr 
	left join silver.erp_px_cat_g1v2 px
	on pr.cat_id=px.id

create view gold.fact_sales as 
	select
		sl.sls_ord_num as order_number,
		dp.product_key,
		dc.customer_key, 
		sl.sls_price as price, 
		sl.sls_quantity as quantity, 
		sl.sls_sales as sales_amount, 
		sl.sls_order_dt as order_date, 
		sl.sls_ship_dt as shipment_date, 
		sl.sls_due_dt as due_date 
	from silver.crm_sales_details sl
	left join gold.dim_customers dc 
	on sl.sls_cust_id=dc.customer_id 
	left join gold.dim_products dp
	on sl.sls_prd_key=dp.product_number 
