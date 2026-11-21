begin;
update inventario_concurrencia set stock = stock - 1 where id_producto = 1;

rollback;

update inventario_concurrencia set stock = stock + 1 where id_producto = 2;
commit;

select * from inventario_concurrencia where id_producto in (1, 2);

-- RESPUESTAS

-- ¿Puede seguir existiendo una espera?
-- Sí. B pide el producto 1 mientras A lo tiene, y se queda esperando
-- hasta que A haga commit. Pero esa espera es normal y temporal: A no
-- necesita nada de B, así que termina, suelta el producto y B continúa.
-- Esperar no es lo mismo que deadlock.

-- ¿Por qué el orden consistente evita el ciclo de este ejercicio?
-- En el ejercicio 4, A tenía la Laptop y quería el Mouse, y B tenía el
-- Mouse y quería la Laptop: cada una esperaba lo de la otra.
-- Con el mismo orden, la que llega segunda se queda esperando el
-- producto 1 sin haber agarrado nada. Así la primera puede pasar al
-- producto 2 sin que nadie se lo bloquee. Nadie retiene algo que la
-- otra necesite, y sin eso no hay ciclo. Es como un pasillo angosto:
-- si todos entran por el mismo lado hacen fila; si entran por lados
-- opuestos se topan en medio y se traban.

-- ¿Qué ventajas tiene mantener las transacciones cortas?
-- Una transacción abierta mantiene sus bloqueos. Mientras más corta,
-- menos tiempo tiene las filas bloqueadas y las demás sesiones esperan
-- menos. Eso baja la probabilidad de deadlocks, evita sesiones
-- olvidadas en "idle in transaction" y deja menos cosas a medias si
-- algo falla.