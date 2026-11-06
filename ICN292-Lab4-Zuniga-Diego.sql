DROP DATABASE IF EXISTS austral;
CREATE DATABASE austral;
USE austral;
CREATE TABLE autores(
    id_autor INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre VARCHAR(80) NOT NULL,
    pais VARCHAR(60),
    genero ENUM('Cómic', 'Ensayo', 'Infantil', 'Novela', 'Poesía') NOT NULL
);
CREATE TABLE colecciones(
    id_coleccion INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(120) NOT NULL,
    fecha_publicacion DATE NOT NULL
);
CREATE TABLE libros(
    id_libro INT AUTO_INCREMENT PRIMARY KEY,
    id_autor INT NOT NULL,
    id_coleccion INT,
    titulo VARCHAR(120) NOT NULL,
    paginas INT,
    ejemplares_vendidos INT,
    anio INT,
    FOREIGN KEY (id_autor) REFERENCES autores(id_autor),
    FOREIGN KEY (id_coleccion) REFERENCES colecciones(id_coleccion)
);
CREATE TABLE pagos(
    id_pago INT AUTO_INCREMENT PRIMARY KEY,
    id_autor INT NOT NULL,
    fecha_pago DATE NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_autor) REFERENCES autores(id_autor)
);
INSERT INTO autores(nombre, pais, genero) VALUES
('Elena Pizarro', 'Chile', 'Novela'),
('Harold Finch','Inglaterra','Ensayo'),
('Rodrigo Bahamonde','Chile','Poesía'),
('Valentina Correa','Argentina','Infantil'),
('Nora Keller','Estados Unidos','Novela'),
('Kenji Arakawa', NULL, 'Cómic');
INSERT INTO libros(id_autor,titulo, paginas, ejemplares_vendidos, anio) VALUES
(1,'Cielo de Enero', 210, 1500, 2024),
(1,'Marea Baja', 185, 800, 2023),
(1,'El Norte', 200, 2200, 2024),
(2,'Estrellas que Caen', 240, 3000, 2022),
(2,'Máquinas', 215, 450, 2024),
(3,'Luz Artificial', 300, 1200, 2024),
(3,'Ruido Blanco', 280, 600, 2023),
(4,'El Barrio de Lila', 190, 5000, 2024),
(4,'Antes del Amanecer', 205, 2700, 2024),
(4,'La Calle 8', 175, 900, 2023),
(5,'Flor de Hierro', 195, 4100, 2024),
(5,'Hora Dorada', 220, 1800, 2022);
-- PRUEBA
SELECT * FROM autores;
SELECT * FROM libros;
-- Consulta 1
SELECT nombre, genero FROM autores WHERE pais = 'Chile' ORDER BY nombre;
SELECT nombre, genero FROM autores WHERE pais <> 'Chile' ORDER BY nombre;
SELECT nombre, genero FROM autores WHERE pais <> 'Chile' OR pais IS NULL ORDER BY nombre;
-- Consulta 2
SELECT titulo, paginas FROM libros WHERE paginas < 220 AND paginas >190 OR paginas = 190 OR paginas =220 ORDER BY paginas;
-- Consulta 3
SELECT COUNT(*) AS total_libros, SUM(ejemplares_vendidos) AS total_vendidos, AVG(paginas) AS promedio_paginas, MIN(anio) AS mas_antiguo, MAX(ejemplares_vendidos) AS libro_mas_vendido FROM libros;
-- Consulta 4
SELECT DISTINCT genero FROM autores ORDER BY genero;
-- Consulta 5
SELECT autores.nombre, COUNT(libros.titulo) AS libros_por_autor  FROM libros JOIN autores ON libros.id_autor = autores.id_autor WHERE anio= 2024 GROUP BY autores.nombre HAVING COUNT(libros.titulo)>1 ORDER BY autores.nombre;
-- Consulta 6
SELECT titulo, ejemplares_vendidos FROM libros WHERE anio = 2024 AND ejemplares_vendidos > 2000 ORDER BY  ejemplares_vendidos DESC LIMIT 3;
-- Consulta 7
INSERT INTO libros(id_autor,titulo, paginas, ejemplares_vendidos, anio) VALUES
(3,'Papel Mojado', 260, 50, 2024);
SELECT * FROM libros WHERE titulo= 'Papel Mojado';
DELETE FROM libros WHERE titulo = 'Papel Mojado';
SELECT * FROM libros WHERE titulo= 'Papel Mojado';
-- Consulta 8
SELECT titulo, ejemplares_vendidos FROM libros WHERE titulo = 'Cielo de Enero';
UPDATE libros SET ejemplares_vendidos = ejemplares_vendidos+100 WHERE titulo = 'Cielo de Enero';
SELECT titulo, ejemplares_vendidos FROM libros WHERE titulo = 'Cielo de Enero';
-- Consulta 9
INSERT INTO colecciones(titulo, fecha_publicacion) VALUES
('Fantástico', '2026-11-05'),
('Ciencia Ficción', '2026-11-06');
UPDATE libros SET id_coleccion = 1 WHERE titulo = 'Cielo de Enero' OR titulo = 'Marea Baja' OR titulo = 'El Norte' OR titulo = 'El Barrio de Lila';
UPDATE libros SET id_coleccion = 2 WHERE id_coleccion IS NULL;
SELECT libros.titulo AS Titulo, colecciones.titulo AS Coleccion, colecciones.fecha_publicacion AS Fecha_coleccion FROM colecciones JOIN libros ON libros.id_coleccion = colecciones.id_coleccion;
-- Consulta 10
INSERT INTO pagos(id_autor, fecha_pago, monto) VALUES
(1, '2026-04-27', 27040.567),
(1, '2026-08-12', 12081.067),
(2, '2026-10-06', 27120.267);
SELECT autores.nombre, fecha_pago, monto FROM pagos JOIN autores ON autores.id_autor=pagos.id_autor;
SELECT autores.nombre, SUM(monto) AS total_recibido FROM pagos JOIN autores ON autores.id_autor=pagos.id_autor GROUP BY autores.nombre;