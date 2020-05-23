USE Northwind;

--simple SELECT con todas las columnas
SELECT *
FROM Productos;

--Mostrar 5 productos;
--simple SELECT con todas las columnas
SELECT TOP(2) *
FROM Productos;

--Contar todos los productos;
SELECT COUNT(*)
FROM Productos;

--simple SELECT seleccionando alguna columnas
SELECT idProducto,nombreProducto,idCategoria,cantidadPorUnidad,precioUnitario,unidadesEnStock,unidadesEnPedido,descontinuado
FROM Productos;

-- Operadores disponibles:
-- >  		mayor que
-- >= 		mayor igual que
-- =  		igual
-- <  		menor que
-- <=       menor igual
-- != o <>  diferente de
-- IN (v)   valor está dentro de valores especificos
-- BETWEEN  entre dos valores

--simple SELECT con datos filtrados
--Obtener productos descontinuados
SELECT idProducto,nombreProducto,idCategoria,cantidadPorUnidad,precioUnitario,unidadesEnStock,unidadesEnPedido,descontinuado
FROM Productos
WHERE descontinuado = 1;

--Obtener productos descontinuados con precio unitario entre 20 y 50
SELECT idProducto,nombreProducto,idCategoria,cantidadPorUnidad,precioUnitario,unidadesEnStock,unidadesEnPedido,descontinuado
FROM Productos
WHERE descontinuado = 1 AND precioUnitario BETWEEN 20 AND 50;

--Obtener nombre completo de Empleados contratados en el año 1992
SELECT CONCAT(nombre, ' ', apellido) nombreCompleto
FROM Empleados
WHERE fechaContratacion BETWEEN '01-01-1992' AND '31-12-1992'

--Obtener Empleados contratados desde 1994 hasta el día de hoy
SELECT nombre + ' ' + apellido nombreCompleto
FROM Empleados
WHERE fechaContratacion BETWEEN '01-02-1994' AND GETDATE()

--Obtener Empleados contratados desde 1994 hasta el año pasado de hoy
SELECT CONCAT(nombre, ' ', apellido) nombreCompleto
FROM Empleados
WHERE fechaContratacion BETWEEN '01-02-1994' AND YEAR(GETDATE())


--Obtener productos que no están descontinuado y su valor unitario es 10, 20 y 30
SELECT idProducto,nombreProducto,idCategoria,cantidadPorUnidad,precioUnitario,unidadesEnStock,unidadesEnPedido,descontinuado
FROM Productos
WHERE descontinuado = 0 AND (precioUnitario = 10 OR precioUnitario = 20 OR precioUnitario = 30);

--Obtener productos que no están descontinuado y su valor unitario es 10, 20 y 30
--Utilizando IN
SELECT idProducto,nombreProducto,idCategoria,cantidadPorUnidad,precioUnitario,unidadesEnStock,unidadesEnPedido,descontinuado
FROM Productos
WHERE descontinuado = 0 AND precioUnitario IN (10,20,30);


--Obtener productos que no están descontinuado y su valor unitario es 10, 20 y 30
--Ordenados por precio unitario
SELECT idProducto,nombreProducto,idCategoria,cantidadPorUnidad,unidadesEnStock,unidadesEnPedido,descontinuado
FROM Productos
WHERE descontinuado = 0 AND precioUnitario IN (10,20,30)
ORDER BY precioUnitario DESC;

--Obtener productos que no están descontinuado y su valor unitario es 10, 20 y 30
--Ordenados por precio unitario
SELECT idProducto,precioUnitario, nombreProducto
FROM Productos
ORDER BY precioUnitario, nombreProducto desc;


---JOINS---
--INNER JOIN--
SELECT *
FROM Productos
INNER JOIN Categorias
ON Productos.idCategoria = Categorias.idCategoria;

SELECT * FROM Productos WHERE idCategoria = 9;

SELECT * FROM Categorias;

INSERT "Categorias"("nombreCategoria","descripcion","imagen") VALUES('Dummy','Dummy Dummy Dummy',null)

SELECT p.*
FROM Pedidos p
JOIN DetallesPedido d
ON p.idPedido = d.idPedido
JOIN Productos pd
ON d.idProducto = pd.idProducto
ORDER BY idCliente
