DECLARE @i INT = 1;

WHILE @i <= 25
BEGIN
    INSERT INTO SalesReps (RepName, Region, Email, HireDate)
    VALUES (
        CONCAT('Rep ', @i),
        CASE (@i % 4)
            WHEN 0 THEN 'West'
            WHEN 1 THEN 'East'
            WHEN 2 THEN 'EMEA'
            ELSE 'APAC'
        END,
        CONCAT('rep', @i, '@semico.com'),
        DATEADD(DAY, -(@i * 100), GETDATE())
    );

    SET @i += 1;
END;
