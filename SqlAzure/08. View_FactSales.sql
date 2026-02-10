CREATE VIEW vw_SalesFact AS
SELECT
    so.OrderID,
    so.OrderDate,
    c.CustomerName,
    c.CustomerType,
    p.ProductName,
    p.ProductCategory,
    p.ProcessNodeNM,
    oi.Quantity,
    oi.UnitPriceUSD,
    oi.LineTotalUSD,
    sr.RepName,
    sr.Region
FROM SalesOrders so
JOIN OrderItems oi ON so.OrderID = oi.OrderID
JOIN Products p ON oi.ProductID = p.ProductID
JOIN Customers c ON so.CustomerID = c.CustomerID
LEFT JOIN SalesReps sr ON so.SalesRepID = sr.SalesRepID;

