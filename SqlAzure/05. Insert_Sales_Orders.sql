DECLARE @i INT = 1;

WHILE @i <= 10000
BEGIN
    INSERT INTO SalesOrders (
        CustomerID, SalesRepID, OrderDate, OrderStatus, TotalAmountUSD
    )
    VALUES (
        (ABS(CHECKSUM(NEWID())) % 1000) + 1,
        (ABS(CHECKSUM(NEWID())) % 25) + 1,
        DATEADD(DAY, - (ABS(CHECKSUM(NEWID())) % 730), GETDATE()),
        CASE (@i % 4)
            WHEN 0 THEN 'Pending'
            WHEN 1 THEN 'Confirmed'
            WHEN 2 THEN 'Shipped'
            ELSE 'Cancelled'
        END,
        0
    );

    SET @i += 1;
END;
