USE AdventureWorks2019
GO

IF EXISTS(
SELECT * FROM INFORMATION_SCHEMA.ROUTINES
WHERE  SPECIFIC_SCHEMA(N'Employee')
AND SPECIFIC_NAME(N'pr_NumberOfEmployees')
)
DROP PROCEDURE Employee.pr_NumberOfEmployees
GO

CREATE PROCEDURE Employee.pr_NumberOfEmployees
@DepartamentID SMALLINT = null
AS
SELECT d.DepartmentID , d.[Name] AS Departamento, p.FirstName AS Nombre,  p.LastName AS Apellido
FROM HumanResources.Department d 
LEFT JOIN HumanResources.Employee e on d.DepartmentID = e.BusinessEntityID
RIGHT JOIN HumanResources.EmployeeDepartmentHistory edh ON d.DepartmentID = edh.DepartmentID
INNER JOIN Person.Person p on edh.BusinessEntityID = p.BusinessEntityID
WHERE (@DepartamentID is null or @DepartamentID = d.DepartmentID)
GROUP BY D.DepartmentID, D.[Name], P.FirstName, P.LastName
GO

exec Employee.pr_NumberOfEmployees 6