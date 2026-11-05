-- =====================================================
-- DBFORGE STUDIO - DEBUGGING AND DATA GENERATOR
-- =====================================================


-- 1. T-SQL DEBUGGER
-- Intentional divide-by-zero error for debugging.

CREATE OR ALTER PROCEDURE dbo.usp_CalculateAverageOrderValue
    @CustomerID INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @TotalRevenue DECIMAL(12,2);
    DECLARE @TotalOrders INT;
    DECLARE @AverageOrderValue DECIMAL(12,2);

    SELECT
        @TotalRevenue = SUM(TotalAmount),
        @TotalOrders = COUNT(*)
    FROM dbo.Orders
    WHERE CustomerID = @CustomerID
      AND OrderStatus = 'Completed';

    -- Intentional error for debugging
    SET @AverageOrderValue = @TotalRevenue / 0;

    SELECT
        @CustomerID AS CustomerID,
        @TotalRevenue AS TotalRevenue,
        @TotalOrders AS TotalOrders,
        @AverageOrderValue AS AverageOrderValue;
END;
GO

-- Execute using dbForge T-SQL Debugger
EXEC dbo.usp_CalculateAverageOrderValue
    @CustomerID = 1;
GO


-- 2. DATA GENERATOR
-- Create an empty table for generating sample data.

IF OBJECT_ID(N'dbo.GeneratedOrders', N'U') IS NOT NULL
    DROP TABLE dbo.GeneratedOrders;
GO

CREATE TABLE dbo.GeneratedOrders
(
    GeneratedOrderID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerName NVARCHAR(100) NOT NULL,
    ProductName NVARCHAR(100) NOT NULL,
    OrderDate DATE NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    Region NVARCHAR(30) NOT NULL,
    OrderStatus VARCHAR(20) NOT NULL
);
GO

-- After generating records through dbForge Data Generator,
-- use this query to inspect the generated data.

SELECT TOP (50)
    GeneratedOrderID,
    CustomerName,
    ProductName,
    OrderDate,
    Quantity,
    UnitPrice,
    Region,
    OrderStatus,
    Quantity * UnitPrice AS OrderValue
FROM dbo.GeneratedOrders
ORDER BY GeneratedOrderID;
GO

-- Analyze the generated data.

SELECT
    Region,
    OrderStatus,
    COUNT(*) AS TotalOrders,
    SUM(Quantity * UnitPrice) AS TotalRevenue
FROM dbo.GeneratedOrders
GROUP BY
    Region,
    OrderStatus
ORDER BY
    Region,
    TotalRevenue DESC;
GO
