use AdventureWorks2019
go


CREATE VIEW Employee.vw_DocumentControl
AS
SELECT p.BusinessEntityID AS ID, p.FirstName AS Nombre,d.[Name] AS Departamento, p.MiddleName AS SegundoNombre, p.LastName AS Apellido, E.BirthDate AS Nacimiento, e.Gender AS Genero
FROM HumanResources.Department d 
RIGHT JOIN HumanResources.Employee e on d.DepartmentID = e.BusinessEntityID
LEFT JOIN HumanResources.EmployeeDepartmentHistory edh ON d.DepartmentID = edh.DepartmentID
INNER JOIN Person.Person p on edh.BusinessEntityID = p.BusinessEntityID
WHERE D.[Name] = 'Document Control'
GROUP BY p.BusinessEntityID,p.FirstName, d.[Name] , p.MiddleName, p.LastName, e.BirthDate, e.Gender

GO

SELECT * FROM Employee.vw_DocumentControl