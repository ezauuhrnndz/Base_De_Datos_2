begin;

update inventario_concurrencia
set stock = stock - 2
where id = 1 and stock >= 10;


--actividad 2

begin;

select *
from inventario_concurrencia
where id_producto = 2
for update nowait;

rollback;

begin;

select *
from inventario_concurrencia
where id_producto
for update skip locked;

--¿Qué error produce NOWAIT?
--lock_not_available
--¿Qué productos muestra SKIP LOCKED?
--Los productos que no estan activos en una transaccion
--¿Cuál es la diferencia entre ambas instrucciones?
--que uno te lanza un error del producto que no puedes consultar porque estan en una sesion activa y SKIP LOCKED te muestra los que si estan disponibles
--¿Para qué serviría SKIP LOCKED en un sistema de pedidos?
--En este ejemplo, seria como tal que dos repartidores no se "estorben" entre si y agarren el mismo producto para repartir