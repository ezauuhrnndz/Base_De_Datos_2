select * from inventario_concurrencia ic;

--Actividad 3.8 Ejercicios de Concurrencias

--sesion A
begin;

select * 
from inventario_concurrencia ic 
where id_producto = 3 
for update;

rollback;

--ejercicio 3 respuestas
-- 1. ¿Qué PID estaba bloqueado?
-- El de la Sesión B, el PID ___ (columna pid_bloqueado del paso 3).
-- Su update sobre el Teclado se quedó esperando y no avanzó.

-- 2. ¿Qué PID provocaba el bloqueo?
-- El de la Sesión A, el PID ___ (columna pid_que_bloquea del paso 3).
-- Había hecho SELECT ... FOR UPDATE sobre el Teclado y no había
-- terminado su transacción, así que seguía reteniendo esa fila.

-- 3. ¿Qué significa wait_event_type = 'Lock'?
-- Que la sesión está detenida esperando que otra transacción libere
-- un bloqueo. En este caso, B esperaba a que A soltara la fila del
-- Teclado. Cuando A hizo rollback, el bloqueo se liberó y B continuó.

-- 4. ¿Qué diferencia hay entre una conexión bloqueada y una inactiva?
-- La bloqueada quiere trabajar, pero no puede porque otra sesión la
-- tiene frenada. Aparece como active con wait_event_type = 'Lock' y
-- con un PID en la lista de bloqueadores.
-- La inactiva está conectada pero sin hacer nada, esperando su
-- siguiente instrucción. Una sesión puede estar inactiva y aun así
-- bloquear: la A estaba en idle in transaction, sin ejecutar nada,
-- pero seguía reteniendo la fila.

--Ejercicio4
begin;

update inventario_concurrencia
set stock = stock + 1
where id_producto = 1;

update inventario_concurrencia
set stock = stock - 1
where id_producto = 2;

commit;

-- 1. ¿Por qué las transacciones se bloquean mutuamente?
-- Porque cada una tiene lo que la otra necesita. A retiene la Laptop
-- y pide el Mouse; B retiene el Mouse y pide la Laptop. Ninguna puede
-- avanzar hasta que la otra termine, y ninguna va a terminar porque
-- espera a la otra. Es un ciclo sin salida.

-- 2. ¿Qué significa el error 40P01?
-- Es el código de PostgreSQL para deadlock_detected (deadlock
-- detectado). Pertenece a la clase 40, que agrupa las transacciones
-- que PostgreSQL cancela (rollback automático).

-- 3. ¿Qué hizo PostgreSQL para resolver el problema?
-- Después de esperar un momento (deadlock_timeout, 1 segundo por
-- defecto) revisó quién esperaba a quién, detectó el ciclo y canceló
-- una de las dos transacciones con el error 40P01. Eso liberó sus
-- bloqueos y la otra transacción pudo continuar.

-- 4. ¿Cómo modificarían el orden de las operaciones para evitarlo?
-- Haciendo que todas las transacciones bloqueen los productos en el
-- mismo orden, por ejemplo siempre primero la Laptop (id 1) y luego
-- el Mouse (id 2). Así, la que llegue segunda espera su turno y no
-- se forma el ciclo. Otra opción es bloquear ambas filas al inicio
-- en un solo paso:
--   select * from inventario_concurrencia
--   where id_producto in (1, 2)
--   order by id_producto
--   for update;
