DECLARE @OrderID INT = 1;
DECLARE @MaxOrderID INT = (SELECT MAX(OrderID) FROM SalesOrders);
DECLARE @Lines INT;

WHILE @OrderID <= @MaxOrderID
BEGIN
    SET @Lines = (ABS(CHECKSUM(NEWID())) % 5) + 1;

    DECLARE @j INT = 1;
    WHILE @j <= @Lines
    BEGIN
        INSERT INTO OrderItems (
            OrderID, ProductID, Quantity, UnitPriceUSD
        )
        VALUES (
            @OrderID,
            (ABS(CHECKSUM(NEWID())) % 200) + 1,
            (ABS(CHECKSUM(NEWID())) % 5000) + 50,
            CAST(ABS(CHECKSUM(NEWID())) % 500 + 5 AS DECIMAL(12,2))
        );

        SET @j += 1;
    END;

    SET @OrderID += 1;
END;
