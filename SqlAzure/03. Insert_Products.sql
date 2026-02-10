DECLARE @i INT = 1;

WHILE @i <= 200
BEGIN
    INSERT INTO Products (
        ProductName, ProductCategory, ProcessNodeNM, PackageType, UnitPriceUSD, LifecycleStatus
    )
    VALUES (
        CONCAT('Chip-', @i),
        CASE (@i % 6)
            WHEN 0 THEN 'MCU'
            WHEN 1 THEN 'ASIC'
            WHEN 2 THEN 'FPGA'
            WHEN 3 THEN 'Power IC'
            WHEN 4 THEN 'Sensor'
            ELSE 'RF'
        END,
        CASE (@i % 6)
            WHEN 0 THEN 5
            WHEN 1 THEN 7
            WHEN 2 THEN 14
            WHEN 3 THEN 28
            WHEN 4 THEN 40
            ELSE 65
        END,
        CASE (@i % 4)
            WHEN 0 THEN 'BGA'
            WHEN 1 THEN 'QFN'
            WHEN 2 THEN 'WLCSP'
            ELSE 'DIP'
        END,
        CAST(ABS(CHECKSUM(NEWID())) % 500 + 5 AS DECIMAL(12,2)),
        'Active'
    );

    SET @i += 1;
END;
