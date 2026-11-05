-- =====================================================
-- DBFORGE STUDIO - EVERYDAY SQL DEVELOPMENT DEMOS
-- =====================================================

-- 1. JOIN AUTOCOMPLETE
-- Pause after ON to demonstrate suggested join columns.

SELECT *
FROM dbo.Customers AS c
INNER JOIN dbo.Orders AS o
    ON c.CustomerID = o.CustomerID;
GO


-- 2. SELECT * COLUMN EXPANSION

SELECT *
FROM dbo.Orders;
GO


-- 3. CTE AND ALIAS INTELLISENSE

WITH CustomerOrders AS
(
    SELECT
        CustomerID,
        OrderID,
        OrderDate,
        TotalAmount,
        ROW_NUMBER() OVER
        (
            PARTITION BY CustomerID
            ORDER BY OrderDate DESC
        ) AS OrderRank
    FROM dbo.Orders
)
SELECT
    o.CustomerID,
    o.OrderID,
    o.OrderDate,
    o.TotalAmount,
    o.OrderRank
FROM CustomerOrders AS o
WHERE o.OrderRank = 1;
GO


-- 4. INLINE TABLE METADATA

SELECT
    od.OrderDetailID,
    od.OrderID,
    od.ProductID,
    od.Quantity,
    od.UnitPrice
FROM dbo.OrderDetails AS od;
GO


-- 5. VISUAL QUERY BUILDER

SELECT
    c.CustomerName,
    o.OrderID,
    o.OrderDate,
    od.Quantity,
    od.UnitPrice
FROM dbo.Customers AS c
INNER JOIN dbo.Orders AS o
    ON c.CustomerID = o.CustomerID
INNER JOIN dbo.OrderDetails AS od
    ON o.OrderID = od.OrderID
WHERE o.OrderStatus = 'Completed'
ORDER BY o.OrderDate DESC;
GO


-- 6. SQL FORMATTING
-- Deliberately compact query for the formatting demonstration.

select c.CustomerID,c.CustomerName,o.OrderID,o.OrderDate,od.Quantity,od.UnitPrice,od.Quantity*od.UnitPrice as LineTotal from dbo.Customers c inner join dbo.Orders o on c.CustomerID=o.CustomerID inner join dbo.OrderDetails od on o.OrderID=od.OrderID where o.OrderStatus='Completed' and od.Quantity>1 order by o.OrderDate desc;
GO


-- 7. T-SQL CODE ANALYZER

SELECT
    c.CustomerID,
    c.CustomerName,
    YEAR(o.OrderDate) AS OrderYear,
    COUNT(DISTINCT o.OrderID) AS TotalOrders,
    SUM(od.Quantity * od.UnitPrice) AS TotalRevenue,
    AVG(od.UnitPrice) AS AverageUnitPrice,
    ROW_NUMBER() OVER
    (
        PARTITION BY c.CustomerID
        ORDER BY SUM(od.Quantity * od.UnitPrice) DESC
    ) AS RevenueRank
FROM dbo.Customers AS c
INNER JOIN dbo.Orders AS o
    ON c.CustomerID = o.CustomerID
INNER JOIN dbo.OrderDetails AS od
    ON o.OrderID = od.OrderID
WHERE YEAR(o.OrderDate) = 2026
    AND o.OrderStatus IN ('Completed', 'Processing')
    AND od.Quantity > 0
GROUP BY
    c.CustomerID,
    c.CustomerName,
    YEAR(o.OrderDate)
HAVING SUM(od.Quantity * od.UnitPrice) > 100
ORDER BY TotalRevenue DESC;
GO


-- 8. QUERY HISTORY
-- Execute these individually to populate Query History.

SELECT * FROM dbo.Customers;
GO

SELECT *
FROM dbo.Orders
WHERE OrderStatus = 'Completed';
GO

SELECT
    CustomerID,
    COUNT(*) AS TotalOrders,
    SUM(TotalAmount) AS TotalRevenue
FROM dbo.Orders
GROUP BY CustomerID
ORDER BY TotalRevenue DESC;
GO
