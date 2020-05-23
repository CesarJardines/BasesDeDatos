--Ejercicio 31:
select estado,nombrecliente,
       avg(saldo) saldoprom,
	   count(c.numcta) total_ctas
from cliente a inner join ctacliente b on
     a.idcliente = b.idcliente
	 inner join cuenta c on c.numcta = b.numcta
	 and estado = 'chiapas'
group by estado,nombrecliente
having count(c.numcta) > 2
order by estado;

/*** SUBCONSULTAS EN SQL SERVER ***/
--Consulta dentro de otra consulta (Hasta 32 niveles de anidamiento)

/*
OPERADORES PARA PRODUCIR UN VALOR BOOLENO

Sea s un valor o una tupla y R una relación (tabla)

1. s IN R
2. s > ANY R (s > SOME R) --> El operador de comparación puede ser: >,<,>=,<=,<>
3. s > ALL R
4. EXISTS R

Podemos utilizar los operadores negados
1. s NOT IN r
2. NOT s > ANY (SOME) R
3. NOT s > ALL R
4. NOT EXISTS R
*/

--Ej32: utilizando JOIN
select distinct nombrecliente,numcta,numprestamo
from cliente natural join ctacliente natural join prestatario

--Utilizando subconsultas: Se puede utilizar también NATURAL JOIN
select distinct a.idcliente,nombrecliente
from cliente a join ctacliente b on a.idcliente = b.idcliente
where a.idcliente in (select idcliente
                      from prestatario)
order by 2;

--Otra forma
select distinct idcliente,nombrecliente
from cliente
where idcliente in (select idcliente from ctacliente
                    intersect
					select idcliente from prestatario)
order by 2;

--Ej37: Utilizando EXISTS
select distinct idcliente
from ctacliente a
where exists (select * from prestatario
              where idcliente = a.idcliente);