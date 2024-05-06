-- 1. Revisa el tipo de relación y crea el modelo correspondiente. Respeta las claves primarias, foráneas y tipos de datos.
CREATE TABLE peliculas (
    id Integer PRIMARY KEY,
    nombre VARCHAR(255),
    anno Integer
);

CREATE TABLE tags (
    id Integer PRIMARY KEY,
    tag VARCHAR(32)
);

-- N a N, muchos a muchos, se crea una tabla intermedia.

CREATE TABLE peliculas_tags (
    peliculas_id Integer, 
    tags_id Integer, 
    Foreign key (peliculas_id) references peliculas (id),
	Foreign key (tags_id) references tags (id)
);

select * from peliculas_Tags;

-- 2. Inserta 5 películas y 5 tags; la primera película debe tener 3 tags asociados, la segunda película debe tener 2 tags asociados.

INSERT INTO peliculas (id, nombre, anno) VALUES
(1, 'El viaje de Chihiro', 2001),
(2, 'La princesa Mononoke', 1997),
(3, 'Mi vecino Totoro', 1988),
(4, 'Ponyo en el acantilado', 2008),
(5, 'La tumba de las luciérnagas', 1988);

select * from peliculas;

INSERT INTO tags (id, tag) VALUES
(1, 'tag 1'),
(2, 'tag 2'),
(3, 'tag 3'),
(4, 'tag 4'),
(5, 'tag 5');

select * from tags;

INSERT into peliculas_tags VALUES
(1 ,1),
(1 ,3),
(1 ,4),
(2 ,2),
(2 ,5);

-- 3. Cuenta la cantidad de tags que tiene cada película. Si una película no tiene tags debe mostrar 0.

select peliculas.id, peliculas.nombre, count(peliculas_tags.tags_id) as tags_por_pelicula
from peliculas
left join peliculas_tags on peliculas.id = peliculas_tags.peliculas_id
group by peliculas.id, peliculas.nombre
order by peliculas.id;


-- 4. Crea las tablas correspondientes respetando los nombres, tipos, claves primarias y foráneas y tipos de datos.
CREATE TABLE Usuarios (
	id Integer Primary key,
	nombre Varchar (255),
	edad Integer
);

CREATE Table Preguntas (
	id Integer Primary key,
	pregunta Varchar (255),
	respuesta_correcta Varchar
);

CREATE TABLE Respuestas (
	id Integer primary key,
	respuesta Varchar (255),
	usuario_id Integer,
	pregunta_id Integer,
	FOREIGN KEY (usuario_id) REFERENCES Usuarios(id),
    FOREIGN KEY (pregunta_id) REFERENCES Preguntas(id)
);

-- 5. Agrega 5 usuarios y 5 preguntas.
INSERT INTO Usuarios (id, nombre, edad) VALUES
(1, 'Alejandro', 35),
(2, 'Tiare', 30),
(3, 'Paulina', 40),
(4, 'Fernando', 28),
(5, 'Marklim', 37);

select * from Usuarios;

INSERT INTO Preguntas (id, pregunta, respuesta_correcta) VALUES
(1, '¿Quién es más fuerte, Goku o Vegeta?', 'Goku'),
(2, '¿Tangananica o tangananá?', 'Tangananica'),
(3, '¿Cuál es la capital de Chipre?', 'Nicosia'),
(4, '¿Cuál es el mejor equipo de Chile?', 'Universidad de Chile'),
(5, 'Si un ciego mira a Medusa, ¿se convierte o no en piedra?', 'No');

select * from Preguntas;

	-- a. La primera pregunta debe estar respondida correctamente dos veces, por dos usuarios diferentes.
	-- b. La segunda pregunta debe estar contestada correctamente solo por un usuario.
	-- c. Las otras tres preguntas deben tener respuestas incorrectas.
	-- Contestada correctamente significa que la respuesta indicada en la tabla respuestas es exactamente igual al texto indicado en la tabla de preguntas
	
INSERT INTO Respuestas (id, respuesta, usuario_id, pregunta_id) VALUES
(1, 'Goku', 1, 1),
(2, 'Goku', 2, 1),
(3, 'Tangananica', 3, 2),
(4, 'Teherán', 4, 3),
(5, 'Cobreloa', 5, 4);

select * from Respuestas;

-- 6. Cuenta la cantidad de respuestas correctas totales por usuario (independiente de la pregunta).
select Usuarios.nombre, count(*) as respuestas_correctas
from Usuarios
inner join Respuestas on Usuarios.id = Respuestas.usuario_id
inner join Preguntas on Respuestas.pregunta_id = Preguntas.id
where Respuestas.respuesta = Preguntas.respuesta_correcta
group by Usuarios.nombre;

-- 7. Por cada pregunta, en la tabla preguntas, cuenta cuántos usuarios respondieron correctamente.
select preguntas.pregunta, count(*) as respuestas_correctas
from respuestas
left join preguntas on respuestas.pregunta_id = preguntas.id
where respuestas.respuesta = preguntas.respuesta_correcta
group by preguntas.pregunta;

-- 8. Implementa un borrado en cascada de las respuestas al borrar un usuario. Prueba la implementación borrando el primer usuario.
ALTER TABLE Respuestas
add constraint fk_usuario_respuesta
foreign key (usuario_id)
references Usuarios(id)
on delete cascade;

delete from Respuestas
where usuario_id = 1;

delete from Usuarios
where id = 1;

select * from Usuarios;
select * from Respuestas;

-- 9. Crea una restricción que impida insertar usuarios menores de 18 años en la base de datos. 
ALTER TABLE Usuarios
add constraint ck_edad_mayor_18
check (edad>= 18);

-- 10.  Altera la tabla existente de usuarios agregando el campo email. Debe tener la restricción de ser único.
ALTER TABLE Usuarios
add column email Varchar(255) unique;

select * from usuarios;