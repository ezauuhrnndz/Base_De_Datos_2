select * from inventario_concurrencia where id_producto in (1, 2);

begin;
update inventario_concurrencia set stock = stock + 1 where id_producto = 1;

update inventario_concurrencia set stock = stock - 1 where id_producto = 2;
commit;