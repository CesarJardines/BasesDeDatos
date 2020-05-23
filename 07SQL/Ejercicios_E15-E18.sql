-- E15. Extraer la mayor cantidad de información de la fecha en que se otorgaron los préstamos utlizando las funciones incorporadas de SQL Server
SELECT DAY(fecha) ,
  	   MONTH(fecha),
  	   YEAR(fecha) 
FROM prestamo;

--Manipulación de fechas utilizando DATENAME
select fecha,
       datename(year,fecha) as año,
	   datename(month,fecha) as mes,
	   datename(day,fecha) as dia,
	   datename(quarter,fecha) as trimeste,
	   datename(dayofyear,fecha) as dia_año,
	   datename(week,fecha) as semana_año,
	   datename(weekday,fecha) as dia_semana
from cuenta;

--Utilizando abreviaturas
select fecha,
       datename(yyyy,fecha) as año, --yy
	   datename(m,fecha) as mes,    --mm
	   datename(d,fecha) as dia,    --dd
	   datename(q,fecha) as trimeste, --qq
	   datename(dy,fecha) as dia_año,
	   datename(wk,fecha) as semana_año, --ww
	   datename(dw,fecha) as dia_semana  --w
from cuenta;

--Cambiar visualización de la fecha
select convert(date,fecha)
from prestamo;

--Estilos para las fechas
select convert(char(10),fecha,112)
from prestamo;

select convert(char(10),fecha,101)
from prestamo;

select convert(char(10),fecha,102)
from prestamo;

select convert(char(10),fecha,103)
from prestamo;

select convert(char(10),fecha,105)
from prestamo;

select convert(char(10),fecha,110)
from prestamo;

select fecha from prestamo;

--Ejercicio 17
select convert(date,fecha) as fecha,
       convert(date,dateadd(year,3,fecha)),
	   convert(date,dateadd(month,5,fecha)),
	   convert(date,dateadd(day,10,fecha)),
	   convert(date,dateadd(day,-10,fecha))
from prestamo;


--Ejercicio 18
--Calcular la edad de una persona
--Asumiendo que ya los cumplió
select convert(date,nacimiento),
       datediff(year,nacimiento,getdate()) as edad
from cliente;

--Calcular edad real, dos formas diferentes
select convert(date,nacimiento),
       datediff(year,nacimiento,getdate()) as edad,
	   floor((cast(convert(char(10),getdate(),112) as int)
	          -
			  cast(convert(char(10),nacimiento,112) as int)
			)/10000) as edad_real
from cliente;
