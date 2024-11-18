CREATE TABLE productos (
id INT NOT NULL AUTO_INCREMENT,
nombre VARCHAR(100) NOT NULL,
precio DECIMAL(10,2) NOT NULL,
categoria VARCHAR(50) NOT NULL,
fecha_lanzamiento DATE NOT NULL,
proveedor_id INT,
PRIMARY KEY(id),
FOREIGN KEY (proveedor_id) REFERENCES proveedores(id) 
);

INSERT INTO productos (nombre, precio, categoria, fecha_lanzamiento,
proveedor_id)
VALUES
('Laptop', 1200.00, 'Electrónica', '2021-01-01', NULL),
('Smartphone', 800.00, 'Electrónica', '2020-05-15', NULL),
('Cafetera', 50.00, 'Hogar', '2019-08-20', NULL),
('Libro', 20.00, 'Libros', '2022-03-10', NULL),
('Tablet', 300.00, 'Electrónica', '2021-06-01', 1),
('Aspiradora', 150.00, 'Hogar', '2020-11-20', 2),
('Monitor', 250.00, 'Electrónica', '2018-07-15', 3),
('Juego de Mesa', 30.00, 'Juegos', '2022-09-05', 4);

 -- Punto 3
 SELECT * FROM productos WHERE (precio > 200.00 AND categoria = 'Electrónica') OR (precio < 51.00 AND categoria = 'Hogar');

 -- Punto 4
 SELECT AVG(precio) AS Precio_Promedio FROM productos GROUP BY categoria HAVING (Precio_Promedio > 100.00);

 -- -- Punto 5
 SELECT * FROM productos ORDER BY precio DESC, nombre ASC;

 -- Punto 6
 UPDATE productos SET precio = precio * 1.10 WHERE categoria = 'Electrónica';
 SELECT * FROM productos;

 -- Punto 7
 DELETE FROM productos WHERE categoria = 'libros' AND fecha_lanzamiento < '2020-01-01'; 

 -- Punto 8
 SELECT * FROM productos WHERE precio > (SELECT AVG(precio) FROM productos);
 
 -- Punto 9
 SELECT nombre, precio, ROW_NUMBER() OVER(ORDER BY precio DESC) AS ranking FROM productos;

 -- Punto 10
 CREATE VIEW Productos_electronica AS SELECT nombre, precio FROM productos WHERE categoria = 'Electrónica';

 -- Punto 11
 SELECT p.precio, p.nombre, p.categoria, promedios.Precio_promedio 
 FROM productos p 
 JOIN (
   SELECT categoria, AVG(precio) AS Precio_promedio 
   FROM productos GROUP BY categoria) AS promedios 
 n p.categoria = promedios.categoria 
 WHERE p.precio > promedios.Precio_promedio

 -- Punto 12

 -- Punto 13
 SELECT p.nombre, p.precio FROM productos p WHERE p.precio > (SELECT AVG(precio) FROM productos) 
 
 -- Punto 14
 SELECT p.nombre, p.categoria, p.precio, Precio_promedio.prom FROM productos p
 JOIN(
  SELECT categoria, AVG(precio) AS prom FROM productos
  GROUP BY categoria
  ) AS Precio_promedio
 ON Precio_promedio.categoria = p.categoria
 WHERE p.precio > precio_promedio.prom
 
 -- Punto 15
 SELECT p.nombre, p.categoria, p.precio, Precio_minimo.min FROM productos p
 JOIN(
  SELECT categoria, MIN(precio) AS MIN FROM productos
  GROUP BY categoria
  ) AS Precio_minimo
 ON Precio_minimo.categoria = p.categoria
 WHERE p.precio > Precio_minimo.min

 -- Punto 16
  SELECT p.nombre, p.categoria, p.precio, Precio_max.max FROM productos p
 JOIN(
  SELECT categoria, MAX(precio) AS MAX FROM productos
  GROUP BY categoria
     ) AS Precio_max
 ON Precio_max.categoria = p.categoria
 WHERE p.precio > Precio_max.max
 -- Punto 17
 SELECT p.nombre, p.categoria, p.precio, Precio_max.max FROM productos p
 JOIN(
  SELECT categoria, MAX(precio) AS MAX FROM productos
  GROUP BY categoria
     ) AS Precio_max
 ON Precio_max.categoria = p.categoria
 WHERE p.precio = Precio_max.max

 -- Punto 18
 SELECT p.nombre, p.categoria, p.precio, Precio_minimo.min FROM productos p
 JOIN(
   SELECT categoria, MIN(precio) AS MIN FROM productos
   GROUP BY categoria
     ) AS Precio_minimo
 ON Precio_minimo.categoria = p.categoria
 WHERE p.precio = Precio_minimo.min

 -- Punto 19 (misma consigna que un -- Punto anterior)
 SELECT nombre, precio
 FROM productos
 WHERE precio > (SELECT AVG(precio) FROM productos);

 -- Punto 20
 SELECT nombre, categoria, precio FROM productos
 WHERE precio > (SELECT AVG(precio) FROM productos WHERE categoria = 'Hogar');

 -- Punto 21
 SELECT p.nombre, p.categoria, p.precio, Precio_promedio.prom FROM productos p
 JOIN (
   SELECT AVG(precio) AS prom, categoria FROM productos
   GROUP BY categoria
   ) AS Precio_promedio
 ON p.categoria = Precio_promedio.categoria
 WHERE p.precio > Precio_promedio.prom AND fecha_lanzamiento > '2020-01-01';

 -- Punto 22
SELECT p.nombre, p.categoria, p.precio, Precio_promedio.prom FROM productos p
JOIN (
 SELECT AVG(precio) AS prom, categoria FROM productos
  GROUP BY categoria
  ) AS Precio_promedio
ON p.categoria = Precio_promedio.categoria
WHERE p.precio > Precio_promedio.prom AND proveedor_id IS NOT NULL;














 SELECT categoria, COUNT(*) AS Cantidad_Productos, AVG(precio) AS Precio_promedio FROM productos GROUP BY categoria;

 SELECT proveedores.id, proveedores.correo, productos.nombre FROM proveedores LEFT JOIN productos ON proveedores.id = productos.proveedor_id;