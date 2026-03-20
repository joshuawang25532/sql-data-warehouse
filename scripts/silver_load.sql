USE DataWarehouse;

TRUNCATE TABLE silver_crm_cust_info;
INSERT INTO silver_crm_cust_info
(
	cst_id,
	cst_key,
	cst_firstname,
	cst_lastname,
	cst_marital_status,
	cst_gndr,
	cst_create_date)
WITH cte AS (
	SELECT 
		cst_id, 
		cst_key,
		TRIM(cst_firstname) AS cst_firstname,
		TRIM(cst_lastname) AS cst_lastname,
		CASE WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married'
			WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single'
			ELSE 'N/A'
		END cst_marital_status,
		CASE WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
			WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
			ELSE 'N/A'
		END cst_gndr,
		cst_create_date,
		ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
	FROM bronze_crm_cust_info)
SELECT 
	cst_id,
	cst_key,
	cst_firstname,
	cst_lastname,
	cst_marital_status,
	cst_gndr,
	cst_create_date
FROM cte
WHERE flag_last = 1 AND cst_id != 0;
SELECT COUNT(*) AS 'silver_crm_cust_info rows' FROM silver_crm_cust_info;


TRUNCATE TABLE silver_crm_prd_info;
INSERT INTO silver_crm_prd_info (
prd_id,
cat_id,
prd_key,
prd_nm,
prd_cost,
prd_line,
prd_start_dt,
prd_end_dt) 
SELECT
	prd_id, 
	REPLACE(SUBSTRING(prd_key, 1, 5), '-', '_') AS cat_id,
	SUBSTRING(prd_key, 7, LENGTH(prd_key)) AS prd_key,
	prd_nm,
	prd_cost,
	CASE UPPER(TRIM(prd_line)) 
		WHEN 'M' THEN 'Mountain'
		WHEN 'R' THEN 'Road'
		WHEN 'T' THEN 'Touring'
		WHEN 'S' THEN 'Other Sales'
		ELSE 'N/A'
	END AS prd_line,
	prd_start_dt,
	DATE_SUB(LEAD(prd_start_dt, 1) OVER (PARTITION BY prd_key ORDER BY prd_start_dt ASC), INTERVAL 1 DAY) AS prd_end_dt
FROM bronze_crm_prd_info;
SELECT COUNT(*) AS 'silver_crm_prd_info rows' FROM silver_crm_prd_info;


TRUNCATE TABLE silver_crm_sales_details;
INSERT INTO silver_crm_sales_details (
sls_ord_num,
sls_prd_key,
sls_cust_id,
sls_order_dt,
sls_ship_dt,
sls_due_dt,
sls_sales,
sls_quantity,
sls_price)
SELECT
sls_ord_num,
sls_prd_key,
sls_cust_id,
CASE 
	WHEN sls_order_dt = 0 OR LENGTH(sls_order_dt) != 8 THEN NULL
	ELSE CAST(sls_order_dt AS DATE)
END AS sls_order_dt,
CASE 
	WHEN sls_ship_dt = 0 OR LENGTH(sls_ship_dt) != 8 THEN NULL
	ELSE CAST(sls_ship_dt AS DATE)
END AS sls_ship_dt,
CASE 
	WHEN sls_due_dt = 0 OR LENGTH(sls_due_dt) != 8 THEN NULL
	ELSE CAST(sls_due_dt AS DATE)
END AS sls_due_dt,
CASE
	WHEN sls_sales <= 0 OR sls_sales IS NULL OR (sls_sales != sls_price * sls_quantity AND sls_price > 0) THEN ABS(sls_price * sls_quantity)
	ELSE sls_sales
END AS sls_sales,
sls_quantity,
CASE
	WHEN sls_price <= 0 OR sls_price IS NULL THEN sls_sales / NULLIF(sls_quantity, 0)
	ELSE sls_price
END AS sls_price
FROM bronze_crm_sales_details;
SELECT COUNT(*) AS 'silver_crm_sales_details rows' FROM silver_crm_sales_details;


TRUNCATE TABLE silver_erp_cust_az12;
INSERT INTO silver_erp_cust_az12 
(cid,
bdate,
gen)
SELECT
	CASE 
		WHEN cid LIKE "NAS%" THEN SUBSTRING(cid, 4, LENGTH(cid))
		ELSE cid
	END AS cid,
	CASE
		WHEN bdate > NOW() THEN NULL
		ELSE bdate
	END AS bdate,
	CASE 
		WHEN UPPER(TRIM(REPLACE(gen, '\r', ''))) IN ('M', 'MALE') THEN 'Male'
		WHEN UPPER(TRIM(REPLACE(gen, '\r', ''))) IN ('F', 'FEMALE') THEN 'Female'
		ELSE NULL
	END AS gen
FROM bronze_erp_cust_az12;
SELECT COUNT(*) AS 'silver_erp_cust_az12 rows' FROM silver_erp_cust_az12;


TRUNCATE silver_erp_loc_a101;
INSERT INTO silver_erp_loc_a101
(cid, cntry)
SELECT
REPLACE(cid, '-', '') AS Cid,
CASE WHEN TRIM(REPLACE(cntry, '\r', '')) = 'DE' THEN 'Germany'
	WHEN TRIM(REPLACE(cntry, '\r', '')) IN ('US', 'USA') THEN 'United States'
	WHEN LENGTH(TRIM(REPLACE(cntry, '\r', ''))) = 0 OR cntry IS NULL THEN 'N/A'	
	ELSE TRIM(REPLACE(cntry, '\r', ''))
END AS cntry
FROM
bronze_erp_loc_a101;
SELECT COUNT(*) AS 'silver_erp_loc_a101 rows' FROM silver_erp_loc_a101;


TRUNCATE TABLE silver_erp_px_cat_g1v2;
INSERT INTO silver_erp_px_cat_g1v2 (id, cat, subcat, maintenance)
SELECT 
id,
cat,
subcat,
REPLACE(maintenance, '\r', '') AS maintenance
FROM bronze_erp_px_cat_g1v2;
SELECT COUNT(*) AS 'silver_erp_px_cat_g1v2 rows' FROM silver_erp_px_cat_g1v2;
