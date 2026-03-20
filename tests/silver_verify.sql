USE DataWarehouse

-- Testing silver_crm_cust_info
-- Check for unwanted spaces in cst_firstname and cst_lastname
SELECT cst_firstname
FROM silver_crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname);



-- Testing silver_crm_prd_info
-- Null/Duplicates Check for PK
SELECT
prd_id, COUNT(*)
FROM silver_crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id = 0 OR prd_id IS NULL;

-- Consistent Data
SELECT DISTINCT prd_line
FROM silver_crm_prd_info

-- Date Consistency
SELECT *
FROM silver_crm_prd_info
WHERE prd_end_dt < prd_start_dt



-- Testing silver_crm_sales_details
-- Price, Sales, Quantity Consistency
SELECT DISTINCT
sls_ord_num,
sls_sales,
sls_quantity, 
sls_price
FROM silver_crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <= 0 OR sls_quantity <= 0 OR sls_price <= 0


-- Date Verification silver_crm_sales_details
SELECT DISTINCT 
bdate
FROM silver_erp_cust_az12
WHERE bdate > NOW()


-- Gender Verification silver_erp_cust_az12
SELECT DISTINCT
gen
FROM silver_erp_cust_az12
