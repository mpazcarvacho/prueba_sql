--Prueba María Paz Carvacho

--Crear base de datos y conexión
CREATE DATABASE prueba;

\c prueba

--Creación de tablas

CREATE TABLE clientes(
    id SERIAL,
    rut VARCHAR(15) NOT NULL,
    direccion VARCHAR(200),
    nombre VARCHAR(200),
    PRIMARY KEY (id)
);

CREATE TABLE categorias(
    id SERIAL,
    nombre VARCHAR(180) NOT NULL,
    descripcion VARCHAR(300),
    PRIMARY KEY (id)
);

CREATE TABLE productos(
    id SERIAL,
    nombre VARCHAR(180) NOT NULL,
    descripcion VARCHAR(300),
    valor_unitario INT,
    id_categoria INT,
    PRIMARY KEY (id),
    FOREIGN KEY (id_categoria) REFERENCES categorias(id)
);

CREATE TABLE facturas(
    numero_factura SERIAL,
    cliente INT NOT NULL,
    iva FLOAT,
    subtotal FLOAT,
    precio_total FLOAT,
    fecha DATE,
    PRIMARY KEY (numero_factura),
    FOREIGN KEY (cliente) REFERENCES clientes(id)
);

CREATE TABLE listados_productos(
    id SERIAL,
    id_producto INT NOT NULL,
    id_factura INT,
    cantidad INT,
    valor_total FLOAT,
    PRIMARY KEY (id),
    FOREIGN KEY (id_producto) REFERENCES productos(id),
    FOREIGN KEY (id_factura) REFERENCES facturas(numero_factura)
);

--Inserción de registros

--5 clientes
INSERT INTO clientes (rut, direccion, nombre)
VALUES ('76.242.501-7', 'La Concepción 141 of 307 Providencia', 'Global Pacific'); --1

INSERT INTO clientes (rut, direccion, nombre)
VALUES ('72.067.501-7', 'Ricardo Lyon 555', 'Walmart'); --2

INSERT INTO clientes (rut, direccion, nombre)
VALUES ('92.067.801-7', 'Av Ossa 1800', 'Cencosud'); --3

INSERT INTO clientes (rut, direccion, nombre)
VALUES ('52.068.643-2', 'Tobalaba 1000', 'Frusan'); --4

INSERT INTO clientes (rut, direccion, nombre)
VALUES ('82.068.643-2', 'Larraín 1000', 'David del curto'); --5

--3 categorías
INSERT INTO categorias (nombre, descripcion)
VALUES ('Libros', 'novelas, best sellers, ficción, no ficción entre otros.'); --1

INSERT INTO categorias (nombre, descripcion)
VALUES ('Vinilos', 'LPs importados'); --2

INSERT INTO categorias (nombre, descripcion)
VALUES ('CDs', 'CDs importados'); --3

--8 productos

INSERT INTO productos (nombre, descripcion, valor_unitario, id_categoria)
VALUES ('Pink Floyd - The wall', 'Doble LP. Mint condition.', 32999, 2); --1

INSERT INTO productos (nombre, descripcion, valor_unitario, id_categoria)
VALUES ('El arte de la guerra - Sun Tzu', 'Enseñanzas del Oriente', 5999, 1); --2

INSERT INTO productos (nombre, descripcion, valor_unitario, id_categoria)
VALUES ('Kasabian - LSF', 'LP', 27999, 2); --3

INSERT INTO productos (nombre, descripcion, valor_unitario, id_categoria)
VALUES ('Kasabian - Velociraptor', 'Cd edición especial', 12999, 3); --4

INSERT INTO productos (nombre, descripcion, valor_unitario, id_categoria)
VALUES ('Radiohead - The Bends', 'LP NM', 25999, 2); --5

INSERT INTO productos (nombre, descripcion, valor_unitario, id_categoria)
VALUES ('La muerte del comendador - Haruki Murakami', 'Best sellers', 14999, 1); --6

INSERT INTO productos (nombre, descripcion, valor_unitario, id_categoria)
VALUES ('Lorde - Melodrama', 'LP. Indie pop', 24999, 2); --7

INSERT INTO productos (nombre, descripcion, valor_unitario, id_categoria)
VALUES ('The National - High Violet', 'LP. Near mint condition', 37999, 2); --8

--10 facturas
--2 para el cliente 1, con 2 y 3 productos
--factura 2 cliente 1, con 2 productos distintos.
INSERT INTO facturas (cliente, fecha)
VALUES (1, '2020-06-25'); --1

INSERT INTO listados_productos(id_producto, id_factura, cantidad, valor_total)
VALUES (8, 1, 2, (SELECT valor_unitario FROM productos WHERE id=8)*2); --1

INSERT INTO listados_productos(id_producto, id_factura, cantidad, valor_total)
VALUES (1, 1, 2, (SELECT valor_unitario FROM productos WHERE id=1)*2); --2

