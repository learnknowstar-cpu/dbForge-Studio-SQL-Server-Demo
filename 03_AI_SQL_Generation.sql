-- =====================================================
-- AI ASSISTANT DEMO
-- Natural Language to SQL
-- =====================================================

-- Business request:
-- Find each customer's most recent order.

WITH RankedOrders AS
(
    SELECT
        c.CustomerID,
        c.CustomerName,
        o.OrderID,
        o.OrderDate,
        o.OrderStatus,
        o.TotalAmount,
        ROW_NUMBER() OVER
        (
            PARTITION BY c.CustomerID
            ORDER BY o.OrderDate DESC, o.OrderID DESC
        ) AS OrderRank
    FROM dbo.Customers AS c
    INNER JOIN dbo.Orders AS o
        ON c.CustomerID = o.CustomerID
)
SELECT
    CustomerID,
    CustomerName,
    OrderID,
    OrderDate,
    OrderStatus,
    TotalAmount
FROM RankedOrders
WHERE OrderRank = 1
ORDER BY CustomerID;
GO
