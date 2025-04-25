use AdventureWorks2019;
select * from HumanResources.Employee;
select * from Person.Person;

select a.FirstName,a.MiddleName,a.LastName,b.JobTitle from Person.Person a
join HumanResources.Employee b on a.BusinessEntityID=b.BusinessEntityID
where JobTitle like 'Sales%';
--assignment 6
select * from Sales.Customer;
select * from Person.Person;
SELECT 
    ISNULL(pp.FirstName + ' ' + pp.LastName, s.Name) AS CustomerName,
    a.City,
    soh.SalesOrderID AS OrderNumber,
    soh.OrderDate,
    soh.TotalDue AS OrderAmount
FROM 
    Sales.Customer c
    LEFT JOIN Person.Person pp ON c.PersonID = pp.BusinessEntityID
    LEFT JOIN Sales.Store s ON c.StoreID = s.BusinessEntityID
    LEFT JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
    LEFT JOIN Person.BusinessEntityAddress bea ON c.CustomerID = bea.BusinessEntityID
    LEFT JOIN Person.Address a ON bea.AddressID = a.AddressID
ORDER BY 
    soh.OrderDate ASC;

--assignment 5
SELECT 
    soh.SalesOrderID AS ord_no,
    soh.TotalDue AS purch_amt,
    ISNULL(p.FirstName + ' ' + p.LastName, s.Name) AS cust_name,
    a.City
FROM 
    Sales.SalesOrderHeader soh
    JOIN Sales.Customer c ON soh.CustomerID = c.CustomerID
    LEFT JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
    LEFT JOIN Sales.Store s ON c.StoreID = s.BusinessEntityID
    LEFT JOIN Person.BusinessEntityAddress bea ON c.CustomerID = bea.BusinessEntityID
    LEFT JOIN Person.Address a ON bea.AddressID = a.AddressID
WHERE 
    soh.TotalDue BETWEEN 500 AND 2000;


--Assignment 4
SELECT 
    st.Name AS TerritoryName,
    sp.SalesYTD,
    sp.BusinessEntityID,
    sp.SalesLastYear AS PrevRepSales
FROM 
    Sales.SalesPerson sp
JOIN 
    Sales.SalesTerritory st ON sp.TerritoryID = st.TerritoryID
ORDER BY 
    st.Name ASC;


--assignment 3

SELECT 
    emp.JobTitle,
    per.FirstName + ' ' + per.LastName AS FullName,
    (MAX(pay.Rate) OVER() - pay.Rate) AS PayGap
FROM 
    HumanResources.Employee emp
JOIN 
    HumanResources.EmployeeDepartmentHistory deptHist ON emp.BusinessEntityID = deptHist.BusinessEntityID
JOIN 
    HumanResources.Department dept ON deptHist.DepartmentID = dept.DepartmentID
JOIN 
    HumanResources.EmployeePayHistory pay ON emp.BusinessEntityID = pay.BusinessEntityID
JOIN 
    Person.Person per ON emp.BusinessEntityID = per.BusinessEntityID
WHERE 
    dept.DepartmentID = 12
ORDER BY 
    FullName;


--assignment 2
SELECT 
    sp.BusinessEntityID AS SalespersonID,
    spPerson.FirstName + ' ' + spPerson.LastName AS Salesperson,
    c.CustomerID,
    custPerson.FirstName + ' ' + custPerson.LastName AS CustomerName,
    addr.City,
    c.StoreID,
    soh.SalesOrderNumber,
    soh.OrderDate,
    soh.TotalDue
FROM 
    Sales.SalesPerson sp
LEFT JOIN Sales.SalesOrderHeader soh ON sp.BusinessEntityID = soh.SalesPersonID
LEFT JOIN Sales.Customer c ON soh.CustomerID = c.CustomerID
LEFT JOIN Person.Person custPerson ON c.PersonID = custPerson.BusinessEntityID
LEFT JOIN Person.BusinessEntityAddress custBEA ON c.PersonID = custBEA.BusinessEntityID
LEFT JOIN Person.Address addr ON custBEA.AddressID = addr.AddressID
LEFT JOIN Person.Person spPerson ON sp.BusinessEntityID = spPerson.BusinessEntityID
ORDER BY sp.BusinessEntityID;

--assignment 1
SELECT DISTINCT
    pCust.FirstName + ' ' + pCust.LastName AS CustomerName,
    custAddr.City AS CustomerCity,
    salesPerson.FirstName + ' ' + salesPerson.LastName AS SalesmanName,
    salesAddr.City AS SalesmanCity,
    salesRep.CommissionPct  AS Commission
FROM Sales.SalesOrderHeader salesOrder
JOIN Sales.Customer cust ON salesOrder.CustomerID = cust.CustomerID
JOIN Sales.SalesPerson salesRep ON salesOrder.SalesPersonID = salesRep.BusinessEntityID
JOIN Person.Person salesPerson ON salesRep.BusinessEntityID = salesPerson.BusinessEntityID
JOIN Person.Person pCust ON cust.PersonID = pCust.BusinessEntityID


JOIN Person.BusinessEntityAddress custBEA ON cust.StoreID = custBEA.BusinessEntityID
JOIN Person.Address custAddr ON custBEA.AddressID = custAddr.AddressID


JOIN Person.BusinessEntityAddress salesBEA ON salesRep.BusinessEntityID = salesBEA.BusinessEntityID
JOIN Person.Address salesAddr ON salesBEA.AddressID = salesAddr.AddressID

WHERE custAddr.City <> salesAddr.City
  AND salesRep.CommissionPct > 0.012;

