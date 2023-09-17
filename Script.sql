-- Crear un nuevo esquema
DROP SCHEMA IF EXISTS vehiculos CASCADE;

create schema vehiculos;

-- Crear las tablas
create table vehiculos.grupo (
	id_grupo serial primary key,
	nombre_grupo varchar(50) not null
);

create table vehiculos.marca (
	id_marca serial primary key,
	marca varchar(30) not null,
	id_grupo int not null
);

create table vehiculos.modelo (
	id_modelo serial primary key, 
	modelo varchar(20) not null,
	id_marca int not null
);

create table vehiculos.revision (
	id_revision serial primary key, 
	fecha_revision date not null,
	kms_revision int not null,
	importe_revision float4 not null,
	moneda varchar(25) not null,
	matricula varchar(20) not null
);

create table vehiculos.aseguradora (
	id_aseguradora serial primary key,
	nombre_aseguradora varchar(35) not null
);

create table vehiculos.colores (
	id_color serial primary key,
	tipo_color varchar(15) not null
);

create table vehiculos.vehiculo (
	matricula varchar(20) primary key,
	id_modelo int not null,
	id_aseguradora int not null,
	fecha_compra date not null,
	kms_totales int not null,
	id_color int not null,
	n_poliza int not null
);
	

-- Crear relaciones

alter table vehiculos.revision add constraint unique_matricula unique (matricula);
alter table vehiculos.modelo add constraint fk_vehiculo_modelo foreign key (id_modelo) references vehiculos.modelo (id_modelo);
alter table vehiculos.marca add constraint fk_modelo_marca foreign key (id_marca) references vehiculos.marca (id_marca);
alter table vehiculos.grupo add constraint fk_marca_grupo foreign key (id_grupo) references vehiculos.grupo (id_grupo);
alter table vehiculos.vehiculo add constraint fk_vehiculo_revision foreign key (matricula) references vehiculos.revision (matricula);
alter table vehiculos.vehiculo add constraint fk_vehiculo_aseguradora foreign key (id_aseguradora) references vehiculos.aseguradora(id_aseguradora);
alter table vehiculos.vehiculo add constraint fk_vehiculo_colores foreign key (id_color) references vehiculos.colores (id_color);


-- Insertar datos en las tablas
insert into vehiculos.grupo (nombre_grupo) values
('Renault-Nissan-Mitsubishi Alliance'),
('PSA Peugeot S.A.'),
('Hyundai Motor Group');

insert into vehiculos.marca (marca, id_grupo) values 
('Renault', 1),
('Citroën', 2),
('Nissan', 1),
('Kia', 3),
('Peugeot', 2),
('Dacia', 1);

insert into vehiculos.modelo (modelo, id_marca) values 
('Clio', 1),
('DS4', 2),
('Leaf', 3),
('Ceed', 4),
('206', 5),
('Rio', 4),
('Megane', 1),
('Duster',6);

insert into vehiculos.revision (fecha_revision, kms_revision, importe_revision, moneda, matricula) values
('2020-07-07', 29564, 1076032.5, 'Peso Colombiano', '7343FRT'),
('2010-05-13', 12028, 734.7, 'Dólar', '2438GSV'),
('2017-12-13', 19543, 344330.4, 'Peso Colombiano', '9666FZC'),
('2000-05-18', 12066, 1162115.1, 'Peso Colombiano', '7221BJG'),
('2012-01-19', 21955, 3615469.2, 'Peso Colombiano', '6756GXW'),
('2021-12-04', 11140, 730, 'Euro', '7987FXL'),
('2021-11-30', 49153, 16767.6, 'Peso Mexicano', '3242GQG'),
('2017-11-02', 20263, 15825.6, 'Peso Mexicano', '4315JKL'),
('2015-09-27', 16879, 437.1, 'Dólar', '5426HDG'),
('2010-12-08', 63099, 2324230.2, 'Peso Colombiano', '5047FJK');

insert into vehiculos.colores (tipo_color) values 
('Rojo'),
('Gris plateado'),
('Blanco'),
('Negro');

insert into vehiculos.aseguradora(nombre_aseguradora) values
('Allianz'),
('Mapfre'),
('Generali'),
('Axa');

insert into vehiculos.vehiculo (matricula, id_modelo, id_aseguradora, fecha_compra, kms_totales, id_color, n_poliza) values 
('7343FRT', 1, 1, '2009-06-01', 47644, 1, 25786),
('2438GSV', 2, 1, '2010-04-17',52349, 2, 195443),
('9666FZC', 3, 1, '2008-03-03',39533,3, 79841),
('7221BJG', 4, 1, '1999-09-30', 70197,3, 112320),
('6756GXW', 5, 2, '2011-07-19', 112881, 4, 142266),
('7987FXL', 6, 3, '2009-01-23', 24726, 3, 32844),
('3242GQG', 7, 3, '2013-03-06', 77662, 1, 187526),
('4315JKL', 8, 2, '2017-08-27', 46145, 2, 9482),
('5426HDG', 4, 4, '2015-04-01', 46759, 4, 144573),
('5047FJK', 2, 2, '2009-10-26', 90641, 3, 161701);

-- Consulta SQL

select 
v.matricula,
ma.marca,
mo.modelo,
g.nombre_grupo,
c.tipo_color,
v.kms_totales,
a.nombre_aseguradora,
v.n_poliza,
v.fecha_compra,
r.moneda

from vehiculos.vehiculo v

inner join vehiculos.modelo mo on v.id_modelo = mo.id_modelo
inner join vehiculos.marca ma on mo.id_marca = ma.id_marca
inner join vehiculos.grupo g on ma.id_grupo = g.id_grupo
inner join vehiculos.aseguradora a on v.id_aseguradora = a.id_aseguradora
inner join vehiculos.colores c on v.id_color = c.id_color
inner join vehiculos.revision r on v.matricula = r.matricula




