--E39
SELECT nombrecliente
FROM cliente a INNER JOIN ctacliente b ON a.numcliente = b.numcliente
               INNER JOIN cuenta c ON b.numcta = c.numcta
               INNER JOIN sucursal d ON b.numsucursal = d.numsucursal
WHERE nombresucursal = 'GUANAJUATO';

--E40
-- Usando CASE tenemos
SELECT idcliente, CASE saldo
                    WHEN saldo >= 10000 AND saldo <= 20000 THEN 'CLÁSICA'
                    WHEN saldo > 20000 AND saldo < 35000 THEN 'ORO'
                    WHEN saldo > 35000 AND saldo <= 50000 THEN 'PREMIUM'
                    WHEN saldo > 50000 THEN 'PLATINUM'
                    ELSE 'NINGUNA'
                  END AS tipo_tarjeta

FROM ctacliente a JOIN cuenta b ON a.numcta = b.numcta;

