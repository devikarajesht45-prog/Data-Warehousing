--to check for duplicate customers
select
	customer_number,
	count(*) as duplicate_customers 
from gold.dim_customers 
group by customer_number
having count(*)>1

--to check duplicate products
select
	product_key,
	count(*) as duplicate_products
from gold.dim_products
group by product_key
having count(*)>1

--to check customer id not in customers
select * from silver.crm_sales_details a
where not exists (select 1 from gold.dim_customers b where b.customer_id =a.sls_cust_id)

--to check product key not in products
select * from silver.crm_sales_details a
where not exists (select 1 from gold.dim_products b where b.product_number =a.sls_prd_key)