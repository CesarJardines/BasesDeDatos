
-- E10
SELECT *
FROM CLIENTE
WHERE NOMBRECLIENTE LIKE '%[ACDN-R]___[^ONRSZ]';

--E11
SELECT nombrecliente,estado,nacimiento
FROM cliente
WHERE nacimiento > '13-12-1954' AND
      nacimiento < '26-06-1986';

--E12
SELECT nombrecliente,estado,nacimiento
FROM cliente
WHERE (nacimiento >= '13-12-1954' AND
       nacimiento <= '26-06-1986') AND
      direccion LIKE '%PRIVADA%';

--Usando BETWEEN
SELECT nombrecliente,estado,nacimiento
FROM cliente
WHERE (nacimiento BETWEEN '13-12-1954' AND '26-06-1986') AND
      direccion LIKE '%PRIVADA%';


--E13
--Cuando es posible te regresa una cadena o bien un string y sino, regresa numeros
SELECT DATENAME(YEAR,nacimiento),
       DATENAME(MONTH,nacimiento),
       DATENAME(DAY,nacimiento),
       DATENAME(WEEKDAY,nacimiento)
FROM cliente;

--E14
--Regresa numeros
SELECT DATEPART(YEAR,nacimiento),
       DATEPART(MONTH,nacimiento),
       DATEPART(DAY,nacimiento),
       DATEPART(WEEKDAY,nacimiento),
       DATEPART(qq, nacimiento),
       DATEPART(dy, nacimiento)
FROM cliente;
