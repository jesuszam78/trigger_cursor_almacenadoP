
--Trigger que me actualice el precio de un plato directamente cuando se realice un pedido 
create or alter trigger update_precio
on PEDIDO_CLIENTE for insert 
as 
begin

	update PEDIDO_CLIENTE set PEDIDO_CLIENTE.costo = p.costo 
	from PEDIDO_CLIENTE inner join	PLATOS as p on PEDIDO_CLIENTE.id_clientesfk2 = P.id_platos
	inner join inserted as i on i.id_pedido = PEDIDO_CLIENTE.id_pedido and i.id_platosfk2 = p.id_platos

end 



----cursor que muestra lo invertido en un plato,el precio de venta y la ganacia 

declare @totalcosto float(20),@costocliente float (20), @ganancia float(30)

declare cursor8 cursor 

for select 
			sum (m.Costo) as totalcosto,
			sum(t.Costo) as costocliente
		    
from  INGREDIENTES as  m
				join PLATOS as t  on m.id_ingredientes = t.id_recetasfk join RECETAS as r on r.id_recetas = id_ingredientes where t.descripcion = 'Apanado de pescado'
			 				
				
open cursor8
fetch cursor8 into @totalcosto ,@costocliente  
print 'totalInvertido  PrecioPublico  Ganacia '
while @@FETCH_STATUS=0
begin
	print concat(@totalcosto, '                  ', @costocliente,'              ' ,@costocliente - @totalcosto )

	fetch cursor8 into @totalcosto ,@costocliente
	end

	close cursor8

	deallocate cursor8




--procedimiento almacenado en el que se ingrese el nombre de un chef y que muestre todas las recetas que tiene dicho chef 
create procedure platoschef

 @Platos varchar(50) as
select c.Nombre, c.Apellido, Especialidad, r.Titulo from RECETAS r

join CHEFS c on c.id_chef = r.id_chefsfk 

where c.Nombre= @Platos

select count(id_chefsfk) as totalplatos from RECETAS r
inner join CHEFS c on c.id_chef= r.id_chefsfk where c.Nombre=@Platos

go


exec platoschef 'Juan'