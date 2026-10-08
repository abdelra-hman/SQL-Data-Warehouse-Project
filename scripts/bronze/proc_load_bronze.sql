/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
*/


CREATE OR ALTER PROCEDURE bronze.load_bronze AS
DECLARE @Start_time DATETIME,
            @End_time   DATETIME,
            @Batch_Start_time DATETIME,
            @Batch_End_time DATETIME;
SET @Batch_Start_time = GETDATE();
BEGIN
   -- DECLARE @Start_time DATETIME,
          --  @End_time   DATETIME;

    BEGIN TRY

        PRINT '================================================';
        PRINT 'Loading Bronze Layer';
        PRINT '================================================';

        PRINT '------------------------------------------------';
        PRINT 'Loading CRM Tables';
        PRINT '------------------------------------------------';


        /* =========================================================
           CRM: Customer Info
        ========================================================= */

        SET @Start_time = GETDATE();

        PRINT '>> Truncating Table: bronze.crm_cust_info';
        TRUNCATE TABLE bronze.crm_cust_info;

        PRINT '>> Inserting Data Into: bronze.crm_cust_info';

        BULK INSERT bronze.crm_cust_info
        FROM 'D:\programming\specializaion track\Data Engineering\Data With Baraa\Data With Baraa (SQL)\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
        WITH
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @End_time = GETDATE();

        PRINT '>> Load Duration: '
              + CAST(DATEDIFF(SECOND, @Start_time, @End_time) AS NVARCHAR)
              + ' seconds';

        PRINT '------------------------------------------------';


        /* =========================================================
           CRM: Product Info
        ========================================================= */

        SET @Start_time = GETDATE();

        PRINT '>> Truncating Table: bronze.crm_prd_info';
        TRUNCATE TABLE bronze.crm_prd_info;

        PRINT '>> Inserting Data Into: bronze.crm_prd_info';

        BULK INSERT bronze.crm_prd_info
        FROM 'D:\programming\specializaion track\Data Engineering\Data With Baraa\Data With Baraa (SQL)\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
        WITH
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @End_time = GETDATE();

        PRINT '>> Load Duration: '
              + CAST(DATEDIFF(SECOND, @Start_time, @End_time) AS NVARCHAR)
              + ' seconds';

        PRINT '------------------------------------------------';


        /* =========================================================
           CRM: Sales Details
        ========================================================= */

        SET @Start_time = GETDATE();

        PRINT '>> Truncating Table: bronze.crm_sales_details';
        TRUNCATE TABLE bronze.crm_sales_details;

        PRINT '>> Inserting Data Into: bronze.crm_sales_details';

        BULK INSERT bronze.crm_sales_details
        FROM 'D:\programming\specializaion track\Data Engineering\Data With Baraa\Data With Baraa (SQL)\DWH Project\project\datasets\source_crm\sales_details.csv'
        WITH
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @End_time = GETDATE();

        PRINT '>> Load Duration: '
              + CAST(DATEDIFF(SECOND, @Start_time, @End_time) AS NVARCHAR)
              + ' seconds';

        PRINT '------------------------------------------------';


        /* =========================================================
           ERP Tables
        ========================================================= */

        PRINT 'Loading ERP Tables';
        PRINT '------------------------------------------------';


        /* =========================================================
           ERP: Customer AZ12
        ========================================================= */

        SET @Start_time = GETDATE();

        PRINT '>> Truncating Table: bronze.erp_cust_az12';
        TRUNCATE TABLE bronze.erp_cust_az12;

        PRINT '>> Inserting Data Into: bronze.erp_cust_az12';

        BULK INSERT bronze.erp_cust_az12
        FROM 'D:\programming\specializaion track\Data Engineering\Data With Baraa\Data With Baraa (SQL)\DWH Project\project\datasets\source_erp\CUST_AZ12.csv'
        WITH
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @End_time = GETDATE();

        PRINT '>> Load Duration: '
              + CAST(DATEDIFF(SECOND, @Start_time, @End_time) AS NVARCHAR)
              + ' seconds';

        PRINT '------------------------------------------------';


        /* =========================================================
           ERP: Location A101
        ========================================================= */

        SET @Start_time = GETDATE();

        PRINT '>> Truncating Table: bronze.erp_loc_a101';
        TRUNCATE TABLE bronze.erp_loc_a101;

        PRINT '>> Inserting Data Into: bronze.erp_loc_a101';

        BULK INSERT bronze.erp_loc_a101
        FROM 'D:\programming\specializaion track\Data Engineering\Data With Baraa\Data With Baraa (SQL)\DWH Project\project\datasets\source_erp\LOC_A101.csv'
        WITH
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @End_time = GETDATE();

        PRINT '>> Load Duration: '
              + CAST(DATEDIFF(SECOND, @Start_time, @End_time) AS NVARCHAR)
              + ' seconds';

        PRINT '------------------------------------------------';


        /* =========================================================
           ERP: Product Category
        ========================================================= */

        SET @Start_time = GETDATE();

        PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2';
        TRUNCATE TABLE bronze.erp_px_cat_g1v2;

        PRINT '>> Inserting Data Into: bronze.erp_px_cat_g1v2';

        BULK INSERT bronze.erp_px_cat_g1v2
        FROM 'D:\programming\specializaion track\Data Engineering\Data With Baraa\Data With Baraa (SQL)\DWH Project\project\datasets\source_erp\PX_CAT_G1V2.csv'
        WITH
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @End_time = GETDATE();

        PRINT '>> Load Duration: '
              + CAST(DATEDIFF(SECOND, @Start_time, @End_time) AS NVARCHAR)
              + ' seconds';

        PRINT '------------------------------------------------';


        PRINT '================================================';
        PRINT 'Bronze Layer Loaded Successfully';
        PRINT '================================================';

    END TRY

    BEGIN CATCH

        PRINT '================================================';
        PRINT 'ERROR OCCURRED DURING LOADING BRONZE LAYER';
        PRINT 'Error Message: ' + ERROR_MESSAGE();
        PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Error State: ' + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT '================================================';

        THROW;

    END CATCH

    set @End_time = GETDATE()
    set @Batch_End_time = GETDATE()
     PRINT '------------------------------------------------';
     PRINT '>> FULL Load Duration: '
              + CAST(DATEDIFF(SECOND, @Batch_Start_time, @Batch_End_time) AS NVARCHAR)
              + ' seconds';
     PRINT '------------------------------------------------';


END;


EXEC bronze.load_bronze;