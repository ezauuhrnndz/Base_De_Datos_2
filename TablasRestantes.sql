drop table if exists pagos;
drop table if exists calificaciones;
drop table if exists inscripciones;
drop table if exists grupos;

create table grupos (
    id_grupo serial primary key,
    id_materia int not null,
    id_docente int not null,
    id_periodo int not null,
    id_aula int not null,
    grupo varchar(10) not null,
    horario varchar(100),
    cupo_maximo int default 30,

    constraint fk_grupo_materia
        foreign key (id_materia)
        references materias(id_materia),

    constraint fk_grupo_docente
        foreign key (id_docente)
        references docentes(id_docente),

    constraint fk_grupo_periodo
        foreign key (id_periodo)
        references periodos_academicos(id_periodo),

    constraint fk_grupo_aula
        foreign key (id_aula)
        references aulas(id_aula)
);

create table inscripciones (
    id_inscripcion serial primary key,
    id_estudiante int not null,
    id_grupo int not null,
    id_periodo int not null,
    fecha_inscripcion date default current_date,
    estado varchar(20) default 'inscrito',

    constraint fk_inscripcion_estudiante
        foreign key (id_estudiante)
        references estudiantes(id_estudiantes),

    constraint fk_inscripcion_grupo
        foreign key (id_grupo)
        references grupos(id_grupo),

    constraint fk_inscripcion_periodo
        foreign key (id_periodo)
        references periodos_academicos(id_periodo),

    constraint uq_estudiante_grupo
        unique(id_estudiante, id_grupo)
);

create table calificaciones (
    id_calificacion serial primary key,
    id_inscripcion int not null,
    calificacion decimal(5,2),
    fecha_registro date default current_date,
    observaciones text,
    tipo_evaluacion varchar(50),

    constraint fk_calificacion_inscripcion
        foreign key (id_inscripcion)
        references inscripciones(id_inscripcion),

    constraint chk_calificacion
        check (calificacion >= 0 and calificacion <= 100)
);

create table pagos (
    id_pago serial primary key,
    id_estudiante int not null,
    id_periodo int not null,
    concepto varchar(100) not null,
    monto decimal(12,2) not null,
    fecha_pago timestamp default current_timestamp,
    metodo_pago varchar(30),
    referencia varchar(100),
    estado varchar(20) default 'pagado',

    constraint fk_pago_estudiante
        foreign key (id_estudiante)
        references estudiantes(id_estudiantes),

    constraint fk_pago_periodo
        foreign key (id_periodo)
        references periodos_academicos(id_periodo),

    constraint chk_monto
        check (monto > 0)
);

insert into grupos
(id_materia, id_docente, id_periodo, id_aula, grupo, horario, cupo_maximo)
values
(1, 1, 2, 1, 'a', 'lunes y miércoles 08:00-10:00', 30),
(2, 2, 2, 2, 'a', 'martes y jueves 10:00-12:00', 35),
(3, 1, 2, 3, 'a', 'lunes y miércoles 12:00-14:00', 25);

insert into inscripciones
(id_estudiante, id_grupo, id_periodo)
values
(1, 1, 2),
(1, 2, 2),
(1, 3, 2),
(2, 1, 2),
(2, 2, 2),
(3, 1, 2);

insert into calificaciones
(id_inscripcion, calificacion, observaciones, tipo_evaluacion)
values
(1, 90, 'buen desempeño', 'final'),
(2, 85, 'cumplió con las actividades', 'final'),
(3, 95, 'excelente desempeño', 'final'),
(4, 78, 'debe mejorar prácticas', 'final'),
(5, 88, 'buen desempeño', 'final');

insert into pagos
(id_estudiante, id_periodo, concepto, monto, metodo_pago, referencia)
values
(1, 2, 'inscripción', 3500.00, 'tarjeta', 'ref001'),
(2, 2, 'inscripción', 3500.00, 'transferencia', 'ref002'),
(3, 2, 'inscripción', 3500.00, 'efectivo', 'ref003');

select * from grupos;

select * from inscripciones;

select
    e.matricula,
    e.nombre,
    e.apellido,
    m.nombre as materia,
    g.grupo,
    g.horario
from estudiantes e
inner join inscripciones i on e.id_estudiantes = i.id_estudiante
inner join grupos g on i.id_grupo = g.id_grupo
inner join materias m on g.id_materia = m.id_materia;



