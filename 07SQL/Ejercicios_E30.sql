---E30
SELECT estado, nombresucursal, YEAR(fecha) año, DATEPART(qq,fecha) trimestre,
       COUNT(numprestamo) total_prestatarios, COUNT(numCta) total_cuentahabiente
FROM ctacliente a JOIN cuenta b ON
     a.numcuenta = b.numcuenta JOIN
     sucursal c ON b.numsucursal = c.numsucursal
     JOIN prestatario d ON  a.idcliente = d.idcliente
GROUP BY estado, numsucursal, YEAR(fecha), DATEPART(qq,fecha)
HAVING COUNT(numcta) > 6;


