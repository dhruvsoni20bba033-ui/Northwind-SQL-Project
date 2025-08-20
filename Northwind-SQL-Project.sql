create database northwind character set 
utf8mb4 COLLATE utf8mb4_unicode_ci;
USE northwind;
show databases
use northwind;
show tables;


Select * from customers;
Select * from orderdetails;
Select * from orders;
Select * from shippers;
Select * from suppliers;
Select * from products;
Select * from categories;
Select * from employees;


-- 1. Top 10 Customers by Revenue
SELECT 
    c.CompanyName,
    SUM(od.Quantity * od.UnitPrice) AS TotalRevenue
FROM
    customers AS c
        JOIN
    orders AS o ON c.CustomerId = o.CustomerId
        JOIN
    orderdetails AS od ON o.OrderId = od.OrderID
GROUP BY c.CompanyName
ORDER BY TotalRevenue DESC
LIMIT 10;


-- 2. Sales by Region
SELECT 
    c.Region, SUM(od.UnitPrice * od.Quantity) AS TotalSales
FROM
    OrderDetails AS od
        JOIN
    Orders AS o ON od.OrderID = o.OrderID
        JOIN
    Customers AS c ON o.CustomerID = c.CustomerID
GROUP BY c.Region
ORDER BY TotalSales DESC;


-- 3. Top Products by Revenue
SELECT 
    p.ProductName, SUM(od.UnitPrice * od.Quantity) AS TotalSales
FROM
    products AS p
        JOIN
    Orderdetails AS od ON od.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY TotalSales;


-- 4. Top Categories by Sales
SELECT 
    ca.CategoryName,
    SUM(od.UnitPrice * od.Quantity) AS TotalRevenue
FROM
    categories AS ca
        JOIN
    products AS p ON p.CategoryID = ca.CategoryID
        JOIN
    Orderdetails AS od ON od.ProductID = p.ProductID
GROUP BY ca.CategoryName
ORDER BY TotalRevenue;


-- 5. Monthly Sales Trend
SELECT 
    DATE_FORMAT(o.OrderDate, '%M %Y') AS Month,
    SUM(od.UnitPrice * od.Quantity) AS MonthlySales
FROM
    orders AS o
        JOIN
    orderdetails AS od ON od.OrderID = o.OrderID
GROUP BY Month
ORDER BY MIN(o.OrderDate);


-- 6. Employee Sales Performance
SELECT 
    CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName,
    SUM(od.UnitPrice * od.Quantity) AS TotalRevenue
FROM
    employees AS e
        JOIN
    orders AS o ON o.EmployeeID = e.EmployeeID
        JOIN
    orderdetails AS od ON od.OrderID = o.OrderID
GROUP BY EmployeeName
ORDER BY TotalRevenue;


-- 7. Top Suppliers by Sales
SELECT 
    s.CompanyName AS Suppliers,
    SUM(od.UnitPrice * od.Quantity) AS TotalSales
FROM
    suppliers AS s
        JOIN
    products AS p ON p.SupplierID = s.SupplierID
        JOIN
    orderdetails AS od ON od.ProductID = p.ProductID
GROUP BY Suppliers
ORDER BY TotalSales DESC;


-- 8. Customer Order Frequency
SELECT 
    c.CompanyName AS CompanyName,
    COUNT(o.OrderID) AS TotalOrders
FROM
    customers AS c
        JOIN
    orders AS o ON o.CustomerID = c.CustomerID
GROUP BY CompanyName
ORDER BY TotalOrders DESC;


-- 9. Average Order Value (AOV)
SELECT 
    o.OrderID, SUM(od.UnitPrice * od.Quantity) AS OrderValue
FROM
    Orders AS o
        JOIN
    OrderDetails AS od ON o.OrderID = od.OrderID
GROUP BY o.OrderID
ORDER BY OrderValue DESC;


-- 10. Shippers Performance (Orders Handled)
SELECT 
    s.CompanyName AS ShipperName,
    COUNT(o.OrderID) AS OrdersHandled
FROM
    Shippers AS s
        JOIN
    Orders AS o ON s.ShipperID = o.ShipperID
GROUP BY s.CompanyName
ORDER BY OrdersHandled DESC;