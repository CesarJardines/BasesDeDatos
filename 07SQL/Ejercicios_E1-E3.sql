
-- E1 
SELECT *
fROM cliente
WHERE estado = 'CHIHUAHUA' OR
      estado = 'CHIAPAS' OR
      estado = 'HIDALGO' OR
      estado = 'JALISCO';

-- Usando la funcion lower para convertir a mayusculas
SELECT *
fROM cliente
WHERE lower(estado) = 'chihuahua' OR
      lower(estado) = 'chiapas' OR
      lower(estado) = 'hidalgo' OR
      lower(estado) = 'jalisco';

--Otra forma, utilizando el operador de subconsultas IN
SELECT *
FROM cliente
wHERE estado IN ('CHIHUAHUA','CHIAPAS','HIDALGO','JALISCO');      

--E2
SELECT *
FROM prestamo
wHERE (numsucursal = 1 OR
      numsucursal = 128 OR
      numsucursal = 109 OR
      numsucursal = 41 OR
      numsucursal = 39 OR
      numsucursal = 110) and importe > 40000;

-- Usando el operador IN	  
SELECT *
fROM prestamo
wHERE numsucursal IN (1,128,109,41,39,110) AND importe > 40000;      


--Ej 3: Vamos a considerar en primer lugar que no queremos considerar las cuentas con saldo igual
--a $16,000 ni a $58,000; utilizamos los operadores mayor y menor estricto.
SELECT *
FROM cuenta
wHERE (saldo > 16000 AND saldo < 58000) AND
      numsucursal IN (62,171,173);

--Si queremos considerar el límite inferior y superior, utilizamos las versiones >= y <=
SELECT *
FROM cuenta
wHERE (saldo >= 16000 AND saldo <= 58000) AND
      numsucursal IN (62,171,173);

--Cuando se requiere considerar ambos límites en el rango de búsqueda, se puede escribir la consulta
--de forma equivalente, a través del operador BETWEEN	  
SELECT *
FROM cuenta
WHERE (saldo BETWEEN 16000 AND 58000) AND
      numsucursal in (62,171,173);      


