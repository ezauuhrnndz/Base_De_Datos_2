create table carrera (
id_carrera serial primary key,
nombre varchar (100) not null unique,
duracion_semestre int not null check ( duracion_semestre > 0),
fecha_de_creacion date not null default current_date
);

create table maestros (
id_maestro serial primary key ,
nombre varchar (100) not null,
apellido_p varchar (100) not null,
apellido_m varchar (100) not null,
correo varchar (100) unique,
id_carrera int not null,
	constraint fk_maestro_carrera
	foreign key (id_carrera)
	references carrera (id_carrera)
	on delete restrict
	
);

create table alumnos (
id_alumno serial primary key ,
nombre varchar (100) not null,
carrera varchar (100) not null ,
materias varchar (200) not null

);

insert into carrera (nombre, duracion_semestre)
	values 
	('Arquitectura', 8),
	('Gastronomia', 9);

insert into maestros (nombre, apellido_p, apellido_m ,id_carrera)
	values
	('Oscar', 'Hernandez','Maldonado', 1),
	('Martin', 'Garcia','Flores' ,2),
	('Angel', 'Gonzalez','Martinez', 2);

insert into alumnos (nombre, carrera, materias)
	values 
	('Ana', 'Software', 'Base de datos , Programacion Web'),
	('Carlos', 'Software', 'Matematicas, Base de datos'),
	('Maria', 'Inteligencia Artificial',  'Programacion Web, Matematicas'),
	('Pedro', 'Software', 'Redes, Base de datos');
	
select * from alumnos;

select * from alumnos
where materias ilike '%Base de datos%';





