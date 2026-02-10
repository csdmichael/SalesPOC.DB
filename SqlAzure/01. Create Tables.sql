CREATE TABLE Customers (
    CustomerID        INT IDENTITY(1,1) PRIMARY KEY,
    CustomerName      NVARCHAR(200) NOT NULL,
    CustomerType      NVARCHAR(50) CHECK (CustomerType IN ('OEM','Distributor','Foundry','Fabless','Research')),
    Industry          NVARCHAR(100),
    Country           NVARCHAR(100),
    State             NVARCHAR(100),
    City              NVARCHAR(100),
    AnnualRevenueUSD  DECIMAL(18,2),
    CreatedDate       DATETIME2 DEFAULT SYSDATETIME()
);

CREATE INDEX IX_Customers_Country ON Customers(Country);


CREATE TABLE Products (
    ProductID         INT IDENTITY(1,1) PRIMARY KEY,
    ProductName       NVARCHAR(200) NOT NULL,
    ProductCategory   NVARCHAR(100), -- e.g. MCU, ASIC, FPGA, Sensor, Power IC
    ProcessNodeNM     INT,            -- e.g. 5, 7, 14, 28
    PackageType       NVARCHAR(50),    -- BGA, QFN, WLCSP, etc.
    UnitPriceUSD      DECIMAL(12,2) NOT NULL,
    LifecycleStatus   NVARCHAR(50) CHECK (LifecycleStatus IN ('Active','NRND','EOL')),
    CreatedDate       DATETIME2 DEFAULT SYSDATETIME()
);

CREATE INDEX IX_Products_Category ON Products(ProductCategory);


CREATE TABLE SalesReps (
    SalesRepID     INT IDENTITY(1,1) PRIMARY KEY,
    RepName        NVARCHAR(150) NOT NULL,
    Region         NVARCHAR(100),
    Email          NVARCHAR(150),
    HireDate       DATE
);


CREATE TABLE SalesOrders (
    OrderID        INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID     INT NOT NULL,
    SalesRepID     INT,
    OrderDate      DATE NOT NULL,
    OrderStatus    NVARCHAR(50) CHECK (OrderStatus IN ('Pending','Confirmed','Shipped','Cancelled')),
    TotalAmountUSD DECIMAL(18,2),
    Currency       CHAR(3) DEFAULT 'USD',

    CONSTRAINT FK_SalesOrders_Customers
        FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),

    CONSTRAINT FK_SalesOrders_SalesReps
        FOREIGN KEY (SalesRepID) REFERENCES SalesReps(SalesRepID)
);

CREATE INDEX IX_SalesOrders_OrderDate ON SalesOrders(OrderDate);


CREATE TABLE OrderItems (
    OrderItemID     INT IDENTITY(1,1) PRIMARY KEY,
    OrderID         INT NOT NULL,
    ProductID       INT NOT NULL,
    Quantity        INT NOT NULL,
    UnitPriceUSD    DECIMAL(12,2) NOT NULL,
    LineTotalUSD    AS (Quantity * UnitPriceUSD) PERSISTED,

    CONSTRAINT FK_OrderItems_Orders
        FOREIGN KEY (OrderID) REFERENCES SalesOrders(OrderID),

    CONSTRAINT FK_OrderItems_Products
        FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE INDEX IX_OrderItems_ProductID ON OrderItems(ProductID);


