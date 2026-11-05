-- =====================================================
-- DBFORGE STUDIO - DATA COMPARE DEMO
-- Compare Production and Staging Order Data
-- =====================================================

-- 1. Create comparison tables

DROP TABLE IF EXISTS dbo.Orders_Staging;
DROP TABLE IF EXISTS dbo.Orders_Production;
GO

CREATE TABLE dbo.Orders_Production
(
    OrderID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATE NOT NULL,
    OrderStatus VARCHAR(20) NOT NULL,
    TotalAmount DECIMAL(12,2) NOT NULL
);

CREATE TABLE dbo.Orders_Staging
(
    OrderID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATE NOT NULL,
    OrderStatus VARCHAR(20) NOT NULL,
    TotalAmount DECIMAL(12,2) NOT NULL
);
GO

-- 2. Insert Production Data

INSERT INTO dbo.Orders_Production
VALUES
(1001, 1, '2026-10-01', 'Completed', 250.00),
(1002, 2, '2026-10-02', 'Completed', 175.50),
(1003, 3, '2026-10-03', 'Pending', 320.00),
(1004, 1, '2026-10-04', 'Completed', 450.00),
(1005, 4, '2026-10-05', 'Processing', 99.99),
(1006, 2, '2026-10-06', 'Completed', 600.00);
GO

-- 3. Insert Staging Data
-- Includes changed, missing and additional records.

INSERT INTO dbo.Orders_Staging
VALUES
(1001, 1, '2026-10-01', 'Completed', 250.00),
(1002, 2, '2026-10-02', 'Completed', 195.50),
(1003, 3, '2026-10-03', 'Completed', 320.00),
(1004, 1, '2026-10-04', 'Completed', 450.00),
(1005, 4, '2026-10-05', 'Processing', 99.99),
(1007, 5, '2026-10-07', 'Pending', 275.00);
GO

-- 4. Verify Production Data

SELECT *
FROM dbo.Orders_Production
ORDER BY OrderID;
GO

-- 5. Verify Staging Data

SELECT *
FROM dbo.Orders_Staging
ORDER BY OrderID;
GO

/*
DATA COMPARE IN DBFORGE

Source: dbo.Orders_Production
Target: dbo.Orders_Staging

Match rows using: OrderID

Expected differences:
- OrderID 1002: TotalAmount differs.
- OrderID 1003: OrderStatus differs.
- OrderID 1006: Exists only in Production.
- OrderID 1007: Exists only in Staging.

Other matching records should be identical.

Use dbForge Data Compare to inspect these differences.
Do not synchronize the tables during this demonstration.
*/
