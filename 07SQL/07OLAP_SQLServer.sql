use banco
go

--Operaciones de OLAP
create view olap as
select estado,nombresucursal,year(fecha) Año,
      datepart(quarter,fecha) trimestre,
      datepart(month,fecha) mes,
      datename(month,fecha) nmes,numprestamo,importe
from prestamo a inner join sucursal b on a.numsucursal = b.numsucursal

select * from olap;

--Obtener la cantidad de prestamos en el banco
select count(numprestamo)
from olap;

--Obtener la cantidad de prestamos por estado
select estado,count(numprestamo)
from olap
group by estado;

--Cantidad de prestamos por año
select año,count(numprestamo)
from olap
group by año;

--Cantidad de prestamos por trimestre
select trimestre,count(numprestamo)
from olap
group by trimestre;

--Cantidad de prestamos por estado,sucursal
select estado,nombresucursal,count(numprestamo)
from olap
group by estado,nombresucursal
order by estado;

--Cantidad de prestamos por estado,sucursal,año
select estado,nombresucursal,año,count(numprestamo)
from olap
group by estado,nombresucursal,año
order by estado;

--Cantidad de prestamos por estado,sucursal,año,trimestre
select estado,nombresucursal,año,trimestre,count(numprestamo)
from olap
group by estado,nombresucursal,año,trimestre
order by estado;

--Cantidad de prestamos por estado,sucursal,año,trimestre,mes
select estado,nombresucursal,año,trimestre,mes,count(numprestamo)
from olap
group by estado,nombresucursal,año,trimestre,mes
order by estado;

--OLTP - Procesamiento de transacciones en linea -> dia a dia

--Inteligencia de negocios
--OPERACIONES OLAP
--OLAP - Procesamiento Analitico en Linea

--GROUPING SETS
--Aplicar la funcion de agregación por cada grupo especificado
select estado,nombresucursal,año,trimestre,mes,count(numprestamo)
from olap
group by grouping sets(estado,nombresucursal,año,trimestre,mes)

--Aplicar la función de agregación para grupos específicos
select estado,nombresucursal,año,trimestre,mes,count(numprestamo)
from olap
group by grouping sets((estado,nombresucursal),(año,trimestre),mes)

--ROLL-UP
select estado,nombresucursal,año,trimestre,mes,count(numprestamo)
from olap
group by rollup(estado,nombresucursal,año,trimestre,mes)

--CUBE
select estado,nombresucursal,año,trimestre,mes,count(numprestamo)
from olap
group by cube(estado,nombresucursal,año,trimestre,mes)

--PIVOT
select estado,nombresucursal,año,trimestre,count(numprestamo)
from olap
group by estado,nombresucursal,año,trimestre;

--Rotar informacion: mostrando solo una funcion de agregacion
select *
from (
select estado,nombresucursal,año,trimestre,numprestamo
from olap) res
pivot(count(numprestamo) for trimestre in ([1],[2],[3],[4])) pvt
order by estado,nombresucursal; 

--Si queremos cambiar el nombre de las columnas que se rotaron
select estado,nombresucursal,año,[1] as 'Q1',
       [2] as 'Q2',[3] as 'Q3', [4] as 'Q4'
from (
select estado,nombresucursal,año,trimestre,numprestamo
from olap) res
pivot(count(numprestamo) for trimestre in ([1],[2],[3],[4])) pvt
order by estado,nombresucursal; 

--Cambiando la función de agregación: por ejemplo un AVG
select estado,nombresucursal,año,[1] as 'Q1',
       [2] as 'Q2',[3] as 'Q3', [4] as 'Q4'
from (
select estado,nombresucursal,año,trimestre,importe
from olap) res
pivot(avg(importe) for trimestre in ([1],[2],[3],[4])) pvt
order by estado,nombresucursal;

--Borrar una vista
drop view olap;

--Crear de nuevo una vista
create view olap as
select estado,nombresucursal,year(fecha) Año,
      'C' + cast(datepart(quarter,fecha) as char) t1,
      datepart(month,fecha) mes,
      datename(month,fecha) nmes,numprestamo,importe,
	  'A' + cast(datepart(quarter,fecha) as char) t2
from prestamo a inner join sucursal b on a.numsucursal = b.numsucursal

select * from olap;

--Mostrar 2 funciones de agregacion
select *
from (
select estado,nombresucursal,año,t1,numprestamo,importe,t2
from olap) res
pivot(count(numprestamo) for t1 in ([C1],[C2],[C3],[C4])) as pvt1
pivot(avg(importe) for t2 in ([A1],[A2],[A3],[A4])) as pvt2
order by estado,nombresucursal;                        

--Aplicar formato a una cross-table
select estado,nombresucursal,año,
       [C1],case when [A1] is null then format(0,'c','en-us') 
	        else format([A1],'c','en-us') end as A1,
	   [C2],case when [A2] is null then format(0,'c','en-us') 
	        else format([A2],'c','en-us') end as A2,
	   [C3],case when [A3] is null then format(0,'c','en-us') 
	        else format([A3],'c','en-us') end as A3,
	   [C4],case when [A4] is null then format(0,'c','en-us') 
	        else format([A4],'c','en-us') end as A4
from (
select estado,nombresucursal,año,t1,numprestamo,importe,t2
from olap) res
pivot(count(numprestamo) for t1 in ([C1],[C2],[C3],[C4])) as pvt1
pivot(avg(importe) for t2 in ([A1],[A2],[A3],[A4])) as pvt2
order by estado,nombresucursal;