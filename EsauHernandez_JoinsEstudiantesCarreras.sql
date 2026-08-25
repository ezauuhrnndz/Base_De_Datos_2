drop table if exists  estudiantes;
drop table if exists carreras;
drop table if exists facultades;


create table facultades (
id_facultad serial primary key,
nombre varchar(150) not null,
codigo varchar(10) unique not null,
decano varchar (100),
telefono varchar (20)
);

create table carreras (
id_carrera serial primary key,
id_facultad int not null,
nombre varchar (150) not null,
codigo varchar (10) unique not null,
duracion_semestres int not null,
estado varchar (20) default 'ACTIVA',

constraint fk_carrera_facultad
	foreign key (id_facultad)
	references facultades (id_facultad)
	
);

create table estudiantes (
id_estudiantes serial primary key,
matricula varchar (20) unique not null ,
nombre varchar (100) not null,
apellido varchar (100) not null,
email varchar (100) unique ,
telefono varchar (20),
fecha_nacimiento date,
id_carrera int not null,
fecha_ingreso date default current_date,
estado varchar  (20) default 'ACTIVO',

	constraint fk_estudiantes_carrera
		foreign key (id_carrera)
		references carreras (id_carrera)
);

insert into facultades (nombre, codigo, decano, telefono)
	values 
	('Facultad de Ingenieria', 'FING', 'Ing. Sandoval Mendez', '6121234567'	),
	('Facultad de Ciencias Administrativas', 'FCA', 'Dra Laura Gonzales', '6127654321'	);

insert into carreras  (id_facultad, nombre, codigo, duracion_semestres)
	values 
	(1, 'Ingenieria en Sistemas Computacionales', 'ISC', 9	),
	(1, 'Ingenieria Civil', 'ICI', 9),
	(2, 'Licenciatura en Administracion', 'LAE', 8);

insert into estudiantes (matricula, nombre, apellido, email, telefono, fecha_nacimiento, id_carrera )
	values 
	('20260001', 'Esau', 'Hernandez', 'esau@gmail.com', '6241776867', '2006-12-18', 1 ),
	('20260002', 'Isaac', 'Garcia', 'isaac@gmail.com', '6243141664', '2001-08-19', 2 ),
	('20260003', 'Bryan', 'Allende', 'bryan@gmail.com', '6241234567', '2007-04-01', 2 ),
	('20260004', 'María', 'López', 'maria@gmail.com', '6249876543', '2005-03-15', 1),
	('20260005', 'Carlos', 'Ramírez', 'carlos@gmail.com', '6245557890', '2004-07-22', 2),
	('20260006', 'Ana', 'Torres', 'ana@gmail.com', '6243334444', '2006-11-05', 1),
	('20260007', 'Luis', 'Mendoza', 'luis@gmail.com', '6242221111', '2003-01-30', 3),
	('20260008', 'Sofía', 'Castillo', 'sofia@gmail.com', '6248887777', '2005-09-12', 2),
	('20260009', 'Diego', 'Herrera', 'diego@gmail.com', '6244445555', '2004-05-18', 1),
	('20260010', 'Valentina', 'Ruiz', 'valentina@gmail.com', '6246663333', '2006-02-28', 2);

select 
	c.nombre as carrera,		
	c.codigo as codigo_carrera,
	c.duracion_semestres,
	c.estado, 
	f.nombre as facultad,
	f.decano
from carreras c 
inner join facultades f
	on c.id_facultad = f.id_facultad;

select 
	e.matricula,		
	e.nombre,
	e.apellido,
	c.nombre as carrera
from estudiantes e
inner join carreras c
	on e.id_carrera = c.id_carrera;

select * from facultades f;

select * from estudiantes



