USE TaqueroMucho;
SET DATEFORMAT dmy
GO

create trigger Act_Precio_Producto
	on Producto
	for update
	as
		if(update(precio))
		begin 
			select(d.precio) as 'registro anterior', (i.precio) as 'registro actualizado'
			from deleted as d 
			join inserted as i 
			on d.idProducto = i.idProducto
		end 
GO
--update Productos set precio=20 where idProdcuto=1,2,3


create trigger Act_Ingredientes_Salsas
	on Salsas
	for update
	as 
		if(update(ingredientes))
		begin
			select(d.ingredientes) as 'registro anterior', (i.ingredientes) as 'registro actualizado'
			from deleted as d
			join inserted as i
			on d.idSalsa = i.idSalsa
		end

--update Salsas set ingredientes=mostaza where idSalsa=2


