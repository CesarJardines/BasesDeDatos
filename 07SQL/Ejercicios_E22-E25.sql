-- E22. Obtener toda la información de los clientes que son homónimos y que tengan un préstamo con un importe entre 10,000 y 60,000 en el período de 2012 a 2015, otorgado en mayo 

SELECT c.nombreCliente
FROM cliente c
INNER JOIN prestatario p  ON c.idCliente = p.idCliente 
INNER JOIN prestamo ps ON ps.numPrestamo = p.numPrestamo
WHERE
-- importe entre 10,000 y 60,000
(ps.importe BETWEEN 10000 AND 60000)
AND
-- en el período de 2012 a 2015
(YEAR(ps.fecha) = 2012 OR YEAR(ps.fecha) = 2013 OR YEAR(ps.fecha) = 2014 OR YEAR(ps.fecha) = 2015)
-- Que un cliente sea homónimo, quiere decir que tiene el mismo nombre
GROUP BY c.nombreCliente

-- E23. Encontrar el nombre de los clientes que tienen un préstamo, una cuenta o ambas 

-- Al hacer INNER JOIN aseguramos que sólo son listados los registros que tienen una cuenta
(SELECT c.nombreCliente
FROM cliente c
INNER JOIN ctaCliente cta ON c.idCliente = cta.idCliente)
-- Con la unicón tenemos el listado de ambas consultas
UNION 
-- Al hacer INNER JOIN aseguramos que sólo son listados los registros que tienen un prestamo
SELECT c.nombreCliente
FROM cliente c  
INNER JOIN prestatario p ON c.idCliente = p.idCliente

--Ejercicio 24
select nombrecliente,idcliente
from cliente a inner join ctacliente b on a.idcliente = b.idcliente
except
select nombrecliente,idcliente
from cliente a inner join prestatario b on a.idcliente = b.idcliente

--Si queremos obtener más información, la solución sería un JOIN EXTERNO
--En este caso un LEFT JOIN
select a.idcliente,numcta,numprestamo,nombrecliente
from ctacliente a left outer join prestatario b 
     on a.idcliente = b.idcliente
	 inner join cliente c on c.idcliente = a.idcliente
where numprestamo is null;

--Ejercicio 25
select nombrecliente
from cliente a inner join ctacliente b on a.idcliente = b.idcliente
intersect
select nombrecliente
from cliente a inner join prestatario b on a.idcliente = b.idcliente

--Otra posibilidad sería retomando el LEFT JOIN, que entrega la información
--tanto de lo que está en ambas tablas, como lo que está solo a la izquierda
select a.idcliente,numcta,numprestamo,nombrecliente
from ctacliente a left outer join prestatario b 
     on a.idcliente = b.idcliente
	 inner join cliente c on c.idcliente = a.idcliente
where numprestamo is not null;

--También podemos recuperar la información, solo con el INNER JOIN
select a.idcliente,numcta,numprestamo,nombrecliente
from ctacliente a inner join prestatario b 
     on a.idcliente = b.idcliente
	 inner join cliente c on c.idcliente = a.idcliente;

--Clientes que tienen prestamo y cuenta o solo prestamo
select b.idcliente,numcta,numprestamo
from ctacliente a right outer join prestatario b 
     on a.idcliente = b.idcliente
where numcta is null;

--JOIN EXTERNO COMPLETO
select a.idcliente,b.idcliente,numcta,numprestamo
from ctacliente a full outer join prestatario b 
     on a.idcliente = b.idcliente