USE TaqueroMucho;
SET DATEFORMAT dmy;

-- 1) Encontrar el nombre y RFC de todos los empleados qué trabajan en la sucursal "TaqueroMucho Xola"
SELECT B.nombre, B.RFC
FROM Trabajar A Join Empleado B ON A.RFC=B.RFC Join Sucursal C ON A.idSucursal=C.idSucursal
WHERE C.nombre='TaqueroMucho Xola';

-- 2) Encontrar el noNomina de los empleados qué viven en la alcaldía Iztacalco
SELECT noNomina, A.RFC
FROM Empleado1 A Join ControlDePago B ON A.RFC=B.RFC
WHERE alcaldia = 'Iztacalco';

-- 3) Nombre de los Taqueros que fueron contratados despues del 2010 que han recibido Bono
SELECT nombre
FROM Taquero A JOIN Empleado B ON A.RFC=B.RFC JOIN Bono C ON B.RFC=C.RFC
WHERE YEAR(B.fechaContratacion)>=2010;

-- 4) Nombre y tipo de transporte de los Repartidores que trabajan en la sucursal "TaqueroMucho Ajusco"
SELECT B.nombre, transporte
FROM Repartidor A Join Empleado B ON A.RFC=B.RFC JOIN Trabajar C ON B.RFC=C.RFC Join Sucursal D ON C.idSucursal=D.idSucursal
WHERE D.nombre='TaqueroMucho Ajusco';

-- 5) Numero de empleados por sucursal
SELECT A.nombre, count(C.RFC) totalEmpleados
FROM Sucursal A JOIN Trabajar B ON A.idSucursal=B.idSucursal JOIN Empleado C ON B.RFC=C.RFC
GROUP BY A.nombre;

-- 6) Nombres de las sucursales en las que se hicieron compras en el tercer trimestre del año 2018
SELECT DISTINCT(B.nombre)
FROM Comprar A Join Sucursal B On A.idSucursal=B.idSucursal
WHERE YEAR(A.diaCompra)=2018 AND DATEPART(QQ, A.diaCompra)= 3;

-- 7) Sucursal que tiene en su inventario la mayor cantidad de sillas
SELECT C.nombre
FROM Sillas A JOIN Revisar B ON A.idInventario=B.idInventario JOIN Sucursal C ON B.idSucursal=C.idSucursal, (SELECT MAX(cantidad) maxCantidad FROM Sillas) D 
WHERE D.maxCantidad=A.cantidad;

-- 8) Sucursales en las que sus proveedores reciden en la alcaldia "Milpa Alta"
SELECT DISTINCT(A.nombre)
FROM Sucursal A JOIN Proveer B ON A.idSucursal=B.idSucursal JOIN Proveedor2 C ON B.idProveedor=C.idProveedor
WHERE C.alcaldia='Milpa Alta';


-- 9) Proveedores de la sucursal "TaqueroMucho Ajusco"
SELECT DISTINCT(A.nombre)
FROM Proveedor A JOIN Proveer B ON A.idProveedor=B.idProveedor JOIN Sucursal C ON B.idSucursal=C.idSucursal
WHERE C.nombre='TaqueroMucho Ajusco';

-- 10) Nombre de los clientes que compraron productos y salsa
SELECT B.nombre
FROM (SELECT A.idCliente
FROM (SELECT DISTINCT(A.idCliente)
FROM Cliente A JOIN Obtener B ON A.idCliente=B.idCliente) A JOIN (SELECT DISTINCT(A.idCliente)
FROM Cliente A JOIN Consumir B ON A.idCliente=B.idCliente) B ON A.idCliente=B.idCliente) A, Cliente B
WHERE A.idCliente=B.idCliente;

-- 11) Numero de compras qué hicieron los cliente que no decidieron dar sus datos
SELECT COUNT(A.idCliente) AS totalComprasClienteDefault
FROM Comprar A JOIN Cliente B ON A.idCliente=B.idCliente
WHERE B.nombre='Cliente Default';

-- 12) Clientes que compraron tacos de pastor
SELECT DISTINCT(C.nombre)
FROM Taco A JOIN Consumir B ON A.idProducto=B.idProducto JOIN Cliente C ON B.idCliente=C.idCliente
WHERE A.descripcionTaco='Pastor';

-- 13) Nombre de los cLientes que hicieron una compra con tarjeta en el primer trimestre del 2008
SELECT B.nombre
FROM Comprar A JOIN Cliente B On A.idCliente=B.idCliente
WHERE YEAR(A.diaCompra)=2008 AND DATEPART(QQ, A.diaCompra)=1 AND A.tipoPago='Tarjeta';

-- 14) Nombre de los clientes mayores de 40 años que compraron salsa en presentacion de '1 L'
SELECT A.nombre
FROM Cliente A JOIN Obtener B ON A.idCliente=B.idCliente JOIN Salsas C ON B.idSalsa=C.idSalsa
WHERE B.presentacion='1 L' AND A.edad > 40;

-- 15) Informacion de los clientes que pagaron su servicio a domicilio con efectivo
SELECT A.*
FROM Cliente A JOIN ServicioDomicilio B ON A.idCliente=B.idCliente JOIN Producto C ON B.idProducto=C.idProducto
WHERE B.metodoDePago='Efectivo';