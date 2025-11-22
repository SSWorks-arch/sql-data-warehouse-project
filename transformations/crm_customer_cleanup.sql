/*====================================================================
 Script: crm_customer_cleanup.sql
 Layer: Bronze → Silver
 Purpose:
    - Deduplicate CRM customer records (keep latest)
    - Normalize gender and marital status
    - Remove whitespace
    - Validate and clean primary keys
    - Prepare data for Silver layer loading
 Outputs:
    - Clean SELECT used by silver.load_silver
