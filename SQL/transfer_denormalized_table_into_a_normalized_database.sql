CREATE DATABASE SalesOrderDetails;
GO
USE SalesOrderDetails;
GO

-- Create Tables
CREATE TABLE Territories (
    TerritoryID INT PRIMARY KEY,
    Territory NVARCHAR(50),
    TerritoryGroup NVARCHAR(50)
);

CREATE TABLE ShipMethods (
    ShipMethodID INT PRIMARY KEY,
    ShipMethod NVARCHAR(50)
);

CREATE TABLE ProductCategories (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(50)
);

CREATE TABLE ProductSubCategories (
    SubCategoryID INT IDENTITY(1,1) PRIMARY KEY,
    SubCategoryName NVARCHAR(50),
    CategoryID INT,
    FOREIGN KEY (CategoryID) REFERENCES ProductCategories(CategoryID)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    Product NVARCHAR(100),
    SubCategoryID INT,
    UnitPrice MONEY,
    FOREIGN KEY (SubCategoryID) REFERENCES ProductSubCategories(SubCategoryID)
);



CREATE TABLE OrderStatus (
    StatusID INT PRIMARY KEY,
    Status NVARCHAR(20)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE,
    DueDate DATE,
    ShipDate DATE,
    StatusID INT,
    OnlineOrderFlag BIT,
    CustomerID INT,
    SalesPersonID INT,
    TerritoryID INT,
    ShipMethodID INT,
    FOREIGN KEY (StatusID) REFERENCES OrderStatus(StatusID),
    FOREIGN KEY (TerritoryID) REFERENCES Territories(TerritoryID),
    FOREIGN KEY (ShipMethodID) REFERENCES ShipMethods(ShipMethodID)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    OrderQty INT,
    UnitPrice MONEY,
    LineTotal MONEY,
    TaxAmt MONEY,
    Freight MONEY,
    TotalDue MONEY,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Insert data into the normalized tables
INSERT INTO Territories (TerritoryID, Territory, TerritoryGroup)
SELECT DISTINCT TerritoryID, Territory, TerritoryGroup
FROM salesd.dbo.salesod;

INSERT INTO ShipMethods (ShipMethodID, ShipMethod)
SELECT DISTINCT ShipMethodID, ShipMethod
FROM salesd.dbo.salesod;

INSERT INTO ProductCategories (CategoryName)
SELECT DISTINCT ProductCategory
FROM salesd.dbo.salesod;

INSERT INTO ProductSubCategories (SubCategoryName, CategoryID)
SELECT DISTINCT o.ProductSubCategory, c.CategoryID
FROM salesd.dbo.salesod o
JOIN ProductCategories c ON o.ProductCategory = c.CategoryName;

INSERT INTO Products (ProductID, Product, SubCategoryID, UnitPrice)
SELECT DISTINCT ProductID, Product, SubCategoryID, UnitPrice
FROM (
    SELECT 
        o.ProductID, 
        o.Product, 
        s.SubCategoryID, 
        o.UnitPrice,
        ROW_NUMBER() OVER (PARTITION BY o.ProductID ORDER BY o.OrderDetailID) as rn
    FROM salesd.dbo.Salesod o
    JOIN ProductSubCategories s ON o.ProductSubCategory = s.SubCategoryName
) ranked
WHERE rn = 1;


INSERT INTO OrderStatus (StatusID, Status)
SELECT DISTINCT StatusID, Status
FROM salesd.dbo.salesod;

INSERT INTO Orders (OrderID, OrderDate, DueDate, ShipDate, StatusID, OnlineOrderFlag, CustomerID, SalesPersonID, TerritoryID, ShipMethodID)
SELECT DISTINCT OrderID, OrderDate, DueDate, ShipDate, StatusID, OnlineOrderFlag, CustomerID, SalesPersonID, TerritoryID, ShipMethodID
FROM salesd.dbo.salesod;

INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, OrderQty, UnitPrice, LineTotal, TaxAmt, Freight, TotalDue)
SELECT OrderDetailID, OrderID, ProductID, OrderQty, UnitPrice, LineTotal, TaxAmt, Freight, TotalDue
FROM salesd.dbo.salesod;