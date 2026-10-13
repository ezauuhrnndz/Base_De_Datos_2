
begin;

update estudiantes 
set telefono = '6129998877'
where id_estudiantes = 2;

insert into pagos ( id_estudiante, id_periodo, concepto, monto, metodo_pago, referencia)
values (2, 2, 'Regularizacion Academica', 1200, 'Transferencia', 'REG2026-002');

savepoint sp_regularizacion;

update inscripciones 
set estado = 'BAJA'
where id_estudiante;

rollback to savepoint sp_regularizacion;

commit;
rollback;

select * from pagos where referencia = 'REG2026-002';