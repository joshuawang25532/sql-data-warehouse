Drop table if exists bronze_crm_cust_info;
create table bronze_crm_cust_info ( 
cst_id INT, 
cst_key VARCHAR(50), 
cst_firstname VARCHAR(50), 
cst_lastname VARCHAR(50), 
cst_marital_status VARCHAR(50), 
cst_gndr VARCHAR(50), 
cst_create_date DATE );


Drop table if exists bronze_crm_prd_info;
create table bronze_crm_prd_info (
prd_id INT,
prd_key VARCHAR(50),
prd_nm VARCHAR(50),
prd_cost INT,
prd_line VARCHAR(50),
prd_start_dt DATE,
prd_end_dt DATE);

Drop table if exists bronze_crm_sales_details;
Create table bronze_crm_sales_details (
sls_ord_num VARCHAR(50), 
sls_prd_key VARCHAR(50),
sls_cust_id INT,
sls_order_dt VARCHAR(50),
sls_ship_dt VARCHAR(50),
sls_due_dt VARCHAR(50),
sls_sales INT,
sls_quantity INT,
sls_price INT);

Drop table if exists bronze_erp_cust_az12;
Create table bronze_erp_cust_az12 (
CID VARCHAR(50),
BDATE DATE,
GEN VARCHAR(50));

Drop table if exists bronze_erp_loc_a101;
Create table bronze_erp_loc_a101 (
Cid VARCHAR(50),
CNTRY VARCHAR(50));

Drop table if exists bronze_erp_px_cat_g1v2;
Create table bronze_erp_px_cat_g1v2 (
ID VARCHAR(50),
CAT VARCHAR(50),
SUBCAT VARCHAR(50),
MAINTENANCE VARCHAR(50) );
