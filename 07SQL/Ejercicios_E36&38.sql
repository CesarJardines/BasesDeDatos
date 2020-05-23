--E36
-- Como nos pide que el activo sea al menos mayor que a uno de Sonora
-- Tenemos que hacer que en la subconsulta nos devuelva forzosamente 
-- una tupla con la columna activo para poder comparar
-- Tambien podiamos ocupar el max en lugar de min
-- Forma 1
SELECT *
FROM sucursal
WHERE activo > (SELECT MIN(activo) FROM sucursal WHERE estado = 'SONORA');
-- Forma 2
SELECT *
FROM sucursal
WHERE activo > (SELECT MIN(activo) FROM sucursal WHERE estado = 'SONORA');

--E38
-- Obtiene el maximo promedio de las sucursales y compara que cuál de los activos en
-- sucursal tiene el máximo p
SELECT numsucursal,MAX(promedio) as maximo
FROM (SELECT AVG(activo) as promedio, numsucursal
      FROM sucursal
      GROUP BY numsucursal)) b ON a.activo = b.maximo 

