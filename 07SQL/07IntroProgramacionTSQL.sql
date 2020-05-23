--Programando don Transact-SQL
--Consulta (query): una única sentencia de DML-SQL
--BATCH:colección de una o más sentencias de T-SQL que es parseada por SQL Server como una unidad

--Terminado un BATCH;
/*
Un script de SQL puede contener múltiples sentencias, si este es el caso, se requiere de una
palabra reservada para indicar que el batch termina. Por omisión, la palabra destinada para esta
tarea es GO (esta palabra debe ser la única en la línea y se puede añadir un comentario después)

GO únicamente funciona en SQL Server Management Studio y SQLCMD y es posible modificarlo
(Herramientas --> Opciones), pero no se recomienda.

Como es una palabra que se utiliza para decirle al Management Studio que envíe un BATCH al
servidor al cual nos encontramos conectados, se puede utilizar para enviar un BATCH 
múltiples veces
*/

print 'Yo soy un BATCH';
go 5 --Esto se ejecutará 5 veces

--Una vez que se termina un BATCH, se eliminan todas las variables locales, tablas temporales
--y cursores.

--Intercambiando las bases de datos
/*
De manera interactiva, la BD actual, se indica en la barra de herramientas del editor de 
consultas y se puede cambiar desde ahi.

Dentro de un código, esto puede hacerse a través de la sentencia USE y es posible utilizarla
desde un BATCH, por ejemplo, para indicar a qué BD se insertarán los datos
*/

use banquito; --Cambiar este valor por el de BD de TVPaga

create table prueba(
id int,
nombre varchar(100),
nacimiento date,
sueldo money
);

insert into prueba default values;
go 5

select * from prueba;

--Trabajando con variables
/*
Todos los lenguajes requieren poder trabajar con variables que almacenen de manera temporal un
valor en memoria.

Las variables en T-SQL  se crean con el comando DECLARE (dicleer) y toda variable requiere de 
un nombre y un tipo de dato. Los tipos de datos disponibles son los mismos que se tienen en la 
sentencia CREATE TABLE, además de los tipos TABLE y CURSOR (cúsror). Se permite la creación de
múltiples variables (separadas por comas) en una única sentencia DECLARE.

El alcance (ámbitom, aplicación, duración) de la variable, se extiende solo al BATCH actual.

Por omisión, recién se crea una variable, se le asigna el valor NULL y por ende, debe ser 
inicializada.
*/
declare @saldoprom money,
        @maxsaldo money;

select @saldoprom,@maxsaldo;

--Ámbito de las variables
declare @saldoprom money,
        @maxsaldo money;
go --Se termina el batch y se destruyen las variables

select @saldoprom,@maxsaldo;

--Asignar valor a una variable: DECLARE, SET y SELECT
/*
Ambos permiten asignar un valor a una variable, la diferencia es que con la sentencia SELECT 
se puede recuperar datos de una fuente de datos, mientras que SET está limitada a recupera 
valores de expresiones. Ambas pueden incluir funciones. Además, set solo puede establecer el 
valor de una única variable, mientras que SELECT puede asignar el valor a múltiples.
*/

--Desde el momento en que se está declarando la variable
declare @saldoprom money = 1000;
print @saldoprom;

--Utilizando la sentencia SET
declare @saldoprom money;
set @saldoprom = 1000;
select @saldoprom;

--Utilizando la sentencia SELECT
declare @saldoprom money;
set @saldoprom = (select avg(saldo) 
                 from cuenta);
print @saldoprom;

--Otra forma sería
declare @saldoprom money;
select @saldoprom = avg(saldo)
from cuenta;
select @saldoprom;

--Establecer más de una variable
declare @saldoprom money,@maxsaldo money;
select @saldoprom = avg(saldo),@maxsaldo = max(saldo)
from cuenta;
select @saldoprom,@maxsaldo;

--IMPORTANTE: Nunca se debe utilizar la cláusula SELECT para asignar valor a variable a menos
--que nos aseguremos que se va a obtener un único registro.
declare @sucursal varchar(20),@activo money;
set @activo = 850;
select @sucursal = nombresucursal,@activo = activo
from sucursal
where numsucursal = 8;

select @sucursal,@activo;

--Incrementando variables
declare @x int = 1;

set @x += 5;
print @x;

set @x -= 3;
print @x;

set @x *= 2;
print @x;

truncate table prueba;

--Asingnación múltiple de variables: También se conoce como concatenación agregada, se trata
--de un método fascinante, que permite añadir una variable a sí misma, usando la sentencia
--SELECT, convirtiendo la lista vertical, en una lista horizontal

declare @sucursales varchar(max) = ''; --se requiere iniciar

select @sucursales += concat(nombresucursal,',') 
from sucursal;

select @sucursales;

--Otra forma de hacerlo, con COALESCE (coowles)
declare @sucursales varchar(max); --No se requiere iniciar

select @sucursales = coalesce(@sucursales + ', ' + nombresucursal,nombresucursal) 
from sucursal;

select @sucursales;

--Otra forma, es denormalizando el resultado con XML
SELECT [text()] = nombresucursal + ','
FROM (
SELECT DISTINCT nombresucursal
FROM sucursal) d
ORDER BY nombresucursal
FOR XML PATH('');

--FLUJO DEL PROCEDURAL

--Utilizando IF para T-SQL condicional
if 1 = 0
	print 'Son iguales';
print 'Son diferentes';

--Forma más interesante
declare @nombre varchar(150);

set @nombre = 'Carlos Sánchez';

if exists(
select *
from cliente a join ctacliente b on a.idcliente = b.idcliente 
where nombrecliente = @nombre)
	print 'El cliente ' + @nombre + ' tiene cuenta con nosotros';
print 'El cliente ' + @nombre + ' NO tiene cuenta con nosotros :(';

--Utilizando IF-ELSE
declare @nombre varchar(150);
set @nombre = 'MONTSERRAT BLESA DOMÍNGUEZ';

if exists(
select *
from cliente a join ctacliente b on a.idcliente = b.idcliente 
where nombrecliente = @nombre)
	print 'El cliente ' + @nombre + ' tiene cuenta con nosotros';
else
print 'El cliente ' + @nombre + ' NO tiene cuenta con nosotros :(';

--Realizar más de una acción en el bloque TRUE/FALSE
declare @nombre varchar(150),@cta char(8);

set @nombre = 'MONTSERRAT BLESA DOMÍNGUEZ';

if exists(
select *
from cliente a join ctacliente b on a.idcliente = b.idcliente 
where nombrecliente = @nombre)
begin
    select @cta = numcta
	from cliente a join ctacliente b on a.idcliente = b.idcliente 
	where nombrecliente = @nombre;
	print 'El cliente ' + @nombre + ' tiene la cuenta ' + @cta;
end
else
	print 'El cliente ' + @nombre + ' NO tiene cuenta con nosotros :(';

--Creación de CICLOS
--Vaciar la tabla con TRUNCATE (tronqueit)
truncate table prueba;

declare @x int = 1;
while @x <= 10
begin
	insert into prueba(id,nombre) values(@x,'Carlos');
	set @x += 1;
end;
select * from prueba;

--OBTENER INFORMACIÓN DE UNA TABLA
sp_help cliente;

--OFFSET AND FETCH
declare @filainicio int = 1,
        @filasporpagina int = 5
while (select count(*) FROM sucursal) >= @filainicio
begin
	select nombresucursal,estado
    from sucursal
	order by nombresucursal
		OFFSET @filainicio - 1 ROWS
		FETCH NEXT @filasporpagina ROWS ONLY;
	SET @filainicio += @filasporpagina;
end;