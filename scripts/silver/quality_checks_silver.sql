
--silver.crm_cust_info table
-- Check For Nulls or Duplicates in Primary Key
-- Expectation: No Result
select 
cst_id,
count(*)
from silver.crm_cust_info
group by cst_id 
having count(*) > 1 or cst_id is null
--silver.crm_cust_info quality checks
--check for unwanted spaces
-- Expectation : No Result
Select 
cst_firstname 
from silver.crm_cust_info
where cst_firstname <> trim(cst_firstname)

Select 
cst_lastname 
from silver.crm_cust_info

where cst_lastname <> trim(cst_lastname)
Select 
cst_gndr
from silver.crm_cust_info
where cst_gndr <> trim(cst_gndr)
-- Data Standardization & Consistency
Select Distinct cst_gndr
from silver.crm_cust_info

Select Distinct cst_marital_status
from silver.crm_cust_info


--silver.crm_prd_info

select 
prd_id,
count(*)
from silver.crm_prd_info
group by prd_id
having count(*) >1 or prd_id is null

--check for unwanted spaces
-- Expectation : No Result
Select 
prd_nm 
from silver.crm_prd_info
where prd_nm <> trim(prd_nm)


--check fro nulls or negative number


select 
prd_cost
from silver.crm_prd_info
where prd_cost < 0 or prd_cost is null

-- Data Standardization & Consistency
Select Distinct prd_line
from silver.crm_prd_info

--ceck fro invalid data orders 


select 
* 
from silver.crm_prd_info
where prd_end_dt <prd_start_dt



-- silver.crm_sales_details


select 
sls_ord_num,
sls_prd_key,
sls_cust_id,
nullif (sls_order_dt,0) sls_order_dt,
sls_ship_dt,
sls_due_dt,
sls_sales,
sls_quantity,
sls_price
from bronze.crm_sales_details
--where sls_ord_num <> trim(sls_ord_num)
--where sls_prd_key <> trim(sls_prd_key)
--where sls_cust_id not in (select cst_id from silver.crm_cust_info)
where sls_ship_dt <=0 or
len(sls_ship_dt) <>8 or
sls_ship_dt >20500101 or
sls_ship_dt < 19000101

select 
sls_ord_num,
sls_prd_key,
sls_cust_id,
case when sls_order_dt = 0 or len(sls_order_dt) <> 8 then NULL 
     else cast(cast(sls_order_dt as nvarchar) as date) 
end sls_order_dt ,
case when sls_ship_dt = 0 or len(sls_ship_dt) <> 8 then NULL 
     else cast(cast(sls_ship_dt as nvarchar) as date) 
end sls_ship_dt,
case when sls_due_dt = 0 or len(sls_due_dt) <> 8 then NULL 
     else cast(cast(sls_due_dt as nvarchar) as date) 
end sls_due_dt,
sls_sales,
sls_quantity,
sls_price
from bronze.crm_sales_details
where sls_order_dt > sls_ship_dt

select 
case 
    when sls_sales < = 0 or sls_sales is null or  sls_sales <> abs(sls_price) * sls_quantity then sls_quantity *abs(sls_price)
    else sls_sales
end sls_sales , 
case
    when sls_price <= 0 or sls_price is null then abs(sls_sales)  / nullif(sls_quantity,0)
    else sls_price
end sls_price,
sls_quantity
from bronze.crm_sales_details
where sls_sales != (sls_quantity * sls_price)
or sls_sales is null or sls_quantity is null or sls_price is null or
sls_sales <=0 or sls_quantity <=0 or sls_price <=0



--silver.erp_cust_az12
select 
distinct gen
from silver.erp_cust_az12

select 
bdate
from silver.erp_cust_az12
where 
bdate > getdate()














