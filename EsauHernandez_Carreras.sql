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

insert into carrera (nombre, duracion_semestre)
	values 
	('Arquitectura', 8),
	('Gastronomia', 9);

insert into maestros (nombre, apellido_p, apellido_m ,id_carrera)
	values
	('Oscar', 'Hernandez','Maldonado', 1),
	('Martin', 'Garcia','Flores' ,2),
	('Angel', 'Gonzalez','Martinez', 2);


