USE AdventureWorks2019
GO

CREATE VIEW PRODUCTION.vw_Discontinued
AS
SELECT P.[ProductID] AS ProductoID, P.[Name] AS Producto, p.DiscontinuedDate AS Estado 
FROM Production.Product P  where p.DiscontinuedDate  IS NOT NULL

GROUP BY P.[ProductID], P.[Name], p.DiscontinuedDate

GO



SELECT * FROM PRODUCTION.vw_Discontinued
GO