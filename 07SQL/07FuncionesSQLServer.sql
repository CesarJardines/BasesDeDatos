use banco
go

--Empaquetar consultas de SQL
--Procedimiento almacenado --> Solo para visualizar el resultado

--Crear un procedimiento almacenado
create procedure cuentas(
@estado varchar(30)
) as
begin
select nombrecliente,c.numcta,saldo,fecha,nombresucursal
from cliente a inner join ctacliente b on
     a.idcliente = b.idcliente
	 inner join cuenta c on c.numcta = b.numcta
	 inner join sucursal d on d.numsucursal = c.numsucursal
where d.estado = @estado
end

--probar el procedimiento almacenado
exec cuentas @estado = 'chiapas'
exec cuentas @estado = 'morelos'
exec cuentas @estado = 'sonora'

--Actualizar un procedimiento
alter procedure cuentas(
@estado varchar(30) = null
) as
begin
if @estado is not null
select nombrecliente,c.numcta,saldo,fecha,nombresucursal
from cliente a inner join ctacliente b on
     a.idcliente = b.idcliente
	 inner join cuenta c on c.numcta = b.numcta
	 inner join sucursal d on d.numsucursal = c.numsucursal
where d.estado = @estado
else
select nombrecliente,c.numcta,saldo,fecha,nombresucursal
from cliente a inner join ctacliente b on
     a.idcliente = b.idcliente
	 inner join cuenta c on c.numcta = b.numcta
	 inner join sucursal d on d.numsucursal = c.numsucursal
end

exec cuentas @estado = 'durango'

exec cuentas

--Utilizando el operador like y between
alter procedure cuentas(
@estado varchar(30) = null,
@s1 money = null,
@s2 money = null
) as
begin
if @estado is not null and @s1 is not null and @s2 is not null
select nombrecliente,c.numcta,saldo,fecha,nombresucursal
from cliente a inner join ctacliente b on
     a.idcliente = b.idcliente
	 inner join cuenta c on c.numcta = b.numcta
	 inner join sucursal d on d.numsucursal = c.numsucursal
where d.estado like @estado and saldo between @s1 and @s2
else
select nombrecliente,c.numcta,saldo,fecha,nombresucursal
from cliente a inner join ctacliente b on
     a.idcliente = b.idcliente
	 inner join cuenta c on c.numcta = b.numcta
	 inner join sucursal d on d.numsucursal = c.numsucursal
end

exec cuentas @estado = '[A-G]%',@s1 = 10000, @s2 = 50000

exec cuentas

--Borrar un procedimiento
drop procedure cuentas;

--Funciones --> Permiten devolver una tabla

--1. Crear una funcion que devuelve una tabla en una sola linea
create function cuentas(@estado varchar(30))
returns table as
return(
select nombrecliente,c.numcta,saldo,fecha,nombresucursal
from cliente a inner join ctacliente b on
     a.idcliente = b.idcliente
	 inner join cuenta c on c.numcta = b.numcta
	 inner join sucursal d on d.numsucursal = c.numsucursal
where d.estado = @estado
)

--Para invocar una función
select * from cuentas('oaxaca')
where saldo between 20000 and 30000

--Segunda forma de crear una función que devuelve una tabla
create function cuentas(@estado varchar(30),
                       @año int,@trimestre int)
returns @t table(cliente varchar(100),
                 cta char(7) primary key,
				 saldo money,
				 fecha date,
				 sucursal varchar(100))
				 as
begin
insert @t
select nombrecliente,c.numcta,saldo,fecha,nombresucursal
from cliente a inner join ctacliente b on
     a.idcliente = b.idcliente
	 inner join cuenta c on c.numcta = b.numcta
	 inner join sucursal d on d.numsucursal = c.numsucursal
where d.estado = @estado and year(fecha) = @año and
      datepart(quarter,fecha) = @trimestre
return
end

--Borrar funciones
drop function cuentas;

--Para probarla
select * from cuentas('durango',2012,3)

--Introducción al manejo de erorres
alter function cuentas(@estado varchar(30),@año int,@trimestre int)
returns @t table(cliente varchar(100),
                 cta char(7) primary key,
				 saldo money,
				 fecha date,
				 sucursal varchar(100))
as
begin
	declare @msj varchar(100)
	if @año not in (2012,2013,2014) begin
		set @msj = 'El año ' + cast(@año as varchar) + ' no existe!'
		insert into @t(cliente,cta) values(@msj,'Err-001')
	end
	else if @trimestre not in (1,2,3,4) begin
		set @msj = 'El trimestre ' + cast(@trimestre as varchar) + ' no existe!'
		insert into @t(cliente,cta) values(@msj,'Err-002')
	end
	else if @estado not in (select estado from sucursal) begin
		set @msj = 'El estado ' + @estado + ' no existe!'
		insert into @t(cliente,cta) values(@msj,'Err-003')
	end
	else
		insert @t
		select nombrecliente,c.numcta,saldo,fecha,nombresucursal
		from cliente a inner join ctacliente b on
		     a.idcliente = b.idcliente
			 inner join cuenta c on c.numcta = b.numcta
			 inner join sucursal d on d.numsucursal = c.numsucursal
		where d.estado = @estado and year(fecha) = @año and
			  datepart(quarter,fecha) = @trimestre
	return
end

--Probando los mensajes de erorr
select * from cuentas('españa',2012,3);
select * from cuentas('chiapas',2020,3);
select * from cuentas('durango',2012,5);

--Parámetros correctos
select * from cuentas('chihuahua',2012,3);