UPDATE so
SET TotalAmountUSD = totals.Total
FROM SalesOrders so
JOIN (
    SELECT OrderID, SUM(LineTotalUSD) AS Total
    FROM OrderItems
    GROUP BY OrderID
) totals
ON so.OrderID = totals.OrderID;
