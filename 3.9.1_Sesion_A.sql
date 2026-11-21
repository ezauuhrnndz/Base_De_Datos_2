select pid, state
from pg_stat_activity
where datname = current_database()
  and state like 'idle in transaction%';

update inventario_concurrencia
set stock = 1
where id_producto = 1;

select * from inventario_concurrencia where id_producto = 1;

begin;

update inventario_concurrencia
set stock = stock - 1
where id_producto = 1
  and stock > 0
returning id_producto, stock;

commit;
