/*Ejercicio 1*/

begin;

update estudiantes
set estado = 'BAJA';

select * from estudiantes;

commit;


/*Ejercicio 2*/

begin;

insert into pagos
(id_estudiante, id_periodo, concepto, monto, metodo_pago, referencia)
values
(10, 2, 'reinscripcion', 3500, 'transferencia', 'REF003');

commit;

select * from information_schema.triggers;


/*Ejercicio 3*/

begin;

update estudiantes
set telefono = '6241776867'
where id_estudiantes = 10;

insert into pagos
(id_estudiante, id_periodo, concepto, monto, metodo_pago, referencia)
values
(10, 2, 'reinscripcion', 3500, 'transferencia', 'REF003');

commit;

select * from information_schema.triggers;