/*====================================================================
 Script: erp_cleanup.sql
 Layer: Bronze → Silver
 Purpose:
    - Clean ERP raw tables
    - Deduplicate if required
    - Standardize text and category values
    - Prepare data for Silver layer
 Outputs:
    - Clean SELECT statements for loading Silver tables
*/
