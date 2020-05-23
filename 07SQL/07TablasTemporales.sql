use banco
go

/*
****** Tablas Temporales en SQL Server ***********
Existen de tres tipos:
1. Tablas temporales LOCALES
2. Tablas temporales GLOBALES
3. Variables de TABLA
4. CTEs (Common Table Expresions)
*/

/****** TABLAS TEMPORALES LOCALES *******/
--Las tablas temporales LOCALES se definen anteponiendo el s�mbolo # al nombre de la tabla.
--Se crean de la misma forma que una tabla com�n --> CREATE TABLE

create table #prestatarios(
numpres char(7) primary key,
cliente varchar(100),
importe money,
fecha date,
sucursal varchar(100)
);

--Estas tablas son creadas en la base de datos TEMPDB, en la carpeta llamada TEMPORARY TABLES:

--Insertando datos en la tabla temporal:
--Puede ser registro a registro
insert into #prestatarios values('P-99999','Patricia S�nchez',50000,getdate(),'Altavista');

--Podemos insertar valores en la tabla temporal por medio de
--una consulta:
insert into #prestatarios
select b.numprestamo,nombrecliente,importe,fecha,nombresucursal
from cliente a inner join prestatario b on
     a.idcliente = b.idcliente 
	 inner join prestamo c on c.numprestamo = b.numprestamo
	 inner join sucursal d on d.numsucursal = c.numsucursal
where d.estado = 'CHIAPAS';

--Seleccionando los valores de la tabla temporal
select * from #prestatarios;

/*
Las tablas temporales LOCALES est�n disponibles para usarse por cada conexi�n actual del usuario 
que las crea.
Varias conexiones pueden crear una tabla temporal LOCAL con mismo nombre sin causar conflictos.
La representaci�n interna de la tabla LOCAL tiene un nombre �nico para no estar en conflicto 
con otras tablas temporales con el mismo nombre, creadas por otras conexiones en la tempdb.
*/

/*
Las tablas temporales locales son eliminadas con el comando DROP o se eliminan autom�ticamente de
memoria cuando se cierra la conexi�n del usuario actual.
*/

-- Eliminando la tabla temporal
drop table #prestatarios;

/****** TABLAS TEMPORALES GLOBALES *******/

--Las tablas temporales GLOBALES se definen anteponiendo el doble s�mbolo ## al nombre de la tabla

--Una vez que una conexi�n crea una tabla temporal GLOBAL, cualquier usuario con permisos adecuados 
--sobre la base de datos puede acceder a la tabla. 
--No se pueden crear versiones simult�neas de una tabla temporal GLOBAL --> conflicto de nombres.
*/

create table ##prestatarios(
numpres char(7) primary key,
cliente varchar(100),
importe money,
fecha date,
sucursal varchar(100)
);

--Estas tablas son creadas en la base de datos TEMPDB, en la carpeta llamada TEMPORARY TABLES.

--Insertando datos en la tabla temporal GLOBAL:
--Puede ser registro a registro
insert into ##prestatarios values('P-99999','Patricia S�nchez',50000,getdate(),'Altavista');

--Podemos insertar valores en la tabla temporal por medio de una consulta:
insert into ##prestatarios
select b.numprestamo,nombrecliente,importe,fecha,nombresucursal
from cliente a inner join prestatario b on
     a.idcliente = b.idcliente 
	 inner join prestamo c on c.numprestamo = b.numprestamo
	 inner join sucursal d on d.numsucursal = c.numsucursal
where d.estado = 'CHIAPAS';

--Seleccionando los valores de la tabla temporal
select * from ##prestatarios;

/*
Las tablas temporales GLOBALES de eliminan expl�citamente de SQL Server ejecutando DROP TABLE.
Tambi�n se eliminan autom�ticamente despu�s de que se cierra la conexi�n que la creo, la tabla 
temporal GLOBAL no es referenciada por otras conexiones, pero es muy raro ver que se utilicen 
tablas temporales GLOBALES en bases de datos en producci�n.
*/
drop table ##prestatarios;

/*
MORALEJA:
Es importante considerar cuando una tabla va o debe ser compartida a trav�s de conexiones, se 
debe crear una tabla real, en lugar de una tabla temporal GLOBAL. No obstante, SQL Server 
ofrece esto como una opci�n.
*/