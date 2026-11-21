--sesion B
begin; 

update inventario_concurrencia ic 
set stock = stock + 1
where ic.id_producto = 3;

commit;

--Ejercicio 4

begin;

update inventario_concurrencia
set stock = stock + 1
where id_producto = 2;

update inventario_concurrencia
set stock = stock - 1
where id_producto = 1;

rollback;


select * from inventario_concurrencia;
