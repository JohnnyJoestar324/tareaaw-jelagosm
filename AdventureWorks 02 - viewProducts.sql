USE AdventureWorks2019
GO

CREATE VIEW Production.vw_Product
AS
SELECT p.ProductID as IDProducto, p.[Name] AS Producto, pc.ProductCategoryID AS CategoriaID, pc.[Name] AS Categoria, psc.ProductSubcategoryID AS SubCategoriaID, psc.[Name] AS Subcategoria, pm.ProductModelID AS ModeloID,pm.[Name] AS Modelo
	FROM Production.Product p
	FULL JOIN Production.ProductModel pm on p.ProductID = pm.ProductModelID
	LEFT JOIN Production.ProductCategory pc on p.ProductSubcategoryID =pc.ProductCategoryID
	LEFT JOIN Production.ProductSubcategory psc on p.ProductID = psc.ProductSubcategoryID
	GROUP BY p.ProductID, p.[Name], pc.ProductCategoryID, pc.[Name],  psc.ProductSubcategoryID,  psc.[Name], pm.ProductModelID, pm.[Name]
GO
DROP VIEW Production.vw_Product

select * from Production.vw_Product
GO





select *from Production.Product
select * from Production.ProductCategory
select * from Production.ProductSubcategory
SELECT * FROM Production.ProductModel