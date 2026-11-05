-- =====================================================
-- dbForge Studio for SQL Server - Demo Database
-- Sample Sales Database
-- =====================================================

-- Create Customers
CREATE TABLE dbo.Customers
(
    CustomerID INT PRIMARY KEY,
    CustomerName NVARCHAR(100) NOT NULL,
    City NVARCHAR(50)
);
GO

-- Create Products
CREATE TABLE dbo.Products
(
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(100) NOT NULL,
    Category NVARCHAR(50),
    UnitPrice DECIMAL(10,2) NOT NULL
);
GO

-- Create Orders
CREATE TABLE dbo.Orders
(
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATE NOT NULL,
    OrderStatus VARCHAR(20) NOT NULL,
    TotalAmount DECIMAL(12,2) NOT NULL,

    CONSTRAINT FK_Orders_Customers
        FOREIGN KEY (CustomerID)
        REFERENCES dbo.Customers(CustomerID)
);
GO

-- Create Order Details
CREATE TABLE dbo.OrderDetails
(
    OrderDetailID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,

    CONSTRAINT FK_OrderDetails_Orders
        FOREIGN KEY (OrderID)
        REFERENCES dbo.Orders(OrderID),

    CONSTRAINT FK_OrderDetails_Products
        FOREIGN KEY (ProductID)
        REFERENCES dbo.Products(ProductID)
);
GO

-- Create Source Sales
CREATE TABLE dbo.SourceSales
(
    SourceRowID INT IDENTITY(1,1) PRIMARY KEY,
    LoadBatchID INT NOT NULL,
    CustomerID INT NOT NULL,
    ProductID INT NOT NULL,
    RegionID INT NOT NULL,
    SalesDate DATE NOT NULL,
    SourceSystem VARCHAR(20) NOT NULL,
    SourceTxnID VARCHAR(30) NOT NULL,
    SalesAmount DECIMAL(12,2) NOT NULL,

    CONSTRAINT UX_SourceSales_Transaction UNIQUE
    (
        CustomerID, ProductID, RegionID,
        SalesDate, SourceSystem, SourceTxnID
    )
);
GO

-- Create Sales Fact
CREATE TABLE dbo.SalesFact
(
    SalesFactID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    ProductID INT NOT NULL,
    RegionID INT NOT NULL,
    SalesDate DATE NOT NULL,
    SalesAmount DECIMAL(12,2) NOT NULL
);
GO

CREATE UNIQUE INDEX UX_SalesFact_BusinessKey
ON dbo.SalesFact
(
    CustomerID, ProductID, RegionID, SalesDate
);
GO

-- Insert Customers
INSERT INTO dbo.Customers
(CustomerID, CustomerName, City)
VALUES
(1, 'Ava Patel', 'Toronto'),
(2, 'Liam Chen', 'Vancouver'),
(3, 'Noah Williams', 'Calgary'),
(4, 'Olivia Martin', 'Ottawa');
GO

-- Insert Products
INSERT INTO dbo.Products
(ProductID, ProductName, Category, UnitPrice)
VALUES
(101, 'Laptop', 'Electronics', 750.00),
(102, 'Monitor', 'Electronics', 250.00),
(103, 'Office Chair', 'Furniture', 180.00),
(104, 'Desk', 'Furniture', 350.00),
(105, 'Keyboard', 'Accessories', 99.99);
GO

-- Insert Orders
INSERT INTO dbo.Orders
(CustomerID, OrderDate, OrderStatus, TotalAmount)
VALUES
(1, '2026-10-01', 'Completed', 250.00),
(2, '2026-10-03', 'Completed', 175.50),
(3, '2026-10-05', 'Pending', 320.00),
(1, '2026-10-10', 'Completed', 450.00),
(4, '2026-10-12', 'Processing', 99.99);
GO

-- Insert Order Details
INSERT INTO dbo.OrderDetails
(OrderID, ProductID, Quantity, UnitPrice)
VALUES
(1, 101, 2, 75.00),
(1, 102, 1, 100.00),
(2, 103, 3, 58.50),
(3, 101, 4, 80.00),
(3, 104, 2, 100.00),
(4, 102, 3, 150.00),
(5, 105, 1, 99.99);
GO

-- Insert Source Sales
INSERT INTO dbo.SourceSales
(
    LoadBatchID, CustomerID, ProductID, RegionID,
    SalesDate, SourceSystem, SourceTxnID, SalesAmount
)
VALUES
(42, 101, 500, 1, '2026-10-01', 'ERP', 'ERP-9001', 125.00),
(42, 101, 500, 1, '2026-10-01', 'CRM', 'CRM-7742', 125.00);
GO

-- Verify the database setup
SELECT * FROM dbo.Customers;
SELECT * FROM dbo.Products;
SELECT * FROM dbo.Orders;
SELECT * FROM dbo.OrderDetails;
GO
