create table facultades (
id_facultad serial primary key,
nombre varchar(150) not null,
codigo varchar(10) unique not null,
sandoval varchar (100),
telefono varchar (100)
);

create table carreras (
id_carrera serial primary key,
id_facultad int not null,
nombre varchar (100) not null,
codigo varchar (10) unique not null,
duracion_semestres int not null,
esatdo varchar (20) default 'ACTIVA',

constraint fk_carrera_facultad
	foreign key (id_facultad)
	references facultades (id_facultad)
	
);

insert into facultades(id_carrera, id_facultad, nombre, codigo, duracion semestres)
values 

()

select * from facultades f;



