-- =====================================================
-- AI ASSISTANT DEMO
-- Duplicate Key Error: Source vs Target Grain
-- =====================================================

-- Inspect source records
SELECT *
FROM dbo.SourceSales
WHERE LoadBatchID = 42;
GO

-- Inspect the target table
SELECT *
FROM dbo.SalesFact;
GO

-- Create the stored procedure
CREATE OR ALTER PROCEDURE dbo.usp_LoadDailySales
    @LoadBatchID INT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.SalesFact
    (
        CustomerID,
        ProductID,
        RegionID,
        SalesDate,
        SalesAmount
    )
    SELECT
        CustomerID,
        ProductID,
        RegionID,
        SalesDate,
        SalesAmount
    FROM dbo.SourceSales
    WHERE LoadBatchID = @LoadBatchID;
END;
GO

-- Execute to reproduce duplicate key error 2601
EXEC dbo.usp_LoadDailySales @LoadBatchID = 42;
GO

-- Inspect source records grouped by target business key
SELECT
    CustomerID,
    ProductID,
    RegionID,
    SalesDate,
    COUNT(*) AS SourceRowCount
FROM dbo.SourceSales
WHERE LoadBatchID = 42
GROUP BY
    CustomerID,
    ProductID,
    RegionID,
    SalesDate
HAVING COUNT(*) > 1;
GO
