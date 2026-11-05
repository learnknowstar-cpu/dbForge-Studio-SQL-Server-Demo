-- =====================================================
-- DBFORGE STUDIO - DATA ANALYSIS AND REPORTING
-- Pivot Tables, Charts and Reporting
-- =====================================================


-- 1. PIVOT TABLE
-- Data source: Revenue by customer and order status.

SELECT
    c.CustomerName,
    o.OrderStatus,
    SUM(od.Quantity * od.UnitPrice) AS TotalRevenue
FROM dbo.Customers AS c
INNER JOIN dbo.Orders AS o
    ON c.CustomerID = o.CustomerID
INNER JOIN dbo.OrderDetails AS od
    ON o.OrderID = od.OrderID
GROUP BY
    c.CustomerName,
    o.OrderStatus;
GO


-- 2. CHARTS
-- Monthly revenue analysis.

SELECT
    YEAR(o.OrderDate) AS OrderYear,
    MONTH(o.OrderDate) AS OrderMonth,
    SUM(od.Quantity * od.UnitPrice) AS TotalRevenue
FROM dbo.Orders AS o
INNER JOIN dbo.OrderDetails AS od
    ON o.OrderID = od.OrderID
WHERE o.OrderStatus = 'Completed'
GROUP BY
    YEAR(o.OrderDate),
    MONTH(o.OrderDate)
ORDER BY
    OrderYear,
    OrderMonth;
GO


-- 3. CUSTOMER REVENUE CHART
-- Compare revenue across customers.

SELECT
    c.CustomerName,
    SUM(od.Quantity * od.UnitPrice) AS TotalRevenue
FROM dbo.Customers AS c
INNER JOIN dbo.Orders AS o
    ON c.CustomerID = o.CustomerID
INNER JOIN dbo.OrderDetails AS od
    ON o.OrderID = od.OrderID
WHERE o.OrderStatus = 'Completed'
GROUP BY
    c.CustomerName
ORDER BY
    TotalRevenue DESC;
GO


-- 4. MASTER-DETAIL BROWSER
-- Master: Customers
-- Detail: Orders (CustomerID)
-- Further detail: OrderDetails (OrderID)

SELECT
    CustomerID,
    CustomerName,
    City
FROM dbo.Customers
ORDER BY CustomerID;
GO

SELECT
    OrderID,
    CustomerID,
    OrderDate,
    OrderStatus,
    TotalAmount
FROM dbo.Orders
ORDER BY CustomerID, OrderDate;
GO


-- 5. DATA REPORTING
-- Customer Sales Performance Report.

SELECT
    c.CustomerID,
    c.CustomerName,
    c.City,
    COUNT(DISTINCT o.OrderID) AS TotalOrders,
    SUM(od.Quantity * od.UnitPrice) AS TotalRevenue,
    MAX(o.OrderDate) AS LastOrderDate
FROM dbo.Customers AS c
INNER JOIN dbo.Orders AS o
    ON c.CustomerID = o.CustomerID
INNER JOIN dbo.OrderDetails AS od
    ON o.OrderID = od.OrderID
WHERE o.OrderStatus = 'Completed'
GROUP BY
    c.CustomerID,
    c.CustomerName,
    c.City
ORDER BY
    TotalRevenue DESC;
GO

/*
REPORTING NOTES

Use the Customer Sales Performance query as the report data source.

Suggested report fields:
- CustomerName
- City
- TotalOrders
- TotalRevenue
- LastOrderDate

Suggested report title:
Customer Sales Performance
*/
