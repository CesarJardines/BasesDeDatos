use banco
go

/******* VISTAS EN SQL SERVER *******/
--Definición:
/*
Se pueden definir como tablas virtuales basadas en una o más tablas o vistas y cuyos contenidos
vienen definidos por una consulta sobre las mismas. 

Esta tabla virtual o consulta se le asigna un nombre y se almacena permanentemente en la BD, 
generando al igual que en las tablas una entrada en el diccionario de datos.

Las vistas permiten que diferentes usuarios vean la BD desde diferentes perspectivas, así como 
restringir el acceso a los datos de modo que diferentes usuarios accedan sólo a ciertas filas o 
columnas de una tabla.

Desde el punto de vista del usuario, la vista es como una tabla real con filas y columnas, pero
a diferencia de esta, sus datos no se almacenan físicamente en la BD. 

Las filas y columnas de datos visibles a través de la vista son los resultados producidos por la 
consulta que define la vista.

Las principales razones por las que podemos crear vistas son:

1) Seguridad, nos pueden interesar que los usuarios tengan acceso a una parte de la
   información que hay en una tabla, pero no a toda la tabla.

2) Comodidad, como hemos dicho el modelo relacional no es el más cómodo para visualizar
   los datos, lo que nos puede llevar a tener que escribir complejas sentencias SQL, tener una
   vista nos simplifica esta tarea
*/

/**** CREACIÓN DE VISTAS EN SQL SERVER ****/

--La cláusula CREATE VIEW permite la creación de vistas. La cláusula asigna un nombre a la vista
--y permite especificar la consulta que la define. Su sintaxis es:

create view prestatarios as
select b.numprestamo,nombrecliente,importe,fecha,nombresucursal
from cliente a inner join prestatario b on
     a.idcliente = b.idcliente 
	 inner join prestamo c on c.numprestamo = b.numprestamo
	 inner join sucursal d on d.numsucursal = c.numsucursal;

/*
Opcionalmente se puede asignar un nombre a cada columna de la vista. Si se especifica, la
lista de nombres de las columnas debe de tener el mismo número de elementos que el número de 
columnas producidas por la consulta. Si se omiten, cada columna de la vista adopta el nombre de 
la columna correspondiente en la consulta. 

Existen dos casos en los que es obligatoria la especificación de la lista de columnas:
1 – Cuando la consulta incluye columnas calculadas
2 – Cuando la consulta produce nombres idénticos.
*/

/**** BORRAR UNA VISTA EN SQL SERVER ****/

drop view prestatarios;

create view prestatarios(numpres,cliente,importe,fecha,sucursal) as
select b.numprestamo,nombrecliente,importe,fecha,nombresucursal
from cliente a inner join prestatario b on
     a.idcliente = b.idcliente 
	 inner join prestamo c on c.numprestamo = b.numprestamo
	 inner join sucursal d on d.numsucursal = c.numsucursal;

/**** ACCESO A VISTAS EN SQL SERVER ****/

--El usuario accede a los datos de una vista exactamente igual que si estuviera accediendo a 
--una tabla. De hecho, en general, el usuario no sabrá que está consultando una vista.

select * from prestatarios;

/**** ACTUALIZACIÓN A TRAVÉS DE VISTAS EN SQL SERVER ****/

/*
Para que una vista se pueda actualizar debe existir una relación directa entre las filas
y columnas de la vista y las de la tabla fuente. 

Según el estándar ANSI, se puede actualizar a través de las vistas si la consulta que la define,
satisface las siguientes restricciones:

1) No especifica DISTINCT
2) FROM debe especificar una única tabla
3) La lista de selección no puede contener expresiones, columnas calculadas o funciones de 
   columna, solo referencias a columnas simples.
4) WHERE no debe incluir subconsultas.
5) No debe incluir ni GROUP BY ni HAVING.
*/

/**** MODIFICAR LA ESTRUCTURA DE UNA VISTA EN SQL SERVER ****/
alter view prestatarios as
select b.numprestamo,nombrecliente,importe,fecha,nombresucursal
from cliente a inner join prestatario b on
     a.idcliente = b.idcliente 
	 inner join prestamo c on c.numprestamo = b.numprestamo
	 inner join sucursal d on d.numsucursal = c.numsucursal
where d.estado = 'chiapas';


--Actualizar una vista
sp_refreshview prestatarios;