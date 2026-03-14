-- Uses local load, remember to config your connection details

USE DataWarehouse;
-- bronze_crm_cust_info
TRUNCATE TABLE bronze_crm_cust_info;
LOAD DATA LOCAL INFILE '/Users/jcw2016/Desktop/SQL Data Warehouse/sql-data-warehouse-project/datasets/source_crm/cust_info.csv'
	INTO TABLE bronze_crm_cust_info
	FIELDS TERMINATED BY ','
	LINES TERMINATED BY '\n'
	IGNORE 1 LINES;
SELECT COUNT(*) FROM bronze_crm_cust_info;

-- bronze_crm_prd_info
TRUNCATE TABLE bronze_crm_prd_info;
LOAD DATA LOCAL INFILE '/Users/jcw2016/Desktop/SQL Data Warehouse/sql-data-warehouse-project/datasets/source_crm/prd_info.csv'
	INTO TABLE bronze_crm_prd_info
	FIELDS TERMINATED BY ','
	LINES TERMINATED BY '\n'
	IGNORE 1 LINES;
SELECT COUNT(*) FROM bronze_crm_prd_info;

-- bronze_crm_sales_details
TRUNCATE TABLE bronze_crm_sales_details;
LOAD DATA LOCAL INFILE '/Users/jcw2016/Desktop/SQL Data Warehouse/sql-data-warehouse-project/datasets/source_crm/sales_details.csv'
	INTO TABLE bronze_crm_sales_details
	FIELDS TERMINATED BY ','
	LINES TERMINATED BY '\n'
	IGNORE 1 LINES;
SELECT COUNT(*) FROM bronze_crm_sales_details;

-- bronze_erp_cust_az12
TRUNCATE TABLE bronze_erp_cust_az12;
LOAD DATA LOCAL INFILE '/Users/jcw2016/Desktop/SQL Data Warehouse/sql-data-warehouse-project/datasets/source_erp/cust_az12.csv'
	INTO TABLE bronze_erp_cust_az12
	FIELDS TERMINATED BY ','
	LINES TERMINATED BY '\n'
	IGNORE 1 LINES;
SELECT COUNT(*) FROM bronze_erp_cust_az12;

-- bronze_erp_loc_a101
TRUNCATE TABLE bronze_erp_loc_a101;
LOAD DATA LOCAL INFILE '/Users/jcw2016/Desktop/SQL Data Warehouse/sql-data-warehouse-project/datasets/source_erp/loc_a101.csv'
	INTO TABLE bronze_erp_loc_a101
	FIELDS TERMINATED BY ','
	LINES TERMINATED BY '\n'
	IGNORE 1 LINES;
SELECT COUNT(*) FROM bronze_erp_loc_a101;

-- bronze_erp_px_cat_g1v2
TRUNCATE TABLE bronze_erp_px_cat_g1v2;
LOAD DATA LOCAL INFILE '/Users/jcw2016/Desktop/SQL Data Warehouse/sql-data-warehouse-project/datasets/source_erp/px_cat_g1v2.csv'
	INTO TABLE bronze_erp_px_cat_g1v2
	FIELDS TERMINATED BY ','
	LINES TERMINATED BY '\n'
	IGNORE 1 LINES;
SELECT COUNT(*) FROM bronze_erp_px_cat_g1v2;
