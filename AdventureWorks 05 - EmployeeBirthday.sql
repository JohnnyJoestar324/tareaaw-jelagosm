USE AdventureWorks2019
GO


IF EXISTS(
SELECT * FROM INFORMATION_SCHEMA.ROUTINES
WHERE  SPECIFIC_SCHEMA(N'Employee')
AND SPECIFIC_NAME(N'pr_Birthday')
)
DROP PROCEDURE Employee.pr_Birthday
GO

CREATE PROCEDURE Employee.pr_Birthday
@DepartamentID SMALLINT =  null

AS

SELECT p.BusinessEntityID AS ID, p.LastName AS Apellido, p.FirstName AS Nombre, d.[Name] AS Departamento,  E.BirthDate AS Cumpleaños
FROM HumanResources.Department d 
LEFT JOIN HumanResources.Employee e on d.DepartmentID = e.BusinessEntityID
RIGHT JOIN HumanResources.EmployeeDepartmentHistory edh ON d.DepartmentID = edh.DepartmentID
INNER JOIN Person.Person p on edh.BusinessEntityID = p.BusinessEntityID
WHERE (@DepartamentID is null or @DepartamentID = d.DepartmentID AND  DATEPART(MM,E.BirthDate)=DATEPART(MONTH,GETDATE()))
ORDER BY P.LastName ASC;

GO

--Ejemplo especificando el departamentoID 
exec Employee.pr_Birthday 1

--Ejemplo de cuando no se especifica el DepartamentoID
exec Employee.pr_Birthday NULL

