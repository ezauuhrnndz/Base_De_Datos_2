begin;

update inventario_concurrencia
set stock = stock - 1
where id_producto = 1
  and stock > 0
returning id_producto, stock;

commit;

select * from inventario_concurrencia where id_producto = 1;


-- RESPUESTAS

-- ¿Qué sucede con la segunda compra?
-- Se queda esperando mientras A no confirme, porque A tiene bloqueada
-- la fila. Cuando A hace commit, B revisa otra vez la condición
-- stock > 0, ve que el stock ya es 0 y no actualiza ninguna fila.
-- La compra de B no se realiza.

-- ¿Por qué no se produce un stock de -1?
-- Porque solo una de las dos transacciones llega a ver stock > 0. La
-- primera descuenta la última unidad y la segunda ya encuentra 0. Como
-- respaldo, la tabla también tiene CHECK (stock >= 0), que rechazaría
-- un valor negativo.

-- ¿Qué ventaja ofrece una actualización condicional?
-- Revisa si hay stock y descuenta en una sola instrucción. No queda un
-- hueco entre "ver si hay" y "descontar" por donde se pueda colar otra
-- compra. No hace falta un select previo ni un for update.