UPDATE facturas 
SET iva=0.19*(SELECT SUM(valor_total) FROM listados_productos WHERE id_factura=1),
subtotal=(SELECT SUM(valor_total) FROM listados_productos WHERE id_factura=1),
precio_total=1.19*(SELECT SUM(valor_total) FROM listados_productos WHERE id_factura=1)
WHERE numero_factura=1;

--factura 2 cliente 1, con 3 productos distintos.

INSERT INTO facturas (cliente, fecha)
VALUES (1, '2020-07-25'); --2

INSERT INTO listados_productos(id_producto, id_factura, cantidad, valor_total)
VALUES (5, 2, 1, (SELECT valor_unitario FROM productos WHERE id=5)*1); --3

INSERT INTO listados_productos(id_producto, id_factura, cantidad, valor_total)
VALUES (1, 2, 2, (SELECT valor_unitario FROM productos WHERE id=1)*2); --4

INSERT INTO listados_productos(id_producto, id_factura, cantidad, valor_total)
VALUES (3, 2, 5, (SELECT valor_unitario FROM productos WHERE id=3)*5); --5

UPDATE facturas 
SET iva=0.19*(SELECT SUM(valor_total) FROM listados_productos WHERE id_factura=2),
subtotal=(SELECT SUM(valor_total) FROM listados_productos WHERE id_factura=2),
precio_total=1.19*(SELECT SUM(valor_total) FROM listados_productos WHERE id_factura=2)
WHERE numero_factura=2;

--3 para el cliente 2, con 3, 2 y 3 productos
--factura 3 cliente 2, con 3 productos distintos.
INSERT INTO facturas (cliente, fecha)
VALUES (2, '2020-03-25'); --3

INSERT INTO listados_productos(id_producto, id_factura, cantidad, valor_total)
VALUES (1, 3, 1, (SELECT valor_unitario FROM productos WHERE id=1)*1); --6

INSERT INTO listados_productos(id_producto, id_factura, cantidad, valor_total)
VALUES (2, 3, 1, (SELECT valor_unitario FROM productos WHERE id=2)*1); --7

INSERT INTO listados_productos(id_producto, id_factura, cantidad, valor_total)
VALUES (3, 3, 1, (SELECT valor_unitario FROM productos WHERE id=3)*1); --8

UPDATE facturas 
SET iva=0.19*(SELECT SUM(valor_total) FROM listados_productos WHERE id_factura=3),
subtotal=(SELECT SUM(valor_total) FROM listados_productos WHERE id_factura=3),
precio_total=1.19*(SELECT SUM(valor_total) FROM listados_productos WHERE id_factura=3)
WHERE numero_factura=3;

--factura 4 cliente 2, con 2 productos distintos.
INSERT INTO facturas (cliente, fecha)
VALUES (2, '2020-06-22'); --4

INSERT INTO listados_productos(id_producto, id_factura, cantidad, valor_total)
VALUES (4, 4, 1, (SELECT valor_unitario FROM productos WHERE id=4)*1); --9

INSERT INTO listados_productos(id_producto, id_factura, cantidad, valor_total)
VALUES (5, 4, 1, (SELECT valor_unitario FROM productos WHERE id=5)*1); --10

UPDATE facturas 
SET iva=0.19*(SELECT SUM(valor_total) FROM listados_productos WHERE id_factura=4),
subtotal=(SELECT SUM(valor_total) FROM listados_productos WHERE id_factura=4),
precio_total=1.19*(SELECT SUM(valor_total) FROM listados_productos WHERE id_factura=4)
WHERE numero_factura=4;

--factura 5 cliente 2, con 3 productos distintos.
INSERT INTO facturas (cliente, fecha)
VALUES (2, '2020-06-22'); --5

INSERT INTO listados_productos(id_producto, id_factura, cantidad, valor_total)
VALUES (8, 5, 3, (SELECT valor_unitario FROM productos WHERE id=8)*3); --11

INSERT INTO listados_productos(id_producto, id_factura, cantidad, valor_total)
VALUES (7, 5, 1, (SELECT valor_unitario FROM productos WHERE id=7)*1); --12

INSERT INTO listados_productos(id_producto, id_factura, cantidad, valor_total)
VALUES (6, 5, 2, (SELECT valor_unitario FROM productos WHERE id=6)*2); --13

UPDATE facturas 
SET iva=0.19*(SELECT SUM(valor_total) FROM listados_productos WHERE id_factura=5),
subtotal=(SELECT SUM(valor_total) FROM listados_productos WHERE id_factura=5),
precio_total=1.19*(SELECT SUM(valor_total) FROM listados_productos WHERE id_factura=5)
WHERE numero_factura=5;

--1 para el cliente 3, con 1 producto
--factura 6 cliente 3, con 1 productos
INSERT INTO facturas (cliente, fecha)
VALUES (3, '2020-06-22'); --6

INSERT INTO listados_productos(id_producto, id_factura, cantidad, valor_total)
VALUES (8, 6, 3, (SELECT valor_unitario FROM productos WHERE id=8)*3); --14

UPDATE facturas 
SET iva=0.19*(SELECT SUM(valor_total) FROM listados_productos WHERE id_factura=6),
subtotal=(SELECT SUM(valor_total) FROM listados_productos WHERE id_factura=6),
precio_total=1.19*(SELECT SUM(valor_total) FROM listados_productos WHERE id_factura=6)
WHERE numero_factura=6;

