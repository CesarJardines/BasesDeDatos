-- E4
SELECT *
FROM cuenta
WHERE  (saldo >= 100000 AND fecha BETWEEN 2013-01-01 AND 2013-03-31)
	   OR
	   (saldo >= 65000 AND saldo < 85000 AND numSucursal IN (55,164,63));

-- E5
SELECT *
FROM sucursal
WHERE nombreSucursal LIKE 'SAN%' AND estado <> 'CDMX';

-- E6 
SELECT *
FROM cliente 
WHERE nombreCliente LIKE '% MOYA %' 
	  AND estado NOT IN ('GUERRERO', 'TAMAULIPAS', 'SONORA');

SELECT *
FROM cliente
WHERE nombreCliente LIKE '% MOYA %'
	  AND (estado <> 'GUERRERO' OR estado <> 'TAMAULIPAS' OR estado <> 'SONORA');

-- E7 
SELECT *
FROM cliente
WHERE nombreCliente LIKE '%ALONSO%' 
	  AND (direccion LIKE '%SANTO%' OR direccion LIKE '%SANTA%');

-- E8
SELECT nombreCliente, estado, nacimiento
FROM cliente
WHERE nombreCliente LIKE '% ALONSO %' 
	  AND direccion LIKE '%MANZANA%' OR direccion LIKE 'MZNA';
	  
--Ejercicio 9
select *
from sucursal
where nombresucursal like '%[NOSZ]';

--También se puede escribir como una lista separada por comas
select *
from sucursal
where nombresucursal like '%[N,O,S,Z]' and
      estado like '[A-D,H,L,O-T]%';
	  
--De igual forma pueden ser por pipes
select *
from sucursal
where nombresucursal like '%[N|O|S|Z]' and
      estado like '[A-D|H|L|O-T]%';

select *
from sucursal
where nombresucursal like '%[NOSZ]' and
      estado like '[A-DHLO-T]%';

--Otra forma de resolver el ejercicio 6
select *
from cliente
where nombrecliente like '%ALONSO%' and
      direccion like '%san[ ,(TA)]%';