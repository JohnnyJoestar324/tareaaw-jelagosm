USE AdventureWorks2019
GO

IF OBJECT_ID (Employee.fc_SalesForYear)IS NOT NULL
DROP FUNCTION Employee.fc_SalesForYear
GO
CREATE FUNCTION Employee.fc_SalesForYear(@Year INT = null)
RETURNS @SalesForYear TABLE(
ProductID int,
Producto varchar(60),
Año datetime,
CantidadVentas SMALLINT,
MontoVentas numeric(38,6)
) 
AS

BEGIN
IF (@Year IS NULL)
SET @Year = YEAR(GETDATE());

INSERT INTO @SalesForYear (ProductID,Producto,Año,CantidadVentas,MontoVentas)

SELECT p.ProductID,p.[Name] AS Producto, SOH.OrderDate AS Año, sod.OrderQty AS CantidadVentas,sod.LineTotal AS MontoVentas
FROM SALES.SalesOrderHeader soh
INNER JOIN SALES.SalesOrderDetail sod on soh.SalesOrderID = sod.SalesOrderID
INNER JOIN Sales.SpecialOfferProduct sop on sod.ProductID = sop.ProductID
RIGHT JOIN Production.Product p on sod.ProductID = p.ProductID
WHERE(@Year IS NULL OR @Year = DATEPART(YYYY,soh.OrderDate))
RETURN;
END
GO



SELECT * FROM Employee.fc_SalesForYear(2014)