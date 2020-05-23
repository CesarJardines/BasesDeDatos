/*
CREATE TRIGGER nombre_trigger
ON {tabla|vista}
[ WITH ENCRYPTION ]
{ AFTER | INSTEAD OF }{ INSERT, UPDATE, DELETE }
[ NOT FOR REPLICATION ]
AS
BEGIN
SET NOCOUNT ON; --added to prevent extra result sets from 
               --interfering with SELECT statements.

--Bloque de instrucciones
END
*/

--Formas de uso de los disparadores
--Verificar restricciones a nivel de la BD (ASSERTIONS)

--Queremos asegurarnos que las cuentas de CHIAPAS que se abran o se
--actualicen, tengan al menos un saldo de $1,000.00

--create trigger check_saldo_chiapas
--Actualizar el disparador
alter trigger check_saldo_chiapas on cuenta
after insert,update as
begin
set nocount on;
declare @edo varchar(30);
declare @saldo money;
select @edo = estado from sucursal a join inserted b on
a.numsucursal = b.numsucursal;
select @saldo = saldo from inserted;
if @edo = 'CHIAPAS' and @saldo < 1000
begin
	RAISERROR ('El saldo mínimo es de $1,000.00' , 16, 1);
	ROLLBACK TRANSACTION;
end;
end;

select * from cliente;
select * from sucursal where estado = 'CHIAPAS'
select * from cuenta where numsucursal = 85;

--Probemos el disparador
insert into cliente values(19000,'CARLOS ROQUE PEREZ','15 DE SEPT. NO. 234','CHIAPAS','15-02-1964');

--Asociamos una cuenta al cliente
insert into ctacliente values(19000,'C-12200');
--Detalle de la cuenta
insert into cuenta values(52,'C-12200',500,getdate()); --Se trata de una cuenta de CHIAPAS, error
insert into cuenta values(52,'C-12200',1000,getdate()); --Se corrige el error

select * from cuenta where numcta = 'C-12200';

--Asociemos una cuenta que no sea de CHIAPAS para el mismo cliente
insert into ctacliente values(19000,'C-12201');
--Detalle de la cuenta
insert into cuenta values(10,'C-12201',500,getdate()); --No hay error porque la cuenta es de otro Estado

select * from cuenta where numcta = 'C-12201';

--Actualizamos una cuenta de CHIAPAS
update cuenta set saldo = 500 where numcta = 'C-00482'; --No se permite porque es cuenta de CHIAPAS
update cuenta set saldo = 10000 where numcta = 'C-00482'; --Ya no hay error

--Actualizamos una cuenta diferente
update cuenta set saldo = 500 where numcta = 'C-00101'; --No hay error porque no es de CHIAPAS
select * from cuenta where numcta = 'C-00101';

--Creación de históricos
--Monitorear los movimientos (retiros/depósitos) de los clientes
create table movimientos(
numcta char(7),
fecha date,
saldo_ant money,
saldo_nuevo money
);

--Creamos el disparador
create trigger mov_saldo on cuenta
after insert,update as
begin
set nocount on;
if exists(select * from inserted) and exists(select * from deleted)
	insert into movimientos 
	select a.numcta,getdate(),b.saldo,a.saldo
	from inserted a join deleted b on a.numcta = b.numcta;
else insert into movimientos 
	select numcta,getdate(),saldo,saldo s1
	from inserted;
end;

--Probamos el disparador
insert into cuenta values(10,'C-12203',500,getdate());
insert into cuenta values(10,'C-12204',10000,getdate());
update cuenta set saldo = 1500 where numcta = 'C-00101';
update cuenta set saldo = 10000 where numcta = 'C-00102';
select * from movimientos;

--Crear un disparador para monitorear la baja de cuentas
--Primero definimos un procedimiento para eliminar la información de cuentas
create procedure eliminar_cuenta_cliente(
@nombre varchar(200)
) as
begin
	declare @cta char(7),
	        @cad varchar(200);
	select @cta = numcta 
	from ctacliente a join cliente b on a.idcliente = b.idcliente
	where nombrecliente = @nombre;
	if @cta is not null
	begin
		delete from ctacliente where numcta = @cta;
		delete from cuenta where numcta = @cta;
	end
	else
	begin
		set @cad = 'El cliente ' + @nombre + ' no existe';
		RAISERROR (@cad, 16, 1);
	end
end;

--Creamos la tabla de histórico
create table baja_cuenta(
cliente varchar(200),
cuenta char(7),
sucursal varchar(100),
saldo money,
apertura date,
usuario varchar(100),
fecha datetime
);

--Definimos el disparador
create trigger del_cuenta on ctacliente
after delete as
begin
set nocount on;
declare @cad varchar(200),@nombre varchar(200);
if exists(select * from deleted)
begin
	select @nombre = nombrecliente
	from cliente a join deleted b on a.idcliente = b.idcliente;
	insert into baja_cuenta
	select nombrecliente,c.numcta,nombresucursal,saldo,fecha,
	       CURRENT_USER,GETDATE()
	from cliente a join deleted b on a.idcliente = b.idcliente join
		 cuenta c on c.numcta = b.numcta join sucursal d on
		 d.numsucursal = c.numsucursal;
end;
else
	begin
		set @cad = 'El cliente ' + @nombre + ' no existe';
		RAISERROR (@cad, 16, 1);
	end
end;

--Probando el disparador
exec eliminar_cuenta_cliente @nombre = 'LEONCIO MORALES VIDAL';
select * from baja_cuenta;

--Disparador para verificar si un cliente ya terminó de pagar su prestamo
--Hacemos una copia de la tabla prestamo
select * into prestamo1 from prestamo;

--Agregamos una columna que permita validar si ya pagó o no
alter table prestamo1 add pagado int;

update prestamo1 set pagado = 0;

select * from prestamo1;

--Ya tenemos una tabla que almacena la información de los pagos

--Creamos el disparador
create trigger paguitos on pagos
after insert as
begin
set nocount on;
declare @cad varchar(200),@npres char(700);
declare @total money,@monto money;
if exists(select * from inserted)
begin
	select @total = importe from prestamo1 a join inserted b on a.numprestamo = b.numprestamo;
	select @monto = sum(a.pago) from pagos a join inserted b on a.numprestamo = b.numprestamo;
	select @npres = numprestamo from inserted;
	if(@monto >= @total)
		update prestamo1 set pagado = 1 where numprestamo = @npres;
end;
else
	begin
		set @cad = 'No se ha efectuado ningun pago';
		RAISERROR (@cad, 16, 1);
	end
end;

select b.numprestamo,sum(distinct importe),sum(a.pago) from pagos a join prestamo b on a.numprestamo = b.numprestamo
group by b.numprestamo;

insert into pagos values('P-00003',500,getdate());
select * from prestamo1 where numprestamo = 'P-00003';
insert into pagos values('P-00003',11774.85-1384.00,getdate());