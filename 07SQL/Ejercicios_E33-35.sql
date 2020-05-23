---E33
-- Forma 1 con WHERE
SELECT a.idcliente, nombrecliente
FROM cliente a JOIN prestatario b ON 
     a.idcliente = b.idcliente
WHERE nombrecliente NOT IN ('%HERNÁNDEZ%','%PÉREZ%');

-- Forma 2 usando EXCEPT
SELECT a.idcliente,nombrecliente
FROM prestatario a INNER JOIN cliente b ON
     a.idcliente = b.idcliente 
WHERE nombrecliente NOT LIKE '%HERNÁNDEZ%'
EXCEPT
SELECT a.idcliente,nombrecliente
FROM prestatario a INNER JOIN cliente b ON
     a.idcliente = b.idcliente 
WHERE nombrecliente LIKE '%PÉREZ%'

--E34
-- Usando subconsulta en el WHERE
SELECT nombrecliente
FROM ctacliente a INNER JOIN cliente b ON
     a.idcliente = b.idcliente
	 INNER JOIN cuenta c ON c.numcta = a.numcta
	 INNER JOIN sucursal d ON d.numsucursal = c.numsucursal
	 AND nombresucursal = 'CUAJIMALPA'
WHERE nombrecliente IN
(SELECT nombrecliente
FROM prestatario a INNER JOIN cliente b ON
     a.idcliente = b.idcliente
	 INNER JOIN prestamo c ON c.numprestamo = a.numprestamo
	 INNER JOIN sucursal d ON d.numsucursal = c.numsucursal
	 AND nombresucursal = 'CUAJIMALPA');

--Usando INTERSECT
SELECT nombrecliente
FROM ctacliente a INNER JOIN cliente b ON
     a.idcliente = b.idcliente
	 INNER JOIN cuenta c ON c.numcta = a.numcta
	 INNER JOIN sucursal d ON d.numsucursal = c.numsucursal
	 AND nombresucursal = 'CUAJIMALPA'
INTERSECT
SELECT nombrecliente
FROM prestatario a INNER JOIN cliente b ON
     a.idcliente = b.idcliente
	 INNER JOIN prestamo c ON c.numprestamo = a.numprestamo
	 INNER JOIN sucursal d ON d.numsucursal = c.numsucursal
	 AND nombresucursal = 'CUAJIMALPA';

-- E35
SELECT nombrecliente
FROM prestatario a INNER JOIN cliente b ON
     a.idcliente = b.idcliente
	 INNER JOIN prestamo c ON c.numprestamo = a.numprestamo
	 INNER JOIN sucursal d ON d.numsucursal = c.numsucursal
EXCEPT
SELECT nombrecliente 
FROM ctacliente a INNER JOIN cliente b ON
     a.idcliente = b.idcliente
	 INNER JOIN cuenta c ON c.numcta = a.numcta
	 INNER JOIN sucursal d ON d.numsucursal = c.numsucursal