--4 para el cliente 4, con 2, 3, 4 y 1 producto
--factura 7 cliente 4, con 2 productos distintos.
INSERT INTO facturas (cliente, fecha)
VALUES (4, '2020-06-28'); --7

INSERT INTO listados_productos(id_producto, id_factura, cantidad, valor_total)
VALUES (8, 7, 1, (SELECT valor_unitario FROM productos WHERE id=8)*1); --15

INSERT INTO listados_productos(id_producto, id_factura, cantidad, valor_total)
VALUES (6, 7, 1, (SELECT valor_unitario FROM productos WHERE id=6)*1); --16

UPDATE facturas 
SET iva=0.19*(SELECT SUM(valor_total) FROM listados_productos WHERE id_factura=7),
subtotal=(SELECT SUM(valor_total) FROM listados_productos WHERE id_factura=7),
precio_total=1.19*(SELECT SUM(valor_total) FROM listados_productos WHERE id_factura=7)
WHERE numero_factura=7;

--factura 8 cliente 4, con 3 productos distintos.
INSERT INTO facturas (cliente, fecha)
VALUES (4, '2020-06-29'); --8

INSERT INTO listados_productos(id_producto, id_factura, cantidad, valor_total)
VALUES (3, 8, 1, (SELECT valor_unitario FROM productos WHERE id=3)*1); --17

INSERT INTO listados_productos(id_producto, id_factura, cantidad, valor_total)
VALUES (5, 8, 1, (SELECT valor_unitario FROM productos WHERE id=5)*1); --18

INSERT INTO listados_productos(id_producto, id_factura, cantidad, valor_total)
VALUES (6, 8, 1, (SELECT valor_unitario FROM productos WHERE id=6)*1); --19

UPDATE facturas 
SET iva=0.19*(SELECT SUM(valor_total) FROM listados_productos WHERE id_factura=8),
subtotal=(SELECT SUM(valor_total) FROM listados_productos WHERE id_factura=8),
precio_total=1.19*(SELECT SUM(valor_total) FROM listados_productos WHERE id_factura=8)
WHERE numero_factura=8;

--factura 9 cliente 4, con 4 productos distintos.
INSERT INTO facturas (cliente, fecha)
VALUES (4, '2020-06-29'); --9

INSERT INTO listados_productos(id_producto, id_factura, cantidad, valor_total)
VALUES (2, 9, 1, (SELECT valor_unitario FROM productos WHERE id=2)*1); --20

INSERT INTO listados_productos(id_producto, id_factura, cantidad, valor_total)
VALUES (4, 9, 1, (SELECT valor_unitario FROM productos WHERE id=4)*1); --21

INSERT INTO listados_productos(id_producto, id_factura, cantidad, valor_total)
VALUES (7, 9, 1, (SELECT valor_unitario FROM productos WHERE id=7)*1); --22

UPDATE facturas 
SET iva=0.19*(SELECT SUM(valor_total) FROM listados_productos WHERE id_factura=9),
subtotal=(SELECT SUM(valor_total) FROM listados_productos WHERE id_factura=9),
precio_total=1.19*(SELECT SUM(valor_total) FROM listados_productos WHERE id_factura=9)
WHERE numero_factura=9;

--factura 10 cliente 4, con 1 productos distinto.
INSERT INTO facturas (cliente, fecha)
VALUES (4, '2020-06-29'); --10

INSERT INTO listados_productos(id_producto, id_factura, cantidad, valor_total)
VALUES (2, 10, 1, (SELECT valor_unitario FROM productos WHERE id=2)*1); --23

UPDATE facturas 
SET iva=0.19*(SELECT SUM(valor_total) FROM listados_productos WHERE id_factura=10),
subtotal=(SELECT SUM(valor_total) FROM listados_productos WHERE id_factura=10),
precio_total=1.19*(SELECT SUM(valor_total) FROM listados_productos WHERE id_factura=10)
WHERE numero_factura=10;

--Parte 3: Consultas
--¿Que cliente realizó la compra más cara?

SELECT nombre FROM clientes
WHERE id=(
            SELECT cliente FROM facturas
            WHERE precio_total=(SELECT MAX(precio_total)FROM facturas
            )
        );

--¿Que cliente pagó sobre 100 de monto?
SELECT nombre FROM clientes
LEFT JOIN facturas ON clientes.id = facturas.cliente
WHERE cliente IN 
(
    SELECT cliente FROM facturas
    WHERE precio_total>100
)
GROUP BY nombre;

--¿Cuantos clientes han comprado el producto 6.
SELECT id_factura FROM listados_productos
WHERE id_producto=6;

SELECT COUNT(c.cliente) AS clientes_producto_6
FROM( 
    SELECT cliente FROM facturas
    WHERE numero_factura IN
    (
        SELECT id_factura FROM listados_productos
        WHERE id_producto=6
    )   
    GROUP BY cliente
) AS c;