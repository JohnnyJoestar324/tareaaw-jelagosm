USE AdventureWorks2019
GO

CREATE SCHEMA Employee
GO

IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'Employee'
     AND SPECIFIC_NAME = N'vw_Employee' 
)
   DROP PROCEDURE Employee.vw_Employee
GO
CREATE PROCEDURE Employee.vw_Employee
AS
SELECT p.BusinessEntityID AS ID, p.FirstName AS Nombre,d.[Name] AS Departamento, p.MiddleName AS SegundoNombre, p.LastName AS Apellido, E.BirthDate AS Nacimiento, e.Gender AS Genero
FROM HumanResources.Department d 
RIGHT JOIN HumanResources.Employee e on d.DepartmentID = e.BusinessEntityID
LEFT JOIN HumanResources.EmployeeDepartmentHistory edh ON d.DepartmentID = edh.DepartmentID
INNER JOIN Person.Person p on edh.BusinessEntityID = p.BusinessEntityID
GROUP BY p.BusinessEntityID,p.FirstName, d.[Name] , p.MiddleName, p.LastName, e.BirthDate, e.Gender

GO

Exec Employee.vw_Employee 