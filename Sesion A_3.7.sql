create table inventario_concurrencia (
    id_producto int primary key,
    nombre varchar(100) not null,
    stock int not null check (stock >= 0),
    precio numeric(10,2) not null
);

drop table if exists inventario_concurrecia;

insert into inventario_concurrencia values
(1, 'laptop', 10, 15000),
(2, 'mouse', 20, 350),
(3, 'teclado', 15, 800),
(4, 'monitor', 8, 3500);

commit;

--Actividad 1
begin;

select *
from inventario_concurrencia
where id_producto = 1
for update;

rollback;

--¿Por qué la sesión B no puede actualizar inmediatamente?
--porque la sesion a sigue en espera a actualizarse
--¿Qué comando libera el bloqueo?
--el comando rollback
--¿Cuál es el stock final?
--el stock final es el mismo, solamente el stock de mouse cambia de 20 a 18
--¿Se produjo un deadlock? Expliquen.
--si ya que al dejar en activa ´A´ la sesion ´B´ tambien se ejecuta al mismo tiempo, asi la ´A´ queda en espera

--actividad 2

begin;

select *
from inventario_concurrencia
where id_producto = 2
for update;

