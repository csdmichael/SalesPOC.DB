DECLARE @i INT = 1;

WHILE @i <= 1000
BEGIN
    INSERT INTO Customers (
        CustomerName, CustomerType, Industry, Country, State, City, AnnualRevenueUSD
    )
    VALUES (
        CONCAT('Customer ', @i),
        CASE (@i % 5)
            WHEN 0 THEN 'OEM'
            WHEN 1 THEN 'Distributor'
            WHEN 2 THEN 'Foundry'
            WHEN 3 THEN 'Fabless'
            ELSE 'Research'
        END,
        'Semiconductors',
        'USA',
        'CA',
        'San Jose',
        ABS(CHECKSUM(NEWID())) % 500000000 + 10000000
    );

    SET @i += 1;
END;
