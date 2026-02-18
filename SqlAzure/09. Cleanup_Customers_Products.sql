-- ============================================================
-- 09. Cleanup: Keep first 150 Customers and first 80 Products
--     Re-assign orphaned Sales Orders and Order Items before
--     deleting excess rows.
-- ============================================================

BEGIN TRANSACTION;

BEGIN TRY

    -- --------------------------------------------------------
    -- 1. Re-assign OrderItems that reference Products > 80
    --    Map each to a random Product in the 1-80 range
    -- --------------------------------------------------------
    UPDATE oi
    SET    oi.ProductID  = (ABS(CHECKSUM(NEWID())) % 80) + 1,
           oi.UnitPriceUSD = p_new.UnitPriceUSD
    FROM   OrderItems oi
    CROSS APPLY (
        SELECT TOP 1 UnitPriceUSD
        FROM   Products
        WHERE  ProductID = (ABS(CHECKSUM(NEWID())) % 80) + 1
    ) p_new
    WHERE  oi.ProductID > 80;

    -- --------------------------------------------------------
    -- 2. Re-assign SalesOrders whose CustomerID > 150
    --    Map each to a random Customer in the 1-150 range
    -- --------------------------------------------------------
    UPDATE so
    SET    so.CustomerID = (ABS(CHECKSUM(NEWID())) % 150) + 1
    FROM   SalesOrders so
    WHERE  so.CustomerID > 150;

    -- --------------------------------------------------------
    -- 3. Delete Products with ProductID > 80
    -- --------------------------------------------------------
    DELETE FROM Products WHERE ProductID > 80;

    -- --------------------------------------------------------
    -- 4. Delete Customers with CustomerID > 150
    -- --------------------------------------------------------
    DELETE FROM Customers WHERE CustomerID > 150;

    DECLARE @custCount INT = (SELECT COUNT(*) FROM Customers);
    DECLARE @prodCount INT = (SELECT COUNT(*) FROM Products);

    PRINT 'Cleanup completed successfully.';
    PRINT 'Remaining Customers: ' + CAST(@custCount AS VARCHAR(10));
    PRINT 'Remaining Products:  ' + CAST(@prodCount AS VARCHAR(10));

    COMMIT TRANSACTION;

END TRY
BEGIN CATCH

    ROLLBACK TRANSACTION;

    PRINT 'Error occurred – transaction rolled back.';
    PRINT ERROR_MESSAGE();

END CATCH;
